local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")


local ServerModules = ServerStorage.Modules

local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer = ReplicatedStorage.Remotes


local StunHandler = require(ServerModules.StunHandler)
local HitboxHandler = require(ServerModules.HitboxHandler)
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local NewKnockback = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService = require(ServerModules.iFramesService)
local WeaponsHandler = require(ServerModules.WeaponsHandler)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)



local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local services = require(ReplicatedStorage.Services)
local VfxUtility = services:GetService("VFX_Utility")
local knockbackService = services:GetService("KnockbackService")

local Sounds = ServerStorage.Assets.Sounds
local Animations = ServerStorage.Assets.Animations
local Models = ServerStorage.Assets.Models


local Weapons = Models.Weapons

local MoveAnims = Animations.Moves
local MoveSounds = Sounds.Moves

local CombatAnims = Animations.Combat
local CombatSounds = Sounds.Combat


local ComSet = RemotesContainer.Comunicator.Set
local ComGet = RemotesContainer.Comunicator.Get


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad
local StartAirDetect = ServerStorage.Bindables.AirDetector

local Assets = shared.Assets

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true


return {
	Start = function(Character: Model, FirstEnemyCharacter: Model, SecondEnemyCharacter: Model)
		local FirstEnemyHumanoid: Humanoid = FirstEnemyCharacter.Humanoid
		local SecondEnemyHumanoid: Humanoid = SecondEnemyCharacter.Humanoid
		
		local FirstEnemyHumRP: BasePart = FirstEnemyCharacter.HumanoidRootPart
		local SecondEnemyHumRP: BasePart = SecondEnemyCharacter.HumanoidRootPart
		
		local HumRP: BasePart = Character.HumanoidRootPart
		
		
		local CharacterStun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local FirstEmemyStun = StunHandler:Stun(FirstEnemyCharacter, nil, true, 0, 0, true)
		local SecondEmemyStun = StunHandler:Stun(SecondEnemyCharacter, nil, true, 0, 0, true)
		
		
		iFramesService:AddAlliFrames(Character)
		iFramesService:AddAlliFrames(FirstEnemyCharacter)
		iFramesService:AddAlliFrames(SecondEnemyCharacter)
		
		
		local UserAnimation = CombatAnims["Anti Team"]["1"].User
		local FirstVictimAnimation = CombatAnims["Anti Team"]["1"].Teamer1
		local SecondVictimAnimation = CombatAnims["Anti Team"]["1"].Teamer2
		
		
		local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)
		local FirstVictimTrack = AnimationService:getAnimationTrack(FirstEnemyCharacter, FirstVictimAnimation)
		local SecondVictimTrack = AnimationService:getAnimationTrack(SecondEnemyCharacter, SecondVictimAnimation)
		
		
		if Character:HasTag("Ragdolled") then
			RagdollHandler.cancelRagdoll(Character, nil, false, nil, nil, true)
		end
		if FirstEnemyCharacter:HasTag("Ragdolled") then
			RagdollHandler.cancelRagdoll(FirstEnemyCharacter, nil, false, nil, nil, true)
		end
		if SecondEnemyCharacter:HasTag("Ragdolled") then
			RagdollHandler.cancelRagdoll(SecondEnemyCharacter, nil, false, nil, nil, true)
		end
		
		
		Character:AddTag("CantRotate")
		FirstEnemyCharacter:AddTag("CantRotate")
		SecondEnemyCharacter:AddTag("CantRotate")
		
		
		CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
		CollisionsModule:SetCollisionGroup(FirstEnemyCharacter, "GrabbedPlayers")
		CollisionsModule:SetCollisionGroup(SecondEnemyCharacter, "GrabbedPlayers")
		
		
		coroutine.wrap(function()
			local startTick = tick()
			
			while true do
				HumRP.AssemblyLinearVelocity = HumRP.AssemblyLinearVelocity * Vector3.new(0, 1, 0)
				HumRP.Anchored = true
				
				local rayResult = workspace:Raycast(HumRP.Position, Vector3.new(0, -10, 0), MapRayParams)
				
				if rayResult then
					local newPos = rayResult.Position + Vector3.new(0, 2.7, 0)
					HumRP.CFrame = CFrame.new(newPos, newPos + HumRP.CFrame.LookVector * Vector3.new(1, 0, 1))
				end
				
				pcall(function()
					if tick() - startTick < 2.1 then
						FirstEnemyHumRP.CFrame = HumRP.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0)
						FirstEnemyHumRP.AssemblyLinearVelocity = FirstEnemyHumRP.AssemblyLinearVelocity * 0
					end
					
					if tick() - startTick < 0.9 then
						SecondEnemyHumRP.CFrame = HumRP.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0)
						SecondEnemyHumRP.AssemblyLinearVelocity = SecondEnemyHumRP.AssemblyLinearVelocity * 0
					end
				end)
				
				RunService.Heartbeat:Wait()
				
				if tick() - startTick >= 2.67 then
					HumRP.Anchored = false
					
					return
				end
			end
		end)()
		
		
		task.delay(0.9, function()
			pcall(function()
				StunHandler:Unstun(SecondEnemyCharacter, SecondEmemyStun)
				SecondEnemyCharacter:RemoveTag('CantRotate')
				iFramesService:RemoveAlliFrames(SecondEnemyCharacter)
				CollisionsModule:SetCollisionGroup(SecondEnemyCharacter, "Players")
				
				DamageHandler:TakeDamage(Character, SecondEnemyHumanoid, 10, nil, nil, false, false, true, false, true, nil, nil)
				
				SecondEnemyHumRP.AssemblyLinearVelocity = Vector3.zero
				
				local selfToOtherChar = (SecondEnemyHumRP.Position - HumRP.Position).Unit
				local lookVector = Character.HumanoidRootPart.CFrame.LookVector
				
				local dotProduct = lookVector:Dot(selfToOtherChar)
				if SecondEnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
					dotProduct = 1
				end
				
				local at = Character.HumanoidRootPart.Position
				local forward = Character.HumanoidRootPart.CFrame.LookVector
				local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))
				
				
				require(ServerStorage.Modules.PerfectKnockback).KnockBack(nil, SecondEnemyCharacter, {
					LookVector = lookposition.LookVector,
					LookForce = 58.5,
					LookFinalForce = 55,
					LookAt = lookposition,
					DestroyRagdoll = true,
					GroundStunTime = 0.95,
					Escapable = false,
					FallingDetectDelay = 0.2,
					Dot = dotProduct,
					DotParams = {0.4, 1},
					canHitWall = true
				}, Character)
			end)
		end)
		
		task.delay(2.13, function()
			pcall(function()
				StunHandler:Unstun(FirstEnemyCharacter, FirstEmemyStun)
				FirstEnemyCharacter:RemoveTag('CantRotate')
				iFramesService:RemoveAlliFrames(FirstEnemyCharacter)
				CollisionsModule:SetCollisionGroup(FirstEnemyCharacter, "Players")
				
				DamageHandler:TakeDamage(Character, FirstEnemyHumanoid, 10, nil, nil, false, false, true, false, true, nil, nil)

				FirstEnemyHumRP.AssemblyLinearVelocity = Vector3.zero

				local selfToOtherChar = (FirstEnemyHumRP.Position - HumRP.Position).Unit
				local lookVector = Character.HumanoidRootPart.CFrame.LookVector

				local dotProduct = lookVector:Dot(selfToOtherChar)
				if FirstEnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
					dotProduct = 1
				end

				local at = Character.HumanoidRootPart.Position
				local forward = Character.HumanoidRootPart.CFrame.LookVector
				local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))


				require(ServerStorage.Modules.PerfectKnockback).KnockBack(nil, FirstEnemyCharacter, {
					LookVector = lookposition.LookVector,
					LookForce = -58.5,
					LookFinalForce = -55,
					LookAt = lookposition,
					DestroyRagdoll = true,
					GroundStunTime = 0.95,
					Escapable = false,
					FallingDetectDelay = 0.2,
					Dot = dotProduct,
					DotParams = {0.4, 1},
					canHitWall = true
				}, Character)
			end)
		end)
		
		
		FirstVictimTrack.Stopped:Once(function()
			StunHandler:Unstun(FirstEnemyCharacter, FirstEmemyStun)
			FirstEnemyCharacter:RemoveTag('CantRotate')
			iFramesService:RemoveAlliFrames(FirstEnemyCharacter)
			CollisionsModule:SetCollisionGroup(FirstEnemyCharacter, "Players")
		end)
		
		SecondVictimTrack.Stopped:Once(function()
			StunHandler:Unstun(SecondEnemyCharacter, SecondEmemyStun)
			SecondEnemyCharacter:RemoveTag('CantRotate')
			iFramesService:RemoveAlliFrames(SecondEnemyCharacter)
			CollisionsModule:SetCollisionGroup(SecondEnemyCharacter, "Players")
		end)
		
		UserTrack.Stopped:Once(function()
			StunHandler:Unstun(Character, CharacterStun)
			Character:RemoveTag('CantRotate')
			iFramesService:RemoveAlliFrames(Character)
			CollisionsModule:SetCollisionGroup(Character, "Players")
			
			Character:SetAttribute("OnAntiTeam", nil)
		end)
		
		
		
		Character:SetAttribute("OnAntiTeam", true)
		
		
		
		AnimationService:stopAll(Character)
		AnimationService:stopAll(FirstEnemyCharacter)
		AnimationService:stopAll(SecondEnemyCharacter)
		
		AnimationService:playAnimation(Character, UserAnimation)
		AnimationService:playAnimation(FirstEnemyCharacter, FirstVictimAnimation)
		AnimationService:playAnimation(SecondEnemyCharacter, SecondVictimAnimation)
		
		
		ReplicateEffects_Set:FireAllClients("AntiTeam", { Char = Character, Variant = "1" })
	end
}