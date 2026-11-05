local Player = game.Players.LocalPlayer


repeat task.wait() until game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled or game:GetService("UserInputService").GamepadEnabled
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded") and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")

--Services
local MarketService = game:GetService("MarketplaceService")
local RNS = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TS = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local GuiService = game:GetService("GuiService")
local VoiceChatService = game:GetService("VoiceChatService")
local TextChatService = game:GetService("TextChatService")

--Remotes
local Remotes = RS.Remotes

--Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid: Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
local Animator: Animator = Humanoid:FindFirstChild("Animator") or Humanoid:WaitForChild("Animator", 10)
local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
local Camera = workspace.CurrentCamera
local gameSettings = UserSettings().GameSettings

local function updateCharacter(newCharacter)
	Character = newCharacter
	Humanoid = Character:WaitForChild("Humanoid")
	Animator = Humanoid:WaitForChild("Animator")
	HumRP = Character:WaitForChild("HumanoidRootPart")
end

-- Initialize for the first time
if Player.Character then
	updateCharacter(Player.Character)
end

Player.CharacterAdded:Connect(updateCharacter)

shared.IsConsole = UIS.GamepadEnabled == true
shared.IsMobile = UIS.TouchEnabled == true

local PlayerGui = Player.PlayerGui
local ConsoleControls = PlayerGui:WaitForChild('Console', 5):WaitForChild('ConsoleControls', 5)

--local function Shiftlock()
--	if not Character:HasTag('CantRotate') then
--		Humanoid.AutoRotate = false
--		HumRP.CFrame = CFrame.new(HumRP.Position, Vector3.new(Camera.CFrame.LookVector.X * 1000000, HumRP.Position.Y, Camera.CFrame.LookVector.Z * 1000000))
--		Camera.CFrame = Camera.CFrame * CFrame.new(1.75, 0 ,0)
--	end
--end

--local lastShiftlock
--if shared.IsConsole or shared.IsMobile then
--	--lastShiftlock = RNS.RenderStepped:Connect(Shiftlock)
--end

local function checkCharacterAvailability()
	return Character ~= nil and Character.Parent ~= nil and HumRP ~= nil and HumRP.Parent ~= nil and Humanoid ~= nil and Humanoid.Parent ~= nil and Humanoid.Health > 0 and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead
end

local LastSideDash = 0
local LastBackDash = 0
local function DashCheck()
	if not checkCharacterAvailability() then return end

	local Rotation
	if UIS.KeyboardEnabled and not UIS.GamepadEnabled and not UIS.TouchEnabled then
		if UIS:IsKeyDown(Enum.KeyCode.W) then
			Rotation = 0

		elseif UIS:IsKeyDown(Enum.KeyCode.S) then
			Rotation = 180

		elseif UIS:IsKeyDown(Enum.KeyCode.D) then
			Rotation = -90

		elseif UIS:IsKeyDown(Enum.KeyCode.A) then
			Rotation = 90

		end
	else
		Rotation = HumRP.CFrame

		local Reference = HumRP.CFrame + Humanoid.MoveDirection * 15
		local ReferencePosition = Reference.Position
		local LookVector = (Vector3.new(ReferencePosition.X, Rotation.Position.Y, ReferencePosition.Z) - Rotation.Position).Unit
		local LookVectorRotation = math.deg((math.acos((Rotation.LookVector:Dot(LookVector)))))

		Rotation = 0
		if LookVectorRotation > -45 and LookVectorRotation < 45 then
			Rotation = 0

		elseif LookVectorRotation > 135 and LookVectorRotation < 215 then
			Rotation = 180

		elseif LookVectorRotation >= 45 and LookVectorRotation <= 135 then
			ReferencePosition = HumRP.CFrame * CFrame.new(15, 0, 0)
			LookVector = HumRP.CFrame * CFrame.new(-15, 0, 0)

			Rotation = (Reference.Position - ReferencePosition.Position).Magnitude > (Reference.Position - LookVector.Position).Magnitude and 90 or -90

		end

	end


	local currDirection

	if Rotation == 0 then
		currDirection = 'Front'
	elseif Rotation == 180 then
		currDirection = 'Back'
	elseif Rotation == 90 then
		currDirection = 'Left'
	elseif Rotation == -90 then
		currDirection = 'Right'
	else
		currDirection = 'Front'
	end


	if currDirection == "Left" or currDirection == "Right" then
		if tick() - LastSideDash < 2 then return end --and not Player.Commands.NoDashCD.Value and not workspace.Configuration.NoDashCD.Value then return end

		if not Character:HasTag('Ragdolled') and not Character:HasTag("Knockbacked") then
			if (Character:HasTag('SideDashCD')) or Character:HasTag('CantSideDash') or Character:HasTag('Stunned') or Character:FindFirstChild("Stunned") then --and not Player.Commands.NoDashCD.Value and not workspace.Configuration.NoDashCD.Value)
				return
			end

		else
			if Character:HasTag('CantRagdollCancel') or Character:GetAttribute('RagdollCancel') ~= true then
				return
			end
		end

		LastSideDash = tick()


		shared.clearVelocities(HumRP)

		Character:SetAttribute("SideDashing", true)


		if Humanoid:GetState() == Enum.HumanoidStateType.Physics then
			Humanoid:ChangeState(Enum.HumanoidStateType.Running)
		end

		if Humanoid.PlatformStand then
			Humanoid.PlatformStand = false
		end

		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

		task.delay(0.6, function()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		end)


		local dashAnim = Instance.new("Animation")
		dashAnim.AnimationId = "rbxassetid://"
		if currDirection == "Left" then
			--dashAnim.AnimationId = "rbxassetid://139212625147266"
			dashAnim.AnimationId = "rbxassetid://140605582146250"
		else
			--dashAnim.AnimationId = "rbxassetid://110122816377050"
			dashAnim.AnimationId = "rbxassetid://81398936754758"

		end

		local AnimationTrack = Animator:LoadAnimation(dashAnim)
		dashAnim:Destroy()

		local Speed = 200
		local Mult

		gameSettings.RotationType = Enum.RotationType.CameraRelative

		if currDirection == "Right" then
			Mult = 1
		else
			Mult = -1
		end

		local DashVelocity = Instance.new('BodyVelocity')
		DashVelocity.MaxForce = Character:HasTag("Slowed") and Vector3.new(10000, 0, 10000) or Vector3.new(50000, 0, 50000)
		DashVelocity.Parent = HumRP

		AnimationTrack.Stopped:Once(function()
			if DashVelocity and DashVelocity.Parent then
				DashVelocity:Destroy()
			end

			gameSettings.RotationType = Enum.RotationType.MovementRelative
		end)

		task.delay(0.325, function()
			Character:SetAttribute("SideDashing", false)
		end)

		AnimationTrack:Play()


		local stopLoop = nil
		stopLoop = shared.loop(function()
			if Speed > 5 and DashVelocity.Parent then
				Speed *= 0.91


				HumRP.CFrame = CFrame.lookAlong(HumRP.Position, Camera.CFrame.LookVector * Vector3.new(1, 0, 1))
				DashVelocity.Velocity = (HumRP.CFrame.RightVector * Mult) * Speed
			else
				stopLoop()
				gameSettings.RotationType = Enum.RotationType.MovementRelative
			end
		end)

	elseif currDirection == "Back" then
		if tick() - LastBackDash < 5 then return end -- and not Player.Commands.NoDashCD.Value and not workspace.Configuration.NoDashCD.Value then return end

		if not Character:HasTag('Ragdolled') and not Character:HasTag("Knockbacked") then
			if (Character:HasTag('DashCD')) or Character:HasTag('CantDash') or Character:HasTag('Stunned') then --and not Player.Commands.NoDashCD.Value and not workspace.Configuration.NoDashCD.Value
				return
			end

		else
			if Character:HasTag('CantRagdollCancel') or Character:GetAttribute('RagdollCancel') ~= true then
				return
			end
		end

		LastBackDash = tick()


		shared.clearVelocities(HumRP)

		Character:SetAttribute("Dashing", true)

		if Humanoid:GetState() == Enum.HumanoidStateType.Physics then
			Humanoid:ChangeState(Enum.HumanoidStateType.Running)
		end

		if Humanoid.PlatformStand then
			Humanoid.PlatformStand = false
		end

		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

		Character:AddTag('CantSideDash')
		task.delay(1.051, function()
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
			Character:RemoveTag('CantSideDash')
		end)


		local dashAnim = Instance.new("Animation")
		dashAnim.AnimationId = "rbxassetid://77046991681714"
		local AnimationTrack = Animator:LoadAnimation(dashAnim)
		dashAnim:Destroy()

		gameSettings.RotationType = Enum.RotationType.CameraRelative


		local Speed = 160
		local BackSpeed = 160

		local DashVelocity = Instance.new("BodyVelocity")
		DashVelocity.MaxForce = Character:HasTag("Slowed") and Vector3.new(10000, 0, 10000) or Vector3.new(50000, 0, 50000)
		DashVelocity.Parent = HumRP

		AnimationTrack.Stopped:Once(function()
			Character:SetAttribute("Dashing", false)

			if DashVelocity and DashVelocity.Parent then
				DashVelocity:Destroy()
			end

			gameSettings.RotationType = Enum.RotationType.MovementRelative
		end)

		AnimationTrack:Play()

		local stopLoop = nil
		stopLoop = shared.loop(function()
			if DashVelocity and DashVelocity.Parent then
				Speed *= 0.91

				if Speed <= 10 then
					if BackSpeed then
						Speed = (BackSpeed or 0) * 0.75
						BackSpeed = nil
					else
						DashVelocity:Destroy()
					end
				end

				HumRP.CFrame = CFrame.lookAlong(HumRP.Position, Camera.CFrame.LookVector * Vector3.new(1, 0, 1))
				DashVelocity.Velocity = -HumRP.CFrame.LookVector * Speed
			else
				stopLoop()
				gameSettings.RotationType = Enum.RotationType.MovementRelative
			end
		end)
	end

	Remotes.Dash:FireServer({ Key = Enum.KeyCode.Q, Direction = currDirection, ClientCFrame = HumRP.CFrame })
end


local combatKeybinds = {} 

if UIS.KeyboardEnabled == true and UIS.GamepadEnabled == false and UIS.TouchEnabled == false then
	combatKeybinds.Punch = Enum.UserInputType.MouseButton1
	combatKeybinds.Dash = Enum.KeyCode.Q
	combatKeybinds.Block = Enum.KeyCode.F
elseif UIS.KeyboardEnabled == false and UIS.GamepadEnabled == true and UIS.TouchEnabled == false then
	combatKeybinds.Punch = Enum.KeyCode.ButtonB
	combatKeybinds.Dash = Enum.KeyCode.ButtonY
	combatKeybinds.Block = Enum.KeyCode.ButtonX

	ConsoleControls.Visible = true
elseif UIS.KeyboardEnabled == true and UIS.GamepadEnabled == false and UIS.TouchEnabled == true then
	ConsoleControls.Visible = false
end

local StartMouseMovePosition, StartSelectedButtonPosition
local NewInput = true
UIS.InputBegan:Connect(function(input, gameProccessedEvent)
	--if gameProccessedEvent and selectedFrame == nil then return end
	if gameProccessedEvent then return end

	if input.UserInputType == combatKeybinds.Punch or input.KeyCode == combatKeybinds.Punch then

		task.spawn(function()
			RNS.Heartbeat:Wait()
			--Punch()
		end)

	elseif input.KeyCode == combatKeybinds.Dash then
		DashCheck()
	end
end)

UIS.InputEnded:Connect(function(input, gpe)

end)

Animator.AnimationPlayed:Connect(function(animationTrack)
	animationTrack.Ended:Once(function()
		if not HumRP then return end

		local Part = Instance.new("Part")
		Part.Massless = true
		Part.Anchored = false
		Part.Size = Vector3.zero
		Part.Material = Enum.Material.SmoothPlastic
		Part.Transparency = 1
		Part.EnableFluidForces = false
		Part.CastShadow = false
		Part.CanCollide = false
		Part.CanTouch = false
		Part.CanQuery = false
		Part.Parent = HumRP

		local Weld = Instance.new("Weld")
		Weld.Parent = Part
		Weld.Part0 = HumRP
		Weld.Part1 = Part

		RNS.RenderStepped:Wait()

		Part:Destroy()
	end)
end)