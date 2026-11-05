--ServerStateController

local replicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

local modules = replicatedStorage.Modules
--local stateService = require(ServerScriptService.Systems.StateService)
local StunHandler = require(ServerStorage.SBGModules.StunHandler)
local AnimationService = require(ServerStorage.SBGModules.AnimationService)
local iFramesService = require(ServerStorage.SBGModules.iFramesService)

--local StateService2 = require(ServerScriptService.Systems.StateService2)
local remotes = replicatedStorage.Remotes
local ReplicateEffects_Set = remotes.Replicate.Set


--Handling sprinting permissions.
--remotes.RequestSprint.OnServerEvent:Connect(function(player, canSprint) --Called from the clint to give permission on if they can sprint or not.
--	local character = player.Character
--	if not character then return end --Probably for if they are dead.
--	if canSprint then
--		if stateService.checkState(character, "Stunned", "Blocking", "NoSprint", "NoMove", "Sprinting") then
--			return
--		end
--		stateService.changeState(character, "Sprinting", true)
--	else
--		stateService.changeState(character, "Sprinting", false)
--	end

--end)

remotes.RequestStun.OnServerEvent:Connect(function(player, timeStunned)
	local Character = player.Character
	if not Character then return end --Probably for if they are dead.
	--stateService.changeState(character, "Stunned", true, timeStunned)
	
	if iFramesService:HasiFrame(Character, 1) then
		warn("Player has iframes")
		return
	end
	
	ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
	StunHandler:Stun(Character, 2, true, 0, 0, true)
	AnimationService:stopAll(Character)
end)

-- For grab skills and to turn off their collisions.
--function ChangeCollisionGroup(character: Model, collisionGroup)
--	for _, part in character:GetDescendants() do
--		if part:IsA("BasePart") then
--			part.CollisionGroup = collisionGroup
--		end
--	end
--end

-- Authoritative movement update and checker.
--runService.Heartbeat:Connect(function() --No need for dt.
--	for _, player in ipairs(players:GetPlayers()) do
--		local character = player.Character
--		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		
--		if character and humanoid then
			
--			local finalWalkSpeed = 16
--			local finalJumpPower = 50
--			local jumpingBlocked = false  -- track this separately
--			--local autoRotate = true

			
--			if character:GetAttribute("Sprinting") == true then
--				finalWalkSpeed = 25
--			end
			
--			if character:GetAttribute("CustomSpeed") then
--				finalWalkSpeed = character:GetAttribute("CustomSpeed")
--			end
			
--			if character:GetAttribute("Attacking") == true then
--				finalWalkSpeed = 16
--				finalJumpPower = 0
--				jumpingBlocked = true
--			end
			
--			if character:GetAttribute("Blocking") == true then
--				finalWalkSpeed = 5
--				finalJumpPower = 0
--				jumpingBlocked = true
--			end
--			if character:GetAttribute("SlowMove") == true then
--				finalWalkSpeed = 10
--				finalJumpPower = 0
--				jumpingBlocked = true
--			end
--			if character:GetAttribute("NoJump") == true then
--				finalJumpPower = 0
--				jumpingBlocked = true
--			end
--			if character:GetAttribute("NoMove") == true then --Different than stunned cause u can still attack.
--				finalWalkSpeed = 0
--				finalJumpPower = 0
--				jumpingBlocked = true
--			end
--			if character:GetAttribute("Ragdolled") == true then
--				finalWalkSpeed = 0
--				finalJumpPower = 0
--				jumpingBlocked = true
--				--autoRotate = false
--			end
--			if character:GetAttribute("Stunned") == true or character:HasTag("Stunned") then
--				finalWalkSpeed = 0
--				finalJumpPower = 0
--				jumpingBlocked = true
--			end
--			--[[
--			if statusFolder:FindFirstChild("Grab") then
--				finalWalkSpeed = 16
--				finalJumpPower = 7.2
--				jumpingBlocked = true
--				autoRotate = false
--				--collisionGroupType = "EntityGrab1"
--			end
--			if statusFolder:FindFirstChild("MovingGrab") then
--				finalWalkSpeed = 16
--				finalJumpPower = 0
--				jumpingBlocked = true
--				autoRotate = true
--				--collisionGroupType = "EntityGrab1"
--			end
--			if statusFolder:FindFirstChild("Grabbed") then
--				finalWalkSpeed = 0
--				finalJumpPower = 0
--				jumpingBlocked = true
--				autoRotate = false
--				--collisionGroupType = "EntityGrab2"
--			end
--			]]
			
--			humanoid.WalkSpeed = finalWalkSpeed
--			humanoid.JumpPower = finalJumpPower
--			--humanoid.AutoRotate = autoRotate
--			--ChangeCollisionGroup(character, collisionGroupType)
			
--			--humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, not jumpingBlocked)
--			humanoid.AutoJumpEnabled = not jumpingBlocked
--			if jumpingBlocked then
--				humanoid.Jump = false -- clear any queued jump
--			end

--		end
		
		
--	end
		
--end)