--!strict
-- The God's view (ROADMAP step 4): an overhead camera that follows the Runner pack
-- (WASD to pan, scroll to zoom 60-220 studs) and a ground reticle under the mouse that shows
-- the selected skill's shape. AbilityController reads GetTarget()/GetDirection() when casting.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)

local LocalPlayer = Players.LocalPlayer

local GodController = {}

local MIN_ZOOM, MAX_ZOOM = 60, 220
local PAN_SPEED = 90

local active = false
local zoom = 130
local focus = Vector3.zero
local panOffset = Vector3.zero
local target = Vector3.zero
local selected = 1
local reticle: Model? = nil
local reticleParts: { [string]: BasePart } = {}

local function isGodActive(): boolean
	return LocalPlayer:GetAttribute("Role") == "God" and ReplicatedStorage:GetAttribute("MatchActive") == true
end

function GodController.IsActive(): boolean
	return active
end

function GodController.GetTarget(): Vector3
	return target
end

-- Lines and cones point the way the camera faces.
function GodController.GetDirection(): Vector3
	local look = workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
	return if look.Magnitude > 0.01 then look.Unit else Vector3.new(0, 0, -1)
end

function GodController.SetSelected(index: number)
	selected = index
end

local function selectedBehavior(): { [string]: any }?
	local kitId = LocalPlayer:GetAttribute("EquippedGodKit")
	local kit = if type(kitId) == "string" then Kits.Get("God", kitId) else nil
	local skill = kit and kit.Skills[selected]
	return skill and skill.Behavior
end

-- ------------------------------------------------------------------ reticle
local function reticlePart(name: string, shape: Enum.PartType): BasePart
	local existing = reticleParts[name]
	if existing then
		return existing
	end
	local part = Instance.new("Part")
	part.Name = name
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CastShadow = false
	part.Material = Enum.Material.Neon
	part.Color = Color3.fromRGB(56, 189, 248)
	part.Transparency = 0.55
	part.Shape = shape
	part.Parent = reticle
	reticleParts[name] = part
	return part
end

local function hideReticle()
	for _, part in reticleParts do
		part.Transparency = 1
	end
end

local function updateReticle()
	if not reticle then
		local model = Instance.new("Model")
		model.Name = "GodReticle"
		model.Parent = workspace
		reticle = model
	end
	hideReticle()
	local behavior = selectedBehavior()
	local ground = CFrame.new(target + Vector3.new(0, 0.15, 0))
	local charging = LocalPlayer:GetAttribute("Charging") == selected
	local kind = if behavior then behavior.T else "Circle"

	if kind == "Line" and behavior then
		local length, width = behavior.L or 40, behavior.W or 6
		local dir = GodController.GetDirection()
		local start = target - dir * (length * 0.15)
		local part = reticlePart("Line", Enum.PartType.Block)
		part.Size = Vector3.new(width, 0.2, length)
		part.CFrame = CFrame.lookAt(start, start + dir) * CFrame.new(0, 0.15, -length / 2)
		part.Transparency = 0.55
	elseif kind == "Cone" and behavior then
		local length, angle = behavior.L or 40, behavior.Angle or 60
		local dir = GodController.GetDirection()
		local start = target - dir * (length * 0.3)
		local part = reticlePart("Cone", Enum.PartType.Block)
		part.Size = Vector3.new(2 * length * math.tan(math.rad(angle / 2)), 0.2, length)
		part.CFrame = CFrame.lookAt(start, start + dir) * CFrame.new(0, 0.15, -length / 2)
		part.Transparency = 0.6
	else
		local radius = if behavior then (behavior.R or behavior.Range or 8) else 4
		if behavior and behavior.RMin then
			radius = behavior.RMin
			if charging and behavior.Charge then
				local started = LocalPlayer:GetAttribute("ChargeStartedAt")
				local held = if type(started) == "number" then os.clock() - started else 0
				radius = behavior.RMin + (behavior.R - behavior.RMin) * math.clamp(held / behavior.Charge, 0, 1)
			end
		end
		local part = reticlePart("Circle", Enum.PartType.Cylinder)
		part.Size = Vector3.new(0.2, radius * 2, radius * 2)
		part.CFrame = ground * CFrame.Angles(0, 0, math.rad(90))
		part.Transparency = if charging then 0.35 else 0.55
	end
	local dot = reticlePart("Dot", Enum.PartType.Ball)
	dot.Size = Vector3.one * 1.2
	dot.CFrame = ground
	dot.Transparency = 0.1
end

-- ------------------------------------------------------------------ camera
local function packCenter(): Vector3?
	local sum = Vector3.zero
	local count = 0
	for _, player in Players:GetPlayers() do
		local character = player.Character
		if player:GetAttribute("Role") == "Runner" and not player:GetAttribute("Eliminated") and character and Characters.IsAlive(character) and character:GetAttribute("TimeErased") ~= true then
			-- (Time Erase: the camera mustn't give away an erased Runner.)
			local root = Characters.GetRoot(character)
			if root then
				sum += root.Position
				count += 1
			end
		end
	end
	return if count > 0 then sum / count else nil
end

local function raycastGround(): Vector3?
	local camera = workspace.CurrentCamera
	local mouse = UserInputService:GetMouseLocation()
	local ray = camera:ViewportPointToRay(mouse.X, mouse.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local exclude: { Instance } = {}
	for _, player in Players:GetPlayers() do
		if player.Character then
			table.insert(exclude, player.Character)
		end
	end
	for _, name in { "GodReticle", "AbilityFx", "HitboxDebug", "TestDummies", "AbilityDecoys" } do
		local folder = workspace:FindFirstChild(name)
		if folder then
			table.insert(exclude, folder)
		end
	end
	params.FilterDescendantsInstances = exclude
	local result = workspace:Raycast(ray.Origin, ray.Direction * 2000, params)
	if result then
		return result.Position
	end
	-- Fall back to the plane at focus height.
	if math.abs(ray.Direction.Y) > 0.01 then
		local t = (focus.Y - ray.Origin.Y) / ray.Direction.Y
		if t > 0 then
			return ray.Origin + ray.Direction * t
		end
	end
	return nil
end

local function step(dt: number)
	local shouldBeActive = isGodActive()
	if shouldBeActive ~= active then
		active = shouldBeActive
		local camera = workspace.CurrentCamera
		if active then
			camera.CameraType = Enum.CameraType.Scriptable
			panOffset = Vector3.zero
			local course = workspace:FindFirstChild("Course") or workspace:FindFirstChild("CourseMarkers")
			local start = course and course:FindFirstChild("StartSpawn")
			focus = if start and start:IsA("BasePart") then start.Position else Vector3.zero
		else
			camera.CameraType = Enum.CameraType.Custom
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				camera.CameraSubject = humanoid
			end
			hideReticle()
		end
	end
	if not active then
		return
	end

	-- Pan with WASD (relative to the camera's facing), drift toward the pack.
	local move = Vector3.zero
	if not UserInputService:GetFocusedTextBox() then
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			move += Vector3.new(0, 0, -1)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			move += Vector3.new(0, 0, 1)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			move += Vector3.new(-1, 0, 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			move += Vector3.new(1, 0, 0)
		end
	end
	panOffset += move * PAN_SPEED * (zoom / 130) * dt
	local center = packCenter()
	if center then
		focus = focus:Lerp(center, math.min(dt * 2, 1))
	end
	local camera = workspace.CurrentCamera
	local look = focus + panOffset
	camera.CFrame = CFrame.lookAt(look + Vector3.new(0, zoom, zoom * 0.45), look)

	local hit = raycastGround()
	if hit then
		target = hit
	end
	updateReticle()
end

function GodController.Init() end

function GodController.Start()
	UserInputService.InputChanged:Connect(function(input, processed)
		if active and not processed and input.UserInputType == Enum.UserInputType.MouseWheel then
			zoom = math.clamp(zoom - input.Position.Z * 12, MIN_ZOOM, MAX_ZOOM)
		end
	end)
	-- Charge timing for the growing reticle.
	LocalPlayer:GetAttributeChangedSignal("Charging"):Connect(function()
		LocalPlayer:SetAttribute("ChargeStartedAt", if LocalPlayer:GetAttribute("Charging") then os.clock() else nil)
	end)
	RunService:BindToRenderStep("GodCamera", Enum.RenderPriority.Camera.Value + 1, step)
end

return GodController
