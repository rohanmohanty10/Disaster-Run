local TouchGui: ScreenGui
local loadStart = tick()

local Player = game.Players.LocalPlayer

repeat task.wait() until game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled or game:GetService("UserInputService").GamepadEnabled
repeat task.wait() until game:IsLoaded() and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")

local InterfaceHandler = require(script.Interface).new()
task.spawn(InterfaceHandler.Start, InterfaceHandler)

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

local ConfigFolder = Player:FindFirstChild('Configuration') or Player:WaitForChild('Configuration', 10)

local vfxFramework = require(RS.Modules.ClientEffects.RandomModules3.EmitModuleTemp)
vfxFramework.init()
local MusicService = require(RS.Modules.MusicService)
MusicService:Start()

--Remotes
local Remotes = RS.Remotes

local ComRemotes = Remotes.Comunicator

local Comunicator = ComRemotes.Set
local Getter = ComRemotes.Get


local PSE = Remotes.Commands.Set


--local CombatRemotes = Remotes.Combat

--local CombatSet = CombatRemotes.Set
--local CombatGet = CombatRemotes.Get



--Modules
local RPModules = RS.Modules

local SoundsModule = require(RPModules.SoundHandler)


local InfoModule = require(RS.Info)



--Player
local gameSettings = UserSettings().GameSettings

local Mouse = Player:GetMouse()

local TouchControlFrame: Frame, JumpButton: ImageButton, PunchButton: ImageButton, DashButton: ImageButton, BlockButton: ImageButton, ShiftlockButton: ImageButton
local mobileButtonsCreated = false

local ConfigFolder = Player:FindFirstChild('Configuration') or Player:WaitForChild('Configuration', 10)
local ShiftlockConfig: BoolValue = ConfigFolder:FindFirstChild('Shiftlock') or ConfigFolder:WaitForChild('Shiftlock', 10)
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid: Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
local Animator: Animator = Humanoid:FindFirstChild("Animator") or Humanoid:WaitForChild("Animator", 10)
local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
local Camera = workspace.CurrentCamera


local PSCfgFolder = Player:FindFirstChild('Commands') or Player:WaitForChild('Commands', 10)
local Cons = {}

--switcheed 7/17 to fix ppl with pc who have controller plugged in and can't turn their camera with no shiftlock
--shared.IsConsole = UIS.GamepadEnabled == true
--shared.IsMobile = UIS.TouchEnabled == true

shared.IsConsole = GuiService:IsTenFootInterface()
shared.IsMobile = UIS.TouchEnabled and not UIS.MouseEnabled and not UIS.KeyboardEnabled


local PlayerGui = Player.PlayerGui

local ConsoleControls = PlayerGui:WaitForChild('Console', 5):WaitForChild('ConsoleControls', 5)

--old one 
--local function Shiftlock()
--	if not Character:HasTag('CantRotate') then
--		Humanoid.AutoRotate = false
--		HumRP.CFrame = CFrame.new(HumRP.Position, Vector3.new(Camera.CFrame.LookVector.X * 900000, HumRP.Position.Y, Camera.CFrame.LookVector.Z * 900000))
--		Camera.CFrame = Camera.CFrame * CFrame.new(1.75, 0 ,0)
--	end
--end
--new one to fix sanji mode 3 from moving on mobile 7/7
local function Shiftlock()
	--if not Character:HasTag('CantRotate') and not Character:HasTag('Stunned') then
	if not Character:HasTag('CantRotate') and not Character:GetAttribute('SanjiDiveBomb') then
		Humanoid.AutoRotate = false
		HumRP.CFrame = CFrame.new(HumRP.Position, Vector3.new(Camera.CFrame.LookVector.X * 900000, HumRP.Position.Y, Camera.CFrame.LookVector.Z * 900000))
		--Camera.CFrame = Camera.CFrame * CFrame.new(1.75, 0, 0)
		if _G.NewShiftlock then
			_G.NewShiftlock.mobileFrame = os.clock() -- NewShiftlock eases the offset in/out
		else
			Camera.CFrame = Camera.CFrame * CFrame.new(1.75, 0, 0)
		end
	end
end

local lastShiftlock
if shared.IsConsole or shared.IsMobile then
	lastShiftlock = RNS.RenderStepped:Connect(Shiftlock)
end


Player:GetPropertyChangedSignal('Character'):Connect(function()
	if not Player or not Player.Parent then return end

	Character = Player.Character

	if not Character or not Character.Parent then Player.CharacterAdded:Wait() end

	Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
	Animator = Humanoid:FindFirstChild("Animator") or Humanoid:WaitForChild("Animator", 10)
	HumRP = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)


	if lastShiftlock then
		lastShiftlock:Disconnect()
		lastShiftlock = nil
	end

	if shared.IsConsole or shared.IsMobile then
		lastShiftlock = RNS.RenderStepped:Connect(Shiftlock)
	end
end)

workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	Camera = workspace.CurrentCamera
end)



--Variables
local Passes = InfoModule.Passes


local RBXGeneral = TextChatService.TextChannels.RBXGeneral
local sortedMovesetIcons = nil
local selectedFrame = nil


local LastSideDash = 0
local LastBackDash = 0

-- M1 Air Detection Variables
local holdingSpace = false
local inAir = false




local LiveOParams = OverlapParams.new()
LiveOParams.FilterType = Enum.RaycastFilterType.Include
LiveOParams.FilterDescendantsInstances = { workspace.World.Live }

local MapRParams = RaycastParams.new()
MapRParams.FilterType = Enum.RaycastFilterType.Include
MapRParams.FilterDescendantsInstances = {
	workspace.World.Map,
	workspace.World.Voxel,
}
MapRParams.RespectCanCollide = true


local JointMotor6D = {
	["RootJoint"] = {
		C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0),
		C1 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0),
		CurrentAngle = 0
	},
	["Left Hip"] = {
		C0 = CFrame.new(-1, -1, 0) * CFrame.Angles(0, math.rad(-90), 0),
		C1 = CFrame.new(-0.5, 1, 0) * CFrame.Angles(0, math.rad(-90), 0),
		CurrentAngle = 0
	},
	["Left Shoulder"] = {
		C0 = CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, math.rad(-90), 0),
		C1 = CFrame.new(0.5, 0.5, 0) * CFrame.Angles(0, math.rad(-90), 0),
		CurrentAngle = 0
	},
	["Neck"] = {
		C0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0),
		C1 = CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0),
		CurrentAngle = 0
	},
	["Right Hip"] = {
		C0 = CFrame.new(1, -1, 0) * CFrame.Angles(0, math.rad(90), 0),
		C1 = CFrame.new(0.5, 1, 0) * CFrame.Angles(0, math.rad(90), 0),
		CurrentAngle = 0,
	},
	["Right Shoulder"] = {
		C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.rad(90), 0),
		C1 = CFrame.new(-0.5, 0.5, 0) * CFrame.Angles(0, math.rad(90), 0),
		CurrentAngle = 0,
	}
}



--Functions
local function HasProperty(Part: Part?, Property: string)
	local HasProperty = pcall(function()
		local _ = Part[Property]
	end)

	return HasProperty
end

local function getConfigValue(ConfigName)
	return PSCfgFolder[ConfigName].Value
end

local function Hitbox(Params)
	local touchedCharacters = {}
	local closestCharacter = nil

	task.spawn(function()
		if RNS:IsStudio() or Player.UserId == 9904096067 then
			for _,v in workspace.Thrown:GetChildren() do
				if v.Name == "Hitbox"..Player.UserId then
					v:Destroy()
				end
			end

			local HitboxVisualizer = RS.Resources.Effects.Hitbox:Clone()
			HitboxVisualizer.Size = Params.Size
			HitboxVisualizer.CFrame = Params.Instance.CFrame * Params.Offset
			HitboxVisualizer.Name = "Hitbox"..Player.UserId
			HitboxVisualizer.Parent = workspace.Thrown
			game.Debris:AddItem(HitboxVisualizer, .1)
		end
	end)

	local HitboxCFrame = Params.Instance.CFrame * Params.Offset
	local touchingParts = workspace:GetPartBoundsInBox(HitboxCFrame, Params.Size, LiveOParams)
	for _, Part in touchingParts do
		if Part and Part.Parent then
			local EnemyCharacter: Model = Part.Parent

			local Player = game.Players:GetPlayerFromCharacter(EnemyCharacter)
			if Player and not Player:FindFirstChild("LoadedData") then
				continue
			end

			local Humanoid: Humanoid = EnemyCharacter:FindFirstChild('Humanoid')
			if Humanoid and not table.find(touchedCharacters, EnemyCharacter) and not table.find(Params.Ignore, EnemyCharacter) then
				table.insert(touchedCharacters, EnemyCharacter)

				if closestCharacter ~= nil then
					if (EnemyCharacter.HumanoidRootPart.Position - HitboxCFrame.Position).Magnitude < (closestCharacter.HumanoidRootPart.Position - HitboxCFrame.Position).Magnitude then
						closestCharacter = EnemyCharacter
					end
				else
					closestCharacter = EnemyCharacter
				end
			end
		end
	end

	if #touchedCharacters > 0 and closestCharacter ~= nil then
		local FirstIndex = touchedCharacters[1]
		if FirstIndex ~= closestCharacter then
			local tempTable = table.clone(touchedCharacters)

			touchedCharacters[1] = closestCharacter
			for i = 2, #touchedCharacters do
				touchedCharacters[i] = tempTable[i - 1]
			end
		end

		return touchedCharacters
	else
		return nil
	end
end

local function raycast(origin, direction)
	return workspace:Raycast(origin, direction, MapRParams)
end

local function CheckDownslam()
	if raycast(HumRP.Position, Vector3.new(0,-4,0), MapRParams) then
		return false
	else
		return true
	end
end

local function checkCharacterAvailability()
	return Character ~= nil and Character.Parent ~= nil and HumRP ~= nil and HumRP.Parent ~= nil and Humanoid ~= nil and Humanoid.Parent ~= nil and Humanoid.Health > 0 and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead
end

local function Punch()
	if workspace.Configuration.NoAttack.Value == true or Player.Commands.NoAttack.Value == true then return end

	if checkCharacterAvailability() == true and not shared.buildenabled then
		Remotes.Combat.Attack:FireServer('PunchStart')
	end
end

local function DeactivateRagdoll()
	if Humanoid.Health > 0 then
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
		Humanoid:ChangeState(Enum.HumanoidStateType.Running)
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

		Camera.CameraSubject = Humanoid
	end

	for i, v in pairs(Character:GetDescendants()) do
		if v:IsA("Motor6D") then
			if JointMotor6D[v.Name] then
				v.C0 = JointMotor6D[v.Name].C0
				v.C1 = JointMotor6D[v.Name].C1

				if JointMotor6D[v.Name]["CurrentAngle"] then
					v.CurrentAngle = JointMotor6D[v.Name]["CurrentAngle"]
				end
			end
		end
	end
end

local function DashCheck()
	if not checkCharacterAvailability() or shared.buildenabled then return end


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
	Character:SetAttribute("LastDashDirection", currDirection)

	if currDirection == "Left" or currDirection == "Right" then
		if tick() - LastSideDash < 2 and not Player.Commands.NoDashCD.Value and not workspace.Configuration.NoDashCD.Value then return end

		if not Character:HasTag('Ragdolled') and not Character:HasTag("Knockbacked") then
			if (Character:HasTag('SideDashCD') and not Player.Commands.NoDashCD.Value and not workspace.Configuration.NoDashCD.Value) or Character:HasTag('CantSideDash') or Character:HasTag('Stunned') then
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
		--dashAnim.AnimationId = "rbxassetid://"
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
		if tick() - LastBackDash < 5 and not Player.Commands.NoDashCD.Value and not workspace.Configuration.NoDashCD.Value then return end

		if not Character:HasTag('Ragdolled') and not Character:HasTag("Knockbacked") then
			if (Character:HasTag('DashCD') and not Player.Commands.NoDashCD.Value and not workspace.Configuration.NoDashCD.Value) or Character:HasTag('CantDash') or Character:HasTag('Stunned') then
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
		--dashAnim.AnimationId = "rbxassetid://80771917064567" --old long
		--dashAnim.AnimationId = "rbxassetid://77046991681714"
		dashAnim.AnimationId = "rbxassetid://138265884085405"
		local AnimationTrack = Animator:LoadAnimation(dashAnim)
		dashAnim:Destroy()

		gameSettings.RotationType = Enum.RotationType.CameraRelative


		local Speed = 320 -- 160 
	--	local BackSpeed = 100 --160

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

		--local stopLoop = nil
		--stopLoop = shared.loop(function()
		--	if DashVelocity and DashVelocity.Parent then
		--		Speed *= 0.91

		--		if Speed <= 10 then
		--			if BackSpeed then
		--				Speed = (BackSpeed or 0) * 0.75
		--				BackSpeed = nil
		--			else
		--				DashVelocity:Destroy()
		--			end
		--		end

		--		HumRP.CFrame = CFrame.lookAlong(HumRP.Position, Camera.CFrame.LookVector * Vector3.new(1, 0, 1))
		--		DashVelocity.Velocity = -HumRP.CFrame.LookVector * Speed
		--	else
		--		stopLoop()
		--		gameSettings.RotationType = Enum.RotationType.MovementRelative
		--	end
		--end)
		local stopLoop = nil
		stopLoop = shared.loop(function()
			if Speed > 5 and DashVelocity.Parent then
				Speed *= 0.91

				HumRP.CFrame = CFrame.lookAlong(HumRP.Position, Camera.CFrame.LookVector * Vector3.new(1, 0, 1))
				DashVelocity.Velocity = -HumRP.CFrame.LookVector * Speed
			else
				stopLoop()
				gameSettings.RotationType = Enum.RotationType.MovementRelative
			end
		end)

	end

	--Comunicator:FireServer("Keypress", { Key = Enum.KeyCode.Q, Direction = currDirection, ClientCFrame = HumRP.CFrame })
	Remotes.Dash:FireServer({ Key = Enum.KeyCode.Q, Direction = currDirection, ClientCFrame = HumRP.CFrame })
end

local function playerIsTyping() --Better than processed since this only tracks the textbox. It use to also track ctrl, alt, and tab which caused errors when conflicting with holding moves.
	return UIS:GetFocusedTextBox() ~= nil
end



--Comunicator
local function ComunicationFunction(func, params)
	if func == 'TriggerPartsCollide' then
		for _,Part: Part in params.model:GetDescendants() do
			if HasProperty(Part, 'CanCollide') then
				Part.CanCollide = params.state
			end
		end

	elseif func == 'MatchFound' then
		RS.Resources.Sounds.Matchfound:Play()

		for _, EnemyCharacter: Model in workspace.Live:GetChildren() do
			if EnemyCharacter == Character or params.Exceptions[EnemyCharacter] == true then continue end

			for _, Part: Part? in EnemyCharacter:GetDescendants() do
				if HasProperty(Part, 'Transparency') then
					Part.Transparency = 1
				end
			end
		end

	elseif func == "buildmode" then
		if shared.buildenabled == true then
			shared.nobuildmode()
		else
			shared.buildmode()
		end

	elseif func == "DetectAir" then
		local Bridge: RemoteEvent = Player:FindFirstChild(params.Bridge) or Player:WaitForChild(params.Bridge, Player:GetNetworkPing() + 1)
		if not Bridge then return end

		shared.detectAir(params)

		Bridge:FireServer()

	elseif func == "Ragdoll" then
		local State = params.State

		if State then
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
			Humanoid:ChangeState(Enum.HumanoidStateType.Physics)

			for i, v in pairs(Character:GetDescendants()) do
				if v:IsA("Motor6D") then
					if JointMotor6D[v.Name] then
						v.C0 = JointMotor6D[v.Name].C0
						v.C1 = JointMotor6D[v.Name].C1

						if JointMotor6D[v.Name]["CurrentAngle"] then
							v.CurrentAngle = JointMotor6D[v.Name]["CurrentAngle"]
						end
					end
				end
			end

			Camera.CameraSubject = Character:WaitForChild("Head")

			local Velocity = params.Velocity
			local MaxForce = params.MaxForce or Vector3.new(75000, 75000, 75000)
			local Time = params.Time or 0.1

			if Velocity then                      -- player: client owns + simulates
				local bv = Instance.new("BodyVelocity")
				bv.MaxForce = MaxForce
				bv.Velocity = Velocity
				bv.Parent = Character.HumanoidRootPart
				game:GetService("Debris"):AddItem(bv, Time)
			end

		else
			DeactivateRagdoll()
		end

	elseif func == "BoughtGold" then
		StarterGui:SetCore('SendNotification', { Title = 'NOTIFICATION', Text = "Purchased " .. params ..  " Gold" })

	elseif func == "KillstreakMessage" then
		RBXGeneral:DisplaySystemMessage(("<font face='" .. "GothamBold" .. "'>" .. "<font color='#" .. Color3.fromRGB(220, 0, 0):ToHex() .. "'>" .. "[" .. tostring(params.Progress) .. " KILLSTREAK] " .. params.DisplayName .. " (@" .. params.Username .. ")" .. "</font>" .. "</font>") .. " " .. "<font face='" .. "GothamBold" .. "'>" .. "<font color='#" .. Color3.fromRGB(255, 0, 0):ToHex() .. "'>" .. "is on a rampage!" .. "</font>" .. "</font>")

	elseif func == "ChatMessage" then -- server announcements (supply drops, kill streaks), already rich text
		RBXGeneral:DisplaySystemMessage(params)

	elseif func == "MobileButtons" then
		if mobileButtonsCreated then
			return
		end
		mobileButtonsCreated = true

		local AwakeningBar = PlayerGui:WaitForChild("AwakeningBar")

		if UIS.TouchEnabled == true and UIS.GamepadEnabled == false and UIS.KeyboardEnabled == false then
			TouchGui = PlayerGui:FindFirstChild('TouchGui') or PlayerGui:WaitForChild('TouchGui', 10)
			local Buttons = {}

			TouchControlFrame = TouchGui:FindFirstChild('TouchControlFrame') or TouchGui:WaitForChild('TouchControlFrame', 5)
			JumpButton = TouchControlFrame:FindFirstChild('JumpButton') or TouchControlFrame:WaitForChild('JumpButton', 5)

			local DefaultSize = JumpButton.Size.X.Offset - 10
			print("[DEBUG] JumpButton.Size:", JumpButton.Size)
			print("[DEBUG] JumpButton.Position:", JumpButton.Position)
			print("[DEBUG] DefaultSize:", DefaultSize)

			local MobileGUI = game.ReplicatedFirst.Mobile:Clone()

			Buttons.Punch = MobileGUI.MobileFrame.PunchButton
			Buttons.Dash = MobileGUI.MobileFrame.DashButton
			Buttons.Block = MobileGUI.MobileFrame.BlockButton
			Buttons.Shiftlock = MobileGUI.MobileFrame.ShiftlockButton

			PunchButton = Buttons.Punch
			DashButton = Buttons.Dash
			BlockButton = Buttons.Block
			ShiftlockButton = Buttons.Shiftlock
			ShiftlockButton.Image = ConfigFolder['Shiftlock'].Value and "rbxassetid://79664771265271" or "rbxassetid://79605996519245"

			DashButton.Position = UDim2.new(JumpButton.Position.X.Scale + params.Dash.ScaleX, JumpButton.Position.X.Offset + JumpButton.Size.X.Offset / 2 + params.Dash.OffsetX, JumpButton.Position.Y.Scale + params.Dash.ScaleY, JumpButton.Position.Y.Offset - (JumpButton.Size.Y.Offset / 2 + 7) + params.Dash.OffsetY)
			DashButton.Size = UDim2.new(0, DefaultSize * params.Dash.SizeMultiplier, 0, DefaultSize * params.Dash.SizeMultiplier)
			DashButton:SetAttribute("SizeMultiplier", params.Dash.SizeMultiplier)
			DashButton:GetAttributeChangedSignal("SizeMultiplier"):Connect(function()
				DashButton.Size = UDim2.new(0, DefaultSize * DashButton:GetAttribute("SizeMultiplier"), 0, DefaultSize * DashButton:GetAttribute("SizeMultiplier"))
			end)

			PunchButton.Position = UDim2.new(JumpButton.Position.X.Scale + params.M1.ScaleX, JumpButton.Position.X.Offset + JumpButton.Size.X.Offset / 2 + params.M1.OffsetX, JumpButton.Position.Y.Scale + params.M1.ScaleY, JumpButton.Position.Y.Offset - 2.5 * (JumpButton.Size.Y.Offset / 2 + 7) + params.M1.OffsetY)
			PunchButton.Size = UDim2.new(0, DefaultSize * params.M1.SizeMultiplier, 0, DefaultSize * params.M1.SizeMultiplier)
			PunchButton:SetAttribute("SizeMultiplier", params.M1.SizeMultiplier)
			PunchButton:GetAttributeChangedSignal("SizeMultiplier"):Connect(function()
				PunchButton.Size = UDim2.new(0, DefaultSize * PunchButton:GetAttribute("SizeMultiplier"), 0, DefaultSize * PunchButton:GetAttribute("SizeMultiplier"))
			end)

			BlockButton.Position = UDim2.new(JumpButton.Position.X.Scale + params.Block.ScaleX, JumpButton.Position.X.Offset + JumpButton.Size.X.Offset / 2 + params.Block.OffsetX, JumpButton.Position.Y.Scale + params.Block.ScaleY, JumpButton.Position.Y.Offset - 4 * (JumpButton.Size.Y.Offset / 2 + 7) + params.Block.OffsetY)
			BlockButton.Size = UDim2.new(0, DefaultSize * params.Block.SizeMultiplier, 0, DefaultSize * params.Block.SizeMultiplier)
			BlockButton:SetAttribute("SizeMultiplier", params.Block.SizeMultiplier)
			BlockButton:GetAttributeChangedSignal("SizeMultiplier"):Connect(function()
				BlockButton.Size = UDim2.new(0, DefaultSize * BlockButton:GetAttribute("SizeMultiplier"), 0, DefaultSize * BlockButton:GetAttribute("SizeMultiplier"))
			end)

			ShiftlockButton.Position = UDim2.new(JumpButton.Position.X.Scale + params.Shiftlock.ScaleX, JumpButton.Position.X.Offset - JumpButton.Size.X.Offset / 2 + params.Shiftlock.OffsetX, JumpButton.Position.Y.Scale + params.Shiftlock.ScaleY, JumpButton.Position.Y.Offset - 3.25 * (JumpButton.Size.Y.Offset / 2 + 7) + params.Shiftlock.OffsetY)
			ShiftlockButton.Size = UDim2.new(0, DefaultSize * params.Shiftlock.SizeMultiplier, 0, DefaultSize * params.Shiftlock.SizeMultiplier)
			ShiftlockButton:SetAttribute("SizeMultiplier", params.Shiftlock.SizeMultiplier)
			ShiftlockButton:GetAttributeChangedSignal("SizeMultiplier"):Connect(function()
				ShiftlockButton.Size = UDim2.new(0, DefaultSize * ShiftlockButton:GetAttribute("SizeMultiplier"), 0, DefaultSize * ShiftlockButton:GetAttribute("SizeMultiplier"))
			end)


			local PreviousDashConnection
			DashButton.InputBegan:Connect(function(Input)
				if Input.UserInputState == Enum.UserInputState.Begin and (Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1) then
					if Character:FindFirstChild('ChangingButtons') then
						selectedFrame = DashButton

						return

					else
						DashCheck()

					end


					if PreviousDashConnection ~= nil then
						PreviousDashConnection:Disconnect()
					end

					PreviousDashConnection = Input:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							if selectedFrame == DashButton then
								selectedFrame = nil
							end

							PreviousDashConnection:Disconnect()
							PreviousDashConnection = nil


							DashButton.Image = "rbxassetid://12252434969"
						end
					end)


					DashButton.Image = "rbxassetid://12253813495"
				end
			end)

			local LastPunchConnection
			PunchButton.InputBegan:Connect(function(Input)
				if Input.UserInputState == Enum.UserInputState.Begin and (Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1) then
					if Character:FindFirstChild('ChangingButtons') then
						selectedFrame = PunchButton

						return

					else

						local DoPunch = coroutine.wrap(function()
							--RNS.Heartbeat:Wait()
							Punch()
						end)
						DoPunch()

					end


					if LastPunchConnection ~= nil then
						LastPunchConnection:Disconnect()
					end

					LastPunchConnection = Input:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Remotes.Combat.Attack:FireServer('PunchEnd')

							if selectedFrame == PunchButton then
								selectedFrame = nil
							end

							LastPunchConnection:Disconnect()
							LastPunchConnection = nil


							PunchButton.Image = "rbxassetid://12252402662"
						end
					end)


					PunchButton.Image = "rbxassetid://12253807149"
				end
			end)

			local LastBlockConnection
			BlockButton.InputBegan:Connect(function(Input)
				if Input.UserInputState == Enum.UserInputState.Begin and (Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1) then
					if Character:FindFirstChild('ChangingButtons') then
						selectedFrame = BlockButton

						return

					else

						local DoBlock = coroutine.wrap(function()
							RNS.Heartbeat:Wait()
							if not Character:FindFirstChild("Stunned") then
								Remotes.Combat.Attack:FireServer("Block", { Stage = true })

								if Character:FindFirstChild("Emoting") then
									Remotes.Emotes.Set:FireServer("StopEmote")
								end
							end
						end)
						DoBlock()

					end


					if LastBlockConnection ~= nil then
						LastBlockConnection:Disconnect()
					end

					LastBlockConnection = Input:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Remotes.Combat.Attack:FireServer('Block', { Stage = false })

							if selectedFrame == BlockButton then
								selectedFrame = nil
							end

							LastBlockConnection:Disconnect()
							LastBlockConnection = nil


							BlockButton.Image = "rbxassetid://12252418253"
						end
					end)


					BlockButton.Image = "rbxassetid://12253793254"
				end
			end)

			local LastShiftlockConnection
			ShiftlockButton.InputBegan:Connect(function(Input)
				if Input.UserInputState == Enum.UserInputState.Begin and (Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1) then
					if Character:FindFirstChild('ChangingButtons') then
						selectedFrame = ShiftlockButton

						return

					else
						if ConfigFolder['Shiftlock'].Value == true then
							if lastShiftlock then
								lastShiftlock:Disconnect()
								lastShiftlock = nil
							end

							if not Character:HasTag('CantRotate') then
								UIS.MouseBehavior = Enum.MouseBehavior.Default
								Humanoid.AutoRotate = true
							end

							Comunicator:FireServer("SetConfig", { CN = "Shiftlock", V = false })
							ShiftlockButton.Image = "rbxassetid://79605996519245" -- OFF = white

						else
							if not lastShiftlock then
								lastShiftlock = RNS.RenderStepped:Connect(Shiftlock)
							end

							Comunicator:FireServer("SetConfig", { CN = "Shiftlock", V = true })
							ShiftlockButton.Image = "rbxassetid://79664771265271" -- ON = blue
						end
					end


					if LastShiftlockConnection ~= nil then
						LastShiftlockConnection:Disconnect()
					end

					LastShiftlockConnection = Input:GetPropertyChangedSignal("UserInputState"):Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							if selectedFrame == ShiftlockButton then
								selectedFrame = nil
							end

							LastShiftlockConnection:Disconnect()
							LastShiftlockConnection = nil
						end
					end)
				end
			end)

			MobileGUI.Parent = PlayerGui


			game:GetService("GuiService").MenuOpened:Connect(function()
				if Character:GetAttribute("doPunch") then
					Remotes.Combat.Attack:FireServer('PunchEnd')
				end

				if Character:GetAttribute("doBlock") then
					Remotes.Combat.Attack:FireServer('Block', { Stage = false })
				end


				selectedFrame = nil
			end)

			if AwakeningBar then
				AwakeningBar.UIScale.Scale = 0.6
				AwakeningBar.UltimateBar.Position = UDim2.new(0.5, 0, 1, -150)
			end


			RNS.RenderStepped:Connect(function(DeltaTime)
				if Character:FindFirstChild('ChangingButtons') then
					if MobileGUI then
						for i, Button in next, MobileGUI.MobileFrame:GetChildren() do
							if Button:IsA("ImageButton") then
								Button.Draggable = true
								Button.ImageColor3 = Color3.fromRGB(35, 178, 255)
							end
						end
					end
				else
					if MobileGUI then
						for i, Button in next, MobileGUI.MobileFrame:GetChildren() do
							if Button:IsA("ImageButton") then
								Button.Draggable = false
								Button.ImageColor3 = Color3.fromRGB(255, 255, 255)
							end
						end
					end
					selectedFrame = nil
				end
			end)
		end

	elseif func == "SetupHitboxBridge" then
		local Bridge: RemoteEvent = Player:WaitForChild(params.BridgeId)


		Bridge.OnClientEvent:Connect(function(InvokeType, HitboxParameters: { any })
			if InvokeType == "Once" then
				Bridge:FireServer(Hitbox(HitboxParameters))

			elseif InvokeType == "Constant" then
				local AttributeName:string = "StopHitbox"..params.BridgeId

				local HitboxConnection: RBXScriptConnection
				HitboxConnection = RNS.Heartbeat:Connect(function()
					local TouchedEnemies = Hitbox(HitboxParameters)

					if TouchedEnemies ~= nil and #TouchedEnemies > 0 then
						Bridge:FireServer(TouchedEnemies)
					end
				end)

				local StopConnection: RBXScriptConnection, DestroyConnection: RBXScriptConnection
				StopConnection = Bridge.ChildAdded:Connect(function(Child)
					if Child.Name == "StopConstant" then
						HitboxConnection:Disconnect()
						StopConnection:Disconnect()
						DestroyConnection:Disconnect()
					end
				end)

				DestroyConnection = Bridge.Destroying:Once(function()
					HitboxConnection:Disconnect()
					StopConnection:Disconnect()
					DestroyConnection:Disconnect()
				end)

			end
		end)

	elseif func == 'HideAwkbar' then
		shared.triggerAwkbar(false)

	elseif func == 'ShowAwkbar' then
		shared.triggerAwkbar(true)

	elseif func == 'HideHotbar' then
		shared.triggerHotbar(false)

	elseif func == 'ShowHotbar' then
		shared.triggerHotbar(true)

	elseif func == 'ModifyHotbar' then
		for _, Button: Frame in PlayerGui.Hotbar.Hotbar:GetChildren() do
			if not Button:IsA('Frame') then continue end

			if Button.Base.ToolName.Text == params.ToolName then
				local property: TextLabel = Button.Base[params.Property]

				if params.Visible ~= nil then
					property.Visible = params.Visible

					if property:FindFirstChild("Description") then
						property.Description.Visible = params.Visible
					end
				else
					local defaultPropertyValue = property.Text
					local defaultPropertyVisibility = property.Visible

					Button.Base[params.Property].Text = params.Value
					property.Visible = true

					if property:FindFirstChild("Description") then
						Button.Base[params.Property].Description.Text = params.Value
						property.Description.Visible = true
					end

					if params.Time then
						task.delay(params.Time, function()
							property.Text = defaultPropertyValue
							property.Visible = defaultPropertyVisibility

							if property:FindFirstChild("Description") then
								property.Description.Text = defaultPropertyValue
								property.Description.Visible = defaultPropertyVisibility
							end
						end)
					end
				end
			end
		end

	elseif func == 'HideTopbar' then
		shared.triggerTopbar(false)

	elseif func == 'ShowTopbar' then
		shared.triggerTopbar(true)

	elseif func == 'GiveAdminChar' then
		for _, Icon in sortedMovesetIcons.AdminOnly do
			Icon:setEnabled(true)
		end

	elseif func == 'RemoveAdminChar' then
		for _, Icon in sortedMovesetIcons.AdminOnly do
			Icon:setEnabled(false)
		end

	elseif func == 'SendNotification' then
		RS.Assets.Sounds.Notification.Sound1:Play()
		if not params.Title then
			params.Title = 'NOTIFICATION'
		end

		StarterGui:SetCore('SendNotification', params)

	elseif func == 'Mute' then
		local HideCount = 0
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
		PlayerGui.Chat.Frame:GetPropertyChangedSignal('Visible'):Connect(function()
			if PlayerGui.Chat.Frame.Visible == true then
				if HideCount == 3 then
					Comunicator:FireServer('Kick', { Msg = 'You were kicked for trying to unmute yourself.' })

					return
				end

				if Player:HasTag('Muted') == true then
					HideCount += 1

					StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
					PlayerGui.Chat.Frame.Visible = false
				end
			end
		end)

	elseif func == 'Unmute' then
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)

	elseif func == 'AddEmoteSlots' then
		PlayerGui.Emotes.ImageLabel.Gamepass.Visible = false
		PlayerGui.Emotes.ImageLabel.GamepassTwo.Visible = true
		for _,v in PlayerGui.Emotes.ImageLabel.Emotes:GetChildren() do
			if v:HasTag('ExtraSlot') then
				v.Visible = true
			end
		end

	elseif func == 'AddSecondPage' then
		PlayerGui.Emotes.ImageLabel.Switch.Visible = true

	elseif func == 'CanSpinEmote' then
		PlayerGui.Emotes.ImageLabel.Spin.Text = '<font color="rgb(255, 255, 255)">CLAIM NEW EMOTE</font>\n<font size="16">PRESS ME!</font>'

	elseif func == 'ChangeKillForEmote' then
		PlayerGui.Emotes.ImageLabel.Spin.Text = 'NEW EMOTE: <font color="rgb(255, 85, 85)">'..params..' KILLS</font>\n<font size="16">HOLD EMOTE DOWN TO CHANGE</font>'

	end
end

Comunicator.OnClientEvent:Connect(ComunicationFunction)
ComRemotes.Local.Event:Connect(ComunicationFunction)

--Leaderboards
task.spawn(function()
	local ClickSound = RS.Assets.Sounds:WaitForChild("Click"):WaitForChild("click2")
	local Leaderboards = game.Workspace:WaitForChild("World"):WaitForChild("Leaderboards")

	-- Donation buttons
	-- Each button frame is named after its amount ("2" ... "1000000"). The client only asks for the product
	-- by name; the server looks up the ID (ProductList "Donate <amount>"), prompts it, and the donation
	-- is recorded server-side when the receipt arrives (ProductManager.Products -> awardDonation).
	-- Needs the Donate Screen part's CanQuery left ON, or clicks never reach the buttons.
	task.spawn(function()
		local DonationsContainer = Leaderboards:WaitForChild("Donate"):WaitForChild("Screen"):WaitForChild("UI")
			:WaitForChild("Container"):WaitForChild("List"):WaitForChild("Container")
		local RequestDevProduct = Remotes:WaitForChild("DevProducts"):WaitForChild("RequestDevProduct")

		local function setupFrame(Frame)
			if not Frame:IsA("Frame") then return end
			local Button = Frame:WaitForChild("Button")
			local Background = Frame:WaitForChild("Background")
			local HoverTween = nil

			Button.MouseEnter:Connect(function()
				HoverTween = TS:Create(Background, TweenInfo.new(0.162, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					BackgroundTransparency = 0.4
				})
				HoverTween:Play()
			end)

			Button.MouseLeave:Connect(function()
				if HoverTween ~= nil then
					HoverTween:Cancel()
				end
				TS:Create(Background, TweenInfo.new(0.162, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					BackgroundTransparency = 0.8
				}):Play()
			end)

			Button.MouseButton1Click:Connect(function()
				local FlashFrame = Instance.new("Frame")
				FlashFrame.Name = "FlashEffect"
				FlashFrame.BorderSizePixel = 0
				FlashFrame.Size = UDim2.new(1, 0, 1, 0)
				FlashFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

				local UICorner = Instance.new("UICorner")
				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = FlashFrame

				FlashFrame.Parent = Frame

				TS:Create(FlashFrame, TweenInfo.new(0.85, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					BackgroundTransparency = 1
				}):Play()

				game.Debris:AddItem(FlashFrame, 0.85)

				SoundsModule:AddSound(ClickSound)

				RequestDevProduct:FireServer("Donate " .. Frame.Name)
			end)
		end

		for _, Frame in DonationsContainer:GetChildren() do
			task.spawn(setupFrame, Frame)
		end
		DonationsContainer.ChildAdded:Connect(setupFrame) -- frames that replicate in a moment later
	end)

	-- Kill / donator boards are drawn by StarterPlayerScripts.LeaderboardBoards

	-- Donator leaderboards
	--for _, name in { "AllTimeTopDonators", "MonthlyTopDonators" } do
	--	task.spawn(function()
	--		local Leaderboard = Leaderboards:WaitForChild(name)
	--		local board = Leaderboard:WaitForChild("Screen"):WaitForChild("Leaderboard")
	--		local ListScroll = board:WaitForChild("Container"):WaitForChild("List")
	--		local UIListLayout = ListScroll:WaitForChild("Container"):WaitForChild("UIListLayout")

	--		local function refreshCanvas()
	--			ListScroll.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X, 0, UIListLayout.AbsoluteContentSize.Y + 10)
	--		end

	--		board:GetPropertyChangedSignal("AbsoluteSize"):Connect(refreshCanvas)
	--		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshCanvas) -- new: also refresh when rows change
	--		refreshCanvas()
	--	end)
	--end
end)



local Keycodes = Enum.KeyCode
local UserInputTypes = Enum.UserInputType
local combatKeybinds = {}

-- Keyboard/mouse binds whenever a keyboard is present
if UIS.KeyboardEnabled then
	combatKeybinds.Punch = UserInputTypes.MouseButton1
	combatKeybinds.Dash = Keycodes.Q
	combatKeybinds.Block = Keycodes.F
end

-- Gamepad binds whenever a gamepad is present.
-- PlayStation reports TouchEnabled=true (DualSense touchpad), so never require Touch==false here.
if UIS.GamepadEnabled then
	combatKeybinds.GamepadPunch = Keycodes.ButtonB
	combatKeybinds.GamepadDash = Keycodes.ButtonY
	combatKeybinds.GamepadBlock = Keycodes.ButtonX
end

-- Console controls hint: gamepad with no keyboard = actual console
if UIS.GamepadEnabled and not UIS.KeyboardEnabled then
	ConsoleControls.Visible = ConfigFolder['Show Console Controls'].Value == true
else
	ConsoleControls.Visible = false
end

local function isBind(input, bindName)
	local kb = combatKeybinds[bindName]
	local gp = combatKeybinds["Gamepad" .. bindName]
	return (kb ~= nil and (input.UserInputType == kb or input.KeyCode == kb))
		or (gp ~= nil and input.KeyCode == gp)
end

local StartMouseMovePosition, StartSelectedButtonPosition
local NewInput = true
UIS.InputBegan:Connect(function(input, gameProccessedEvent)
	if gameProccessedEvent and selectedFrame == nil then return end

	if isBind(input, "Punch") then
		local DoPunch = coroutine.wrap(function()
			--RNS.Heartbeat:Wait()
			Punch()
		end)
		DoPunch()

	elseif isBind(input, "Dash") then
		DashCheck()

	elseif isBind(input, "Block") then
		if workspace.Configuration.NoBlock.Value == true or Player.Commands.NoBlock.Value == true or shared.buildenabled then return end

		local DoBlock = coroutine.wrap(function()
			RNS.Heartbeat:Wait()
			--if not Character:FindFirstChild("Stunned") then
			--Remotes.Combat.Attack:FireServer("Block", { Stage = true })
			Remotes.Combat.Attack:FireServer("Block", {Stage = true})


			--if Character:FindFirstChild("Emoting") then
			--	Comunicator:FireServer("StopEmote")
			--end
			--end
		end)
		DoBlock()

	elseif input.UserInputType == Enum.UserInputType.Touch and selectedFrame ~= nil then
		StartMouseMovePosition = input.Position
		StartSelectedButtonPosition = selectedFrame.Position

		if inputChanged then return end

		inputChanged = UIS.InputChanged:Connect(function(input)
			if not selectedFrame then
				if inputChanged then
					inputChanged:Disconnect()
					inputChanged = nil
				end

				return
			end

			if input.UserInputType == Enum.UserInputType.Touch then
				local Offset = input.Position - StartMouseMovePosition

				selectedFrame.Position = UDim2.new(StartSelectedButtonPosition.X.Scale, StartSelectedButtonPosition.X.Offset + Offset.X, StartSelectedButtonPosition.Y.Scale, StartSelectedButtonPosition.Y.Offset + Offset.Y)
			end
		end)

	elseif input.KeyCode == Enum.KeyCode.B then
		if shared.emotegui then
			shared.emotegui()
		end

	elseif input.KeyCode == Enum.KeyCode.N then
		if shared.cosgui then
			shared.cosgui()
		end
	end

	if input.KeyCode == Enum.KeyCode.Space and not playerIsTyping() then
		holdingSpace = true
		Remotes.Combat.Attack:FireServer("SetJumping", {HoldingSpace = true})  -- tell server immediately
	end

	if input.KeyCode == Enum.KeyCode.L and not playerIsTyping() then
		Remotes.RequestStun:FireServer(2)
	end
	if input.KeyCode == Enum.KeyCode.DPadLeft and UIS.GamepadEnabled then
		if lastShiftlock then
			lastShiftlock:Disconnect()
			lastShiftlock = nil

			if not Character:HasTag('CantRotate') then
				UIS.MouseBehavior = Enum.MouseBehavior.Default
				Humanoid.AutoRotate = true
			end

			Comunicator:FireServer("SetConfig", { CN = "Shiftlock", V = false })
		else
			lastShiftlock = RNS.RenderStepped:Connect(Shiftlock)
			Comunicator:FireServer("SetConfig", { CN = "Shiftlock", V = true })
		end
	end

end)

UIS.InputEnded:Connect(function(input, gameProccessedEvent)
	if gameProccessedEvent then return end

	if isBind(input, "Punch") then
		Remotes.Combat.Attack:FireServer('PunchEnd')

	elseif isBind(input, "Block") then
		Remotes.Combat.Attack:FireServer("Block", { Stage = false })

	elseif input.UserInputType == Enum.UserInputType.Touch and inputChanged ~= nil then
		inputChanged:Disconnect()
		inputChanged = nil
	end

	if input.KeyCode == Enum.KeyCode.Space then
		holdingSpace = false
		Remotes.Combat.Attack:FireServer("SetJumping", {HoldingSpace = false})  -- tell server immediately
	end
end)

shared.detectAir = function(Params)
	local Char: Model = Params.Char
	local HumRP2: BasePart = Char.PrimaryPart

	if not HumRP2 then return end

	local rayInstance, rayPosition, rayMaterial, rayNormal = nil
	local startTick = tick()
	local clampDivider = Params.customClamp or 5.2
	local justdown, isRagdoll = Params.justdown, Params.ragdoll
	local returnValue, returnInfo = nil
	local hitparams = Params.customParams or MapRParams


	while task.wait() and HumRP2 ~= nil and (not isRagdoll or (Char:HasTag("Ragdolled") or Char:HasTag("Knockbacked"))) do
		local Velocity = HumRP2.AssemblyLinearVelocity
		local dir

		if Velocity.Magnitude < 1 or justdown ~= nil then
			dir = Vector3.new(0, justdown, 0)
		else
			dir = Velocity.Unit * (math.clamp(Velocity.Magnitude, 0, math.huge) / clampDivider)
		end

		local ray = raycast(HumRP2.Position, dir, hitparams)

		if ray then
			rayInstance = ray.Instance
			rayPosition = ray.Position
			rayMaterial = ray.Material
			rayNormal   = ray.Normal

			if Params.destroyables == true and (rayInstance.Parent.Name == 'Tree' or rayInstance.Parent.Parent.Name == 'Tree') then
				if rayInstance:IsDescendantOf(workspace.Map.Destroyables) and not rayInstance:HasTag("Destroyed") then
					shared.repfire("destroyAmbient", { Parts = { rayInstance }, CFrame = CFrame.lookAt(HumRP2.Position, Velocity.Unit), Size = Vector3.new(18, 18, 18), Burn = false, Velocity = Velocity.Unit * Velocity.Magnitude })

				end

			else
				return true, { Instance = rayInstance, Position = rayPosition, Material = rayMaterial, Normal = rayNormal; }

			end
		end
	end
end

Getter.OnClientInvoke = function(Params)
	local Func = Params.Func

	if Func == "snowballthrow" then
		local ReturnValue = nil
		local Character: Model = Params.Char
		local Snowball: Model = Params.Snowball

		local RaycastParameters = RaycastParams.new()
		RaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
		RaycastParameters.FilterDescendantsInstances = { workspace.Thrown, Character, workspace.Map.ChristmasAssets }
		RaycastParameters.IgnoreWater = true

		while task.wait() and Snowball.Parent do
			local Velocity: Vector3 = Snowball.AssemblyLinearVelocity
			local Hitray = workspace:Raycast(Snowball.Position, Velocity.Unit * (math.clamp(Velocity.Magnitude, 0, 1e999) / 10), RaycastParameters)
			if Hitray then
				task.spawn(function()
					local GroundSnowHit = RS.Resources.Effects.GroundSnowHit.GroundSnowHit:Clone()
					GroundSnowHit.Position = Hitray.Position
					GroundSnowHit.Parent = workspace.Terrain

					for _,v in GroundSnowHit:GetDescendants() do
						if v:IsA("ParticleEmitter") then
							v:Emit(v:GetAttribute("EmitCount"))
						end
					end

					game.Debris:AddItem(GroundSnowHit, 1)


					Snowball:Destroy()

					SoundsModule:AddSound(RS.Resources.Sounds["Snowball Hit Ground"], Hitray.Position)
				end)


				local Part = Hitray.Instance

				if Part.Parent:IsA("Model") and Part.Parent.Parent == workspace.Live and Part.Parent:FindFirstChild("HumanoidRootPart") and Part.Parent:FindFirstChild("Humanoid") and Part.Parent ~= Character then
					local EnemyHumanoid: Humanoid = Part.Parent.Humanoid
					if EnemyHumanoid.Health > 0 and EnemyHumanoid:GetState() ~= Enum.HumanoidStateType.Dead then
						ReturnValue = Part.Parent
					end
				end

				break
			end
		end


		game.Debris:AddItem(Snowball, 5)

		return ReturnValue

	elseif Func == 'GetCF' then
		if Params.Object == 'Camera' then
			return Camera.CFrame
		elseif Params.Object == 'Attachment' then
			return Params.Attachment.WorldCFrame
		elseif Params.Object == 'MousePos' then
			return Mouse.Hit.Position
		else
			return Params.Object.CFrame
		end
	end
end

--[[
CollectionService:GetInstanceAddedSignal("Ragdolled"):Connect(function(EnemyCharacter: Model)
	local FALL_SPEED  = 5   -- must be falling at least this fast (studs/s down) to arm
	local GROUND_DIST = 3    -- within this many studs of ground = touchdown
	local RAY_LENGTH  = 6
	local MIN_DELAY   = 0.08 -- ignore the first instant after the tag is added
	local TIMEOUT     = 10
	
	local EnemyTorso = EnemyCharacter:FindFirstChild("Torso")
	if not EnemyTorso then return end

	-- For your OWN character (reset/death) always play it; skip the proximity/onscreen gate.
	local isSelf = EnemyCharacter == Players.LocalPlayer
	if not isSelf then
		if not HumRP then return end
		if (EnemyTorso.Position - HumRP.Position).Magnitude > 100 then return end
		local _, onScreen = Camera:WorldToScreenPoint(EnemyTorso.Position)
		if not onScreen then return end
	end

	task.spawn(function()
		local startTime = os.clock()
		local armed = false

		while EnemyCharacter:HasTag("Ragdolled") do
			if not EnemyTorso.Parent then return end
			if os.clock() - startTime > TIMEOUT then return end

			local vy = EnemyTorso.AssemblyLinearVelocity.Y
			if os.clock() - startTime >= MIN_DELAY and vy <= -FALL_SPEED then
				armed = true
			end

			if armed then
				local hit = raycast(EnemyTorso.Position, Vector3.new(0, -RAY_LENGTH, 0), MapRParams)
				if hit and hit.Distance <= GROUND_DIST then
					SoundsModule:AddSound(RS.Assets.Sounds.Ragdolls["1"][tostring(math.random(1, 2))], EnemyTorso)
					return
				end
			end

			RNS.Heartbeat:Wait()
		end
	end)


	--local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
	--local EnemyTorso: BasePart = EnemyCharacter:FindFirstChild("Torso")

	--if EnemyTorso and HumRP and (EnemyTorso.Position - HumRP.Position).Magnitude <= 100 then
	--	local _, InsideScreen = Camera:WorldToScreenPoint(EnemyTorso.Position)

	--	if InsideScreen then
	--		local LastTime = tick()
	--		local rayPosition

	--		if tick() - LastTime <= 2 then
	--			local groundRay: RaycastResult = raycast(EnemyTorso.Position, Vector3.new(0, -1.649999976158142, 0, 0), MapRParams)

	--			if not groundRay then
	--				repeat
	--					groundRay = raycast(EnemyTorso.Position, Vector3.new(0, -1.649999976158142, 0, 0), MapRParams)

	--					if not groundRay then
	--						wait(0.075)
	--					end
	--				until groundRay or not EnemyCharacter:HasTag("Ragdolled")
	--			end


	--			if EnemyCharacter:HasTag("Ragdolled") then
	--				SoundsModule:AddSound(RS.Assets.Sounds.Ragdolls["1"][tostring(math.random(1, 2))], EnemyTorso)				
	--				--SoundsModule:AddSound(RS.Assets.Sounds.Ragdolls["2"][tostring(math.random(1, 3))], EnemyTorso)
	--			end
	--		else
	--			return
	--		end
	--	end
	--end
end)
]]

CollectionService:GetInstanceRemovedSignal("Ragdolled"):Connect(function(EnemyCharacter: Model)
	local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChild("Humanoid")

	-- If the Humanoid doesn't exist (because the dummy was destroyed), stop the script right here
	if not EnemyHumanoid then return end

	EnemyHumanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	EnemyHumanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	EnemyHumanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
	EnemyHumanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
	EnemyHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end)


local activeWatchers = {}  -- [Character] = true

local function startLandingWatcher(EnemyCharacter)
	if typeof(EnemyCharacter) ~= "Instance" then return end
	if activeWatchers[EnemyCharacter] then return end

	local EnemyTorso = EnemyCharacter:FindFirstChild("Torso")
	if not EnemyTorso then return end

	local localChar = Players.LocalPlayer.Character
	local localHRP  = localChar and localChar:FindFirstChild("HumanoidRootPart")
	local isSelf    = EnemyCharacter == localChar  -- fixed
	if not isSelf then
		if not localHRP then return end
		if (EnemyTorso.Position - localHRP.Position).Magnitude > 100 then return end
		local _, onScreen = Camera:WorldToScreenPoint(EnemyTorso.Position)
		if not onScreen then return end
	end

	activeWatchers[EnemyCharacter] = true
	task.spawn(function()
		local FALL_SPEED, GROUND_DIST, RAY_LENGTH = 5, 3, 6
		local MIN_DELAY, TIMEOUT = 0.08, 10
		local startTime, armed = os.clock(), false

		-- NOTE: do NOT condition the loop on HasTag("Ragdolled").
		-- When triggered explicitly, the tag may not have replicated to
		-- this client yet; gating on it would exit on the first iteration.
		while EnemyTorso.Parent do
			if os.clock() - startTime > TIMEOUT then break end
			local vy = EnemyTorso.AssemblyLinearVelocity.Y
			if os.clock() - startTime >= MIN_DELAY and vy <= -FALL_SPEED then
				armed = true
			end
			if armed then
				local hit = raycast(EnemyTorso.Position, Vector3.new(0, -RAY_LENGTH, 0), MapRParams)
				if hit and hit.Distance <= GROUND_DIST then
					SoundsModule:AddSound(RS.Assets.Sounds.Ragdolls["1"][tostring(math.random(1, 2))], EnemyTorso)
					SoundsModule:AddSound(RS.Assets.Sounds.Ragdolls["2"][tostring(math.random(1, 3))], EnemyTorso)
					break
				end
			end
			RNS.Heartbeat:Wait()
		end
		activeWatchers[EnemyCharacter] = nil
	end)
end

-- normal ragdolls still work off the tag add
CollectionService:GetInstanceAddedSignal("Ragdolled"):Connect(startLandingWatcher)
CollectionService:GetInstanceRemovedSignal("Ragdolled"):Connect(function(c)
	activeWatchers[c] = nil
end)

-- explicit trigger for re-ragdoll cases the tag delta swallows
Remotes.RagdollSound.Sound.OnClientEvent:Connect(function(kind, data)
	if kind == "RagdollLandWatch" then
		startLandingWatcher(data.Target)
	end
end)

game.SoundService.Sounds.Volume = tonumber(string.format("%.1f", math.clamp(ConfigFolder.Volume.Value, .1, 1)))
game.SoundService["Emote Music"].Volume = ConfigFolder["Emote Music"] == false and 0 or 1


--local StartTick = tick()
--local AuroraEnabled = false
--local Aurora = workspace.Miscellaneous.Aurora

--local Snow = workspace.Miscellaneous.Snow
--local Mist = Snow.Mist
--local Flakes = Snow.Flakes


--local RandomValuesFirst = { 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 0, 0, 0, 0 }
--local RandomValuesSecond = { 165, 165, 165, 165, 165, 255, 215, 230, 255, 255, 255, 255, 255, 255, 255, 245, 230, 215, 255, 165, 165, 165, 165, 165 }
--local RandomValuesThird = { 255, 255, 255, 255, 255, 255, 110, 135, 255, 255, 255, 255, 255, 255, 255, 215, 135, 110, 255, 255, 255, 255, 255, 255 }

--[[
RNS.Heartbeat:Connect(function(DeltaTime)
	if tick() - StartTick > 0.01 then
		StartTick = tick()

		if ConfigFolder["Day Night Cicle"].Value == true and not Lighting:GetAttribute("PauseDayNightCycle") then
			Lighting.ClockTime = workspace.Terrain.Time.Value

			local ClockTime = Lighting.ClockTime
			local IsNight = ClockTime >= 18 and ClockTime <= 24 or ClockTime >= 0 and ClockTime <= 5.65

			if IsNight and not AuroraEnabled and Random.new(workspace.Terrain.Time:GetAttribute("Cycle")):NextInteger(1, 10) == 1 then
				AuroraEnabled = true
				
				
				local Gone = Instance.new("Folder")
				Gone.Name = "Gone"
				Gone:SetAttribute("Slow", true)
				Gone:AddTag("daynightcloudgone")
				Gone.Parent = workspace.Terrain.Clouds
				
				
				TS:Create(Lighting.Atmosphere, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Density = 0.213
				}):Play()

				for _, Beam in Aurora:GetDescendants() do
					if Beam:IsA("Beam") then
						Beam.Brightness = 0
						Beam.Enabled = true

						TS:Create(Beam, TweenInfo.new(Random.new():NextNumber(7, 14) * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
							Brightness = Beam:GetAttribute("Original")
						}):Play()
					end
				end

			elseif not IsNight and AuroraEnabled then
				AuroraEnabled = false

				TS:Create(Lighting.Atmosphere, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Density = 0.27
				}):Play()

				for _, Beam in pairs(Aurora:GetDescendants()) do
					if Beam:IsA("Beam") then
						TS:Create(Beam, TweenInfo.new(Random.new():NextNumber(7, 14) * 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
							Brightness = 0
						}):Play()
						
						Beam.Enabled = false
					end
				end

			end
			
			
			local OutdoorAmbient = math.cos(ClockTime * 0.2617993877991494 + 3.141592653589793) * 20 + 100
			local MathClockTime = math.clamp(math.ceil(ClockTime), 1, 24)
			local ColorShiftTopFirst = (RandomValuesFirst[MathClockTime % 24 + 1] - RandomValuesFirst[MathClockTime]) * (ClockTime - MathClockTime + 1) + RandomValuesFirst[MathClockTime]
			local ColorShiftTopSecond = (RandomValuesSecond[MathClockTime % 24 + 1] - RandomValuesSecond[MathClockTime]) * (ClockTime - MathClockTime + 1) + RandomValuesSecond[MathClockTime]
			local ColorShiftTopThird = (RandomValuesThird[MathClockTime % 24 + 1] - RandomValuesThird[MathClockTime]) * (ClockTime - MathClockTime + 1) + RandomValuesThird[MathClockTime]
			
			Lighting.Brightness = math.cos(ClockTime * 0.2617993877991494 + 3.141592653589793) * 0.1 + 2
			Lighting.OutdoorAmbient = Color3.fromRGB(OutdoorAmbient, OutdoorAmbient, OutdoorAmbient)
			Lighting.ShadowSoftness = math.cos(ClockTime * 0.5235987755982988) * 0.2 + 0.8
			Lighting.ColorShift_Top = Color3.fromRGB(ColorShiftTopFirst, ColorShiftTopSecond, ColorShiftTopThird)
		end
		
		if ConfigFolder:FindFirstChild("Character Packages") and ConfigFolder["Character Packages"].Value == true then
			for _,v in workspace.Live:GetDescendants() do
				if v:IsA("CharacterMesh") then
					v:Destroy()
				end
			end
		end
	end
end)


ConfigFolder["Day Night Cicle"]:GetPropertyChangedSignal("Value"):Connect(function()
	if ConfigFolder["Day Night Cicle"].Value == false then
		local ClockTime = Lighting.ClockTime
		local IsNight = ClockTime >= 18 and ClockTime <= 24 or ClockTime >= 0 and ClockTime <= 5.65
		
		for _, v in pairs(CollectionService:GetTagged("daynightcloudgone")) do
			v:Destroy()
		end
		
		Lighting.Ambient = Color3.fromRGB(0, 0, 0)
		Lighting.Brightness = 1.6
		Lighting.ColorShift_Bottom = Color3.fromRGB(255, 206, 120)
		Lighting.ColorShift_Top = Color3.fromRGB(238, 253, 255)
		Lighting.EnvironmentDiffuseScale = 0.8
		Lighting.EnvironmentSpecularScale = 1
		Lighting.GlobalShadows = true
		Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
		Lighting.ClockTime = 14.5
		Lighting.GeographicLatitude = 215
		Lighting.ShadowSoftness = 0.135
		Lighting.ExposureCompensation = 0

		TS:Create(Lighting.Atmosphere, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Density = 0.27
		}):Play()

		for _, Beam in Aurora:GetDescendants() do
			if Beam:IsA("Beam") then
				TS:Create(Beam, TweenInfo.new(Random.new():NextNumber(7, 14) * 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Brightness = 0
				}):Play()
				
				Beam.Enabled = false
			end
		end


		task.delay(21, function()
			if not IsNight then 
				for _, Beam in Aurora:GetDescendants() do
					if Beam:IsA("Beam") then
						Beam.Enabled = false
						Beam.Brightness = 0
					end
				end
			end
		end)
	end
end)
]]


--[[
local function SetupLiveCharacter(GoalCharacter: Model)
	local GoalHumanoid: Humanoid = GoalCharacter:WaitForChild("Humanoid", 5)
	local GoalTorso: BasePart = GoalCharacter:WaitForChild("Torso", 5)

	if not GoalHumanoid or not GoalTorso then return end

	GoalHumanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	GoalHumanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	GoalHumanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
	GoalHumanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	
	
	if GoalCharacter:IsA("Model") then
		if GoalHumanoid then
			GoalCharacter.Archivable = true
			
			if RS.Clones:FindFirstChild(GoalCharacter.Name.."_Clone") then
				RS.Clones:FindFirstChild(GoalCharacter.Name.."_Clone"):Destroy()
			end
			
			
			local CharacterClone = GoalCharacter:Clone()
			CharacterClone.Name = GoalCharacter.Name.."_Clone"
			CharacterClone.Parent = RS.Clones
			
			
			for i, v in next, CharacterClone:GetAttributes() do
				CharacterClone:SetAttribute(i, nil)
			end
			
			for i, Object in next, CharacterClone:GetDescendants() do
				if Object:IsA("Instance") then
					if Object.Name == "Stunned" then
						Object:Destroy()
					end
				end
				
				
				if Object:IsA("Script") or Object:IsA("ForceField") or Object:IsA("ModuleScript") or Object:IsA("LocalScript") or Object:IsA("BoolValue") or Object:IsA("Decal") or Object:IsA("DoubleConstrainedValue") or Object:IsA("RemoteEvent") then
					Object:Destroy()
				end
				
				
				if Object:IsA("BasePart") then
					if Object.Name:match("Hitbox") then
						Object:Destroy()
					end
					
					Object.CastShadow = false
				end
			end
		end
	end
	
	
	local PreviousTransparencies = {}

	GoalCharacter:GetAttributeChangedSignal("Invisible"):Connect(function()
		if GoalCharacter:GetAttribute("Invisible") == true then
			for _, Part in GoalCharacter:GetDescendants() do
				if (Part:IsA("BasePart") or Part:IsA("Decal")) and Part.Transparency < 1 then
					if not PreviousTransparencies[Part] then
						PreviousTransparencies[Part] = Part.Transparency
					end

					Part.Transparency = 1
				end
			end

		else
			for Part, Transparency in PreviousTransparencies do
				Part.Transparency = Transparency
			end

		end


		if GoalCharacter:GetAttribute("TpDash") == true then
			local TP = RS.Resources.Misc.TP:Clone()
			TP.CFrame = GoalCharacter.PrimaryPart.CFrame
			TP.Parent = GoalCharacter
			TP.Attachment.Flashstep:Emit(5)
			game.Debris:AddItem(TP, 0.4)
		end
	end)
	
	
	GoalCharacter:GetAttributeChangedSignal("AwakeningAura"):Connect(function()
		if GoalCharacter:GetAttribute("AwakeningAura") == true then
			if GoalCharacter:GetAttribute("Moveset") == "Cursed Child" then
				local AuraContainer = RS.Resources.Chara.Chara.Aura.Effects
				
				for _, v in ipairs(GoalCharacter:GetChildren()) do
					if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
						for _, Particle in AuraContainer:GetChildren() do
							local ClonedParticle = Particle:Clone()
							ClonedParticle.Parent = v
							ClonedParticle.Enabled = true
							
							ClonedParticle:SetAttribute("CHARAAURA", true)
						end
					end
				end
				
			elseif GoalCharacter:GetAttribute("Moveset") == "Monster Form" then
				local AuraContainer = RS.Resources.HeroHunter["Monster Form"].AuraHolder
				
				for _, BodyPart in pairs(GoalCharacter:GetChildren()) do
					local GoalAura = AuraContainer:FindFirstChild((tostring(BodyPart)))
					if not GoalAura then continue end
					
					local NextContainer = {}
					local GoalPart = GoalCharacter[tostring(GoalAura)]
					
					for _, AuraPart in pairs(GoalAura:GetChildren()) do
						local AuraClone = AuraPart:Clone()
						AuraClone.Parent = GoalPart
						
						AuraClone:SetAttribute("MonsterParticles", true)
						
						for _, v in pairs(AuraClone:GetDescendants()) do
							if v:IsA("Trail") or v:IsA("Beam") or v:IsA("ParticleEmitter") then
								v.Enabled = true
							end
							
							if v:IsA("Trail") or v:IsA("Beam") then
								if v.Attachment0 and v.Attachment1 then
									NextContainer[v] = { Attachment0 = v.Attachment0.CFrame, Attachment1 = v.Attachment1.CFrame }
								end
							end
						end
						
					end
					
					if next(NextContainer) then
						for i, v in pairs(NextContainer) do
							local AttachmentZero = v.Attachment0
							local AttachmentOne = v.Attachment1
							local NextParent = i.Parent.Parent
							
							for _, Object in pairs(GoalCharacter:GetDescendants()) do
								if Object:IsA("Attachment") then
									local GoalParent = Object.Parent
									
									if GoalParent and GoalParent:IsA("BasePart") and GoalParent == NextParent then
										local GoalCF = Object.CFrame
										
										if GoalCF == AttachmentZero then
											i.Attachment0 = Object
											
										elseif GoalCF == AttachmentOne then
											i.Attachment1 = Object
											
										end
									end
								end
							end
						end
					end
				end
			end
			
		else
			if GoalCharacter:GetAttribute("Moveset") == "Cursed Child" then
				for _, AuraObject in GoalCharacter:GetDescendants() do
					if AuraObject:GetAttribute("CHARAAURA") then
						if AuraObject:IsA("ParticleEmitter") or AuraObject:IsA("Beam") or AuraObject:IsA("Trail") then
							AuraObject.Enabled = false
						end

						game.Debris:AddItem(AuraObject, 2)
					end
				end
				
			elseif GoalCharacter:GetAttribute("Moveset") == "Monster Form" then
				for _, AuraObject in GoalCharacter:GetDescendants() do
					if AuraObject:GetAttribute("MonsterParticles") then
						if AuraObject:IsA("ParticleEmitter") or AuraObject:IsA("Beam") or AuraObject:IsA("Trail") then
							AuraObject.Enabled = false
						end

						game.Debris:AddItem(AuraObject, 2)
					end
				end
			end
			
		end
	end)
end

--workspace.Live.ChildAdded:Connect(SetupLiveCharacter)

for _, GoalCharacter: Model in workspace.World.Live:GetChildren() do
	task.spawn(function()
		--SetupLiveCharacter(GoalCharacter)
	end)
end

for _, LegIron: Model in pairs(CollectionService:GetTagged("ballnchain")) do
	local LegIronParent = LegIron.Parent
	if LegIronParent and LegIronParent.Parent ~= Player.Character then
		LegIron.CanCollide = false

	else
		LegIron:GetPropertyChangedSignal("CollisionGroup"):Connect(function()
			LegIron.CollisionGroup = "NonPColDebri"
		end)

	end
end

CollectionService:GetInstanceAddedSignal("ballnchain"):Connect(function(LegIron: Model)
	local LegIronParent = LegIron.Parent
	if LegIronParent and LegIronParent.Parent ~= Player.Character then
		LegIron.CanCollide = false

	else
		LegIron:GetPropertyChangedSignal("CollisionGroup"):Connect(function()
			LegIron.CollisionGroup = "NonPColDebri"
		end)

	end
end)
]]

local SoundClient = require(script.SoundClient)
SoundClient()


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

if workspace:GetAttribute("ServerOwner") == Player.UserId or RNS:IsStudio() then
	RBXGeneral:DisplaySystemMessage(`<font face = 'SourceSansBold' size = '16' color='#FFD813'>{"[ADMIN/PS+ COMMANDS]"}</font>`)

	RBXGeneral:DisplaySystemMessage("<font face = 'SourceSansBold' size = '16' color='#FFFFD8'>" .. table.concat({
		"\t/fly username", 
		"/unfly username", 
		"/bring username", 
		"/goto username", 
		"/size username size", 
		"/respawn username", 
		"/godmode username", 
		"/kick username", 
		"/ban username", 
		"/unban username", 
		"/announce message",
		"/builder username",
		"/addkills username"
	}, "\n\t") .."</font>")
end



if game.PlaceId == workspace:GetAttribute("DuelsPlaceId") then
	local InvisibleWalls = workspace:WaitForChild("Map"):WaitForChild("InvisibleWalls")

	for _, v in pairs(InvisibleWalls:GetChildren()) do
		v.CanCollide = true
	end
end


TextChatService.OnIncomingMessage = function(message: TextChatMessage)
	local textSource = message.TextSource
	if not textSource then return end

	local Chatter = game.Players:GetPlayerByUserId(textSource.UserId)
	if not Chatter or not Chatter:GetAttribute("EquippedTitle") or not Chatter:GetAttribute("TitleColor") then return end

	local overrideProperties = Instance.new("TextChatMessageProperties")
	overrideProperties.PrefixText = "<font color='#" .. Chatter:GetAttribute("TitleColor"):ToHex() .. "'>[" .. Chatter:GetAttribute("EquippedTitle") .. "]</font> " .. message.PrefixText
	return overrideProperties
end



print('CLIENT LOADED '..tick() - loadStart)