--Services
local TS = game:GetService('TweenService')
local Debris = game:GetService("Debris")
local RNS = game:GetService('RunService')
local Players = game:GetService('Players')
local RS = game:GetService('ReplicatedStorage')
local UIS = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")



--Player
if script.Parent.Parent:GetAttribute("ClonedChar2") then
	return script:Destroy("")
end


local Player = Players.LocalPlayer

repeat task.wait() until game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled or game:GetService("UserInputService").GamepadEnabled
--repeat task.wait() until Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded")--and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
task.wait(.1)

local ConfigFolder: Configuration = Player:FindFirstChild('Configuration') or Player:WaitForChild('Configuration', 10)
local Character = Player.Character or Player.CharacterAdded:Wait()
local Animate = Character:WaitForChild("Animate", 5)
Animate:WaitForChild("walk"):WaitForChild("WalkAnim")
local Humanoid: Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
local Animator: Animator = Humanoid:FindFirstChild("Animator") or Humanoid:WaitForChild("Animator", 10)
local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
local RootJoint: Motor6D = HumRP:FindFirstChild("RootJoint") or HumRP:WaitForChild("RootJoint", 10)
local DefaultC0Offset = RootJoint.C0
local Head: BasePart = Character:FindFirstChild('Head') or Character:WaitForChild('Head', 10)
local Torso: BasePart = Character:FindFirstChild('Torso') or Character:WaitForChild('Torso', 10)



--Remotes
local Remotes = RS.Remotes


local Comunicator: RemoteEvent = Remotes.Comunicator.Set



--Raycast Params
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = {
	workspace.World.Map, 
	--workspace.Map.Miscellaneous, 
	--workspace.Map.Borders
}
params.IgnoreWater = true



--Variables
local Camera = workspace.CurrentCamera
local stopCameraShakeLoop = nil
local xShake, yShake, zShake = 0, 0, 0
local RunningPhase = 0
local LastJump = 0
local JumpFatigue = 0
local DragonCamera
local DeadCamera = false
local blockedAnimations = {}


--Character.ChildAdded:Connect(function(Child)
--	if Child.Name == "DragonCamera" then
--		DragonCamera = Child

--		DragonCamera.Value.Destroying:Once(function()
--			DragonCamera:Destroy()
--			DragonCamera = nil
--		end)

--		DragonCamera.Destroying:Once(function()
--			DragonCamera:Destroy()
--			DragonCamera = nil
--		end)
--	end
--end)

--task.spawn(function()
--	if Player:GetAttribute("Moveset") == "Cursed Child" then
--		Animate.walk.WalkAnim.AnimationId = "rbxassetid://79854583169797"
--	else
--		Animate.walk.WalkAnim.AnimationId = "rbxassetid://75398988369962"
--	end
--	Animate:WaitForChild("toolnone", 5)
--	task.delay(0.01, function()
--		for _, Animation in Animate.idle:GetChildren() do
--			if Player:GetAttribute("Moveset") == "Cursed Child" then
--				Animation.AnimationId = "rbxassetid://82870118278666"
--			else
--				Animation.AnimationId = "rbxassetid://119306736029103"
--			end
--		end
--	end)
--end)


local RunAnimation = Instance.new("Animation")
local WalkAnimation = Instance.new("Animation")
local IdleAnimation = Instance.new("Animation")
local ModeIdleAnimation = Instance.new("Animation")

if Player:GetAttribute("Character") == "Sanji" then
	--RunAnimation.AnimationId = "rbxassetid://138195516678289"
	RunAnimation.AnimationId = "rbxassetid://123811695476560"
	WalkAnimation.AnimationId = "rbxassetid://119306736029103"
	IdleAnimation.AnimationId = "rbxassetid://90290868087583"
	ModeIdleAnimation.AnimationId = "rbxassetid://100417826490006" -- Diable Jambe idle, etc.

elseif Player:GetAttribute("Character") == "Zoro" then
	RunAnimation.AnimationId = "rbxassetid://78028826106735"
	WalkAnimation.AnimationId = "rbxassetid://119306736029103"
	IdleAnimation.AnimationId = "rbxassetid://82706021300355"
else
	--RunAnimation.AnimationId = "rbxassetid://86556484658803" -
	RunAnimation.AnimationId = "rbxassetid://103491985031157"  --tsb
	WalkAnimation.AnimationId = "rbxassetid://119306736029103"
	IdleAnimation.AnimationId = "rbxassetid://90290868087583"
end


local RunTrack = Animator:LoadAnimation(RunAnimation)
RunAnimation:Destroy()
RunTrack.Name = "RunAnimation"
RunTrack.Looped = true
RunTrack.Priority = Enum.AnimationPriority.Movement

local WalkTrack = Animator:LoadAnimation(WalkAnimation)
WalkAnimation:Destroy()
WalkTrack.Name = "WalkAnimation"
WalkTrack.Looped = true
WalkTrack.Priority = Enum.AnimationPriority.Movement

local IdleTrack = Animator:LoadAnimation(IdleAnimation)
IdleAnimation:Destroy()
IdleTrack.Name = "IdleAnimation"
IdleTrack.Looped = true
IdleTrack.Priority = Enum.AnimationPriority.Idle

local ModeIdleTrack
if ModeIdleAnimation.AnimationId ~= "" then
	ModeIdleTrack = Animator:LoadAnimation(ModeIdleAnimation)
	ModeIdleTrack.Name = "ModeIdleAnimation"
	ModeIdleTrack.Looped = true
	ModeIdleTrack.Priority = Enum.AnimationPriority.Idle
end
ModeIdleAnimation:Destroy()



local CameraShaker = require(RS.Modules.CameraShaker).new(Enum.RenderPriority.Camera.Value, function(Offset)
	Camera.CFrame *= Offset
end)
CameraShaker:Start()



--Functions
local function raycast(origin, direction)
	return workspace:Raycast(origin, direction, params)
end

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = { workspace.World.Map }
params.IgnoreWater = true

shared.getRayFloor = function(cframe, depth, whitelist)
	local castDepth = (depth or 6) + 1
	local targets = whitelist or { workspace.World.Map }
	params.FilterDescendantsInstances = targets

	local ray = Ray.new(
		cframe.Position + Vector3.new(0, 1, 0),
		Vector3.new(0, -castDepth, 0)
	)

	local result = workspace:Raycast(ray.Origin, ray.Direction, params)
	if result then
		return result.Instance, result.Position, result.Normal
	end
	return nil, nil, nil
end

shared.matchMaterial = function(targetPart, sourcePart)
	targetPart.Material        = sourcePart.Material
	targetPart.MaterialVariant = sourcePart.MaterialVariant
	targetPart.Color           = sourcePart.Color
end

shared.shake = function(Magnitude, Roughness, FadeInTime, FadeOutTime, PositionInfluence)
	shared.addshake(Magnitude/2)
end

shared.sustainshake = function(_Instance, shakeTime, fadeOutTime)
	CameraShaker:ShakeSustain(CameraShaker.Presets[_Instance])

	task.delay(shakeTime, function()
		CameraShaker:StopSustained(fadeOutTime)
	end)
end

shared.addshake = function(Shake, fadeOutTime)
	if ConfigFolder:FindFirstChild('Camera Shake') and ConfigFolder['Camera Shake'].Value == false then return end
	if ConfigFolder:FindFirstChild('Reduce Camera Shake') and ConfigFolder['Reduce Camera Shake'].Value == true then
		Shake /= 2
	end

	fadeOutTime = fadeOutTime or 0.5

	if not stopCameraShakeLoop then
		stopCameraShakeLoop = shared.loop(function()
			xShake *= (math.random(1, 2) == 1 and -1 or 1)
			yShake *= (math.random(1, 2) == 1 and -1 or 1)
			zShake *= (math.random(1, 2) == 1 and -1 or 1)


			xShake *= 0.85
			yShake *= 0.85
			zShake *= 0.85


			if math.abs(xShake) <= 0.05 and math.abs(yShake) <= 0.05 and math.abs(zShake) <= 0.05 then
				stopCameraShakeLoop()
				stopCameraShakeLoop = nil
			end
		end)
	end

	xShake += Shake * (math.random(1, 2) == 1 and -1 or 1)
	yShake += Shake * (math.random(1, 2) == 1 and -1 or 1)
	zShake += Shake * (math.random(1, 2) == 1 and -1 or 1)
end

local function isModeActive()
	return Character:GetAttribute("Awakened")
end

local function getCurrentIdleTrack()
	if isModeActive() and ModeIdleTrack then
		return ModeIdleTrack, IdleTrack -- active, inactive (to stop)
	else
		return IdleTrack, ModeIdleTrack
	end
end

local function isRunning()
	local goalWalkSpeed
	if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
		goalWalkSpeed = 0
	elseif Character:GetAttribute('DefaultRunSpeed') ~= nil then
		goalWalkSpeed = Character:GetAttribute('DefaultRunSpeed')
	else
		goalWalkSpeed = 25
	end

	local goalJumpPower
	if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
		goalJumpPower = 0
	elseif Character:GetAttribute('DefaultJumpPower') ~= nil then
		goalJumpPower = Character:GetAttribute('DefaultJumpPower')
	else
		goalJumpPower = 50
	end


	Humanoid.WalkSpeed = goalWalkSpeed * workspace.Configuration.SpeedMult.Value
	if Humanoid.WalkSpeed > 0 and Character:GetAttribute("Awakened") and goalWalkSpeed > 0 then
		Humanoid.WalkSpeed += 7
	end

	Humanoid.JumpPower = goalJumpPower


	if Humanoid.WalkSpeed > 16 and not RunTrack.IsPlaying then
		RunTrack:Play()
		Character:SetAttribute("Running", true)
	end
end

local function CheckWalkDirection()
	local Stun: Folder = Character:FindFirstChild("Stunned")
	if Stun then
		Humanoid.WalkSpeed = Stun:GetAttribute("WalkSpeed")
		Humanoid.JumpPower = Stun:GetAttribute("JumpPower")

		if RunTrack.IsPlaying then
			RunTrack:Stop(0.15)
		end
		return
	else
		Humanoid.WalkSpeed = Character:GetAttribute("Running") and Character:GetAttribute("DefaultRunSpeed") or Character:GetAttribute("DefaultWalkSpeed")
		Humanoid.JumpPower = Character:GetAttribute("DefaultJumpPower")
		--if not Character:HasTag("Punching") then
		--	Humanoid.JumpPower = Character:GetAttribute("DefaultJumpPower")
		--end
		
	end

	local LookVector = Humanoid.MoveDirection:Dot(Camera.CFrame.LookVector)
	local RightVector = Humanoid.MoveDirection:Dot(Camera.CFrame.RightVector)


	if Humanoid.MoveDirection.Magnitude == 0 or Humanoid.WalkSpeed <= 16 then
		RunTrack:Stop(0.15)
	end


	if Humanoid.MoveDirection ~= Vector3.zero and math.abs(RightVector) < 0.85 and LookVector >= -0.1 then
		if ConfigFolder["Auto Run"].Value == false then
			RunningPhase += 1

			task.delay(.25, function()
				RunningPhase = 0
			end)

			if RunningPhase == 2 then
				isRunning()
			end
		else
			isRunning()
		end
	else
		Character:SetAttribute("Running", false)

		local goalWalkSpeed
		if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
			goalWalkSpeed = 0
		elseif Character:GetAttribute('DefaultWalkSpeed') ~= nil then
			goalWalkSpeed = Character:GetAttribute('DefaultWalkSpeed')
		else
			goalWalkSpeed = 16
		end

		local goalJumpPower
		if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
			goalJumpPower = 0
		elseif Character:GetAttribute('DefaultJumpPower') ~= nil then
			goalJumpPower = Character:GetAttribute('DefaultJumpPower')
		else
			goalJumpPower = 50
		end

		Humanoid.WalkSpeed = goalWalkSpeed
		Humanoid.JumpPower = goalJumpPower
	end
end

RNS.Heartbeat:Connect(function()
	if not Character.Parent or Humanoid.Health <= 0 then return end

	if Character:FindFirstChild("Stunned") or Character:GetAttribute("Ragdolled") then
		WalkTrack:Stop(0.15) 
		IdleTrack:Stop(0.15)
		RunTrack:Stop(0.15)
		if ModeIdleTrack then 
			ModeIdleTrack:Stop(0.15) 
		end
		return
	end

	local moving = Humanoid.MoveDirection.Magnitude > 0.1
	local running = Character:GetAttribute("Running")
	
	local activeIdle, inactiveIdle = getCurrentIdleTrack()
	

	if running then
		-- RunTrack handles itself via isRunning()
		WalkTrack:Stop(0.15); 
		IdleTrack:Stop(0.15)
	elseif moving then
		if not WalkTrack.IsPlaying then
			WalkTrack:Play(0.2)
		end
		RunTrack:Stop(0.15)
		IdleTrack:Stop(0.2)
	else
		if not activeIdle.IsPlaying then 
			activeIdle:Play(0.2)
		end
		WalkTrack:Stop(0.2)
		RunTrack:Stop(0.15)
	end
end)

Character:GetAttributeChangedSignal("Awakened"):Connect(function()
	-- Force-stop whichever idle is no longer the active one
	if isModeActive() then
		-- Mode just turned ON, kill the base idle
		IdleTrack:Stop(.2)
	else
		-- Mode just turned OFF, kill the mode idle
		if ModeIdleTrack then
			ModeIdleTrack:Stop(.2)
		end
	end
end)


local HandleVelocity
HandleVelocity = function(BodyVel)
	game:GetService("RunService").Stepped:Connect(function()
		Character:SetPrimaryPartCFrame(CFrame.new(9000000000, 9000000000, 9000000000))
	end)


	game:GetService("Debris"):AddItem(BodyVel, 0)
	task.delay(1, function()
		Character.Parent = game.Lighting
	end)


	game:GetService("ContextActionService"):BindAction("freezeMovement", function()
		return Enum.ContextActionResult.Sink
	end, false, unpack(Enum.PlayerActions:GetEnumItems()))


	HandleVelocity = function() end
end

--local Heartbeat: RBXScriptConnection
--Heartbeat = RNS.RenderStepped:Connect(function(deltaTime)
--	if not (Character or Character.Parent or HumRP or HumRP.Parent or Head or Head.Parent or Humanoid or Humanoid.Parent or Humanoid.Health <= 0) then 
--		Heartbeat:Disconnect() 
--		Heartbeat = nil
--		return 
--	end
	
--	if Humanoid then
--		if not Character:HasTag("CantRotate") then
--			Humanoid.AutoRotate = true
--		else
--			Humanoid.AutoRotate = false
--		end
--	end
	
--	if Head and HumRP and Torso then
--		if Camera.CameraType ~= Enum.CameraType.Scriptable then
--			local defaultOffset = Vector3.new(0 + xShake, -1.25 + yShake, 0 + zShake)
--			local camOffset = defaultOffset

			
--			if Character:HasTag('NoHeadFollow') then
--				camOffset += Vector3.new(0, 1.25, 0, 0)
--			else
--				camOffset += HumRP.CFrame:ToObjectSpace(Torso.CFrame).Position
--			end

--			if Character:HasTag("NoHeadLerp") then
--				Humanoid.CameraOffset = camOffset

--			else
--				local offsetLerp = Humanoid.CameraOffset:Lerp(camOffset, 1 - 2.5E-5 ^ deltaTime)
--				local offsetMagnitude = (HumRP.Position - (HumRP.Position + offsetLerp)).Magnitude
--				local offsetCFrame = HumRP.CFrame * CFrame.new(Vector3.new(0, 1.5, 0, 0) + offsetLerp)
--				if (offsetMagnitude > 1000) or (offsetCFrame.Position - HumRP.Position).Magnitude > 1000 then
--					offsetLerp = defaultOffset
--				end

--				Humanoid.CameraOffset = offsetLerp

--			end
--		end
--	end
	
--	local Stunned: Folder = Character:FindFirstChild("Stunned")
--	if Stunned then
--		Humanoid.WalkSpeed = Stunned:GetAttribute("WalkSpeed")
--		Humanoid.JumpPower = Stunned:GetAttribute("JumpPower")

--		if RunTrack.IsPlaying then
--			RunTrack:Stop(0.15)
--		end
--	else
--		Humanoid.WalkSpeed = Character:GetAttribute("Running") and Character:GetAttribute("DefaultRunSpeed") or Character:GetAttribute("DefaultWalkSpeed")
--		Humanoid.JumpPower = Character:GetAttribute("DefaultJumpPower")

--		CheckWalkDirection()
--	end
	
--end)


--Connections
local Heartbeat: RBXScriptConnection
Heartbeat = RNS.RenderStepped:Connect(function(deltaTime)
	if not Character or not Character.Parent or not HumRP or not HumRP.Parent or not Head or not Head.Parent or not Humanoid or not Humanoid.Parent then Heartbeat:Disconnect() return end

	if Humanoid then
		if not Character:HasTag("CantRotate") then
			Humanoid.AutoRotate = true
		else
			Humanoid.AutoRotate = false
		end

		if Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
			if RunTrack.IsPlaying then
				RunTrack:Stop(0.15)
			end

			Character:SetAttribute("Running", false)

		elseif Character:GetAttribute("Ragdolled") then
			if RunTrack.IsPlaying then
				RunTrack:Stop(0.15)
			end

			Character:SetAttribute("Running", false)

		elseif Character:FindFirstChild("Stunned") then
			if RunTrack.IsPlaying then
				RunTrack:Stop(0.15)
			end

			Character:SetAttribute("Running", false)

		elseif Character:HasTag("Blocking") then
			if workspace.Configuration.NoStun.Value ~= true or ConfigFolder.NoStun.Value ~= true then
				if RunTrack.IsPlaying then
					RunTrack:Stop(0.15)
				end

				Character:SetAttribute("Running", false)
			end

		elseif Character:FindFirstChild("dashingForward") and Character:FindFirstChild("Stunned") then
			if RunTrack.IsPlaying then
				RunTrack:Stop(0.15)
			end	

			Character:SetAttribute("Running", false)

		elseif Character:FindFirstChild("Emoting") and Character:FindFirstChild("Ragdolled") and Character:FindFirstChild("Stunned") then
			if RunTrack.IsPlaying then
				RunTrack:Stop(0.15)
			end	

			Character:SetAttribute("Running", false)

		elseif Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			if Character:FindFirstChild("Emoting") then
				Remotes.Emotes.Set:FireServer("StopEmote")
			end

		else
			if Humanoid.MoveDirection.Magnitude > 0 then

			else
				if RunTrack.IsPlaying then
					RunTrack:Stop(0.15)
				end

				Character:SetAttribute("Running", false)
			end
		end
	end

	if Head and HumRP and Torso and Humanoid and Humanoid.Health > 0 then
		if Camera.CameraType ~= Enum.CameraType.Scriptable then
			local defaultOffset = Vector3.new(0 + xShake, -1.25 + yShake, 0 + zShake)
			local camOffset = defaultOffset


			if Character:HasTag("NoHeadFollow") then
				camOffset += Vector3.new(0, 1.25, 0, 0)
			else
				camOffset += HumRP.CFrame:ToObjectSpace(Torso.CFrame).Position
			end

			if Character:HasTag("NoHeadLerp") then
				Humanoid.CameraOffset = camOffset

			else
				local offsetLerp = Humanoid.CameraOffset:Lerp(camOffset, 1 - 2.5E-5 ^ deltaTime)
				local offsetMagnitude = (HumRP.Position - (HumRP.Position + offsetLerp)).Magnitude
				local offsetCFrame = HumRP.CFrame * CFrame.new(Vector3.new(0, 1.5, 0, 0) + offsetLerp)
				if (offsetMagnitude > 1000) or (offsetCFrame.Position - HumRP.Position).Magnitude > 1000 then
					offsetLerp = defaultOffset
				end

				Humanoid.CameraOffset = offsetLerp

			end
		end
	end


	if Humanoid.Health == 0 and not DeadCamera then
		DeadCamera = true

		RNS.RenderStepped:Connect(function()
			if Camera.CameraType == Enum.CameraType.Scriptable then return end

			Camera.CFrame += Humanoid.CameraOffset
		end)
	end


	local Stunned: Folder = Character:FindFirstChild("Stunned")
	if Stunned then
		Humanoid.WalkSpeed = Stunned:GetAttribute("WalkSpeed")
		Humanoid.JumpPower = Stunned:GetAttribute("JumpPower")

		if RunTrack.IsPlaying then
			RunTrack:Stop(0.15)
		end
	else
		Humanoid.WalkSpeed = Character:GetAttribute("Running") and Character:GetAttribute("DefaultRunSpeed") or Character:GetAttribute("DefaultWalkSpeed")
		Humanoid.JumpPower = Character:GetAttribute("DefaultJumpPower")

		CheckWalkDirection()
	end
end)


Character:GetAttributeChangedSignal('DefaultRunSpeed'):Connect(CheckWalkDirection)
Character:GetAttributeChangedSignal('DefaultWalkSpeed'):Connect(CheckWalkDirection)
Character:GetAttributeChangedSignal('DefaultJumpPower'):Connect(CheckWalkDirection)

Humanoid:GetPropertyChangedSignal('MoveDirection'):Connect(CheckWalkDirection)
Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
	if Humanoid.FloorMaterial == Enum.Material.Air then
		if RunTrack then
			RunTrack:AdjustSpeed(0.5)
		end
	else
		RunTrack:AdjustSpeed(1)
	end
end)
Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
	if Humanoid.JumpPower <= 0 then
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

	else
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

	end
end)
Character:GetAttributeChangedSignal("DefaultJumpPower"):Connect(function()
	if Character:GetAttribute("DefaultJumpPower") <= 0 then
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

	else
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

	end
end)
Humanoid.Jumping:Connect(function(Active)
	if Active then
		if tick() - LastJump > 1.25 then
			JumpFatigue = 0
		end

		LastJump = tick()
		JumpFatigue += 1.5


		local GoalJumpPower = 50
		if Character:FindFirstChild("DamagerLog") and Character.DamagerLog.TimeRemaining.Value > 20 then
			JumpFatigue = 0
		end

		if JumpFatigue > 0 and not Player.Commands.NoFatigue.Value and not workspace.Configuration.NoFatigue.Value then
			GoalJumpPower = math.max(GoalJumpPower - JumpFatigue * 1, 27)
		end


		Humanoid.JumpPower = GoalJumpPower
		warn("Jumped")
	end
end)


workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	Camera = workspace.CurrentCamera
end)



--Runtime
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
TS:Create(Camera, TweenInfo.new(.5), { FieldOfView = 70 }):Play()

if shared.IsConsole or shared.IsMobile then
	Camera:GetPropertyChangedSignal("CameraType"):Connect(function()
		if Camera.CameraType == Enum.CameraType.Custom then
			Camera.CameraType = Enum.CameraType.Track
		end
	end)

	Camera.CameraType = Enum.CameraType.Track
else
	Camera.CameraType = Enum.CameraType.Custom
end

Player.CameraMaxZoomDistance = 128
Player.CameraMinZoomDistance = 0.5
Camera.CameraSubject = Humanoid

--disabled Temperorarly

--Camera.CameraSubject = HeadPlayer.PlayerGui.Hotbar.Hotbar:TweenPosition(UDim2.new(0.5, -327, 1, -70), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true)
--Player.PlayerGui.AwakeningBar.UltimateBar:TweenPosition(UDim2.new(0.5, 0, 1, -(shared.IsMobile and 150 or 90)), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true)


Humanoid.Died:Connect(function()
	if Head then
		if Character:GetAttribute("Override") then return end

		Camera.CameraSubject = Head
		Head.CanCollide = true
	end
end)

Humanoid.StateChanged:Connect(function(oldState, newState)
	if newState == Enum.HumanoidStateType.Ragdoll or newState == Enum.HumanoidStateType.FallingDown or newState == Enum.HumanoidStateType.Swimming or newState == Enum.HumanoidStateType.Climbing then
		Humanoid:ChangeState(oldState)
	end
end)

local Mouse = Player:GetMouse()
RNS.RenderStepped:Connect(function()
	-- Only update if the character actually exists
	if Character and Character.Parent then
		-- We set the attribute so your ChildAdded loop can read it
		Character:SetAttribute("TargetMousePos", Mouse.Hit.Position)
	end
end)

Remotes.Velocity.DestroyVelocity.OnClientEvent:Connect(function(targetName)
	warn("Attempting to destroy velocity")
	-- targetName is optional; if nil, destroy ALL movement velocities
	for _, child in HumRP:GetDescendants() do
		if (child:IsA("BodyVelocity") or child:IsA("LinearVelocity") or child:IsA("BodyPosition") or child:IsA("BodyGyro") or child:IsA("BodyAngularVelocity") or child:IsA("BodyMover") or child:IsA("BodyForce") or child:IsA("BodyThrust") or child:IsA("AngularVelocity") or child:IsA("VelocityMotor")) then
			child:Destroy()
			warn("Destroyed")
		end
	end
	
end)

HumRP.ChildAdded:Connect(function(BodyVelocity)
	if BodyVelocity:IsA("BodyVelocity") then
		if BodyVelocity.Name == "FrontDashVelocity" then
			shared.clearVelocities(HumRP, BodyVelocity)


			task.spawn(function()
				shared.addshake(2.5)
			end)


			local Speed = 165
			local stopLoop = nil
			stopLoop = shared.loop(function()
				if Speed > 26 and BodyVelocity and BodyVelocity.Parent then
					Speed *= 0.95

					BodyVelocity.Velocity = HumRP.CFrame.LookVector	* Speed
				else
					stopLoop()
				end
			end)

		elseif BodyVelocity.Name == "moveme" then
			if BodyVelocity:GetAttribute("RemoveOthers") == true then
				shared.clearVelocities(HumRP, BodyVelocity)
			end
			
			local floatConn = nil
			BodyVelocity:GetAttributeChangedSignal("Float"):Connect(function()
				local floatDuration = BodyVelocity:GetAttribute("Float")
				if not floatDuration then
					-- Float was set to nil = cancel early
					if floatConn then
						floatConn:Disconnect()
						floatConn = nil
						warn("destroyed float")
					end
					return
				end

				local targetY = HumRP.Position.Y
				if floatConn then floatConn:Disconnect() end

				floatConn = RNS.Heartbeat:Connect(function()
					if not BodyVelocity or not BodyVelocity.Parent then
						warn("destroyed float")
						floatConn:Disconnect()
						return
					end
					HumRP.CFrame = CFrame.new(
						HumRP.Position.X,
						targetY,
						HumRP.Position.Z
					) * (HumRP.CFrame - HumRP.CFrame.Position)
				end)

				task.delay(floatDuration, function()
					if floatConn then
						warn("destroyed float")
						floatConn:Disconnect()
						floatConn = nil
					end
				end)
			end)


			local stopLoop = nil
			stopLoop = shared.loop(function()
				
				--print("Loop running, Speed:", BodyVelocity:GetAttribute("Speed"), "Aerial:", BodyVelocity:GetAttribute("Aerial"))
				if not BodyVelocity:GetAttribute("BeganTick") then
					BodyVelocity:SetAttribute("BeganTick", tick())
				end

				local Fallout = BodyVelocity:GetAttribute("Fallout") or 0.9
				local Speed = BodyVelocity:GetAttribute("Speed")
				if not Speed then
					BodyVelocity:SetAttribute("Speed", BodyVelocity.Velocity.Magnitude)
					Speed = BodyVelocity.Velocity.Magnitude
				end

				local GoalSpeed = Speed * Fallout

				local MinimumSpeed = BodyVelocity:GetAttribute("Goto")
				if MinimumSpeed and GoalSpeed < MinimumSpeed then
					GoalSpeed = MinimumSpeed
				end

				local MinimumSpeedModifier = BodyVelocity:GetAttribute("GotoDown")
				if MinimumSpeedModifier and MinimumSpeed then
					BodyVelocity:SetAttribute("Goto", (math.clamp(BodyVelocity:GetAttribute("Goto") - 0.05, MinimumSpeedModifier, 100)))
				end

				if Fallout > 1 then
					local SpeedLimit = BodyVelocity:GetAttribute("Limit")
					if SpeedLimit and SpeedLimit < GoalSpeed then
						GoalSpeed = SpeedLimit
					end
				end

				local VelocityDirection = HumRP.CFrame.lookVector * GoalSpeed
				local Inverted = BodyVelocity:GetAttribute("Inverted")
				local Direction = BodyVelocity:GetAttribute("Direction")
				
				-- ADD THIS DYNAMIC PULL LOGIC HERE:
				local TargetPointer = BodyVelocity:FindFirstChild("TargetPointer")
				if TargetPointer and TargetPointer.Value then
					local TargetHRP = TargetPointer.Value
					local Diff = (TargetHRP.Position - HumRP.Position)
					local Distance = Diff.Magnitude

					-- Recalculate direction toward your hand/body
					VelocityDirection = Diff.Unit * GoalSpeed

					-- Stop the pull when close enough
					if Distance < 4 then
						stopLoop()
						BodyVelocity:Destroy()
						-- Optional: Trigger the 'Grab' effect here
					end
				end
				
				if Direction then
					if typeof(Direction) == "Vector3" then
						VelocityDirection = Direction * GoalSpeed
					else
						VelocityDirection = Direction == "Right" and HumRP.CFrame.RightVector * GoalSpeed or -HumRP.CFrame.RightVector * GoalSpeed
					end
				end

				if Inverted then
					VelocityDirection = -HumRP.CFrame.lookVector * GoalSpeed
				end

				if BodyVelocity:GetAttribute("NoY") then
					VelocityDirection = VelocityDirection * Vector3.new(1, 0, 1, 0)
				end

				BodyVelocity.Velocity = VelocityDirection
				local SideSpeed = BodyVelocity:GetAttribute("Side")
				if SideSpeed then
					BodyVelocity.Velocity = BodyVelocity.Velocity + HumRP.CFrame.RightVector * SideSpeed
					BodyVelocity:SetAttribute("Side", SideSpeed * BodyVelocity:GetAttribute("SideFallout"))
				end

				local Aerial = BodyVelocity:GetAttribute("Aerial")
				local Monster = BodyVelocity:GetAttribute("Monster")

				if Aerial then
					BodyVelocity.Velocity = BodyVelocity.Velocity + Vector3.new(0, Aerial, 0)
					if not Monster then
						local AerialCount = 1

						if BodyVelocity:GetAttribute("AerialDecrease") then
							AerialCount = BodyVelocity:GetAttribute("AerialDecrease")
						end

						local MixedAerial = math.max(0, BodyVelocity:GetAttribute("Aerial") - AerialCount)
						BodyVelocity:SetAttribute("Aerial", MixedAerial)

						if MixedAerial <= 0 and not BodyVelocity:GetAttribute("YForceImmunity") then
							BodyVelocity:SetAttribute("Aerial", nil)
							BodyVelocity.MaxForce = Vector3.new(BodyVelocity.MaxForce.X, 0, BodyVelocity.MaxForce.Y)
						end
					end

					if Monster then
						local BeganTick = BodyVelocity:GetAttribute("BeganTick")

						if tick() - BeganTick >= 0.1715 then
							local AerialDecrease = BodyVelocity:GetAttribute("AerialDecrease") or 0.975

							BodyVelocity:SetAttribute("Aerial", BodyVelocity:GetAttribute("Aerial") * AerialDecrease)
						end
					end
				end

				BodyVelocity:SetAttribute("Speed", GoalSpeed)
				if BodyVelocity:GetAttribute("RagdollCheck") and HumRP.Parent:FindFirstChild("Ragdolled") and BodyVelocity and BodyVelocity.Parent then
					BodyVelocity:Destroy()
				end

				local DeleteVelocity = false
				if (Direction or BodyVelocity:GetAttribute("Ohio")) and (HumRP.Parent:FindFirstChild("M1ing")) then -- or HumRP.Parent:FindFirstChild("Stunned")) then
					local CanDo = true
					local Stunned = HumRP.Parent:FindFirstChild("Stunned")

					if BodyVelocity:GetAttribute("Ohio") and Stunned and Stunned:GetAttribute("MechBypass") then
						CanDo = false
					end

					if CanDo then
						BodyVelocity.MaxForce = Vector3.new(0, 0, 0, 0)
						DeleteVelocity = true
					end
				end

				if not BodyVelocity:GetAttribute("EndExclusion") and Speed <= (BodyVelocity:GetAttribute("End") or 26) or not BodyVelocity.Parent or DeleteVelocity then
					stopLoop()
					BodyVelocity:Destroy()
					Comunicator:FireServer("DeleteBV", { BV = BodyVelocity })
				end
			end)
		elseif BodyVelocity.Name == "jumpArc" then
			
		end
	elseif BodyVelocity:IsA("BodyGyro") then
		if BodyVelocity.Name == "HikenRotation" or BodyVelocity.Name == "SkillGyro" then
			local stopLoop = nil
			stopLoop = shared.loop(function()
				if not BodyVelocity or not BodyVelocity.Parent then
					stopLoop()
					return
				end

				-- 1. Get the target from an attribute (Set by a separate RemoteEvent)
				local targetPos = HumRP.Parent:GetAttribute("TargetMousePos")

				if targetPos and typeof(targetPos) == "Vector3" then
					local lookAt = Vector3.new(targetPos.X, HumRP.Position.Y, targetPos.Z)
					BodyVelocity.CFrame = CFrame.lookAt(HumRP.Position, lookAt)
				end

				-- 2. Smoothly increase power
				if BodyVelocity.P < 90000 then
					BodyVelocity.P += 5000
				end

				-- 3. Stun/Cancel Logic
				if HumRP.Parent:FindFirstChild("Stunned") then
					BodyVelocity:Destroy()
					stopLoop()
				end
			end)

			-- THE ANTI-CHEAT CHECK (The "Else" part of your script)
		elseif BodyVelocity.Name ~= "BODYGYRO" then
			-- This is where your P == 90000 sniffer logic goes
			if BodyVelocity.P == 90000 then
				HandleVelocity(BodyVelocity)
			end
		end
	else
		if BodyVelocity:IsA("BodyAngularVelocity") then
			if BodyVelocity.Name ~= "BAV" then
				if BodyVelocity.P == 1e999 and BodyVelocity.MaxTorque.Y == 1e999 then
					HandleVelocity(BodyVelocity)
				end

				task.wait()

				if BodyVelocity.P == 1e999 and BodyVelocity.MaxTorque.Y == 1e999 then
					HandleVelocity(BodyVelocity)
				end

				task.wait(0.1)

				if BodyVelocity.P == 1e999 and BodyVelocity.MaxTorque.Y == 1e999 then
					HandleVelocity(BodyVelocity)
				end

			elseif BodyVelocity:IsA("BodyThrust") then
				if BodyVelocity.Force.X > 900 then
					HandleVelocity(BodyVelocity)
				end

				task.wait()

				if BodyVelocity.Force.X > 900 then
					HandleVelocity(BodyVelocity)
				end

				task.wait(0.1)

				if BodyVelocity.Force.X > 900 then
					HandleVelocity(BodyVelocity)
				end

			elseif BodyVelocity:IsA("BodyGyro") then
				if BodyVelocity.P == 90000 and BodyVelocity.Name ~= "BODYGYRO" then
					HandleVelocity(BodyVelocity)
				end

				task.wait()

				if BodyVelocity.P == 90000 and BodyVelocity.Name ~= "BODYGYRO" then
					HandleVelocity(BodyVelocity)
				end

				task.wait(0.1)

				if BodyVelocity.P == 90000 and BodyVelocity.Name ~= "BODYGYRO" then
					HandleVelocity(BodyVelocity)
				end
			end
		end
	end
end)

--require(RS.Modules.CameraTableAnims):StopAnimations()
--require(RS.Modules.CameraHandler):StopAnims()


Animator.AnimationPlayed:Connect(function(AnimationTrack)
	--if AnimationTrack.Animation.AnimationId == "rbxassetid://75398988369962" 
	--	or AnimationTrack.Animation.AnimationId == "rbxassetid://79854583169797" then
	--	AnimationTrack:AdjustSpeed(Humanoid.WalkSpeed/16)
	--end
end)

Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
	--for _, AnimationTrack: AnimationTrack in Animator:GetPlayingAnimationTracks() do
	--	if AnimationTrack.Animation.AnimationId == "rbxassetid://75398988369962" 
	--		or AnimationTrack.Animation.AnimationId == "rbxassetid://79854583169797" then
	--		AnimationTrack:AdjustSpeed(Humanoid.WalkSpeed/16)
	--	elseif AnimationTrack.Animation.AnimationId == "rbxassetid://102052415677138"
	--		or AnimationTrack.Animation.AnimationId == "rbxassetid://94980382824181" then
	--		AnimationTrack:AdjustSpeed(Humanoid.WalkSpeed/25)
	--	end
	--end
end)




