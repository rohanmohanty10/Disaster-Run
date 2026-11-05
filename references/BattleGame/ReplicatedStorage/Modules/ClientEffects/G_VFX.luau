--!nonstrict
-- VFX.lua → ReplicatedStorage/Modules/VFX
-- Effect/particle helpers pulled out of the old _G bootstrap into a real module.
--
-- ENVIRONMENT DEPENDENCIES (still provided by your existing setup — NOT redefined here):
--   Globals : _G.PlayEffect, _G.destroy, _G.raycastWhitelist, _G.tween
--   Method  : Instance:QueryDescendants(query)   (your custom Instance extension)
--   Folders : workspace.Effects(.Decals), workspace.Terrain,
--             workspace.Islands, workspace.Ships, workspace.Env
--   Stats   : ReplicatedStorage["Stats"..player.Name].Settings.ParticleEmitRate
--   flipbook also needs a `DecalHolder` template parented under THIS module.
--
-- NOTE: _G.checkRenderDistance is NOT here (it wasn't in the source you gave me) —
--       keep calling _G.checkRenderDistance until you extract it too.

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local IS_SERVER = RunService:IsServer()

-- Re-export Tween/Destroy so consumers can drop _G/Ess entirely.
-- (If this ever throws a cyclic-require error, swap to lazy wrappers:
--   VFX.Tween = function(...) return _G.Ess.Tween(...) end )
local Ess = require(ReplicatedStorage.Modules.ClientEffects.G_Essentials)

local VFX = {}
VFX.Tween   = Ess.Tween
VFX.Destroy = Ess.Destroy

-- ── Client-only state used to scale particle counts ──────────────────────────
local localStats            -- the local player's Stats folder
local qualityMultiplier = 1

if not IS_SERVER then
	task.spawn(function()
		--localStats = ReplicatedStorage:WaitForChild("Stats" .. Players.LocalPlayer.Name)
	end)

	local userSettings = UserSettings():GetService("UserGameSettings")
	local function refreshQuality()
		if userSettings.SavedQualityLevel == Enum.SavedQualitySetting.Automatic then
			qualityMultiplier = 0.5
		else
			qualityMultiplier = userSettings.SavedQualityLevel.Value / 10
		end
	end
	refreshQuality()
	userSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(refreshQuality)
end

-- ═════════════════════════════════════════════════════════════════════════════
--  RAYCAST HELPERS
-- ═════════════════════════════════════════════════════════════════════════════

-- Raycasts straight down from `cframe.Position` to find the floor.
-- Returns whatever _G.raycastWhitelist returns: hitPart, hitPosition, hitNormal.
function VFX.getRayFloor(cframe, depth, whitelistOrFlag, extra)
	local rayLength = depth + 1
	local whitelist, flag
	if whitelistOrFlag == true then
		whitelist, flag = nil, true
	else
		whitelist, flag = whitelistOrFlag, extra
	end
	if whitelist == nil then
		whitelist =  {workspace.World.Map.Destroyable.Map}--{ workspace.Islands, workspace.Ships, workspace.Env }
	end
	local ray = Ray.new(cframe.Position + Vector3.new(0, 1, 0), Vector3.new(0, -rayLength, 0))
	return Ess.raycastWhitelist(ray, whitelist) --_G.raycastWhitelist(ray, whitelist, flag)
end

-- Raycasts from `fromPart` toward `toPart` to find a wall between them.
function VFX.getRayWall(fromPart, toPart, whitelist)
	--whitelist = whitelist or { workspace.World.Map.Baseplate }--{ workspace.Islands, workspace.Ships, workspace.Env }
	--local distance = (fromPart.Position - toPart.Position).Magnitude
	--local direction = (toPart.Position - fromPart.Position).Unit * distance
	--return Ess.raycastWhitelist(ray, whitelist) --_G.raycastWhitelist(Ray.new(fromPart.Position, direction), whitelist)
	whitelist = whitelist or { workspace.World.Map }
	local ray = Ray.new(fromPart.Position, toPart.Position - fromPart.Position)
	return Ess.raycastWhitelist(ray, whitelist)

end

-- ═════════════════════════════════════════════════════════════════════════════
--  PARTICLE UTILITIES
-- ═════════════════════════════════════════════════════════════════════════════

-- Scales a particle effect: bigger size keypoints, faster speed, lower drag.
--   deepSearch nil = top-level emitters only, non-nil = all descendant emitters.
function VFX.scaleParticle(container, scale, deepSearch)
	scale = scale or 1
	local query = deepSearch == nil and ">ParticleEmitter" or "ParticleEmitter"
	for _, emitter in container:QueryDescendants(query) do
		local keypoints = {}
		for _, kp in emitter.Size.Keypoints do
			table.insert(keypoints, NumberSequenceKeypoint.new(kp.Time, kp.Value * scale))
		end
		emitter.Drag = emitter.Drag / scale
		emitter.Size = NumberSequence.new(keypoints)
		emitter.Speed = NumberRange.new(emitter.Speed.Min * scale, emitter.Speed.Max * scale)
	end
end

-- Recolors every tagged visual under `container` (Color3 or ColorSequence).
--   tag : attribute name marking recolorable instances (default "recolorable").
function VFX.recolorParticles(container, color, tag)
	if color == nil then return end
	local attr = tag or "recolorable"
	for _, inst in container:GetDescendants() do
		local visual = inst:IsA("ParticleEmitter") or inst:IsA("BasePart")
			or inst:IsA("PointLight") or inst:IsA("Trail")
			or inst:IsA("Decal") or inst:IsA("Beam")
		if visual and inst:GetAttribute(attr) ~= nil then
			if inst:IsA("Trail") or inst:IsA("ParticleEmitter") or inst:IsA("Beam") then
				inst.Color = typeof(color) == "ColorSequence" and color or ColorSequence.new(color)
			elseif inst:IsA("Decal") then
				inst.Color3 = color
			else
				inst.Color = color
			end
		end
	end
end

-- Destroys particle emitters flagged with a ground-color attribute.
function VFX.removeGroundParticles(container, attribute)
	attribute = attribute or "UseGroundColor"
	for _, inst in container:GetDescendants() do
		if inst:IsA("ParticleEmitter") and inst:GetAttribute(attribute) then
			inst:Destroy()
		end
	end
end

-- Hides tagged emitters by forcing full transparency.
function VFX.removeParticles(container, tag)
	tag = tag or "recolorable"
	for _, inst in container:GetDescendants() do
		if inst:GetAttribute(tag) ~= nil then
			inst.Transparency = NumberSequence.new(1)
		end
	end
end

-- Sets .Enabled on emitters (and optionally Trails/Beams and extra ClassNames).
--   extraClasses : table whose KEYS are extra ClassNames to include.
function VFX.particleEnabled(container, enabled, includeTrails, extraClasses)
	local selectors = {}
	for className in pairs(extraClasses or {}) do
		table.insert(selectors, ('[ClassName="%s"]'):format(className))
	end
	if includeTrails then
		table.insert(selectors, "Trail")
		table.insert(selectors, "Beam")
	end
	local query = "ParticleEmitter" .. (#selectors > 0 and "," .. table.concat(selectors, ",") or "")
	for _, inst in container:QueryDescendants(query) do
		inst.Enabled = enabled
	end
end

-- Scales a model's parts (size + position) around its pivot.
function VFX.scaleModel(model, scale)
	local primary = model.PrimaryPart
	local pivot = primary == nil and model:GetPivot() or primary.CFrame
	for _, part in model:QueryDescendants(">BasePart") do
		part.Size = part.Size * scale
		if part ~= primary then
			part.CFrame = pivot + pivot:Inverse() * part.Position * scale
		end
	end
	return model
end

-- ═════════════════════════════════════════════════════════════════════════════
--  EMIT CORE
-- ═════════════════════════════════════════════════════════════════════════════

-- Emits particles, scaled by graphics quality and the player's particle-rate setting.
--   target     : container Instance (children scanned) OR array of instances
--   burst      : true  -> one-shot burst from each emitter (honors EmitDelay/EmitCount)
--                false -> toggle .Enabled (bursting if it was off), toggle back after enableTime
--   enableTime : (burst=false) seconds to stay enabled before toggling back
function VFX.Emit(target, burst, enableTime, extra)
	if IS_SERVER then
		_G.PlayEffect("Emit", nil, target, burst, enableTime, extra)
		return
	end

	if typeof(target) == "Instance" then
		target = target:GetChildren()
	end
	if target == nil then return end

	local rateMultiplier = (not localStats) and 1 or localStats.Settings.ParticleEmitRate.Value

	local function burstEmitter(emitter, requestedCount)
		local emitCount = emitter:GetAttribute("EmitCount")
		local emitDelay = emitter:GetAttribute("EmitDelay")
		local countAllows = emitCount == nil or emitCount > 0
		local delayAllows = type(emitDelay) == "number" and emitDelay > 0
		if not (countAllows or delayAllows) then return end

		local count = requestedCount or emitCount or 10
		task.delay(emitDelay or 0, function()
			if not emitter then return end
			local quality = UserSettings().GameSettings.SavedQualityLevel
			local qualityScale
			if count == 1 then
				qualityScale = 1
			elseif quality == Enum.SavedQualitySetting.Automatic then
				qualityScale = 0.5
			else
				qualityScale = quality.Value / 10
			end
			local amount = math.ceil(count * qualityScale) * rateMultiplier
			emitter:Emit(math.max(amount, 1))
		end)
	end

	if burst then
		for _, child in pairs(target) do
			if child:IsA("ParticleEmitter") then
				local delay = child:GetAttribute("EmitDelay")
				if delay then
					task.delay(delay, function()
						burstEmitter(child, child:GetAttribute("EmitCount"))
					end)
				else
					burstEmitter(child, child:GetAttribute("EmitCount"))
				end
			end
		end
	else
		for _, child in pairs(target) do
			if child:IsA("ParticleEmitter") then
				if not child.Enabled then
					burstEmitter(child, child:GetAttribute("EmitCount"))
				end
				child.Enabled = not child.Enabled
				if enableTime then
					task.delay(enableTime, function()
						child.Enabled = not child.Enabled
					end)
				end
			end
		end
	end
end

-- Like Emit, but scales by a cached quality multiplier and supports EmitDuration.
--   rateMode : nil  -> burst using each emitter's EmitCount
--              else -> emit a frame's worth based on .Rate
function VFX.customEmit(target, rateMode, extra)
	if target == nil then return end

	if IS_SERVER then
		_G.PlayEffect("CustomEmit", nil, target, rateMode, extra) -- (dropped the dead validation reads)
		return
	end

	local particleRate = (not localStats) and 1 or localStats.Settings.ParticleEmitRate.Value
	local emitScale = qualityMultiplier * particleRate

	local ok, err = pcall(function()
		local function fire(emitter)
			local delay = emitter:GetAttribute("EmitDelay") or 0
			local duration = emitter:GetAttribute("EmitDuration") or 0
			task.delay(delay, function()
				if rateMode == nil then
					local count = emitter:GetAttribute("EmitCount")
					if (count == nil or count == 0) and duration == 0 then return end
					if typeof(count) ~= "number" and duration == 0 then return end
					if count then
						local amount = count * emitScale
						emitter:Emit(amount < 1 and 1 or amount)
					end
				else
					local amount = emitter.Rate * emitScale
					emitter:Emit(amount < 1 and 1 or amount)
				end
				if duration ~= 0 then
					emitter.Enabled = true
					task.delay(duration, function() emitter.Enabled = false end)
				end
			end)
		end

		if typeof(target) ~= "Instance" then return end
		if target:IsA("ParticleEmitter") then
			fire(target)
		else
			for _, emitter in ipairs(target:QueryDescendants("ParticleEmitter")) do
				fire(emitter)
			end
		end
	end)
	if not ok then warn("ERROR:", err) end
end

-- ═════════════════════════════════════════════════════════════════════════════
--  COMPOSITE VFX SPAWNERS
-- ═════════════════════════════════════════════════════════════════════════════

-- Clones a hit template at `cframe` with random spin, scales/recolors, emits,
-- fades any PointLight, and cleans up after 8s.
--   color : Color3/ColorSequence, OR { Color = ..., Tag = ... } to target a recolor tag.
function VFX.emitHitVfx(template, cframe, scale, color)
	local tag
	if typeof(color) == "table" then
		tag, color = color.Tag, color.Color
	end

	local fx = template:Clone()
	fx.CFrame = cframe * CFrame.Angles(
		math.rad(math.random(0, 360)),
		math.rad(math.random(0, 360)),
		math.rad(math.random(0, 360))
	)
	if scale then VFX.scaleParticle(fx, scale, true) end
	if color then VFX.recolorParticles(fx, color, tag) end

	local light = fx:FindFirstChildWhichIsA("PointLight")
	fx.Parent = workspace.Effects
	if light then
		_G.tween(light, { 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
		{ Range = light.Range * 3, Brightness = 0 })
	end

	VFX.customEmit(fx)
	_G.destroy(fx, 8)
	return fx
end

-- Same idea, driven by a params table and a fixed CFrame (no random spin). Cleans up after 5s.
--   params : { CFrame = ..., Scale = ..., Color = Color3/ColorSequence or { Color =, Tag = } }
function VFX.customEmitCFrame(template, params)
	local scale, color = params.Scale, params.Color
	local tag
	if typeof(color) == "table" then
		tag, color = color.Tag, color.Color
	end

	local fx = template:Clone()
	fx.CFrame = params.CFrame
	if scale then VFX.scaleParticle(fx, scale, true) end
	if color then VFX.recolorParticles(fx, color, tag) end

	local light = fx:FindFirstChildWhichIsA("PointLight")
	fx.Parent = workspace.Effects
	if light then
		_G.tween(light, { 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
		{ Range = light.Range * 3, Brightness = 0 })
	end

	VFX.customEmit(fx)
	_G.destroy(fx, 5)
	return fx
end

-- Lays a VFX flat on the floor below `opts.StartCFrame`, tinted to the floor color.
--   opts : { StartCFrame, Depth = 6, Offset = -90° tilt, Clone = auto-spawn/cleanup }
function VFX.vfxToFloor(instance, opts)
	local startCFrame = opts.StartCFrame
	local depth = opts.Depth or 6
	local offset = opts.Offset or CFrame.Angles(-1.5709708597200962, 0, 0) -- ≈ -90° on X

	if opts.Clone then
		instance = instance:Clone()
	end

	local floorPart, hitPos, hitNormal = VFX.getRayFloor(startCFrame, depth)
	if not floorPart then
		if opts.Clone then instance:Destroy() else instance:ClearAllChildren() end
		return nil
	end

	local placement = CFrame.new(hitPos, hitPos + hitNormal) * offset * CFrame.new(0, 0.1, 0)
	VFX.recolorParticles(instance, floorPart.Color)
	if instance:IsA("BasePart") then
		instance.CFrame = placement
	elseif instance:IsA("Attachment") then
		instance.WorldCFrame = placement
	end

	if opts.Clone ~= nil then
		instance.Parent = workspace.Effects
		VFX.customEmit(instance)
		_G.destroy(instance, 6)
	end
	return instance
end

-- ═════════════════════════════════════════════════════════════════════════════
--  SOUND
-- ═════════════════════════════════════════════════════════════════════════════

-- Plays a one-shot copy of `sound` at `target`, then cleans it up.
--   target  : BasePart, Model, Attachment, or CFrame
--   options : { RandomSound, RandomPitch, <any existing Sound property to override> }
-- NOTE: property overrides only apply when the property's current value is truthy
--       (a quirk of the original — e.g. can't set Looped while it's currently false).
function VFX.PlaySound(target, sound, options)
	if target == nil then return end
	if typeof(target) == "Instance" and not target.Parent then return end
	if not sound then return end

	if options and options.RandomSound then
		local choices = sound:GetChildren()
		if #choices == 0 then return end
		sound = choices[math.random(1, #choices)]
	end

	local lifetime = sound.TimeLength + 5
	local soundClone = sound:Clone()

	if options then
		for key, value in options do
			pcall(function()
				if soundClone[key] then
					soundClone[key] = value
				end
			end)
		end
		if options.RandomPitch ~= nil then
			soundClone.Pitch = math.random(90, 110) / 100
		end
	end

	soundClone.PlayOnRemove = false

	if typeof(target) == "Instance" and target:IsA("Attachment") then
		soundClone.Parent = target
		_G.destroy(soundClone, lifetime)
	else
		local worldCF
		if typeof(target) == "Instance" then
			if target:IsA("BasePart") then
				worldCF = target.CFrame
			elseif target:IsA("Model") then
				worldCF = target:GetPivot()
			end
		else
			worldCF = target -- CFrame
		end

		local attachment = Instance.new("Attachment")
		attachment.WorldCFrame = worldCF
		attachment.Parent = workspace.Terrain
		soundClone.Parent = attachment

		_G.destroy(attachment, lifetime)
		_G.destroy(soundClone, lifetime)
	end

	soundClone:Play()
	return soundClone
end

-- ═════════════════════════════════════════════════════════════════════════════
--  FLIPBOOK
-- ═════════════════════════════════════════════════════════════════════════════

-- Cycles a SpecialMesh's TextureId to play a flipbook animation.
--   part / textures(array) / fps / destroyAfter(bool)
-- NOTE: needs a `DecalHolder` template parented under THIS module (copy from old script).
function VFX.flipbook(part, textures, fps, destroyAfter)
	local mesh = part:FindFirstChildOfClass("SpecialMesh")
	if not (mesh and textures) then return end

	task.spawn(function()
		local character = Players.LocalPlayer.Character
		local alreadyLoaded = workspace.Effects.Decals:FindFirstChild(textures[1]) ~= nil
		if not alreadyLoaded and character and character:FindFirstChild("Head") then
			local holder = script.DecalHolder:Clone()
			holder.Name = textures[1]
			holder.CFrame = CFrame.new(part.Position.X, -500, part.Position.Z)
			holder.Parent = workspace.Effects.Decals
			for _, texture in textures do
				local decal = Instance.new("Decal")
				decal.Texture = texture
				decal.Parent = holder
			end
			holder.Anchored = true
		end

		for _, texture in textures do
			mesh.TextureId = texture
			task.wait(1 / fps)
		end

		if destroyAfter == true then
			mesh.Parent:Destroy()
		end
	end)
end

return VFX