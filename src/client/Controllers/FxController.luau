--!strict
-- Ability visuals, all built in code so they work without imported assets
-- (the reference VFX modules can replace them per element later):
--   telegraphs (fill up until impact), impacts (flash + particles + shake), lingering zones,
--   bolts, blinks, buffs, domains, screen effects (blind, invert, time stop) and the Runner
--   danger warning (GAME_PLAN.md 5C) — Flow State sees it as soon as a strike is aimed.

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)

local UIController = require(script.Parent.UIController)
local SkillFx = require(script.Parent.SkillFx)
local StandFx = require(script.Parent.StandFx)
local SoundConfig = require(ReplicatedStorage.Shared.Config.SoundConfig)

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

local folder: Folder
local danger: Frame
local overlay: Frame

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
	sound.RollOffMode = Enum.RollOffMode.InverseTapered
	sound.RollOffMaxDistance = SoundConfig.MaxDistance
	sound.Parent = anchor
	sound:Play()
	sound.Ended:Once(function()
		anchor:Destroy()
	end)
	Debris:AddItem(anchor, 15)
end

-- ------------------------------------------------------------------ handlers
local handlers: { [string]: (info: { [string]: any }) -> () } = {}

handlers.Telegraph = function(info)
	SkillFx.Telegraph(info) -- extra signature visuals; the ground warning below always draws
	playSkillSound(info, "Telegraph")
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

function FxController.Init()
	folder = Instance.new("Folder")
	folder.Name = "AbilityFx"
	folder.Parent = workspace
	SkillFx.SetFolder(folder)
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
