--!strict
-- Ability visuals, all built in code so they work without imported assets
-- (the reference VFX modules can replace them per element later):
--   telegraphs (fill up until impact), impacts (flash + particles + shake), lingering zones,
--   bolts, blinks, buffs, domains, screen effects (blind, invert, time stop) and the Runner
--   danger warning (GAME_PLAN.md 5C) — Flow State sees it as soon as a strike is aimed.
--   Crimson Epitaph's effects (erased time, Epitaph) are original code modelled on the King Crimson
--   Requiem effects in the Universe Game reference; its sounds are empty slots in SoundConfig.luau.

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)

local UIController = require(script.Parent.UIController)
local SkillFx = require(script.Parent.SkillFx)
local StandFx = require(script.Parent.StandFx)
local SoundConfig = require(ReplicatedStorage.Shared.Config.SoundConfig)
local Audio = require(script.Parent.Audio)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui

local FxController = {}

local ELEMENT_COLORS: { [string]: Color3 } = {
	Boulder = Color3.fromRGB(150, 110, 70),
	Wind = Color3.fromRGB(210, 245, 255),
	Fire = Color3.fromRGB(255, 120, 30),
	Ice = Color3.fromRGB(150, 220, 255),
	Water = Color3.fromRGB(60, 140, 255),
	Sand = Color3.fromRGB(230, 200, 130),
	Shadow = Color3.fromRGB(70, 40, 110),
	Magma = Color3.fromRGB(255, 70, 20),
	Lightning = Color3.fromRGB(255, 240, 90),
	Meteor = Color3.fromRGB(255, 110, 50),
	Gravity = Color3.fromRGB(150, 90, 255),
	Light = Color3.fromRGB(255, 235, 150),
	Quake = Color3.fromRGB(235, 235, 235),
	BlackFlame = Color3.fromRGB(40, 0, 60),
	Spirit = Color3.fromRGB(190, 110, 255),
	Slash = Color3.fromRGB(230, 30, 50),
	Void = Color3.fromRGB(120, 80, 255),
}
local WARNING = Color3.fromRGB(255, 50, 50)

-- Crimson Epitaph colours (modelled on King Crimson Requiem's look in the Universe Game reference).
local KCR = {
	Aura = ColorSequence.new(Color3.fromRGB(229, 140, 50), Color3.fromRGB(255, 209, 70)),
	Gold = Color3.fromRGB(255, 190, 60),
	Ghost = Color3.fromRGB(255, 0, 0), -- the "future" afterimages in erased time
	EraseAmbient = Color3.fromRGB(170, 0, 255),
	Skip = Color3.fromRGB(200, 20, 40), -- the time-skip screen cut
}

local folder: Folder
local danger: Frame
local overlay: Frame
local arrowHolder: Frame
local hazardArrow: (Vector3, number) -> ()

local function colorOf(element: any): Color3
	return ELEMENT_COLORS[element] or Color3.fromRGB(255, 255, 255)
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

-- A flat ground shape (Circle / Line / Cone) at height 0.15.
local function groundShape(info: { [string]: any }, color: Color3, transparency: number, scale: number?): Part?
	local s = scale or 1
	if typeof(info.CFrame) ~= "CFrame" then
		return nil
	end
	local cf: CFrame = info.CFrame
	if info.Shape == "Line" then
		local length, width = tonumber(info.Length) or 40, tonumber(info.Width) or 6
		return part({ Size = Vector3.new(width * s, 0.2, length), CFrame = cf * CFrame.new(0, 0.15, -length / 2), Color = color, Transparency = transparency })
	elseif info.Shape == "Cone" then
		local length, angle = tonumber(info.Length) or 40, tonumber(info.Angle) or 60
		return part({ Size = Vector3.new(2 * length * math.tan(math.rad(angle / 2)) * s, 0.2, length), CFrame = cf * CFrame.new(0, 0.15, -length / 2), Color = color, Transparency = transparency })
	end
	local radius = (tonumber(info.Radius) or 8) * s
	return part({ Shape = Enum.PartType.Cylinder, Size = Vector3.new(0.2, radius * 2, radius * 2), CFrame = CFrame.new(cf.Position + Vector3.new(0, 0.15, 0)) * CFrame.Angles(0, 0, math.rad(90)), Color = color, Transparency = transparency })
end

local function shake(position: Vector3, strength: number)
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = humanoid and humanoid.RootPart
	if not humanoid or not root or LocalPlayer:GetAttribute("Role") == "God" then
		return
	end
	local distance = (root.Position - position).Magnitude
	if distance > 60 then
		return
	end
	local power = strength * (1 - distance / 60)
	task.spawn(function()
		local base = humanoid.CameraOffset
		for _ = 1, 8 do
			humanoid.CameraOffset = base + Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10)) / 10 * power
			task.wait(0.03)
		end
		humanoid.CameraOffset = base
	end)
end

local function burst(position: Vector3, color: Color3, count: number)
	local anchor = part({ Size = Vector3.one * 0.2, Transparency = 1, Position = position })
	local attachment = Instance.new("Attachment")
	attachment.Parent = anchor
	local emitter = Instance.new("ParticleEmitter")
	emitter.Color = ColorSequence.new(color)
	emitter.LightEmission = 0.8
	emitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.2), NumberSequenceKeypoint.new(1, 0) })
	emitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
	emitter.Speed = NumberRange.new(15, 35)
	emitter.Lifetime = NumberRange.new(0.4, 0.9)
	emitter.SpreadAngle = Vector2.new(180, 180)
	emitter.Acceleration = Vector3.new(0, -30, 0)
	emitter.Rate = 0
	emitter.Parent = attachment
	emitter:Emit(count)
	Debris:AddItem(anchor, 1.5)
end

-- ------------------------------------------------------------------ screen effects
local function screenFlash(color: Color3, duration: number, from: number?)
	overlay.BackgroundColor3 = color
	overlay.BackgroundTransparency = from or 0
	overlay.Visible = true
	local tween = TweenService:Create(overlay, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { BackgroundTransparency = 1 })
	tween:Play()
	tween.Completed:Once(function()
		if overlay.BackgroundTransparency >= 0.99 then
			overlay.Visible = false
		end
	end)
end

local function colorEffect(name: string, duration: number, props: { [string]: any })
	local effect = Instance.new("ColorCorrectionEffect")
	effect.Name = name
	effect.Parent = Lighting
	for key, value in props do
		(effect :: any)[key] = value
	end
	task.delay(duration, function()
		TweenService:Create(effect, TweenInfo.new(0.3), { Saturation = 0, Contrast = 0, TintColor = Color3.new(1, 1, 1), Brightness = 0 }):Play()
		task.wait(0.3)
		effect:Destroy()
	end)
end

-- A red arrow at the edge of the screen pointing toward an incoming strike (GAME_PLAN.md 5C),
-- until it lands.
hazardArrow = function(target: Vector3, duration: number)
	local arrow = Instance.new("TextLabel")
	arrow.BackgroundTransparency = 1
	arrow.AnchorPoint = Vector2.new(0.5, 0.5)
	arrow.Size = UDim2.fromOffset(46, 46)
	arrow.Text = "▲"
	arrow.TextScaled = true
	arrow.TextColor3 = WARNING
	arrow.TextStrokeTransparency = 0.3
	arrow.Font = Enum.Font.GothamBlack
	arrow.Parent = arrowHolder
	local started = os.clock()
	local connection: RBXScriptConnection
	connection = game:GetService("RunService").RenderStepped:Connect(function()
		local character = LocalPlayer.Character
		local root = character and Characters.GetRoot(character)
		local elapsed = os.clock() - started
		if not root or elapsed >= duration or not arrow.Parent then
			connection:Disconnect()
			arrow:Destroy()
			return
		end
		-- Direction to the strike relative to where the camera faces (top of screen = ahead).
		local camera = workspace.CurrentCamera
		local look = camera.CFrame.LookVector * Vector3.new(1, 0, 1)
		local offset = (target - root.Position) * Vector3.new(1, 0, 1)
		if look.Magnitude < 0.01 or offset.Magnitude < 2 then
			arrow.Visible = false
			return
		end
		arrow.Visible = true
		look, offset = look.Unit, offset.Unit
		local right = Vector3.new(-look.Z, 0, look.X)
		local angle = math.atan2(offset:Dot(right), offset:Dot(look)) -- 0 = ahead, +90° = right
		arrow.Position = UDim2.fromScale(0.5 + math.sin(angle) * 0.38, 0.5 - math.cos(angle) * 0.38)
		arrow.Rotation = math.deg(angle)
		-- Pulse faster as impact gets closer.
		arrow.TextTransparency = 0.15 + 0.35 * (0.5 + 0.5 * math.sin(elapsed * (6 + 10 * elapsed / duration)))
	end)
end

-- Red pulse when a strike is about to land near the local Runner.
local function dangerCheck(info: { [string]: any })
	if LocalPlayer:GetAttribute("Role") ~= "Runner" or typeof(info.CFrame) ~= "CFrame" then
		return
	end
	local character = LocalPlayer.Character
	local root = character and Characters.GetRoot(character)
	if not root then
		return
	end
	local center = (info.CFrame :: CFrame).Position
	local reach = (tonumber(info.Radius) or tonumber(info.Length) or 10) + 25
	if ((root.Position - center) * Vector3.new(1, 0, 1)).Magnitude > reach then
		return
	end
	local duration = tonumber(info.Duration) or 1
	local flow = LocalPlayer:GetAttribute("Passive_FlowState") == true
	local delayTime = if flow then 0 else math.max(duration - 0.6, 0)
	task.delay(delayTime, function()
		danger.Visible = true
		danger.BackgroundTransparency = 0.55
		local tween = TweenService:Create(danger, TweenInfo.new(0.5, Enum.EasingStyle.Sine), { BackgroundTransparency = 1 })
		tween:Play()
	end)
	hazardArrow(center, math.clamp(duration, 0.1, 5))
end

-- Plays a skill's Telegraph / Impact sound at the strike (SoundConfig.luau).
local function playSkillSound(info: { [string]: any }, slot: "Telegraph" | "Impact")
	local entry = (if type(info.Skill) == "string" then SoundConfig.Skills[info.Skill] else nil)
		or (if type(info.Element) == "string" then SoundConfig.Elements[info.Element] else nil)
	local id = entry and entry[slot]
	if not id or id == "" or typeof(info.CFrame) ~= "CFrame" then
		return
	end
	local anchor = part({ Size = Vector3.one * 0.2, Transparency = 1, Position = (info.CFrame :: CFrame).Position })
	local sound = Instance.new("Sound")
	sound.SoundId = id
	sound.Volume = SoundConfig.Volume
	sound.SoundGroup = Audio.Group()
	sound.RollOffMode = Enum.RollOffMode.InverseTapered
	sound.RollOffMaxDistance = SoundConfig.MaxDistance
	sound.Parent = anchor
	sound:Play()
	sound.Ended:Once(function()
		anchor:Destroy()
	end)
	Debris:AddItem(anchor, 15)
end

-- ------------------------------------------------------------------ King Crimson Requiem
-- Plays a Crimson Epitaph sound from SoundConfig.Stands (empty slots don't play).
-- With a parent part it's 3D; without one it's local to this player.
local function kcrSound(name: string, parent: Instance?): Sound?
	local slots = SoundConfig.Stands.CrimsonEpitaph
	local id = slots and slots[name]
	if type(id) ~= "string" or id == "" then
		return nil
	end
	local sound = Instance.new("Sound")
	sound.Name = name
	sound.SoundId = id
	sound.Volume = SoundConfig.Volume
	sound.SoundGroup = Audio.Group()
	if parent then
		sound.Parent = parent
		sound:Play()
	else
		sound.Parent = SoundService
		SoundService:PlayLocalSound(sound)
	end
	sound.Ended:Once(function()
		sound:Destroy()
	end)
	Debris:AddItem(sound, 30)
	return sound
end

-- The time-skip cut across the whole screen (original effect): a few hard red/black frames
-- with jagged tear lines, then it snaps back.
local function timeSkipFlash()
	local gui = Instance.new("ScreenGui")
	gui.Name = "TimeSkipEffect"
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 60
	gui.ResetOnSpawn = false
	local base = Instance.new("Frame")
	base.Size = UDim2.fromScale(1, 1)
	base.BorderSizePixel = 0
	base.Parent = gui
	gui.Parent = PlayerGui
	local frames = { KCR.Skip, Color3.new(0, 0, 0), KCR.Skip, Color3.new(1, 1, 1), Color3.new(0, 0, 0) }
	for i, color in frames do
		base.BackgroundColor3 = color
		base.BackgroundTransparency = 0.15 + i * 0.12
		for _ = 1, 3 do
			local tear = Instance.new("Frame")
			tear.BorderSizePixel = 0
			tear.BackgroundColor3 = if color == KCR.Skip then Color3.new(0, 0, 0) else KCR.Skip
			tear.AnchorPoint = Vector2.new(0.5, 0.5)
			tear.Position = UDim2.fromScale(math.random(), math.random())
			tear.Size = UDim2.new(1.4, 0, 0, math.random(2, 10))
			tear.Rotation = math.random(-35, 35)
			tear.Parent = base
		end
		RunService.RenderStepped:Wait()
		RunService.RenderStepped:Wait()
		base:ClearAllChildren()
	end
	gui:Destroy()
end

local function rootOf(character: any): BasePart?
	if typeof(character) ~= "Instance" or not character:IsA("Model") then
		return nil
	end
	return Characters.GetRoot(character)
end

local function goldEmitter(parent: Instance, props: { [string]: any }): ParticleEmitter
	local emitter = Instance.new("ParticleEmitter")
	emitter.Color = KCR.Aura
	emitter.LightEmission = 1
	emitter.LockedToPart = true
	emitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 1) })
	for key, value in props do
		(emitter :: any)[key] = value
	end
	emitter.Parent = parent
	return emitter
end

-- Characters hidden from this client during someone's Time Erasure.
local erased: { [Model]: boolean } = {}
local erasedLoop: RBXScriptConnection? = nil

local function setHidden(character: Model, hidden: boolean)
	for _, d in character:GetDescendants() do
		if d:IsA("BasePart") or d:IsA("Decal") then
			d.LocalTransparencyModifier = if hidden then 1 else 0
		elseif d:IsA("Sound") then
			-- TimeErasureMute: you can't hear an erased Runner either.
			local mute = d:FindFirstChild("TimeErasureMute")
			if hidden and not mute then
				local eq = Instance.new("EqualizerSoundEffect")
				eq.Name = "TimeErasureMute"
				eq.Priority = 1000
				eq.HighGain, eq.MidGain, eq.LowGain = -80, -80, -80
				eq.Parent = d
			elseif not hidden and mute then
				mute:Destroy()
			end
		end
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = if hidden then Enum.HumanoidDisplayDistanceType.None else Enum.HumanoidDisplayDistanceType.Viewer
	end
end

local function hideErased(character: Model, duration: number)
	erased[character] = true
	if not erasedLoop then
		erasedLoop = RunService.RenderStepped:Connect(function()
			for c in erased do
				setHidden(c, true)
			end
		end)
	end
	local start = os.clock()
	repeat
		task.wait(0.1)
	until os.clock() - start >= duration or character:GetAttribute("TimeErased") ~= true or not character.Parent
	erased[character] = nil
	if character.Parent then
		setHidden(character, false)
	end
	if next(erased) == nil and erasedLoop then
		erasedLoop:Disconnect()
		erasedLoop = nil
	end
end

-- A red see-through copy of a character's body, left where they are (the KC "future" ghost).
local function ghostOf(character: Model): Model
	local ghost = Instance.new("Model")
	ghost.Name = "TimeEraseGhost"
	for _, d in character:GetChildren() do
		if d:IsA("BasePart") and d.Name ~= "HumanoidRootPart" then
			local copy = part({ Size = d.Size, CFrame = d.CFrame, Color = KCR.Ghost, Transparency = 0.7, Material = Enum.Material.ForceField })
			copy.Parent = ghost
		end
	end
	ghost.Parent = folder
	return ghost
end

-- What the erasing Runner sees: the world shatters and fades, the sky turns purple,
-- and every other Runner leaves red afterimages showing where they're heading.
local function eraseWorld(character: Model, duration: number)
	task.spawn(timeSkipFlash)
	kcrSound("TimeEraseActivate")
	kcrSound("TimeErase")
	kcrSound("TimeEraseVoiceline")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local panic = humanoid and humanoid.Health <= humanoid.MaxHealth * 0.35
	local ambient = kcrSound(if panic then "TimeEraseAmbientPanic" else "TimeEraseAmbient")

	local root = Characters.GetRoot(character)
	local origin = if root then root.Position else Vector3.zero
	local world = workspace:FindFirstChild("Course") or workspace
	local skip: { Instance } = { folder }
	for _, player in Players:GetPlayers() do
		if player.Character then
			table.insert(skip, player.Character)
		end
	end
	for _, name in { "AbilityDecoys", "TestDummies", "GodReticle", "HitboxDebug" } do
		local f = workspace:FindFirstChild(name)
		if f then
			table.insert(skip, f)
		end
	end
	local function skipped(d: Instance): boolean
		for _, s in skip do
			if d == s or d:IsDescendantOf(s) then
				return true
			end
		end
		return false
	end

	-- Nearby pieces fly apart and shrink away; the real world stays as a faint outline
	-- (fully invisible would hide the obstacles you're running through).
	local saved: { [Instance]: number } = {}
	for _, d in world:GetDescendants() do
		if (d:IsA("BasePart") and not d:IsA("Terrain")) or d:IsA("Decal") or d:IsA("Texture") then
			if not skipped(d) then
				local p = d :: any
				saved[d] = p.LocalTransparencyModifier
				p.LocalTransparencyModifier = 0.85
				if d:IsA("BasePart") and d.Transparency < 1 and (d.Position - origin).Magnitude <= 50 and d.Size.Magnitude < 150 then
					local shard = part({ Size = d.Size, CFrame = d.CFrame, Color = d.Color, Material = d.Material, Transparency = d.Transparency })
					local r = math.random
					TweenService:Create(shard, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {
						CFrame = shard.CFrame * CFrame.Angles(math.rad(r(-360, 360)), math.rad(r(-360, 360)), math.rad(r(-360, 360))) * CFrame.new(r(-50, 50), r(-25, 25), r(-25, 25)),
					}):Play()
					task.delay(0.15, function()
						TweenService:Create(shard, TweenInfo.new(0.55, Enum.EasingStyle.Quad), { Size = Vector3.zero }):Play()
					end)
					Debris:AddItem(shard, 0.75)
				end
			end
		end
	end

	local oldAmbient = Lighting.Ambient
	Lighting.Ambient = KCR.EraseAmbient
	local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
	local oldAtmosphere = if atmosphere then { atmosphere.Density, atmosphere.Glare, atmosphere.Haze } else nil
	if atmosphere then
		atmosphere.Density, atmosphere.Glare, atmosphere.Haze = 0, 0, 0
	end
	local tint = Instance.new("ColorCorrectionEffect")
	tint.Name = "TimeErase"
	tint.TintColor = Color3.fromRGB(215, 170, 255)
	tint.Saturation = -0.25
	tint.Contrast = 0.15
	tint.Parent = Lighting

	local ghosts: { Model } = {}
	local start = os.clock()
	local nextGhost = 0
	repeat
		local elapsed = os.clock() - start
		if elapsed >= nextGhost then
			nextGhost += 1
			for _, player in Players:GetPlayers() do
				local other = player.Character
				if other and other ~= character and player:GetAttribute("Role") == "Runner" and Characters.IsAlive(other) then
					table.insert(ghosts, ghostOf(other))
				end
			end
		end
		task.wait(0.05)
	until os.clock() - start >= duration or character:GetAttribute("TimeErased") ~= true or not character.Parent

	for d, value in saved do
		if d.Parent then
			(d :: any).LocalTransparencyModifier = value
		end
	end
	for _, ghost in ghosts do
		ghost:Destroy()
	end
	Lighting.Ambient = oldAmbient
	if atmosphere and oldAtmosphere then
		atmosphere.Density, atmosphere.Glare, atmosphere.Haze = oldAtmosphere[1], oldAtmosphere[2], oldAtmosphere[3]
	end
	tint:Destroy()
	if ambient then
		ambient:Destroy()
	end
	kcrSound("TimeEraseEnd")
	kcrSound("TimeEraseEndVoiceline")
	timeSkipFlash()
end

-- ------------------------------------------------------------------ handlers
local handlers: { [string]: (info: { [string]: any }) -> () } = {}

handlers.Telegraph = function(info)
	SkillFx.Telegraph(info) -- extra signature visuals; the ground warning below always draws
	if not info.Silent then
		playSkillSound(info, "Telegraph") -- Silent: a second warning for the same cast (Flame Arrow's path)
	end
	local duration = math.clamp(tonumber(info.Duration) or 1, 0.05, 20)
	local color = colorOf(info.Element)
	local outline = groundShape(info, if info.Faint then color else WARNING, if info.Faint then 0.8 else 0.7)
	local fill = groundShape(info, color, 0.35, 0.05)
	if fill and outline then
		-- The fill grows to the outline's size exactly when the strike lands.
		TweenService:Create(fill, TweenInfo.new(duration, Enum.EasingStyle.Linear), { Size = outline.Size }):Play()
	end
	if outline then
		Debris:AddItem(outline, duration + 0.05)
	end
	if fill then
		Debris:AddItem(fill, duration + 0.05)
	end
	dangerCheck(info)
end

handlers.Impact = function(info)
	playSkillSound(info, "Impact")
	if SkillFx.Impact(info) then
		return
	end
	local color = colorOf(info.Element)
	local flash = groundShape(info, color, 0.1)
	if flash then
		local up = flash.Size
		local grow = if info.Shape == "Circle" or info.Shape == nil then Vector3.new(up.X + 6, up.Y * 1.1, up.Z * 1.1) else up + Vector3.new(0, 6, 0)
		TweenService:Create(flash, TweenInfo.new(0.35, Enum.EasingStyle.Quad), { Transparency = 1, Size = grow }):Play()
		Debris:AddItem(flash, 0.4)
	end
	local position = if typeof(info.CFrame) == "CFrame" then (info.CFrame :: CFrame).Position else Vector3.zero
	if info.Shape == "Line" then
		position = ((info.CFrame :: CFrame) * CFrame.new(0, 0, -(tonumber(info.Length) or 40) / 2)).Position
	end
	burst(position + Vector3.new(0, 1, 0), color, 40)
	if info.Element == "Lightning" then
		local bolt = part({ Size = Vector3.new(1.2, 60, 1.2), CFrame = CFrame.new(position + Vector3.new(0, 30, 0)), Color = color, Transparency = 0.1 })
		TweenService:Create(bolt, TweenInfo.new(0.25), { Transparency = 1 }):Play()
		Debris:AddItem(bolt, 0.3)
	end
	shake(position, if (tonumber(info.Radius) or 0) >= 14 then 2 else 1)
end

handlers.Linger = function(info)
	if SkillFx.Linger(info) then
		return
	end
	local duration = math.clamp(tonumber(info.Duration) or 2, 0.1, 30)
	local zone = groundShape(info, colorOf(info.Element), 0.5)
	if zone then
		TweenService:Create(zone, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Transparency = 0.75 }):Play()
		Debris:AddItem(zone, duration)
	end
end

handlers.Bolt = function(info)
	if SkillFx.Bolt(info) then
		return
	end
	if typeof(info.From) ~= "Vector3" or typeof(info.To) ~= "Vector3" then
		return
	end
	local from, to = info.From :: Vector3, info.To :: Vector3
	local length = (to - from).Magnitude
	local bolt = part({ Size = Vector3.new(0.6, 0.6, length), CFrame = CFrame.lookAt(from, to) * CFrame.new(0, 0, -length / 2), Color = colorOf(info.Element) })
	TweenService:Create(bolt, TweenInfo.new(0.3), { Transparency = 1 }):Play()
	Debris:AddItem(bolt, 0.35)
end

-- Broken cover (DestructionService): the part splits into voxels that fly from the impact,
-- land, and fade. Animated by hand (no physics), so debris never shoves the local player.
handlers.Shatter = function(info)
	if typeof(info.CFrame) ~= "CFrame" or typeof(info.Size) ~= "Vector3" then
		return
	end
	local cf: CFrame = info.CFrame
	local size: Vector3 = info.Size
	local origin = if typeof(info.Origin) == "Vector3" then info.Origin :: Vector3 else cf.Position
	local maxCells = math.clamp(tonumber(info.MaxCells) or 40, 1, 120)
	local cell = math.max(tonumber(info.CellSize) or 3, 0.5)
	-- Bigger parts use bigger voxels so the count stays under maxCells.
	while math.ceil(size.X / cell) * math.ceil(size.Y / cell) * math.ceil(size.Z / cell) > maxCells do
		cell *= 1.25
	end
	local nx, ny, nz = math.ceil(size.X / cell), math.ceil(size.Y / cell), math.ceil(size.Z / cell)
	local piece = Vector3.new(size.X / nx, size.Y / ny, size.Z / nz)
	local power = tonumber(info.Power) or 45
	local life = math.clamp(tonumber(info.Life) or 2.5, 0.5, 6)
	local color = if typeof(info.Color) == "Color3" then info.Color :: Color3 else Color3.fromRGB(150, 146, 136)
	local material = if typeof(info.Material) == "EnumItem" then info.Material :: Enum.Material else Enum.Material.Concrete

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { folder }
	local ground = workspace:Raycast(cf.Position + Vector3.new(0, 2, 0), Vector3.new(0, -200, 0), params)
	local groundY = if ground then ground.Position.Y else cf.Position.Y - size.Y / 2

	type Voxel = { Part: Part, Start: Vector3, Velocity: Vector3, Spin: Vector3, Landed: boolean }
	local voxels: { Voxel } = {}
	local rng = Random.new()
	for ix = 1, nx do
		for iy = 1, ny do
			for iz = 1, nz do
				local offset = Vector3.new((ix - 0.5) * piece.X - size.X / 2, (iy - 0.5) * piece.Y - size.Y / 2, (iz - 0.5) * piece.Z - size.Z / 2)
				local position = (cf * CFrame.new(offset)).Position
				local away = position - origin
				away = if away.Magnitude > 0.1 then away.Unit else Vector3.new(rng:NextNumber(-1, 1), 0.5, rng:NextNumber(-1, 1)).Unit
				local p = part({ Size = piece * 0.95, CFrame = CFrame.new(position) * cf.Rotation, Color = color, Material = material, Transparency = 0 })
				table.insert(voxels, {
					Part = p,
					Start = position,
					Velocity = away * power * rng:NextNumber(0.4, 1) + Vector3.new(0, rng:NextNumber(15, 35), 0),
					Spin = Vector3.new(rng:NextNumber(-8, 8), rng:NextNumber(-8, 8), rng:NextNumber(-8, 8)),
					Landed = false,
				})
			end
		end
	end
	burst(origin + Vector3.new(0, 2, 0), color, 20)

	local started = os.clock()
	local gravity = Vector3.new(0, -workspace.Gravity, 0)
	local connection: RBXScriptConnection
	connection = game:GetService("RunService").Heartbeat:Connect(function()
		local t = os.clock() - started
		if t >= life then
			connection:Disconnect()
			for _, voxel in voxels do
				voxel.Part:Destroy()
			end
			return
		end
		local fade = math.clamp((t - (life - 0.6)) / 0.6, 0, 1)
		for _, voxel in voxels do
			local p = voxel.Part
			if not voxel.Landed then
				local position = voxel.Start + voxel.Velocity * t + gravity * (0.5 * t * t)
				local floorY = groundY + p.Size.Y / 2
				if position.Y <= floorY and t > 0.05 then
					position = Vector3.new(position.X, floorY, position.Z)
					voxel.Landed = true
				end
				local spin = voxel.Spin * t
				p.CFrame = CFrame.new(position) * CFrame.Angles(spin.X, spin.Y, spin.Z)
			end
			p.Transparency = fade
		end
	end)
end

-- A crater for heavy strikes: a dark scorched dip ringed by tilted rocks, which sinks away.
handlers.Crater = function(info)
	if typeof(info.CFrame) ~= "CFrame" then
		return
	end
	local center = (info.CFrame :: CFrame).Position
	local radius = math.clamp(tonumber(info.Radius) or 10, 2, 60)
	local disc = part({
		Shape = Enum.PartType.Cylinder,
		Size = Vector3.new(0.3, radius * 1.5, radius * 1.5),
		CFrame = CFrame.new(center + Vector3.new(0, 0.12, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		Color = Color3.fromRGB(45, 38, 32),
		Material = Enum.Material.Slate,
		Transparency = 0.1,
	})
	local rocks: { Part } = { disc }
	local count = math.clamp(math.floor(radius * 1.2), 8, 28)
	local rng = Random.new()
	for i = 1, count do
		local angle = (i / count) * math.pi * 2 + rng:NextNumber(-0.1, 0.1)
		local distance = radius * rng:NextNumber(0.7, 0.85)
		local position = center + Vector3.new(math.cos(angle) * distance, 0.6, math.sin(angle) * distance)
		local rockSize = Vector3.new(rng:NextNumber(1.5, 3.5), rng:NextNumber(1, 2.5), rng:NextNumber(1.5, 3.5))
		local outward = CFrame.lookAt(position, Vector3.new(center.X, position.Y, center.Z))
		table.insert(rocks, part({
			Size = rockSize,
			CFrame = outward * CFrame.Angles(math.rad(rng:NextNumber(20, 40)), 0, math.rad(rng:NextNumber(-15, 15))),
			Color = Color3.fromRGB(95, 85, 75),
			Material = Enum.Material.Rock,
			Transparency = 0,
		}))
	end
	task.delay(6, function()
		for _, rock in rocks do
			TweenService:Create(rock, TweenInfo.new(1.5), { Transparency = 1, CFrame = rock.CFrame - Vector3.new(0, 1.5, 0) }):Play()
			Debris:AddItem(rock, 1.6)
		end
	end)
end

-- The shoulder-shove: a puff in front of the shover, a hit burst on whoever got shoved.
handlers.Shove = function(info)
	local character = info.Character
	if typeof(character) ~= "Instance" or not character:IsA("Model") then
		return
	end
	local root = Characters.GetRoot(character)
	if not root then
		return
	end
	burst(root.Position + root.CFrame.LookVector * 2.5, Color3.fromRGB(230, 230, 240), 8)
	local target = info.Target
	if typeof(target) == "Instance" and target:IsA("Model") then
		local targetRoot = Characters.GetRoot(target)
		if targetRoot then
			burst(targetRoot.Position, Color3.fromRGB(200, 170, 255), 18)
			shake(targetRoot.Position, 0.6)
		end
	end
end

-- A shot travelling from one point to another (Flame Arrow). Signature visuals in SkillFx.
handlers.Projectile = function(info)
	if SkillFx.Projectile(info) then
		return
	end
	if typeof(info.From) ~= "Vector3" or typeof(info.To) ~= "Vector3" then
		return
	end
	local ball = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 2, Position = info.From, Color = colorOf(info.Element), Transparency = 0.1 })
	TweenService:Create(ball, TweenInfo.new(math.clamp(tonumber(info.Duration) or 0.25, 0.05, 3), Enum.EasingStyle.Linear), { Position = info.To }):Play()
	Debris:AddItem(ball, math.clamp(tonumber(info.Duration) or 0.25, 0.05, 3))
end

handlers.Blink = function(info)
	if StandFx.Blink(info) then
		return
	end
	for _, key in { "From", "To" } do
		local position = info[key]
		if typeof(position) == "Vector3" then
			local ball = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 4, Position = position, Color = Color3.fromRGB(180, 220, 255), Transparency = 0.2 })
			TweenService:Create(ball, TweenInfo.new(0.35), { Size = Vector3.one * 8, Transparency = 1 }):Play()
			Debris:AddItem(ball, 0.4)
		end
	end
end
handlers.Swap = handlers.Blink

handlers.Buff = function(info)
	local character = info.Character
	if typeof(character) ~= "Instance" or not character:IsA("Model") then
		return
	end
	local highlight = Instance.new("Highlight")
	highlight.FillColor = Color3.fromRGB(120, 220, 255)
	highlight.OutlineColor = Color3.fromRGB(200, 240, 255)
	highlight.FillTransparency = 0.6
	highlight.Parent = character
	local duration = math.clamp(tonumber(info.Duration) or 1, 0.2, 10)
	TweenService:Create(highlight, TweenInfo.new(duration), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
	Debris:AddItem(highlight, duration)
end
handlers.Charge = handlers.Buff

handlers.Trail = function(info)
	local duration = math.clamp(tonumber(info.Duration) or 2, 0.2, 10)
	local zone = groundShape({ Shape = "Line", CFrame = info.CFrame, Length = info.Length, Width = 3 }, Color3.fromRGB(200, 255, 230), 0.5)
	if zone then
		TweenService:Create(zone, TweenInfo.new(duration), { Transparency = 1 }):Play()
		Debris:AddItem(zone, duration)
	end
end

handlers.Domain = function(info)
	if typeof(info.CFrame) ~= "CFrame" then
		return
	end
	local radius = tonumber(info.Radius) or 25
	local sphere = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 2, CFrame = info.CFrame, Color = colorOf(info.Element), Transparency = 0.4, Material = Enum.Material.ForceField })
	TweenService:Create(sphere, TweenInfo.new(0.4, Enum.EasingStyle.Quad), { Size = Vector3.one * radius * 2 }):Play()
	local duration = math.clamp(tonumber(info.Duration) or 2, 0.2, 10)
	task.delay(duration, function()
		TweenService:Create(sphere, TweenInfo.new(0.4), { Transparency = 1 }):Play()
	end)
	Debris:AddItem(sphere, duration + 0.5)
end

-- Stand effects (StandFx.luau): Made in Heaven's aura, Time Acceleration and Universe Reset.
handlers.StandAura = function(info)
	StandFx.Aura(info)
end

handlers.TimeAccel = function(info)
	StandFx.TimeAccel(info)
end

handlers.UniverseReset = function(info)
	StandFx.UniverseReset(info)
end

handlers.AlternateUniverse = function(info)
	StandFx.AlternateUniverse(info)
end

handlers.TimeStop = function(info)
	local duration = math.clamp(tonumber(info.Duration) or 1.5, 0.2, 5)
	colorEffect("TimeStop", duration, { Saturation = -1, Contrast = 0.4, TintColor = Color3.fromRGB(255, 230, 180) })
	screenFlash(Color3.new(1, 1, 1), 0.4, 0.3)
end

handlers.Blind = function(info)
	screenFlash(Color3.fromRGB(255, 250, 230), math.clamp(tonumber(info.Duration) or 1, 0.2, 5), 0)
end

handlers.Invert = function(info)
	colorEffect("Tsukuyomi", math.clamp(tonumber(info.Duration) or 1.5, 0.2, 5), { Saturation = -1, Contrast = 1, TintColor = Color3.fromRGB(255, 80, 80), Brightness = -0.1 })
end

handlers.Toast = function(info)
	if type(info.Text) == "string" then
		UIController.Popup(info.Text, 1.5, Color3.fromRGB(255, 140, 140))
	end
end

handlers.Dodged = function(info)
	if typeof(info.Position) == "Vector3" then
		burst(info.Position, Color3.fromRGB(120, 220, 255), 15)
	end
end

handlers.TimeErase = function(info)
	local character = info.Character
	if typeof(character) ~= "Instance" or not character:IsA("Model") then
		return
	end
	local duration = math.clamp(tonumber(info.Duration) or 4, 0.2, 15)
	if character == LocalPlayer.Character then
		eraseWorld(character, duration)
	else
		hideErased(character, duration)
	end
end

-- Epitaph on: the KCR forehead face plus the counter aura. Off: they fade out.
handlers.Epitaph = function(info)
	local character = info.Character
	local root = rootOf(character)
	if not root then
		return
	end
	local model = character :: Model
	local head = model:FindFirstChild("Head") :: BasePart?
	if not info.On then
		for _, name in { "_Epitaph", "EpitaphCounter" } do
			local fx = model:FindFirstChild(name)
			if fx then
				fx.Name ..= "Off"
				for _, d in fx:GetDescendants() do
					if d:IsA("ParticleEmitter") or d:IsA("Trail") then
						d.Enabled = false
					elseif d:IsA("BasePart") then
						TweenService:Create(d, TweenInfo.new(0.4), { Transparency = 1 }):Play()
					end
				end
				Debris:AddItem(fx, 2.5)
			end
		end
		return
	end
	if model:FindFirstChild("_Epitaph") then
		return
	end
	kcrSound("Witness", root)
	kcrSound("WitnessVoiceline", root)

	if head then
		-- Epitaph's little face on the forehead.
		local face = Instance.new("Part")
		face.Name = "_Epitaph"
		face.Shape = Enum.PartType.Ball
		face.Size = Vector3.one * 0.45
		face.Color = KCR.Gold
		face.Material = Enum.Material.Neon
		face.CanCollide, face.CanQuery, face.CanTouch, face.Massless = false, false, false, true
		face.CFrame = head.CFrame * CFrame.new(0, 0.25, -head.Size.Z / 2)
		local weld = Instance.new("WeldConstraint")
		weld.Part0, weld.Part1 = head, face
		weld.Parent = face
		local attachment = Instance.new("Attachment")
		attachment.Parent = face
		goldEmitter(attachment, {
			Rate = 25,
			Lifetime = NumberRange.new(0.3, 0.6),
			Speed = NumberRange.new(0.5, 1.5),
			Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) }),
			SpreadAngle = Vector2.new(180, 180),
		})
		face.Parent = model
	end

	-- The counter aura around the body.
	local counter = Instance.new("Part")
	counter.Name = "EpitaphCounter"
	counter.Size = Vector3.new(5, 2.5, 5)
	counter.Transparency = 1
	counter.CanCollide, counter.CanQuery, counter.CanTouch, counter.Massless = false, false, false, true
	counter.CFrame = root.CFrame * CFrame.Angles(0, math.rad(90), 0)
	local weld = Instance.new("WeldConstraint")
	weld.Part0, weld.Part1 = root, counter
	weld.Parent = counter
	local attachment = Instance.new("Attachment")
	attachment.Parent = counter
	goldEmitter(attachment, {
		Rate = 40,
		Lifetime = NumberRange.new(0.5, 0.8),
		Speed = NumberRange.new(2, 4),
		Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(0.5, 0.6), NumberSequenceKeypoint.new(1, 0) }),
		Shape = Enum.ParticleEmitterShape.Cylinder,
		ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface,
		ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward,
		Acceleration = Vector3.new(0, 6, 0),
	})
	attachment.CFrame = CFrame.Angles(0, 0, math.rad(90))
	local highlight = Instance.new("Highlight")
	highlight.FillColor = KCR.Gold
	highlight.OutlineColor = Color3.fromRGB(255, 209, 70)
	highlight.FillTransparency = 0.85
	highlight.Adornee = model
	highlight.Parent = counter
	counter.Parent = model
end

-- Epitaph triggered: the hit never happened.
handlers.EpitaphHit = function(info)
	local character = info.Character
	local root = rootOf(character)
	kcrSound("WitnessHit", root)
	kcrSound("WitnessHitVoiceline", root)
	if character == LocalPlayer.Character then
		task.spawn(timeSkipFlash)
	end
	for _, key in { "From", "To" } do
		local position = info[key]
		if typeof(position) == "Vector3" then
			local ball = part({ Shape = Enum.PartType.Ball, Size = Vector3.one * 4, Position = position, Color = KCR.Gold, Transparency = 0.2 })
			TweenService:Create(ball, TweenInfo.new(0.35), { Size = Vector3.one * 9, Transparency = 1 }):Play()
			Debris:AddItem(ball, 0.4)
			burst(position, KCR.Gold, 20)
		end
	end
end

function FxController.Init()
	folder = Instance.new("Folder")
	folder.Name = "AbilityFx"
	folder.Parent = workspace
	SkillFx.SetFolder(folder)
	SkillFx.SetPlayerGui(PlayerGui)
	StandFx.SetFolder(folder)
	StandFx.SetPlayerGui(PlayerGui)

	local gui = Instance.new("ScreenGui")
	gui.Name = "ScreenFx"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 50
	gui.Parent = PlayerGui
	overlay = Instance.new("Frame")
	overlay.Size = UDim2.fromScale(1, 1)
	overlay.BorderSizePixel = 0
	overlay.BackgroundTransparency = 1
	overlay.Visible = false
	overlay.Parent = gui
	danger = Instance.new("Frame")
	danger.Size = UDim2.fromScale(1, 1)
	danger.BorderSizePixel = 0
	danger.BackgroundColor3 = WARNING
	danger.BackgroundTransparency = 1
	danger.Visible = false
	danger.Parent = gui
	local gradient = Instance.new("UIGradient")
	-- Transparent in the middle, red at the edges (a vignette).
	gradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.25, 0.9),
		NumberSequenceKeypoint.new(0.75, 0.9),
		NumberSequenceKeypoint.new(1, 0),
	})
	gradient.Parent = danger
	arrowHolder = Instance.new("Frame")
	arrowHolder.Name = "HazardArrows"
	arrowHolder.BackgroundTransparency = 1
	arrowHolder.Size = UDim2.fromScale(1, 1)
	arrowHolder.Parent = gui

	Remotes.Event("AbilityFx").OnClientEvent:Connect(function(info)
		if type(info) ~= "table" or type(info.Kind) ~= "string" then
			return
		end
		local handler = handlers[info.Kind]
		if handler then
			task.spawn(handler, info)
		end
	end)
end

function FxController.Start() end

return FxController
