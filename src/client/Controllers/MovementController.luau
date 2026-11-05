--!strict
-- Runner movement on the local character (ROADMAP step 3):
--   sprint + stamina, slide (iframes granted by the server), speed from server effects,
--   air jumps / jump boosts, skill-driven dashes, Valley-style locomotion animations and
--   an over-the-shoulder shift lock (Left Alt — Shift is sprint).
-- WalkSpeed is recomputed every frame from the character's attributes, so server effects
-- (SpeedMultiplier, MovementLocked, SpeedBoost) and sprinting never fight each other.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local MovementConfig = require(ReplicatedStorage.Shared.Config.MovementConfig)
local AnimationConfig = require(ReplicatedStorage.Shared.Config.AnimationConfig)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Knockback = require(ReplicatedStorage.Shared.Util.Knockback)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local LocalPlayer = Players.LocalPlayer

local MovementController = {}

MovementController.Stamina = MovementConfig.Stamina.Max
MovementController.Sprinting = false
MovementController.StaminaChanged = Signal.new()

local sprintHeld = false
local lastDrain = 0
local slideReadyAt = 0
local airJumpsUsed = 0
local shiftLock = false
local actionTracks: { [string]: AnimationTrack } = {}
local animator: Animator? = nil
local usingRunAnim = false

local function getCharacter(): (Model?, Humanoid?, BasePart?)
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = humanoid and humanoid.RootPart
	return character, humanoid, root
end

local function isRunner(): boolean
	return LocalPlayer:GetAttribute("Role") ~= "God"
end

function MovementController.AddStamina(amount: number)
	local max = MovementConfig.Stamina.Max
	MovementController.Stamina = math.clamp(MovementController.Stamina + amount, 0, max)
	if amount < 0 then
		lastDrain = os.clock()
	end
	MovementController.StaminaChanged:Fire(MovementController.Stamina)
end

-- ------------------------------------------------------------------ animations
local function setAnimId(character: Model, folderName: string, id: string)
	local animate = character:FindFirstChild("Animate")
	local folder = animate and animate:FindFirstChild(folderName)
	if not folder then
		return
	end
	for _, child in folder:GetChildren() do
		if child:IsA("Animation") and child.AnimationId ~= id then
			child.AnimationId = id
		end
	end
end

local function applyLocomotion(character: Model, running: boolean)
	local ids = AnimationConfig.Locomotion
	setAnimId(character, "idle", ids.Idle)
	setAnimId(character, "walk", ids.Walk)
	setAnimId(character, "run", if running then ids.Run else ids.Walk)
	setAnimId(character, "fall", ids.Fall)
	usingRunAnim = running
end

function MovementController.PlayAction(name: string, speed: number?)
	local id = (AnimationConfig.Actions :: any)[name]
	if not id or not animator then
		return
	end
	local track = actionTracks[name]
	if not track then
		local animation = Instance.new("Animation")
		animation.AnimationId = id
		local ok, loaded = pcall(function()
			return (animator :: Animator):LoadAnimation(animation)
		end)
		if not ok then
			return
		end
		track = loaded
		track.Priority = Enum.AnimationPriority.Action
		actionTracks[name] = track
	end
	track:Play(0.08, 1, speed or 1)
end

-- ------------------------------------------------------------------ motion
local function push(velocity: Vector3, duration: number)
	local character = LocalPlayer.Character
	if character then
		Knockback.Push(character, velocity, duration)
	end
end

local function slide()
	local _, humanoid, root = getCharacter()
	if not humanoid or not root or not isRunner() then
		return
	end
	local cfg = MovementConfig.Slide
	if os.clock() < slideReadyAt or MovementController.Stamina < cfg.StaminaCost then
		return
	end
	local character = LocalPlayer.Character :: Model
	if character:GetAttribute("MovementLocked") or humanoid.FloorMaterial == Enum.Material.Air then
		return
	end
	local direction = humanoid.MoveDirection
	if direction.Magnitude < 0.1 then
		direction = root.CFrame.LookVector
	end
	direction = (direction * Vector3.new(1, 0, 1)).Unit
	slideReadyAt = os.clock() + cfg.Cooldown
	MovementController.AddStamina(-cfg.StaminaCost)
	Remotes.Event("Ability"):FireServer("Slide", 1, {})
	MovementController.PlayAction("Slide", 1.2)
	push(direction * cfg.Speed, cfg.Duration)
end

local function onSelfMove(info: { [string]: any })
	local _, humanoid, root = getCharacter()
	if not humanoid or not root or type(info) ~= "table" then
		return
	end
	if info.Kind == "Dash" and typeof(info.Direction) == "Vector3" then
		local duration = math.clamp(tonumber(info.Duration) or 0.22, 0.05, 1)
		local distance = math.clamp(tonumber(info.Distance) or 10, 0, 60)
		local direction = (info.Direction :: Vector3) * Vector3.new(1, 0, 1)
		if direction.Magnitude < 0.01 then
			return
		end
		local anim = info.Anim
		if anim == "DashSide" then
			anim = if direction.Unit:Dot(root.CFrame.RightVector) > 0 then "DashRight" else "DashLeft"
		end
		if type(anim) == "string" then
			MovementController.PlayAction(anim, 1.3)
		end
		-- The push tapers to 40%, so scale it up to cover the full distance.
		push(direction.Unit * distance / duration * 1.25, duration)
	elseif info.Kind == "AirJump" then
		local direction = if typeof(info.Direction) == "Vector3" then (info.Direction :: Vector3) * Vector3.new(1, 0, 1) else Vector3.zero
		local forward = if direction.Magnitude > 0.01 then direction.Unit * (tonumber(info.Forward) or 30) else Vector3.zero
		root.AssemblyLinearVelocity = forward + Vector3.new(0, tonumber(info.Up) or 50, 0)
		humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
	elseif info.Kind == "Path" then
		MovementController.ShowPath(tonumber(info.Duration) or 4)
	end
end

-- Draws a beam from the player toward the Sanctuary (Direct Line).
function MovementController.ShowPath(duration: number)
	local _, _, root = getCharacter()
	local course = Workspace:FindFirstChild("Course") or Workspace:FindFirstChild("CourseMarkers")
	local sanctuary = course and course:FindFirstChild("Sanctuary")
	if not root or not sanctuary or not sanctuary:IsA("BasePart") then
		return
	end
	local a0 = Instance.new("Attachment")
	a0.Parent = root
	local a1 = Instance.new("Attachment")
	a1.Parent = sanctuary
	local beam = Instance.new("Beam")
	beam.Attachment0 = a0
	beam.Attachment1 = a1
	beam.Color = ColorSequence.new(Color3.fromRGB(80, 255, 160))
	beam.Width0 = 1.5
	beam.Width1 = 1.5
	beam.FaceCamera = true
	beam.LightEmission = 1
	beam.Parent = root
	task.delay(duration, function()
		beam:Destroy()
		a0:Destroy()
		a1:Destroy()
	end)
end

-- ------------------------------------------------------------------ shift lock
local function setShiftLock(on: boolean)
	shiftLock = on
	local _, humanoid = getCharacter()
	if humanoid then
		humanoid.AutoRotate = not on
		humanoid.CameraOffset = if on then Vector3.new(1.75, 0.5, 0) else Vector3.zero
	end
	UserInputService.MouseBehavior = if on then Enum.MouseBehavior.LockCenter else Enum.MouseBehavior.Default
end

-- ------------------------------------------------------------------ per frame
local function step(dt: number)
	local character, humanoid, root = getCharacter()
	if not character or not humanoid or not root or humanoid.Health <= 0 then
		return
	end
	if not isRunner() then
		if shiftLock then
			setShiftLock(false)
		end
		return
	end
	local stamina = MovementConfig.Stamina
	local moving = humanoid.MoveDirection.Magnitude > 0.1
	local locked = character:GetAttribute("MovementLocked") == true
	local freeSprint = character:GetAttribute("FreeSprint") == true

	-- Sprint and stamina.
	local wantsSprint = sprintHeld and moving and not locked
	if wantsSprint and (freeSprint or MovementController.Stamina > 0) then
		if not freeSprint then
			MovementController.Stamina = math.max(MovementController.Stamina - stamina.SprintDrain * dt, 0)
			lastDrain = os.clock()
			MovementController.StaminaChanged:Fire(MovementController.Stamina)
		end
		MovementController.Sprinting = true
	else
		MovementController.Sprinting = false
		if os.clock() - lastDrain >= stamina.RegenDelay and MovementController.Stamina < stamina.Max then
			MovementController.Stamina = math.min(MovementController.Stamina + stamina.Regen * dt, stamina.Max)
			MovementController.StaminaChanged:Fire(MovementController.Stamina)
		end
	end

	-- The server owns stamina (MovementService). Predict locally, but snap to the server's value
	-- whenever the two drift apart, so the bar can't lie and sprinting can't outlast the server.
	local serverStamina = LocalPlayer:GetAttribute("Stamina")
	if type(serverStamina) == "number" and math.abs(serverStamina - MovementController.Stamina) > 12 then
		MovementController.Stamina = serverStamina
		MovementController.StaminaChanged:Fire(serverStamina)
	end

	-- Speed from sprint × server effects × boosts.
	local base = if MovementController.Sprinting then MovementConfig.SprintSpeed else MovementConfig.WalkSpeed
	local multiplier = (character:GetAttribute("SpeedMultiplier") :: number?) or 1
	local boost = (character:GetAttribute("SpeedBoost") :: number?) or 1
	humanoid.WalkSpeed = if locked then 0 else base * multiplier * boost
	humanoid.UseJumpPower = true
	humanoid.JumpPower = if locked then 0 else 50 * ((character:GetAttribute("JumpBoost") :: number?) or 1)

	if MovementController.Sprinting ~= usingRunAnim then
		applyLocomotion(character, MovementController.Sprinting)
	end

	if humanoid.FloorMaterial ~= Enum.Material.Air then
		airJumpsUsed = 0
	end

	if shiftLock then
		local look = Workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
		if look.Magnitude > 0.01 and not locked then
			root.CFrame = CFrame.lookAt(root.Position, root.Position + look.Unit)
		end
	end
end

local function onCharacter(character: Model)
	table.clear(actionTracks)
	MovementController.Stamina = MovementConfig.Stamina.Max
	MovementController.StaminaChanged:Fire(MovementController.Stamina)
	airJumpsUsed = 0
	local humanoid = character:WaitForChild("Humanoid", 10) :: Humanoid?
	if not humanoid then
		return
	end
	animator = humanoid:FindFirstChildOfClass("Animator") or (humanoid:WaitForChild("Animator", 5) :: Animator?)
	character:WaitForChild("Animate", 5)
	applyLocomotion(character, false)
	if shiftLock then
		setShiftLock(true)
	end
end

function MovementController.Init()
	Remotes.Event("SelfMove").OnClientEvent:Connect(onSelfMove)
	Remotes.Event("Stamina").OnClientEvent:Connect(function(amount: number)
		if type(amount) == "number" then
			MovementController.AddStamina(amount)
		end
	end)
end

function MovementController.Start()
	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end
		local key = input.KeyCode
		if key == MovementConfig.SprintKey then
			sprintHeld = true
		elseif key == MovementConfig.Slide.Key or key == MovementConfig.Slide.AltKey then
			slide()
		elseif key == MovementConfig.Camera.ShiftLockKey and isRunner() then
			setShiftLock(not shiftLock)
		elseif key == Enum.KeyCode.Space then
			-- Extra air jumps (Gale Step).
			local character, humanoid, root = getCharacter()
			local jumps = character and character:GetAttribute("AirJumps")
			if humanoid and root and type(jumps) == "number" and humanoid.FloorMaterial == Enum.Material.Air and airJumpsUsed < jumps then
				airJumpsUsed += 1
				root.AssemblyLinearVelocity = root.AssemblyLinearVelocity * Vector3.new(1, 0, 1) + Vector3.new(0, 50, 0)
				humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.KeyCode == MovementConfig.SprintKey then
			sprintHeld = false
		end
	end)
	RunService.RenderStepped:Connect(step)
	if LocalPlayer.Character then
		task.spawn(onCharacter, LocalPlayer.Character)
	end
	LocalPlayer.CharacterAdded:Connect(onCharacter)
end

-- Mobile: the HUD's sprint button calls this.
function MovementController.SetSprint(on: boolean)
	sprintHeld = on
end

function MovementController.Slide()
	slide()
end

return MovementController
