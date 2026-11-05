--!strict
-- The 3D showcase behind the vault screens: a client-only stage with a clone of the
-- player's own avatar, and a camera pointed at it (same idea as the reference style rig).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local UIConfig = require(ReplicatedStorage.Shared.Config.UIConfig)

local LocalPlayer = Players.LocalPlayer

local ShowcaseStage = {}

local stage: Model? = nil
local rig: Model? = nil
local idleTrack: AnimationTrack? = nil
local active = false

local function buildStage(): Model
	local model = Instance.new("Model")
	model.Name = "VaultStage"

	local function part(name: string, size: Vector3, cframe: CFrame, color: Color3, material: Enum.Material): Part
		local p = Instance.new("Part")
		p.Name = name
		p.Anchored = true
		p.CanCollide = false
		p.CanQuery = false
		p.CanTouch = false
		p.CastShadow = false
		p.Size = size
		p.CFrame = cframe
		p.Color = color
		p.Material = material
		p.Parent = model
		return p
	end

	local origin = CFrame.new(UIConfig.StageOrigin)
	part("Floor", Vector3.new(60, 1, 60), origin, Color3.fromRGB(15, 23, 42), Enum.Material.SmoothPlastic)
	part("Backdrop", Vector3.new(60, 40, 1), origin * CFrame.new(0, 20, -8), Color3.fromRGB(15, 23, 42), Enum.Material.SmoothPlastic)
	local ring = part("Pedestal", Vector3.new(1, 9, 9), origin * CFrame.new(0, 0.6, 0) * CFrame.Angles(0, 0, math.rad(90)), Color3.fromRGB(56, 189, 248), Enum.Material.Neon)
	ring.Shape = Enum.PartType.Cylinder

	local light = Instance.new("PointLight")
	light.Range = 18
	light.Brightness = 2
	light.Color = Color3.fromRGB(200, 220, 255)
	light.Parent = ring

	model.PrimaryPart = model:FindFirstChild("Floor") :: BasePart
	return model
end

local function stripScripts(model: Instance)
	for _, d in model:GetDescendants() do
		if d:IsA("BaseScript") or d:IsA("ModuleScript") then
			d:Destroy()
		end
	end
end

local function buildRig(): Model?
	local character = LocalPlayer.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then
		return nil
	end
	local wasArchivable = character.Archivable
	character.Archivable = true
	local clone = character:Clone()
	character.Archivable = wasArchivable
	if not clone then
		return nil
	end

	-- Grab the player's own idle animation before scripts are removed.
	local idle: Animation? = nil
	local animate = clone:FindFirstChild("Animate")
	local idleFolder = animate and animate:FindFirstChild("idle")
	if idleFolder then
		idle = idleFolder:FindFirstChildOfClass("Animation")
		if idle then
			idle = idle:Clone()
		end
	end
	stripScripts(clone)

	local humanoid = clone:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		humanoid.PlatformStand = true
	end
	for _, d in clone:GetDescendants() do
		if d:IsA("BasePart") then
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
		end
	end
	local root = clone:FindFirstChild("HumanoidRootPart") :: BasePart
	root.Anchored = true
	clone.Name = "VaultRig"
	-- Face the camera (+Z); the backdrop sits behind at -Z.
	clone:PivotTo(CFrame.new(UIConfig.StageOrigin + Vector3.new(0, 3.6, 0)) * CFrame.Angles(0, math.pi, 0))
	clone.Parent = stage

	if humanoid and idle then
		local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
		local ok, track = pcall(function()
			return (animator :: Animator):LoadAnimation(idle :: Animation)
		end)
		if ok and track then
			track.Looped = true
			track:Play()
			idleTrack = track
		end
	end
	return clone
end

function ShowcaseStage.IsActive(): boolean
	return active
end

-- Shows the stage and points the camera at the rig.
function ShowcaseStage.Show()
	if not stage then
		stage = buildStage()
	end
	local s = stage :: Model
	s.Parent = workspace
	if rig then
		rig:Destroy()
		rig = nil
	end
	rig = buildRig()
	active = true

	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Scriptable
	local focus = UIConfig.StageOrigin + Vector3.new(0, 3.6, 0)
	camera.CFrame = CFrame.lookAt(focus + Vector3.new(0, 0.5, 11), focus)
end

function ShowcaseStage.Hide()
	active = false
	if idleTrack then
		idleTrack:Stop()
		idleTrack = nil
	end
	if rig then
		rig:Destroy()
		rig = nil
	end
	if stage then
		stage.Parent = nil
	end
	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Custom
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		camera.CameraSubject = humanoid
	end
end

-- A rarity-coloured burst on the rig for the reveal.
function ShowcaseStage.Burst(color: Color3, big: boolean?)
	local r = rig
	if not r then
		return
	end
	local root = r:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not root then
		return
	end
	local attachment = Instance.new("Attachment")
	attachment.Parent = root
	local emitter = Instance.new("ParticleEmitter")
	emitter.Color = ColorSequence.new(color)
	emitter.LightEmission = 1
	emitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0) })
	emitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
	emitter.Speed = NumberRange.new(10, 22)
	emitter.Lifetime = NumberRange.new(0.5, 1)
	emitter.SpreadAngle = Vector2.new(180, 180)
	emitter.Rate = 0
	emitter.Parent = attachment
	emitter:Emit(if big then 160 else 60)

	local highlight = Instance.new("Highlight")
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.FillTransparency = 0.2
	highlight.Parent = r
	TweenService:Create(highlight, TweenInfo.new(if big then 1.6 else 0.8), { FillTransparency = 1, OutlineTransparency = 1 }):Play()

	task.delay(2, function()
		attachment:Destroy()
		highlight:Destroy()
	end)
end

return ShowcaseStage
