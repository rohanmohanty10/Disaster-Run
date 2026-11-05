--!strict
-- VisualRain.luau
-- The camera-locked particle curtain (no per-drop parts) plus the on-screen
-- "water on the lens" overlay. Two emitter layers (near/far) create parallax depth.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Config = require(script.Parent.Config)
local Maid = require(script.Parent.Maid)

local VisualRain = {}
VisualRain.__index = VisualRain

export type VisualRain = typeof(setmetatable(
	{} :: {
		_maid: Maid.Maid,
		_camera: Camera,
	},
	VisualRain
	))

-- An invisible, query-proof box that rides with the camera. CanQuery=false is
-- critical: our own occlusion/splash rays must never hit the rain volume.
local function makeContainer(name: string, size: Vector3, parent: Instance): BasePart
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Massless = true
	part.CastShadow = false
	part.Locked = true
	part.Parent = parent
	return part
end

local function makeStreakEmitter(parent: BasePart, opts: {
	texture: string,
	color: Color3,
	rate: number,
	size: number,
	speed: NumberRange,
	squash: number,
	}): ParticleEmitter
	local e = Instance.new("ParticleEmitter")
	e.Texture = opts.texture
	-- Align the texture to the velocity vector so it reads as a vertical streak.
	e.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	e.Color = ColorSequence.new(opts.color)
	e.LightEmission = 1 -- bright, high-contrast (anime look)
	e.LightInfluence = 0 -- ignore world lighting → stays crisp white
	e.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.05),
		NumberSequenceKeypoint.new(0.8, 0.15),
		NumberSequenceKeypoint.new(1, 1),
	})
	e.Size = NumberSequence.new(opts.size)
	e.Squash = NumberSequence.new(opts.squash) -- elongate into a streak
	e.Speed = opts.speed
	e.Lifetime = Config.Visual.Lifetime
	e.Rate = opts.rate
	e.SpreadAngle = Vector2.new(6, 6)
	e.Acceleration = Config.Visual.Gravity
	e.EmissionDirection = Enum.NormalId.Bottom -- initial velocity points down
	e.LockedToPart = false -- particles fall in world space as the box moves
	e.Drag = 0
	e.Rotation = NumberRange.new(0, 0)
	e.RotSpeed = NumberRange.new(0, 0)
	e.Parent = parent
	return e
end

function VisualRain.new(camera: Camera): VisualRain
	local self = setmetatable({}, VisualRain) :: VisualRain
	self._maid = Maid.new()
	self._camera = camera
	return self
end

function VisualRain._buildOverlay(self: VisualRain)
	local player = Players.LocalPlayer
	local gui = Instance.new("ScreenGui")
	gui.Name = "RainScreenOverlay"
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 50
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Parent = player:WaitForChild("PlayerGui")
	self._maid:give(gui)

	for _ = 1, Config.Visual.OverlayDropletCount do
		local img = Instance.new("ImageLabel")
		img.BackgroundTransparency = 1
		img.Image = Config.Visual.DropletTexture
		img.ImageTransparency = 1
		img.AnchorPoint = Vector2.new(0.5, 0.5)
		img.Size = UDim2.fromScale(0.08, 0.16)
		img.Parent = gui

		-- Each droplet lives its own little loop: appear at a random spot, hold,
		-- fade out. Cancelled wholesale when the maid cleans.
		local thread = task.spawn(function()
			while true do
				local span = Config.Visual.OverlayMaxInterval - Config.Visual.OverlayMinInterval
				task.wait(Config.Visual.OverlayMinInterval + math.random() * span)

				img.Position = UDim2.fromScale(math.random(), math.random())
				local scale = 0.6 + math.random()
				img.Size = UDim2.fromScale(0.06 * scale, 0.14 * scale)
				img.Rotation = math.random(-12, 12)

				local fadeIn = TweenService:Create(
					img,
					TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ ImageTransparency = Config.Visual.OverlayPeakTransparency }
				)
				fadeIn:Play()
				fadeIn.Completed:Wait()
				task.wait(0.25 + math.random() * 0.4)
				local fadeOut = TweenService:Create(
					img,
					TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
					{ ImageTransparency = 1 }
				)
				fadeOut:Play()
				fadeOut.Completed:Wait()
			end
		end)
		self._maid:give(thread)
	end
end

function VisualRain.start(self: VisualRain)
	local folder = Instance.new("Folder")
	folder.Name = "RainVisuals"
	folder.Parent = Workspace
	self._maid:give(folder)

	local near = makeContainer("RainNear", Config.Visual.NearVolumeSize, folder)
	local far = makeContainer("RainFar", Config.Visual.FarVolumeSize, folder)

	makeStreakEmitter(near, {
		texture = Config.Visual.StreakTexture,
		color = Config.Visual.NearColor,
		rate = Config.Visual.NearRate,
		size = Config.Visual.NearSize,
		speed = Config.Visual.NearSpeed,
		squash = Config.Visual.NearSquash,
	})
	makeStreakEmitter(far, {
		texture = Config.Visual.StreakTexture,
		color = Config.Visual.FarColor,
		rate = Config.Visual.FarRate,
		size = Config.Visual.FarSize,
		speed = Config.Visual.FarSpeed,
		squash = Config.Visual.FarSquash,
	})

	-- Follow the camera POSITION (axis-aligned) every frame for smooth tracking
	-- while keeping streaks perfectly vertical.
	self._maid:give(RunService.RenderStepped:Connect(function()
		local pos = self._camera.CFrame.Position
		near.CFrame = CFrame.new(pos + Config.Visual.NearOffset)
		far.CFrame = CFrame.new(pos + Config.Visual.FarOffset)
	end))

	self:_buildOverlay()
end

function VisualRain.stop(self: VisualRain)
	self._maid:clean()
end

return VisualRain