--!nonstrict
-- Flipbook VFX module (Suiryu / TwinFangs wind & slash effects)
-- Plays frame-by-frame texture animations on cloned mesh parts, with optional
-- welding to a moving part and tween helpers for size / transparency / CFrame.

local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local Thrown       = game.Workspace.Thrown

--========================================================================
-- Stopwatch : simple elapsed-time tracker with freeze/unfreeze support
--   call the instance like a function (sw()) to get elapsed seconds
--========================================================================
local Stopwatch = {}
Stopwatch.__index = Stopwatch

function Stopwatch.new(dontStart)
	local self = setmetatable({}, Stopwatch)
	self.start             = (not dontStart) and tick() or nil
	self.freezeStart       = nil
	self.freezeTimeSubtract = 0
	return self
end

-- elapsed seconds since a given timestamp
local function getTimePassed(sinceTime)
	return tick() - sinceTime
end

function Stopwatch:Reset()
	self.start             = tick()
	self.freezeStart       = nil
	self.freezeTimeSubtract = 0
end

-- if currently frozen, fold the frozen duration into freezeTimeSubtract
function Stopwatch:UpdateFreezeTimeSub()
	local freezeStart = self.freezeStart
	if not freezeStart then
		return false
	end
	self.freezeTimeSubtract = self.freezeTimeSubtract + getTimePassed(freezeStart)
	self.freezeStart = tick()
	return true
end

function Stopwatch:Freeze()
	if self:UpdateFreezeTimeSub() then return end
	self.freezeStart = tick()
end

function Stopwatch:Unfreeze()
	self:UpdateFreezeTimeSub()
	self.freezeStart = nil
end

-- true once `duration` seconds have elapsed; auto-resets unless `noReset`
function Stopwatch:HasPassedTime(duration, noReset)
	if not self.start or duration <= self() then
		if not noReset then
			self:Reset()
		end
		return true
	end
	return false
end

function Stopwatch:GetStopwatchTime()
	local now = tick()
	self.start = self.start or now
	self:UpdateFreezeTimeSub()
	return getTimePassed(self.start) - self.freezeTimeSubtract
end

-- normalized progress (0..1) through `duration`, with optional time offset
function Stopwatch:GetAlpha(duration, noClamp, offset)
	offset = offset or 0
	local alpha = (self() + offset) / duration
	if noClamp then
		return alpha
	end
	return math.clamp(alpha, 0, 1)
end

-- runs `callback(alpha, elapsed, frameDelta)` every Heartbeat until the
-- duration elapses or the callback returns truthy
function Stopwatch.newTimer(duration, callback, offset)
	offset = offset or 0
	local total = Stopwatch.new()
	local frame = Stopwatch.new()
	while not total:HasPassedTime(duration + offset, true)
		and not callback(total:GetAlpha(duration, nil, offset), total(), frame()) do
		frame:Reset()
		RunService.Heartbeat:Wait()
	end
end

Stopwatch.__call = function(self)
	return self:GetStopwatchTime()
end

--========================================================================
-- Util : small math / random helpers
--========================================================================
local Util = {}

function Util.Random(min, max)
	return Random.new():NextNumber(min or 0.8, max or 1.2)
end

function Util.RandomReverseMultiplier()
	return (math.random(0, 1) == 1) and 1 or -1
end

function Util.RandomRotation()
	return Util.Random(-math.pi * 2, math.pi * 2)
end

function Util.Round(value, decimals)
	decimals = decimals or 0
	local rounded = math.round(value * 10 ^ decimals) * 10 ^ (-decimals)
	return tonumber(string.format("%." .. decimals .. "f", rounded))
end

function Util.NumberToVector3(n)
	return Vector3.new(n, n, n)
end

-- proportionally rescales a number / NumberSequence / NumberRange:
--   newValue = targetScale * value / baseScale
function Util.ScaleValue(baseScale, value, targetScale)
	local handlers = {}

	handlers.NumberSequence = function()
		local keypoints = {}
		for i, kp in pairs(value.Keypoints) do
			keypoints[i] = NumberSequenceKeypoint.new(
				kp.Time,
				targetScale * kp.Value / baseScale,
				targetScale * kp.Envelope / baseScale
			)
		end
		return NumberSequence.new(keypoints)
	end

	handlers.NumberRange = function()
		return NumberRange.new(
			targetScale * value.Min / baseScale,
			targetScale * value.Max / baseScale
		)
	end

	handlers.Default = function()
		return targetScale * value / baseScale
	end

	return (handlers[typeof(value)] or handlers.Default)()
end

-- returns (referenceMagnitude, sizeMagnitude)
function Util.GetRootScaleValues(size)
	return Vector3.new(2, 2, 1).Magnitude, size.Magnitude
end

-- returns (largestAxisSize, axisName)
function Util.GetLargestAxis(size)
	local largest = { size = size.X, name = "X" }
	if largest.size <= size.Y then largest = { size = size.Y, name = "Y" } end
	if largest.size <= size.Z then largest = { size = size.Z, name = "Z" } end
	return largest.size, largest.name
end

function Util.SineBetween(t, a, b, frequency, phase)
	return ((a - b) * math.sin(t * frequency + phase) + a + b) / 2
end

--========================================================================
-- TexturePlayer : cycles an ImageObject's texture through a frame list
--========================================================================
local TexturePlayer = {}
TexturePlayer.__index = TexturePlayer

function TexturePlayer.new(imageObject, textureParamName)
	local self = setmetatable({}, TexturePlayer)
	self.ImageObject      = imageObject
	self.TextureParamName = textureParamName or "Texture"
	return self
end

-- maps a 0..1 alpha to the matching frame in `textures`
function TexturePlayer.GetTextureFromAlpha(textures, alpha)
	local n = #textures
	return textures[math.clamp(math.round(alpha * n), 1, n)]
end

function TexturePlayer:SetTextureFromAlpha(textures, alpha)
	self.ImageObject[self.TextureParamName] = TexturePlayer.GetTextureFromAlpha(textures, alpha)
end

-- plays the frame sequence over `duration` seconds
--   easingFn: optional function(alpha) -> remappedAlpha
--   deleteAfter: clears the player table when finished
function TexturePlayer:Play(textures, duration, easingFn, deleteAfter)
	local sw = Stopwatch.new()
	task.spawn(function()
		while not sw:HasPassedTime(duration) do
			local alpha = sw() / duration
			if easingFn then alpha = easingFn(alpha) end
			self.ImageObject[self.TextureParamName] = TexturePlayer.GetTextureFromAlpha(textures, alpha)
			task.wait()
		end
		if deleteAfter then
			self:Delete()
		end
	end)
end

function TexturePlayer:Delete()
	for key in self do
		self[key] = nil
	end
end

--========================================================================
-- FlipbookEffect : the actual VFX object (mesh + animated decal)
--========================================================================
local FlipbookEffect = {}
FlipbookEffect.__index = FlipbookEffect

-- Frame sequences (each is an ordered list of texture asset IDs)
FlipbookEffect.Wind0 = {
	"rbxassetid://11461678568", "rbxassetid://11461678488", "rbxassetid://11461678409",
	"rbxassetid://11461678313", "rbxassetid://11461678244", "rbxassetid://11461675803",
	"rbxassetid://11461675738", "rbxassetid://11461675605", "rbxassetid://11461675546",
	"rbxassetid://11461675422", "rbxassetid://11461675356",
}

FlipbookEffect.Wind1 = {
	"rbxassetid://12709087413", "rbxassetid://12709089414", "rbxassetid://12709091338",
	"rbxassetid://12709052082", "rbxassetid://12709051925", "rbxassetid://12709051840",
	"rbxassetid://12709046645", "rbxassetid://12709046514", "rbxassetid://12709046410",
	"rbxassetid://12709046344", "rbxassetid://12709046207", "rbxassetid://12709046012",
	"rbxassetid://12709041406", "rbxassetid://12709041294", "rbxassetid://12709041173",
	"rbxassetid://12709041095", "rbxassetid://12709040977", "rbxassetid://12709040841",
	"rbxassetid://12709035460", "rbxassetid://12709035361", "rbxassetid://12709035226",
	"rbxassetid://12709035099", "rbxassetid://12709034940", "rbxassetid://12709034804",
	"rbxassetid://12709029886", "rbxassetid://12709029739", "rbxassetid://12709029558",
	"rbxassetid://12709029448", "rbxassetid://12709029377", "rbxassetid://12709029200",
}

FlipbookEffect.Wind2 = {
	"rbxassetid://13470338298", "rbxassetid://13470338205", "rbxassetid://13470338069",
	"rbxassetid://13470337936", "rbxassetid://13470337799", "rbxassetid://13470337705",
	"rbxassetid://13470337605", "rbxassetid://13470337504", "rbxassetid://13470337307",
	"rbxassetid://13470337065", "rbxassetid://13470336871", "rbxassetid://13470336729",
	"rbxassetid://13470336566", "rbxassetid://13470336437", "rbxassetid://13470336294",
	"rbxassetid://13470336113", "rbxassetid://13470336008", "rbxassetid://13470335851",
	"rbxassetid://13470335752", "rbxassetid://13470335638",
}

FlipbookEffect.Wind3 = {
	"rbxassetid://15583581350", "rbxassetid://15583581268", "rbxassetid://15583581163",
	"rbxassetid://15583581073", "rbxassetid://15583580947", "rbxassetid://15583580830",
	"rbxassetid://15583580724", "rbxassetid://15583580608", "rbxassetid://15583580488",
	"rbxassetid://15583580288", "rbxassetid://15583580138", "rbxassetid://15583580039",
	"rbxassetid://15583579925", "rbxassetid://15583579776", "rbxassetid://15583579583",
	"rbxassetid://15583579386", "rbxassetid://15583579213", "rbxassetid://15583579007",
	"rbxassetid://15583578841", "rbxassetid://15583578616", "rbxassetid://15583578452",
	"rbxassetid://15583578183",
}

FlipbookEffect.DiceyWind0 = {
	"rbxassetid://13769737333", "rbxassetid://13769737186", "rbxassetid://13769737005",
	"rbxassetid://13769736812", "rbxassetid://13769759577", "rbxassetid://13769736174",
	"rbxassetid://13769735915", "rbxassetid://13769735699", "rbxassetid://13769735432",
	"rbxassetid://13769735245", "rbxassetid://13769734982",
}

FlipbookEffect.Slash0 = {
	"rbxassetid://13204898262", "rbxassetid://13204897736", "rbxassetid://13204897313",
	"rbxassetid://13204896833", "rbxassetid://13204896227", "rbxassetid://13204895744",
	"rbxassetid://13204895210", "rbxassetid://13204894750", "rbxassetid://13204894286",
	"rbxassetid://13204893811", "rbxassetid://13204893290", "rbxassetid://13204892795",
	"rbxassetid://13204892226", "rbxassetid://13204891702", "rbxassetid://13204891035",
	"rbxassetid://13204890584", "rbxassetid://13204890049", "rbxassetid://13204889468",
	"rbxassetid://13204888992",
}

FlipbookEffect.SlashWind0 = {
	"rbxassetid://14127444698", "rbxassetid://14127393320", "rbxassetid://14127393204",
	"rbxassetid://14127393113", "rbxassetid://14127392987", "rbxassetid://14127392831",
	"rbxassetid://14127392695", "rbxassetid://14127392572", "rbxassetid://14127392433",
	"rbxassetid://14127392308", "rbxassetid://14127448226", "rbxassetid://14127392018",
	"rbxassetid://14127391892",
}

FlipbookEffect.UpLines0 = {
	"rbxassetid://14334428426", "rbxassetid://14334428426", "rbxassetid://14334428243",
	"rbxassetid://14334428107", "rbxassetid://14334427908", "rbxassetid://14334427593",
	"rbxassetid://14334427593", "rbxassetid://14334427409", "rbxassetid://14334427313",
	"rbxassetid://14334427189", "rbxassetid://14334427002", "rbxassetid://14334427002",
	"rbxassetid://14334426739", "rbxassetid://14334426626",
}

FlipbookEffect.UpLines1 = {
	"rbxassetid://16349253150", "rbxassetid://16349253003", "rbxassetid://16349252865",
	"rbxassetid://16349252630", "rbxassetid://16349252435", "rbxassetid://16349252319",
	"rbxassetid://16349252232", "rbxassetid://16349252127", "rbxassetid://16349251934",
	"rbxassetid://16349251721", "rbxassetid://16349251510", "rbxassetid://16349251398",
	"rbxassetid://16349251243", "rbxassetid://16349251093", "rbxassetid://16349250958",
}

FlipbookEffect.DotDissolve = {
	"rbxassetid://15494257040", "rbxassetid://15494256947", "rbxassetid://15494256825",
	"rbxassetid://15494254516", "rbxassetid://15494254445", "rbxassetid://15494254370",
	"rbxassetid://15494254273", "rbxassetid://15494254222", "rbxassetid://15494254167",
	"rbxassetid://15494254118", "rbxassetid://15494254073", "rbxassetid://15494254030",
	"rbxassetid://15494253978", "rbxassetid://15494253921", "rbxassetid://15494253857",
	"rbxassetid://15494253812", "rbxassetid://15494253754", "rbxassetid://15494253685",
	"rbxassetid://15494253626", "rbxassetid://15494253569", "rbxassetid://15494253511",
	"rbxassetid://15494253430", "rbxassetid://15494253331", "rbxassetid://15494253331",
	"rbxassetid://15494253227", "rbxassetid://15494285181", "rbxassetid://15494289522",
	"rbxassetid://15494253021", "rbxassetid://15494252936",
}

FlipbookEffect.SphereWind0 = {
	"rbxassetid://15117059121", "rbxassetid://15117060921", "rbxassetid://15117061899",
	"rbxassetid://15117062959", "rbxassetid://15117062959", "rbxassetid://15117065207",
	"rbxassetid://15117066547", "rbxassetid://15117067537",
}

-- Creates a new effect.
--   meshName : key under ReplicatedStorage.Resources.Suiryu.TwinFangs.FlipbookMeshes
--   textures : frame list to animate
--   weldPart : optional part to follow (CFrame becomes relative to it)
--   cframe   : initial CFrame (world, or relative to weldPart)
--   scale    : Mesh.Scale (default Vector3.new(0.5, 0))
--   color    : Decal.Color3 (default Color3.fromRGB(330, 510, 498) -> clamps to white)
function FlipbookEffect.new(meshName, textures, weldPart, cframe, scale, color)
	local self = setmetatable({}, FlipbookEffect)

	scale = scale or Vector3.new(0.5, 0)
	color = color or Color3.fromRGB(330, 510, 498)

	--local part  = game.ReplicatedStorage.Resources.Suiryu.TwinFangs.FlipbookMeshes[meshName]:Clone()
	local part  = game.ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.
		Sanji.RegularSkillsSet.Concasse.TwinFangs.FlipbookMeshes[meshName]:Clone()

	local mesh  = part.Mesh
	local decal = part.Decal
	local cfValue = Instance.new("CFrameValue")

	-- recompute the part's world CFrame from the stored value (+ weld part)
	local function updateCF()
		local wp  = self.WeldPart
		local val = cfValue.Value
		part.CFrame = wp and wp.CFrame:ToWorldSpace(val) or val
	end

	-- keep following the weld part as it moves
	local weldUpdate = weldPart and weldPart.Changed:Connect(function(prop)
		if prop ~= "CFrame" then return end
		updateCF()
	end)

	cfValue.Changed:Connect(updateCF)

	self.Part            = part
	self.Mesh            = mesh
	self.Decal           = decal
	self.Flipbook        = TexturePlayer.new(decal)
	self.Textures        = textures
	self.CFValue         = cfValue
	self.WeldPart        = weldPart
	self.WeldPartStartCF = weldPart and weldPart.CFrame
	self.WeldUpdate      = weldUpdate

	mesh.Scale  = scale
	decal.Color3 = color
	cfValue.Value = self:ConvertCFrame(cframe)
	part.Parent = Thrown
	self:SetTextureFromAlpha(0)

	return self
end

-- world CFrame -> stored value (relative to weld part's start CFrame if welded)
function FlipbookEffect:ConvertCFrame(cframe)
	if self.WeldPart then
		return self.WeldPartStartCF:ToObjectSpace(cframe)
	end
	return cframe
end

-- generic tween helper: tweens a property table on one of our objects
function FlipbookEffect:Tween(objectName, tweenInfo, goal, dontPlay)
	local tween = TweenService:Create(self[objectName], tweenInfo, goal)
	if not dontPlay then
		tween:Play()
	end
	return tween
end

function FlipbookEffect:TweenDecal(tweenInfo, goal, dontPlay)
	return self:Tween("Decal", tweenInfo, goal, dontPlay)
end

function FlipbookEffect:TweenPart(tweenInfo, goal, dontPlay)
	return self:Tween("Part", tweenInfo, goal, dontPlay)
end

function FlipbookEffect:TweenMesh(tweenInfo, goal, dontPlay)
	return self:Tween("Mesh", tweenInfo, goal, dontPlay)
end

function FlipbookEffect:TweenTransparency(transparency, tweenInfo, dontPlay)
	return self:TweenDecal(tweenInfo, { Transparency = transparency }, dontPlay)
end

function FlipbookEffect:TweenCFrame(cframe, tweenInfo, dontPlay)
	return self:Tween("CFValue", tweenInfo, { Value = self:ConvertCFrame(cframe) }, dontPlay)
end

function FlipbookEffect:TweenSize(scale, tweenInfo, dontPlay)
	return self:TweenMesh(tweenInfo, { Scale = scale }, dontPlay)
end

function FlipbookEffect:SetTransparency(transparency)
	self.Decal.Transparency = transparency
end

function FlipbookEffect:SetCFrame(cframe)
	self.CFValue.Value = self:ConvertCFrame(cframe)
end

function FlipbookEffect:SetTextureFromAlpha(alpha)
	self.Flipbook:SetTextureFromAlpha(self.Textures, alpha)
end

-- plays the flipbook over `duration`; auto-destroys afterward unless `dontAutoDestroy`
function FlipbookEffect:Play(duration, easingFn, dontAutoDestroy, texturesOverride)
	self.WeldPartStartCF = self.WeldPart and self.WeldPart.CFrame
	self.Flipbook:Play(self.Textures or texturesOverride, duration, easingFn, true)
	if not dontAutoDestroy then
		task.delay(duration, function()
			self:Destroy()
		end)
	end
end

function FlipbookEffect:Destroy()
	self.CFValue:Destroy()
	self.Part:Destroy()
	if self.WeldUpdate then
		self.WeldUpdate:Disconnect()
	end
	for key in self do
		self[key] = nil
	end
end

--========================================================================
-- Convenience constructors
--========================================================================

-- NOTE: original referenced FlipbookEffect.LoadFlipbook("Sphere", ...) which is
-- not defined in this module — preserved as-is in case it lives elsewhere.
--function FlipbookEffect.LoadSphereFlipbook(...)
--	return FlipbookEffect.LoadFlipbook("Sphere", ...)
--end

function FlipbookEffect.CreateWind0Flipbook(...)
	return FlipbookEffect.new("Cone", FlipbookEffect.Wind0, ...)
end

function FlipbookEffect.CreateWind1Flipbook(...)
	return FlipbookEffect.new("Sphere", FlipbookEffect.Wind1, ...)
end

function FlipbookEffect.CreateWind2Flipbook(...)
	return FlipbookEffect.new("Sphere", FlipbookEffect.Wind2, ...)
end

function FlipbookEffect.CreateWind3Flipbook(...)
	return FlipbookEffect.new("Sphere", FlipbookEffect.Wind3, ...)
end

function FlipbookEffect.CreateDiceyWindFlipbook(...)
	return FlipbookEffect.new("Sphere", FlipbookEffect.DiceyWind0, ...)
end

function FlipbookEffect.CreateSlashWind0Flipbook(...)
	return FlipbookEffect.new("Sphere", FlipbookEffect.SlashWind0, ...)
end

-- Spawns a randomized rising/rotating wind puff and tweens it outward.
--   baseCFrame   : origin
--   targetSize   : final Mesh.Scale (Vector3); starts at (0, Y, 0)
--   startHeight  : initial vertical offset
--   endHeight    : vertical offset to drift to
--   duration     : effect length (seconds)
--   creatorFn    : flipbook constructor (default CreateWind2Flipbook)
--   transparency : decal transparency (default 0.95)
function FlipbookEffect.CreateAnimatedWind(baseCFrame, targetSize, startHeight, endHeight, duration, creatorFn, transparency)
	local startCF = baseCFrame
		* CFrame.Angles(0, Util.RandomRotation(), 0)
		* CFrame.new(0, startHeight, 0)

	local effect = (creatorFn or FlipbookEffect.CreateWind2Flipbook)(
		nil,
		startCF,
		Vector3.new(0, targetSize.Y, 0),
		Color3.new(1, 1, 1)
	)

	effect:Play(duration)
	effect:TweenSize(targetSize, TweenInfo.new(duration, Enum.EasingStyle.Cubic))
	effect:SetTransparency(transparency or 0.95)
	effect:TweenCFrame(
		startCF
			* CFrame.Angles(0, (math.pi / 2) * Util.RandomReverseMultiplier(), 0)
			* CFrame.new(0, endHeight, 0),
		TweenInfo.new(duration)
	)

	return effect
end

return FlipbookEffect