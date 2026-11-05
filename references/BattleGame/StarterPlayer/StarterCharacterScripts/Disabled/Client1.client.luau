--Services
local TS = game:GetService('TweenService')
local Debris = game:GetService("Debris")
local RNS = game:GetService('RunService')
local Players = game:GetService('Players')
local RS = game:GetService('ReplicatedStorage')
local CollectionService = game:GetService("CollectionService")



--Player
if script.Parent.Parent:GetAttribute("ClonedChar2") then
	return script:Destroy("")
end


local Player = Players.LocalPlayer

repeat task.wait() until game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled or game:GetService("UserInputService").GamepadEnabled
--repeat task.wait() until Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded")--and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")


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
--				Animation.AnimationId = "rbxassetid://90918379876257"
--			end
--		end
--	end)
--end)


local RunAnimation = Instance.new("Animation")
--if Player:GetAttribute("Moveset") == "Cursed Child" then
--RunAnimation.AnimationId = "rbxassetid://94980382824181"
--else
--RunAnimation.AnimationId = "rbxassetid://87144289641620" 86556484658803-- jjs
RunAnimation.AnimationId = "rbxassetid://86556484658803"
--end
local RunTrack = Animator:LoadAnimation(RunAnimation)
RunAnimation:Destroy()
RunTrack.Name = "RunAnimation"
RunTrack.Looped = true
RunTrack.Priority = Enum.AnimationPriority.Movement


local CameraShaker = require(RS.Modules.CameraShaker).new(Enum.RenderPriority.Camera.Value, function(Offset)
	Camera.CFrame *= Offset
end)
CameraShaker:Start()



--Functions
local function raycast(origin, direction)
	return workspace:Raycast(origin, direction, params)
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

local function isRunning()
	local goalWalkSpeed
	if Player.Commands.NoMovement.Value == true or workspace.Configuration.NoMovement.Value == true then
		goalWalkSpeed = 0
	elseif game:GetService("RunService"):IsStudio() and Character:GetAttribute("CustomSpeed") ~= nil then -- custom speed stuff
		goalWalkSpeed = Character:GetAttribute("CustomSpeed")
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



--Params
local Oparams = OverlapParams.new()
Oparams.FilterType = Enum.RaycastFilterType.Include
Oparams.FilterDescendantsInstances = { workspace.World.Map }


local Heartbeat: RBXScriptConnection
Heartbeat = RNS.RenderStepped:Connect(function(deltaTime)
	if not Character or not Character.Parent or not HumRP or not HumRP.Parent or not Head or not Head.Parent or not Humanoid or not Humanoid.Parent then Heartbeat:Disconnect() return end

	if Head and HumRP and Torso then
		if Camera.CameraType ~= Enum.CameraType.Scriptable then
			local defaultOffset = Vector3.new(0 + xShake, -1.25 + yShake, 0 + zShake)
			local camOffset = defaultOffset

			
			if Character:HasTag('NoHeadFollow') then
				camOffset += Vector3.new(0, 1.25, 0, 0)
			else
				camOffset += HumRP.CFrame:ToObjectSpace(Head.CFrame).Position
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
end)


--Connections
--local Heartbeat: RBXScriptConnection
--Heartbeat = RNS.RenderStepped:Connect(function(deltaTime)
--	if not Character or not Character.Parent or not HumRP or not HumRP.Parent or not Head or not Head.Parent or not Humanoid or not Humanoid.Parent then Heartbeat:Disconnect() return end

--	if Humanoid then
--		if not Character:HasTag("CantRotate") then
--			Humanoid.AutoRotate = true
--		else
--			Humanoid.AutoRotate = false
--		end


--		if Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
--			if RunTrack.IsPlaying then
--				RunTrack:Stop(0.15)
--			end

--			Character:SetAttribute("Running", false)

--		elseif Character:GetAttribute("Ragdolled") then
--			if RunTrack.IsPlaying then
--				RunTrack:Stop(0.15)
--			end

--			Character:SetAttribute("Running", false)

--		elseif Character:FindFirstChild("Stunned") then
--			if RunTrack.IsPlaying then
--				RunTrack:Stop(0.15)
--			end

--			Character:SetAttribute("Running", false)

--		elseif Character:HasTag("Blocking") then
--			if workspace.Configuration.NoStun.Value ~= true or ConfigFolder.NoStun.Value ~= true then
--				if RunTrack.IsPlaying then
--					RunTrack:Stop(0.15)
--				end

--				Character:SetAttribute("Running", false)
--			end

--		elseif Character:FindFirstChild("dashingForward") and Character:FindFirstChild("Stunned") then
--			if RunTrack.IsPlaying then
--				RunTrack:Stop(0.15)
--			end	

--			Character:SetAttribute("Running", false)

--		elseif Character:FindFirstChild("Emoting") and Character:FindFirstChild("Ragdolled") and Character:FindFirstChild("Stunned") then
--			if RunTrack.IsPlaying then
--				RunTrack:Stop(0.15)
--			end	

--			Character:SetAttribute("Running", false)

--		elseif Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
--			if Character:FindFirstChild("Emoting") then
--				Comunicator:FireServer("StopEmote")
--			end

--		else
--			if Humanoid.MoveDirection.Magnitude > 0 then

--			else
--				if RunTrack.IsPlaying then
--					RunTrack:Stop(0.15)
--				end

--				Character:SetAttribute("Running", false)
--			end
--		end
--	end

--	if Head and HumRP and Torso then
--		if Camera.CameraType ~= Enum.CameraType.Scriptable then
--			local defaultOffset = Vector3.new(0 + xShake, -1.25 + yShake, 0 + zShake)
--			local camOffset = defaultOffset

--			if DragonCamera and DragonCamera.Value then
--				camOffset += HumRP.CFrame:ToObjectSpace(DragonCamera.Value.RootPart.Root.UpperMouth["Bone.002"]["Bone.003"].WorldCFrame).Position
--			elseif Character:HasTag('NoHeadFollow') then
--				camOffset += Vector3.new(0, 1.25, 0, 0)
--			else
--				camOffset += HumRP.CFrame:ToObjectSpace(Head.CFrame).Position
--			end

--			if DragonCamera and not DragonCamera.Parent then
--				DragonCamera = nil
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


--	if Humanoid.Health == 0 and not DeadCamera then
--		DeadCamera = true

--		RNS.RenderStepped:Connect(function()
--			if Camera.CameraType == Enum.CameraType.Scriptable then return end

--			Camera.CFrame += Humanoid.CameraOffset
--		end)
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
				if Direction then
					VelocityDirection = Direction == "Right" and HumRP.CFrame.RightVector * GoalSpeed or -HumRP.CFrame.RightVector * GoalSpeed
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
				if (Direction or BodyVelocity:GetAttribute("Ohio")) and (HumRP.Parent:FindFirstChild("M1ing") or HumRP.Parent:FindFirstChild("Stunned")) then
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




