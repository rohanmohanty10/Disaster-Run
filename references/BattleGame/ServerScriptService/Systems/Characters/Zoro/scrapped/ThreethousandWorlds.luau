local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")


local ServerModules = ServerStorage.SBGModules

local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer = ReplicatedStorage.Remotes


local StunHandler = require(ServerModules.StunHandler)
local HitboxHandler = require(ServerModules.HitboxHandler)
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local NewKnockback = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService = require(ServerModules.iFramesService)
--local WeaponsHandler = require(ServerModules.WeaponsHandler)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.ModeMoveSet["3000worlds"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true





return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		local Janitor = Trove.new()

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		--local initialAnim = NewAnimLocation.Miss
		local initialAnim = NewAnimLocation.Miss

		local StartAnimation = initialAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local Assets = {}
		local Container = {}
		
		local Hit = false
		
		StartEvents["spin"] = StartTrack:GetMarkerReachedSignal("spin"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
				Attacker  = Character,
				SkillType = "spin",            
			})
		end)
		
		
		
		--StartEvents["move"] = StartTrack:GetMarkerReachedSignal("move"):Once(function()
		--	RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
		--		Attacker  = Character,
		--		SkillType = "move",            
		--	})
		--end)	
		
		local Hitbox = HitboxHandler.new()
		StartEvents["move"] = StartTrack:GetMarkerReachedSignal("move"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
				Attacker  = Character,
				SkillType = "move",            
			})
			
			--local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(15, 10, 30)
			
			--Hitbox.Offset   = hitboxCFrame:ToObjectSpace(origin) -- offset relative to HumRP
			Hitbox.Offset = CFrame.new(0, 0, -18)

			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				Hitbox:Destroy()
				
				
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				
				RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
					Attacker  = Character,
					SkillType = "spinstop",            
				})
				
				
				
				
				
				--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name)  then return end
				if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2)  then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1.5, nil, nil, false, EnemyCharacter:HasTag('DEATH') and true or false, true, true, false, nil, 15)
				if HitInfo.Countered then return end
				Hit = true


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				EnemyCharacter:AddTag("CantRotate")
				Character:AddTag("CantRotate")


				iFramesService:AddAlliFrames(Character)
				iFramesService:AddAlliFrames(EnemyCharacter)

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")


				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				
				--local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0), -1)
				local myLook = HumRP.CFrame.LookVector
				local targetPos = EnemyHumRP.Position + myLook * 3  -- 3 studs past them in YOUR direction
				local targetCFrame = CFrame.lookAt(targetPos, targetPos + myLook)  -- keep your facing
				local offset = EnemyHumRP.CFrame:ToObjectSpace(targetCFrame)
				local Weld = WeldSystem.new(EnemyHumRP, HumRP, offset, -1)

				--flip them so they get pulled to enemy.
				
				local UserAnimation = NewAnimLocation.User
				local VictimAnimation = NewAnimLocation.Victim

				local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)


				--table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("freeze"):Once(function()
				--	UserTrack:AdjustSpeed(0)
				--	VictimTrack:AdjustSpeed(0)

				--	task.delay(0.2, function()
				--		UserTrack:AdjustSpeed(1)
				--		VictimTrack:AdjustSpeed(1)
				--	end)

				--end))
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("Flash"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
						Attacker  = Character,
						SkillType = "Flash",            
					})
				end))

				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("SlashEnd"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
						Attacker  = Character,
						SkillType = "SlashEnd",            
					})
				end))
				
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("fall"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
						Attacker  = Character,
						SkillType = "fall",
					})
				end))


				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("blood"):Once(function()
					

					RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
						Attacker  = Character,
						SkillType = "blood",
					})
					
					
				end))


				VictimTrack.Stopped:Once(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end

					StunHandler:Unstun(EnemyCharacter, EnemyStun)
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					EnemyCharacter:RemoveTag("CantRotate")
				end)

				UserTrack.Stopped:Once(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end

					StunHandler:Unstun(Character, Stun)
					iFramesService:RemoveAlliFrames(Character)
					CollisionsModule:SetCollisionGroup(Character, "Players")
					Character:RemoveTag("CantRotate")

				end)

				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)
				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)


				Weld:Start(nil, EnemyPlayer)

				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 4, Last = 3 } })

			end
			
			
			Hitbox:Start()
			
			--task.delay(4, function()
			--	Hitbox:Destroy()
			--end)
			--if BodyVelocity then
			--	--task.wait(.2)
			--	BodyVelocity:Destroy()
			--	BodyVelocity = nil
			--end
			--executeTeleport(HumRP, Character)

		end)

		StartEvents["spinstop"] = StartTrack:GetMarkerReachedSignal("spinstop"):Once(function()
			if Hitbox then
				Hitbox:Destroy()

			end			
			RemotesContainer.ClientEffects:FireAllClients("ThreethousandWorlds", {
				Attacker  = Character,
				SkillType = "spinstop",            
			})
			
		end)	

		StartTrack.Stopped:Once(function()
			

			for _,v in StartEvents do
				v:Disconnect()
			end
			

			if Hit then return end

			StunHandler:Unstun(Character, Stun)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		--temp
		--RemotesContainer.ClientEffects:FireAllClients("TigerHunt", {Attacker = Character, SkillType =  "start",})
	end
}