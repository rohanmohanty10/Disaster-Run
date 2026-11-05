----Services
--local TS = game:GetService('TweenService')
--local Debris = game:GetService("Debris")
--local RNS = game:GetService('RunService')
--local Players = game:GetService('Players')
--local RS = game:GetService('ReplicatedStorage')
--local UIS = game:GetService("UserInputService")
--local CollectionService = game:GetService("CollectionService")



----Player
--if script.Parent.Parent:GetAttribute("ClonedChar2") then
--	return script:Destroy("")
--end


--local Player = Players.LocalPlayer

--repeat task.wait() until game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled or game:GetService("UserInputService").GamepadEnabled
----repeat task.wait() until Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
--repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded")--and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
--task.wait(.1)

--local ConfigFolder: Configuration = Player:FindFirstChild('Configuration') or Player:WaitForChild('Configuration', 10)
--local Character = Player.Character or Player.CharacterAdded:Wait()
--local Animate = Character:WaitForChild("Animate", 5)
--Animate:WaitForChild("walk"):WaitForChild("WalkAnim")
--local Humanoid: Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
--local Animator: Animator = Humanoid:FindFirstChild("Animator") or Humanoid:WaitForChild("Animator", 10)
--local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
--local RootJoint: Motor6D = HumRP:FindFirstChild("RootJoint") or HumRP:WaitForChild("RootJoint", 10)
--local DefaultC0Offset = RootJoint.C0
--local Head: BasePart = Character:FindFirstChild('Head') or Character:WaitForChild('Head', 10)
--local Torso: BasePart = Character:FindFirstChild('Torso') or Character:WaitForChild('Torso', 10)



----Remotes
--local Remotes = RS.Remotes


--local Comunicator: RemoteEvent = Remotes.Comunicator.Set



----Raycast Params
--local params = RaycastParams.new()
--params.FilterType = Enum.RaycastFilterType.Include
--params.FilterDescendantsInstances = {
--	workspace.World.Map, 
--	--workspace.Map.Miscellaneous, 
--	--workspace.Map.Borders
--}
--params.IgnoreWater = true

----Variables
--local Camera = workspace.CurrentCamera
--local stopCameraShakeLoop = nil
--local xShake, yShake, zShake = 0, 0, 0
--local RunningPhase = 0
--local LastJump = 0
--local JumpFatigue = 0
--local DragonCamera
--local DeadCamera = false
--local blockedAnimations = {}

--local ANIM_IDS = {
--	Sanji = {
--		Idle = "rbxassetid://90290868087583",
--		Walk = "rbxassetid://119306736029103",
--		Run  = "rbxassetid://123811695476560",
--	},
--	Zoro = {
--		Idle = "rbxassetid://82706021300355",
--		Walk = "rbxassetid://119306736029103",
--		Run  = "rbxassetid://72538278199987",
--	},
--	Default = {
--		Idle = "rbxassetid://114579677901031",
--		Walk = "rbxassetid://119306736029103",
--		Run  = "rbxassetid://103491985031157",
--	},
--}

--local moveset = Player:GetAttribute("Moveset") or Player:GetAttribute("Character")
--local animSet = ANIM_IDS[moveset] or ANIM_IDS.Default

---- Exactly how the working script does it
--task.spawn(function()
--	if Animate then
--		Animate.walk.WalkAnim.AnimationId = animSet.Walk

--		Animate:WaitForChild("toolnone", 5)
--		task.delay(0.01, function()
--			if Animate:FindFirstChild("idle") then
--				for _, anim in Animate.idle:GetChildren() do
--					if anim:IsA("Animation") then
--						anim.AnimationId = animSet.Idle
--					end
--				end
--			end
--		end)
--	end
--end)

---- Run track exactly how the working script does it
--local RunAnimation = Instance.new("Animation")
--RunAnimation.AnimationId = animSet.Run
--local RunTrack = Animator:LoadAnimation(RunAnimation)
--RunAnimation:Destroy()
--RunTrack.Name = "RunAnimation"
--RunTrack.Looped = true
--RunTrack.Priority = Enum.AnimationPriority.Movement

---- Expose for other scripts
--local ref = Instance.new("ObjectValue")
--ref.Name = "RunTrackRef"
--ref.Value = RunTrack
--ref.Parent = Character

--local function isRunning()
--	local goalWalkSpeed
--	if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
--		goalWalkSpeed = 0
--	elseif Character:GetAttribute('DefaultRunSpeed') ~= nil then
--		goalWalkSpeed = Character:GetAttribute('DefaultRunSpeed')
--	else
--		goalWalkSpeed = 25
--	end

--	local goalJumpPower
--	if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
--		goalJumpPower = 0
--	elseif Character:GetAttribute('DefaultJumpPower') ~= nil then
--		goalJumpPower = Character:GetAttribute('DefaultJumpPower')
--	else
--		goalJumpPower = 50
--	end


--	Humanoid.WalkSpeed = goalWalkSpeed * workspace.Configuration.SpeedMult.Value
--	if Humanoid.WalkSpeed > 0 and Character:GetAttribute("Awakened") and goalWalkSpeed > 0 then
--		Humanoid.WalkSpeed += 7
--	end

--	Humanoid.JumpPower = goalJumpPower


--	if Humanoid.WalkSpeed > 16 and not RunTrack.IsPlaying then
--		RunTrack:Play()
--		Character:SetAttribute("Running", true)
--	end
--end

--local function CheckWalkDirection()
--	local Stun: Folder = Character:FindFirstChild("Stunned")
--	if Stun then
--		Humanoid.WalkSpeed = Stun:GetAttribute("WalkSpeed")
--		Humanoid.JumpPower = Stun:GetAttribute("JumpPower")

--		if RunTrack.IsPlaying then
--			RunTrack:Stop(0.15)
--		end
--		return
--	else
--		Humanoid.WalkSpeed = Character:GetAttribute("Running") and Character:GetAttribute("DefaultRunSpeed") or Character:GetAttribute("DefaultWalkSpeed")
--		Humanoid.JumpPower = Character:GetAttribute("DefaultJumpPower")
--		--if not Character:HasTag("Punching") then
--		--	Humanoid.JumpPower = Character:GetAttribute("DefaultJumpPower")
--		--end

--	end

--	local LookVector = Humanoid.MoveDirection:Dot(Camera.CFrame.LookVector)
--	local RightVector = Humanoid.MoveDirection:Dot(Camera.CFrame.RightVector)


--	if Humanoid.MoveDirection.Magnitude == 0 or Humanoid.WalkSpeed <= 16 then
--		RunTrack:Stop(0.15)
--	end


--	if Humanoid.MoveDirection ~= Vector3.zero and math.abs(RightVector) < 0.85 and LookVector >= -0.1 then
--		if ConfigFolder["Auto Run"].Value == false then
--			RunningPhase += 1

--			task.delay(.25, function()
--				RunningPhase = 0
--			end)

--			if RunningPhase == 2 then
--				isRunning()
--			end
--		else
--			isRunning()
--		end
--	else
--		Character:SetAttribute("Running", false)

--		local goalWalkSpeed
--		if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
--			goalWalkSpeed = 0
--		elseif Character:GetAttribute('DefaultWalkSpeed') ~= nil then
--			goalWalkSpeed = Character:GetAttribute('DefaultWalkSpeed')
--		else
--			goalWalkSpeed = 16
--		end

--		local goalJumpPower
--		if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
--			goalJumpPower = 0
--		elseif Character:GetAttribute('DefaultJumpPower') ~= nil then
--			goalJumpPower = Character:GetAttribute('DefaultJumpPower')
--		else
--			goalJumpPower = 50
--		end

--		Humanoid.WalkSpeed = goalWalkSpeed
--		Humanoid.JumpPower = goalJumpPower
--	end
--end

--Character:GetAttributeChangedSignal('DefaultRunSpeed'):Connect(CheckWalkDirection)
--Character:GetAttributeChangedSignal('DefaultWalkSpeed'):Connect(CheckWalkDirection)
--Character:GetAttributeChangedSignal('DefaultJumpPower'):Connect(CheckWalkDirection)

--Humanoid:GetPropertyChangedSignal('MoveDirection'):Connect(CheckWalkDirection)
--Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
--	if Humanoid.FloorMaterial == Enum.Material.Air then
--		if RunTrack then
--			RunTrack:AdjustSpeed(0.5)
--		end
--	else
--		RunTrack:AdjustSpeed(1)
--	end
--end)
--Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
--	if Humanoid.JumpPower <= 0 then
--		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
--	else
--		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
--	end
--end)
--Character:GetAttributeChangedSignal("DefaultJumpPower"):Connect(function()
--	if Character:GetAttribute("DefaultJumpPower") <= 0 then
--		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
--	else
--		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
--	end
--end)
--Humanoid.Jumping:Connect(function(Active)
--	if Active then
--		if tick() - LastJump > 1.25 then
--			JumpFatigue = 0
--		end

--		LastJump = tick()
--		JumpFatigue += 1.5

--		local GoalJumpPower = 50
--		if Character:FindFirstChild("DamagerLog") and Character.DamagerLog.TimeRemaining.Value > 20 then
--			JumpFatigue = 0
--		end

--		if JumpFatigue > 0 and not Player.Commands.NoFatigue.Value and not workspace.Configuration.NoFatigue.Value then
--			GoalJumpPower = math.max(GoalJumpPower - JumpFatigue * 1, 27)
--		end

--		Humanoid.JumpPower = GoalJumpPower
--	end
--end)

--workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
--	Camera = workspace.CurrentCamera
--end)

--local Mouse = Player:GetMouse()
--RNS.RenderStepped:Connect(function()
--	if Character and Character.Parent then
--		Character:SetAttribute("TargetMousePos", Mouse.Hit.Position)
--	end
--end)
