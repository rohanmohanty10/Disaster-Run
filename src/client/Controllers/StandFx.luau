--!strict
-- Stand visuals (original effects built in code, no imported assets). FxController calls these.
--
-- Made in Heaven
--   Aura              — StandGame's Made in Heaven aura, rebuilt from its emitter settings
--                       (references/StandGame/Stands/Made in Heaven.rbxmx → StandAura x2 on the
--                       root, StandAura2 on the torso): same colours, sizes, rates, lifetimes,
--                       drag, spin and upward drift. Textures are Roblox's built-in particle
--                       textures; swap in your own uploads in TEXTURES.
--   Blink             — an aura burst where Godly Speed leaves and lands
--   TimeAccel         — aura + afterimages on the caster, a dome over the trapped area, and the
--                       sky racing through day and night for everyone while time is accelerated
--   UniverseReset     — white-out, a new universe expanding from the caster, lighting restored
--   AlternateUniverse — the victim's screen shifts to an "alternate universe" grade for a moment

local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local StandFx = {}

-- Built-in Roblox particle textures. Replace with your own uploaded ids for a closer look.
local TEXTURES = {
	Wisp = "rbxasset://textures/particles/smoke_main.dds",
	Glow = "rbxasset://textures/particles/sparkles_main.dds",
}

local LAVENDER = Color3.fromRGB(165, 163, 222)
local HEAVEN_WHITE = Color3.fromRGB(239, 250, 255)

local folder: Instance = workspace

function StandFx.SetFolder(target: Instance)
	folder = target
end

-- ------------------------------------------------------------------ helpers
local function seq(points: { { number } }): NumberSequence
	local keys = {}
	for _, p in points do
		table.insert(keys, NumberSequenceKeypoint.new(p[1], p[2], p[3] or 0))
	end
	return NumberSequence.new(keys)
end

local function colors(points: { { any } }): ColorSequence
	local keys = {}
	for _, p in points do
		table.insert(keys, ColorSequenceKeypoint.new(p[1], p[2]))
	end
	return ColorSequence.new(keys)
end

local function rgb(r: number, g: number, b: number): Color3
	return Color3.new(r, g, b)
end

-- The three Made in Heaven aura emitters, values copied from StandGame's model.
local AURA_LAYERS = {
	{ -- StandAura (dark grey wisps, drawn behind)
		Part = "Root",
		Texture = TEXTURES.Wisp,
		Color = colors({ { 0, rgb(0.502, 0.486, 0.58) }, { 0.463, rgb(0.499, 0.483, 0.577) }, { 1, rgb(0.259, 0.251, 0.298) } }),
		LightEmission = -1,
		Size = seq({ { 0, 2.125, 0.62 }, { 0.608, 0.375, 0.244 }, { 1, 0 } }),
		Transparency = seq({ { 0, 0 }, { 1, 0.512, 0.488 } }),
		Lifetime = NumberRange.new(0.35, 0.55),
		Rate = 45,
		Speed = NumberRange.new(5, 9),
		Drag = 6,
		Acceleration = Vector3.new(0, 8, 0),
		RotSpeed = NumberRange.new(-350, 350),
		VelocityInheritance = 1.25,
		ZOffset = -2,
	},
	{ -- StandAura (pale lavender wisps)
		Part = "Root",
		Texture = TEXTURES.Wisp,
		Color = colors({ { 0, rgb(0.647, 0.639, 0.871) }, { 1, rgb(0.937, 0.98, 1) } }),
		LightEmission = 0.35,
		Size = seq({ { 0, 2.125, 0.62 }, { 0.608, 0.375, 0.244 }, { 1, 0 } }),
		Transparency = seq({ { 0, 0 }, { 1, 0.512, 0.488 } }),
		Lifetime = NumberRange.new(0.35, 0.55),
		Rate = 45,
		Speed = NumberRange.new(5, 9),
		Drag = 6,
		Acceleration = Vector3.new(0, 8, 0),
		RotSpeed = NumberRange.new(-350, 350),
		VelocityInheritance = 1.25,
		ZOffset = -1.5,
	},
	{ -- StandAura2 (blue → violet → teal → white glow on the torso)
		Part = "Torso",
		Texture = TEXTURES.Glow,
		Color = colors({
			{ 0, rgb(0.188, 0.376, 1) },
			{ 0.519, rgb(0.765, 0.569, 0.957) },
			{ 0.775, rgb(0.51, 0.933, 0.871) },
			{ 1, rgb(1, 0.988, 0.914) },
		}),
		LightEmission = 1,
		Size = seq({ { 0, 6.188, 1.062 }, { 0.592, 0.938, 0.687 }, { 1, 0 } }),
		Transparency = seq({ { 0, 1 }, { 0.128, 0.706, 0.137 }, { 0.357, 0.512, 0.285 }, { 1, 0.65, 0.35 } }),
		Lifetime = NumberRange.new(0.35, 0.75),
		Rate = 100,
		Speed = NumberRange.new(5, 10),
		Drag = 4,
		Acceleration = Vector3.zero,
		RotSpeed = NumberRange.new(-200, 200),
		VelocityInheritance = 0,
		ZOffset = -1,
	},
}

local function bodyPart(character: Model, which: string): BasePart?
	if which == "Root" then
		return character:FindFirstChild("HumanoidRootPart") :: BasePart?
	end
	return (character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")) :: BasePart?
end

local function makeEmitter(layer: { [string]: any }, parent: Instance): ParticleEmitter
	local e = Instance.new("ParticleEmitter")
	e.Name = "MadeInHeavenAura"
	e.Texture = layer.Texture
	e.Color = layer.Color
	e.LightEmission = layer.LightEmission
	e.LightInfluence = 0
	e.Brightness = 1
	e.Size = layer.Size
	e.Transparency = layer.Transparency
	e.Lifetime = layer.Lifetime
	e.Rate = layer.Rate
	e.Speed = layer.Speed
	e.Drag = layer.Drag
	e.Acceleration = layer.Acceleration
	e.Rotation = NumberRange.new(-360, 360)
	e.RotSpeed = layer.RotSpeed
	e.SpreadAngle = Vector2.new(360, 360)
	e.EmissionDirection = Enum.NormalId.Top
	e.Shape = Enum.ParticleEmitterShape.Box
	e.LockedToPart = true
	e.VelocityInheritance = layer.VelocityInheritance
	e.ZOffset = layer.ZOffset
	e.Parent = parent
	return e
end

-- Puts the aura on a character for `duration` seconds. Returns the emitters.
local function aura(character: Model, duration: number): { ParticleEmitter }
	local emitters = {}
	for _, layer in AURA_LAYERS do
		local target = bodyPart(character, layer.Part)
		if target then
			local e = makeEmitter(layer, target)
			table.insert(emitters, e)
			task.delay(duration, function()
				e.Enabled = false
				Debris:AddItem(e, 1)
			end)
		end
	end
	return emitters
end

local function part(props: { [string]: any }): Part
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.CastShadow = false
	p.Material = Enum.Material.Neon
	for key, value in props do
		(p :: any)[key] = value
	end
	p.Parent = folder
	return p
end

local function fade(instance: Instance, time: number, props: { [string]: any })
	TweenService:Create(instance, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
	Debris:AddItem(instance, time + 0.05)
end

local function isCharacter(value: any): boolean
	return typeof(value) == "Instance" and value:IsA("Model")
end

-- Ghost copies of the caster's body left behind as they move (the accelerated-time look).
local function afterimages(character: Model, duration: number)
	local stop = os.clock() + duration
	while os.clock() < stop and character.Parent do
		for _, child in character:GetChildren() do
			if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" and child.Transparency < 1 then
				local ghost = part({ Size = child.Size, CFrame = child.CFrame, Color = LAVENDER, Transparency = 0.55, Material = Enum.Material.ForceField })
				fade(ghost, 0.35, { Transparency = 1 })
			end
		end
		task.wait(0.12)
	end
end

-- ------------------------------------------------------------------ screen / sky
local skyToken = 0
local savedClock: number? = nil

-- Races the sun through day and night until `duration` ends, then eases back to the real time.
local function raceSky(duration: number)
	skyToken += 1
	local token = skyToken
	if savedClock == nil then
		savedClock = Lighting.ClockTime
	end
	local hoursPerSecond = 16 -- a full day every 1.5s
	local connection: RBXScriptConnection? = nil
	connection = RunService.RenderStepped:Connect(function(dt)
		if token ~= skyToken then
			if connection then
				connection:Disconnect()
			end
			return
		end
		Lighting.ClockTime = (Lighting.ClockTime + dt * hoursPerSecond) % 24
	end)
	task.delay(duration, function()
		if token ~= skyToken then
			return
		end
		if connection then
			connection:Disconnect()
		end
		local original = savedClock or 14
		savedClock = nil
		TweenService:Create(Lighting, TweenInfo.new(0.6, Enum.EasingStyle.Sine), { ClockTime = original }):Play()
	end)
end

local function grade(name: string, duration: number, props: { [string]: any }, fadeIn: number?)
	local effect = Instance.new("ColorCorrectionEffect")
	effect.Name = name
	effect.Parent = Lighting
	if fadeIn and fadeIn > 0 then
		local target = table.clone(props)
		for key in props do
			if key ~= "TintColor" then
				(effect :: any)[key] = 0
			end
		end
		effect.TintColor = Color3.new(1, 1, 1)
		TweenService:Create(effect, TweenInfo.new(fadeIn), target):Play()
	else
		for key, value in props do
			(effect :: any)[key] = value
		end
	end
	task.delay(math.max(duration - 0.4, 0), function()
		TweenService:Create(effect, TweenInfo.new(0.4), { Saturation = 0, Contrast = 0, Brightness = 0, TintColor = Color3.new(1, 1, 1) }):Play()
		Debris:AddItem(effect, 0.45)
	end)
end

local flashGui: ScreenGui? = nil
local function whiteOut(playerGui: Instance, hold: number)
	if not flashGui then
		local gui = Instance.new("ScreenGui")
		gui.Name = "StandFx"
		gui.IgnoreGuiInset = true
		gui.ResetOnSpawn = false
		gui.DisplayOrder = 55
		gui.Parent = playerGui
		flashGui = gui
	end
	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromScale(1, 1)
	frame.BorderSizePixel = 0
	frame.BackgroundColor3 = HEAVEN_WHITE
	frame.BackgroundTransparency = 0
	frame.Parent = flashGui
	task.delay(hold, function()
		fade(frame, 0.8, { BackgroundTransparency = 1 })
	end)
end

-- ------------------------------------------------------------------ entry points
local playerGuiRef: Instance? = nil
function StandFx.SetPlayerGui(gui: Instance)
	playerGuiRef = gui
end

-- Kind = "StandAura": { Character, Stand, Duration }
function StandFx.Aura(info: { [string]: any }): boolean
	if info.Stand ~= "MadeInHeaven" or not isCharacter(info.Character) then
		return false
	end
	aura(info.Character, math.clamp(tonumber(info.Duration) or 1, 0.2, 15))
	return true
end

-- Kind = "Blink" with Stand set: a burst of the aura where you leave and where you land.
function StandFx.Blink(info: { [string]: any }): boolean
	if info.Stand ~= "MadeInHeaven" then
		return false
	end
	for _, key in { "From", "To" } do
		local position = info[key]
		if typeof(position) == "Vector3" then
			local anchor = part({ Size = Vector3.new(2, 5, 2), CFrame = CFrame.new(position), Transparency = 1 })
			for _, layer in AURA_LAYERS do
				local e = makeEmitter(layer, anchor)
				e.Enabled = false
				e.LockedToPart = false
				e.Speed = NumberRange.new(10, 22)
				e:Emit(if layer.Part == "Torso" then 30 else 20)
			end
			Debris:AddItem(anchor, 1.2)
		end
	end
	return true
end

-- Kind = "TimeAccel": { Caster, Duration, Radius }
function StandFx.TimeAccel(info: { [string]: any }): boolean
	local duration = math.clamp(tonumber(info.Duration) or 8, 0.5, 15)
	local caster = info.Caster
	if isCharacter(caster) then
		aura(caster, duration)
		task.spawn(afterimages, caster, duration)
		local radius = tonumber(info.Radius)
		local root = (caster :: Model):FindFirstChild("HumanoidRootPart") :: BasePart?
		if radius and root then
			-- The trapped area: a faint dome that follows the caster.
			local dome = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 2, CFrame = root.CFrame, Color = LAVENDER, Transparency = 0.85, Material = Enum.Material.ForceField })
			TweenService:Create(dome, TweenInfo.new(0.5, Enum.EasingStyle.Quad), { Size = Vector3.one * radius * 2 }):Play()
			local follow = RunService.RenderStepped:Connect(function()
				if root.Parent then
					dome.CFrame = CFrame.new(root.Position)
				end
			end)
			task.delay(duration, function()
				follow:Disconnect()
				fade(dome, 0.3, { Transparency = 1 })
			end)
		end
	end
	raceSky(duration)
	grade("TimeAccel", duration, { Saturation = -0.35, Contrast = 0.2, TintColor = Color3.fromRGB(215, 225, 255) }, 0.4)
	return true
end

-- Kind = "UniverseReset": { Caster, CFrame, Radius }
function StandFx.UniverseReset(info: { [string]: any }): boolean
	if typeof(info.CFrame) ~= "CFrame" then
		return false
	end
	local center = (info.CFrame :: CFrame).Position
	local radius = tonumber(info.Radius) or 40
	-- A new universe expands out of the caster.
	local sphere = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 2, CFrame = CFrame.new(center), Color = HEAVEN_WHITE, Transparency = 0.1 })
	TweenService:Create(sphere, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = Vector3.one * radius * 2, Transparency = 0.6 }):Play()
	task.delay(0.6, function()
		fade(sphere, 0.6, { Transparency = 1 })
	end)
	local ring = part({ Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.4, 2, 2), CFrame = CFrame.new(center) * CFrame.Angles(0, 0, math.rad(90)), Color = LAVENDER, Transparency = 0.2 })
	fade(ring, 0.8, { Size = Vector3.new(0.4, radius * 2.4, radius * 2.4), Transparency = 1 })
	if isCharacter(info.Caster) then
		aura(info.Caster, 1.2)
	end
	-- Everyone sees the white-out as the universe resets.
	if playerGuiRef then
		whiteOut(playerGuiRef, 0.15)
	end
	return true
end

-- Kind = "AlternateUniverse": sent only to Runners caught in the reset.
function StandFx.AlternateUniverse(info: { [string]: any }): boolean
	local duration = math.clamp(tonumber(info.Duration) or 3, 0.5, 8)
	grade("AlternateUniverse", duration, { Saturation = -0.6, Contrast = 0.45, Brightness = -0.05, TintColor = Color3.fromRGB(190, 170, 255) })
	return true
end

return StandFx
