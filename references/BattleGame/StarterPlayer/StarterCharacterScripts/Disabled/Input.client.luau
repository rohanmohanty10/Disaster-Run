-- Core Input Client
local runService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local replicatedService = game:GetService("ReplicatedStorage")
local debris = game:GetService("Debris")
local players = game:GetService("Players")


local remotes = replicatedService:WaitForChild("Remotes")
local assets = replicatedService:WaitForChild("Assets")
local modules = replicatedService:WaitForChild("Modules")

local character:Model = script.Parent.Parent
local player = players:GetPlayerFromCharacter(character)
local humanoid:Humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

--local animationsFolder = assets:WaitForChild("Animations", math.huge)

--local animsModule = require(modules.Animations)
--local stateService = require(modules.ClientState)
--local CameraShaker = require(modules.CameraShaker)

--game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

--animsModule.Load(character, humanoid.Animator, assets.Animations)


-- SETTINGS --
--local Settings = require(modules.Settings)

--local autoRunEnabled = Settings.Get("AutoRun")
--Settings.Changed:Connect(function(key, value)
--	if key == "AutoRun" then
--		autoRunEnabled = value
		 	
--	end
--end)

--local currentIdle = "Gojo.Idle.Gojo"
--local currentRun = "Gojo.Run.Gojo"

--local function changeIdle()
--	local weaponName = player:GetAttribute("Character") 


--end

--local function changeRun()
--	local weaponName = player:GetAttribute("Character")  


--end

-- VARIABLES --
--local stepConnection = nil

--Higuruma
--currentIdle = changeIdle()
--currentRun = changeRun()

local isSprintingInput = false
local isMouseHeld = false
local attackLoopRunning = false
local holdingSpace = false
local inAir = false

-- Double Tap W for Sprinting
local DOUBLE_TAP_TIMING = .3
local lastWDownTime = 0
local isRunning = false
local lasTapped = tick()


local plr = players.LocalPlayer
local cam = workspace.CurrentCamera

-- HELPER METHODS --
--local function getCharacterName()
--	local weaponName = player:GetAttribute("Character") 

--	
	
--end

--local function canDash()
--	if stateService.checkState(character, "Stunned", "Blocking", "NoMove", "Dashing") then --Removed "Attacking", "NoSprint", "NoMove"
--		return false
--	end
	
--	return true
--end

--local function getDashDirection()
--	local keysPressed = UIS:GetKeysPressed() --Gives us 2 objects.
--	for _, input:InputObject in keysPressed do
--		if input.KeyCode == Enum.KeyCode.A then
--			return "Left"
--		end
--		if input.KeyCode == Enum.KeyCode.D then
--			return "Right"
--		end
--		if input.KeyCode == Enum.KeyCode.W then
--			return "Forward"
--		end
--		if input.KeyCode == Enum.KeyCode.S then
--			return "Back"
--		end
--	end
--	return "Forward"
--end

local function isMoving()
	return humanoid.MoveDirection.Magnitude > 0 --This is a boolean value since we are comparing to 0. Checks to see if magnitude is > 0.
end

local function playerIsTyping() --Better than processed since this only tracks the textbox. It use to also track ctrl, alt, and tab which caused errors when conflicting with holding moves.
    return UIS:GetFocusedTextBox() ~= nil
end

--local function attackLoop()
--	if attackLoopRunning then return end
--	attackLoopRunning = true

--	while isMouseHeld do
--		if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
--			--Old one and will not be used.
--			--remotes.Attack:FireServer(holdingSpace, inAir)
--		end

--		task.wait(0.05)
--	end

--	attackLoopRunning = false
--end

-- New function being used.
--local CombatRemotes = remotes.Combat

local CombatSet = remotes.Combat.Attack

local function checkCharacterAvailability()
	return character ~= nil and character.Parent ~= nil and  humanoidRootPart ~= nil and humanoidRootPart.Parent ~= nil and humanoid ~= nil and humanoid.Parent ~= nil and humanoid.Health > 0 and humanoid:GetState() ~= Enum.HumanoidStateType.Dead
end

local function Punch()
	--if workspace.Configuration.NoAttack.Value == true or Player.Commands.NoAttack.Value == true then return end

	--if checkCharacterAvailability() == true and not shared.buildenabled then
	if checkCharacterAvailability() == true then
		CombatSet:FireServer("PunchStart")

		--print("PunchStart Client")
	end
end
	
	
	
	
	
	
	
	
-- Input detection and changes --
humanoid.StateChanged:Connect(function(oldState, newState)
	if newState == Enum.HumanoidStateType.Jumping or newState == Enum.HumanoidStateType.Freefall then
		inAir = true
		CombatSet:FireServer("SetAirState", {InAir = true})  -- tell server
	end

	if newState == Enum.HumanoidStateType.Landed
		or newState == Enum.HumanoidStateType.Running
		or newState == Enum.HumanoidStateType.RunningNoPhysics
		or newState == Enum.HumanoidStateType.GettingUp then

		inAir = false
		CombatSet:FireServer("SetAirState", {InAir = false})  -- tell server
	end
end)

UIS.InputBegan:Connect(function(input, processed)
	if processed then return end

	-- CLICKING M1s --
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		-- 1. Check for stuns locally to prevent Remote unnecessary traffic
		--if character:HasTag("Stunned") or character:HasTag("CantPunch") or character:HasTag("Ragdolled") then 
		--	return 
		--end

		---- 2. Add an attribute check if you use attributes for cooldowns
		--if character:GetAttribute("PunchCDS") == true then
		--	return
		--end
		
		--print("Punch Input Sent")
		task.spawn(function()
			runService.Heartbeat:Wait()
			Punch() -- This should fire your RemoteEvent to the server
		end)
		--local DoPunch = coroutine.wrap(function()
		--	runService.Heartbeat:Wait()
		--	Punch()
		--end)
		--DoPunch()
	end

	-- DASHING SCRIPT --
	--if input.KeyCode == Enum.KeyCode.Q and not playerIsTyping() then
	--	local direction = getDashDirection() 
	--	if direction and canDash() then
	
	--		local hrp: BasePart = character:FindFirstChild("HumanoidRootPart")
	--		local humanoid: Humanoid = character:FindFirstChild("Humanoid")
	--		if not hrp or not humanoid then return end
	--		remotes.Dash:FireServer(direction)		
	--	end
	--end
	
	-- DOUBLE TAPPING W --
	--if input.KeyCode == Enum.KeyCode.W and not playerIsTyping() then
	--	if autoRunEnabled and not stateService.checkState(character, "Stunned", "Blocking", "NoMove", "Sprinting") then  --local checks with server checks later.
	--		remotes.RequestSprint:FireServer(true)
	--		return
	--	end
		
	--	if lastWDownTime == 0 then
	--		lastWDownTime += 1
	--	else 
	--		if tick() - lasTapped < DOUBLE_TAP_TIMING then
	--			lastWDownTime += 1
	--			if lastWDownTime > 2 then
	--				lastWDownTime = 2
	--			end
	--		end
	--	end

	--	if lastWDownTime == 2 and not stateService.checkState(character, "Stunned", "Blocking", "NoMove", "Sprinting") then --local checks with server checks later.
	--		remotes.RequestSprint:FireServer(true)
	--	end
	--	lasTapped = tick()
	--end
	
	-- Move Sets (1, 2, 3, 4)
	--if input.KeyCode == Enum.KeyCode.One and not playerIsTyping() and character:GetAttribute("ModeActive") == false then
	--	if character:GetAttribute("CanFollowUp") == true and not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned", "FirstAbilityFollowUpCD") then
	--		remotes.FollowUpSkill:FireServer()
	--	end
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned", "FirstAbility") then
	--		remotes.SkillRequest:FireServer(1)
	--	end
		
	--end

	--if input.KeyCode == Enum.KeyCode.Two and not playerIsTyping() and character:GetAttribute("ModeActive") == false then
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
	--		remotes.SkillRequest:FireServer(2)
	--	end
	--end

	--if input.KeyCode == Enum.KeyCode.Three and not playerIsTyping() and character:GetAttribute("ModeActive") == false then
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
	--		remotes.SkillRequest:FireServer(3)
	--	end
	--end

	--if input.KeyCode == Enum.KeyCode.Four and not playerIsTyping() and character:GetAttribute("ModeActive") == false then
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
	--		remotes.SkillRequest:FireServer(4)
	--	end
	--end
	
	--if input.KeyCode == Enum.KeyCode.G and not playerIsTyping() then
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
	--		remotes.ModeRequest:FireServer()
	--	end
	--end
	
	-- Adding Stun to myself --
	if input.KeyCode == Enum.KeyCode.L and not playerIsTyping() then
		remotes.RequestStun:FireServer(2)
	end

	if input.KeyCode == Enum.KeyCode.Space and not playerIsTyping() then
		holdingSpace = true
		CombatSet:FireServer("SetJumping", {HoldingSpace = true})  -- tell server immediately
	end
	

	--local doubleUseName = doubleUseMoves[ToolName]
	
	--if input.KeyCode == Enum.KeyCode.One and not playerIsTyping() and character:GetAttribute("ModeActive") == true then
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
	--		remotes.ModeSkillRequest:FireServer(1)
	--	end
	--end

	--if input.KeyCode == Enum.KeyCode.Two and not playerIsTyping()  and character:GetAttribute("ModeActive") == true then
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
	--		remotes.ModeSkillRequest:FireServer(2)
	--	end
	--end

	--if input.KeyCode == Enum.KeyCode.Three and not playerIsTyping()  and character:GetAttribute("ModeActive") == true then
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
	--		remotes.ModeSkillRequest:FireServer(3)
	--	end
	--end

	--if input.KeyCode == Enum.KeyCode.Four and not playerIsTyping() and character:GetAttribute("ModeActive") == true then
	--	if not stateService.checkState(character, "Dashing", "Blocking", "Attacking", "Stunned") then
	--		remotes.ModeSkillRequest:FireServer(4)
	--	end
	--end
	
	if input.KeyCode == Enum.KeyCode.B then
		if shared.emotegui then
			shared.emotegui()
			print("EmoteGUI")
		end
	end
	
	if input.KeyCode == Enum.KeyCode.N then
		if shared.cosgui then
			shared.cosgui()
			print("EmoteGUI")
		end
	end

end)

UIS.InputEnded:Connect(function(input, processed)
	if processed then return end

	--if input.KeyCode == Enum.KeyCode.W and not playerIsTyping() then
	--	if stateService.checkState(character, "Sprinting") then
	--		remotes.RequestSprint:FireServer(false)
	--		lastWDownTime = 0
	--		lasTapped = tick()
	--	end	

	--end

	if input.KeyCode == Enum.KeyCode.Space then
		holdingSpace = false
		CombatSet:FireServer("SetJumping", {HoldingSpace = false})  -- tell server immediately
	end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		CombatSet:FireServer('PunchEnd')
		--isMouseHeld = false
		
	end
	
end)

--stepConnection = runService.RenderStepped:Connect(function(deltaTime: number)  --It's in the variable stepConnection so we can disconnect it if the player is dead.	
--	if not character or not character.Parent then
--		if stepConnection then
--			stepConnection:Disconnect()
--			stepConnection = nil
--		end
--		return
--	end
	
--	if stateService.checkState(character, "Dead") then --None of these work if the player is dead.
--		stepConnection:Disconnect()
--		stepConnection = nil
--	end
	
--	if stateService.checkState(character, "Stunned", "Dashing") or inAir then
--		local idleTrack  = animsModule.Get(character, currentIdle)
--		if idleTrack and idleTrack.IsPlaying then
--			idleTrack:Stop() --Little Fade time
--		end
		
--		local foundRun = animsModule.Get(character, currentRun)
--		if foundRun and foundRun.IsPlaying then
--			foundRun:Stop()
--		end
		
--		return
--	end
	
--	--Idle Section
--	if isMoving() then
--		local idleTrack  = animsModule.Get(character, currentIdle)
--		if idleTrack and idleTrack.IsPlaying then
--			idleTrack:Stop() --Little Fade time
--		end
--	else
--		changeIdle()
--		local foundRun = animsModule.Get(character, currentRun)
--		if foundRun then
--			if foundRun.IsPlaying then
--				foundRun:Stop()
--			end
--		end
		
--		local idleTrack = animsModule.Get(character, currentIdle)
--		if idleTrack and not idleTrack.IsPlaying then
--			idleTrack:Play()
--		end

--	end
	
--	--Sprinting Section
--	if isMoving() and stateService.checkState(character, "Sprinting") then		
--		changeRun() --Changes the animation everytime. So if someone does switch char, it changes it.
--		local foundRun = animsModule.Get(character, currentRun)
--		if foundRun then
--			if not foundRun.IsPlaying then
--				foundRun:Play()
--			end
--		end
--	else
--		local foundRun = animsModule.Get(character, currentRun)
--		if foundRun then
--			if foundRun.IsPlaying then
--				foundRun:Stop()
--			end
--		end
--	end
	
--	-- BLOCKING 
--	if UIS:IsKeyDown(Enum.KeyCode.F) and not playerIsTyping() then --If f key is held, then it looks for a status folder called blocking and only runs it if it isn't there. So it doesn't spam the fireserver a billion times. Good for no lag.
--		if not stateService.checkState(character, "Blocking") then
--			remotes.Block:FireServer(true)
--		end
--	else --If f key isn't held, then it looks for a status folder called blocking and only runs it if it is there. So it doesn't spam the fireserver a billion times. Good for no lag
--		if stateService.checkState(character, "Blocking") then
--			remotes.Block:FireServer(false)
--		end
--	end
	
--end)


