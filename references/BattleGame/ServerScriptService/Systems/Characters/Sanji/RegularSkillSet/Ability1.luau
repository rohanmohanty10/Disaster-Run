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


local NewAnimLocation = ServerStorage.Assets.Animations.Sanji["Mutton Kick"]


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
		
		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityOneCooldown") then return end

		Player:SetAttribute("AbilityOneCooldown", true)		

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end
				
		local Janitor = Trove.new()

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false
		local Hitbox = nil


		local StartAnimation = NewAnimLocation.FullAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}
		

		--local Assets = {}
		--local Container = {}
		--local function MoveChar(Params)
		--	for _, v in pairs(Container) do
		--		v:Destroy()
		--	end

		--	local BodyVelocity = Janitor:Add(Instance.new("BodyVelocity"))

		--	table.insert(Assets, BodyVelocity)
		--	table.insert(Container, BodyVelocity)

		--	BodyVelocity.Name = "moveme"
		--	BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000, 0)
		--	BodyVelocity:SetAttribute("Speed", Params.speed or 100)
		--	BodyVelocity:SetAttribute("Fallout", Params.fallout or 0.95)
		--	BodyVelocity:SetAttribute("End", Params.endd or 5)
		--	BodyVelocity.Parent = HumRP

		--	Debris:AddItem(BodyVelocity, Params.deletiontime or 5)
		--end

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000, 0)
		BodyVelocity:SetAttribute("Speed", 60)
		BodyVelocity:SetAttribute("Fallout", .98)
		BodyVelocity:SetAttribute("End", 5)

		StartEvents["spin"] = StartTrack:GetMarkerReachedSignal("spin"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "spin",})
		end)

		StartEvents["move"] = StartTrack:GetMarkerReachedSignal("move"):Once(function()
			--MoveChar({ speed = 160, fallout = 0.98, endd = 5, deletiontime = 1.5 })
			RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "move",})
			BodyVelocity.Parent = HumRP
		end)
		
		local Ended = false
		

		StartEvents["kickStart"] = StartTrack:GetMarkerReachedSignal("kickStart"):Once(function()
			print("KickStart")
			Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(8, 12, 8)
			Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if EnemyCharacter:GetAttribute("Ragdolled") then
					warn("Enemy was ragdolled. Exited early")
					return
				end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, 2, nil, false, true, true, true, false, nil, 19.5)
				if HitInfo.Countered == true then return end --Simple and easy
				if HitInfo.Blocked == true then return end
				
				local Finisher = HitInfo.Finisher == true
				Hit = true

				EnemyCharacter:AddTag("CantRotate")

				local UserAnimation = NewAnimLocation.User
				local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
				local UserEvents = {}
				
				local VictimTrack
				local VictimEvents = {}
				
				local function EndFunction()
					task.spawn(function()
						if Ended then return end
						Ended = true


						if BodyVelocity then 
							BodyVelocity:Destroy() 
							BodyVelocity = nil 
						end

						for _,v in UserEvents do
							v:Disconnect()
						end

						if Stun then
							StunHandler:Unstun(Character, Stun)
							Stun:Destroy()
							warn("Unstunned from 2nd anim")
						end
						Player:SetAttribute("AbilityOneCooldown", CooldownTime)
						task.delay(CooldownTime, function()
							if Player then
								Player:SetAttribute("AbilityOneCooldown", false)
							end
						end)
						
					end)
				end
				
				if Finisher then
					--task.delay(0.2, function()
					--	if BodyVelocity then
					--		BodyVelocity:Destroy()
					--		BodyVelocity = nil
					--	end
					--end)
					
					if BodyVelocity then
						BodyVelocity:Destroy()
						BodyVelocity = nil
					end
					
					local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
					local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(1.5, 0, -4) * CFrame.Angles(0, math.pi, 0), -1)	

					local userFinisher = NewAnimLocation.UserFinisher
					local victimFinisher = NewAnimLocation.VictimFinisher
					UserTrack = AnimationService:getAnimationTrack(Character, userFinisher)
					VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, victimFinisher)


					UserEvents["start"] = UserTrack:GetMarkerReachedSignal("start"):Once(function()
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 6 } })
						RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "FireLegMoutonKickStartup",})
					end)

					UserEvents["hitend"] = UserTrack:GetMarkerReachedSignal("hitend"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "finisherHit",})
						RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "FireLegMoutonKickDestroy",})
						
						EnemyCharacter:AddTag("DontDoDieFunction")

						if Weld then
							pcall(function()
								Weld:Stop()
							end)
							Weld = nil
						end
						
						if EnemyStun then
							StunHandler:Unstun(EnemyCharacter, EnemyStun)
							EnemyStun = nil
						end
						
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						EnemyCharacter:RemoveTag("CantRotate")
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 9, Last = 0.2 } })
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, false, true, true, nil, nil)

						RagdollHandler.ragdoll(EnemyHumanoid, 2.25, false, Character, nil, nil, true, {
							DestructionAttach = true,     
							Size = Vector3.new(10, 10, 10),
							MaxDuration = 2.25,
							Player = EnemyPlayer,
							MinimumSize = 4,
							VoxelDestroyChance = .4,
							FlingDestroyChance = 1,
							ExtrapolateWithPing = true,
							Shake = true,
							
							
							LaunchKnockback = {
								KnockbackType = "Velocity",
								MaxForce = Vector3.new(100000, 50000, 100000),
								Velocity = HumRP.CFrame.LookVector * 150 + Vector3.new(0, 60, 0),
							},
							VoxelVelocity = function(voxel, hitPos)
								local outward = voxel.Position - hitPos
								outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
								return outward * math.random(40, 70) + Vector3.new(0, 20, 0)
							end,
						})
						
						--task.delay(.1, function()
						--	
						--end)

						ReplicateEffects_Set:FireAllClients("collisionWall", { root = EnemyHumRP,
							NoCrater = "SanjiExplosion",
							hit = EnemyCharacter,
							caller = Character,
							OnlyCheck = {workspace.World.Map.Destroyable.Map}, --added
						})
					end)

					UserEvents["end"] = UserTrack:GetMarkerReachedSignal("end"):Once(function()
						--RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "FireLegMoutonKickDestroy",})
					end)

					VictimTrack.Stopped:Once(function()
						if Weld then
							pcall(function()
								Weld:Stop()
							end)
							Weld = nil
						end
						
						if EnemyStun then
							StunHandler:Unstun(EnemyCharacter, EnemyStun)
							EnemyStun:Destroy()
						end
						
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						EnemyCharacter:RemoveTag("CantRotate")
					end)

					UserTrack.Stopped:Once(function()
						
						if Weld then
							pcall(function()
								Weld:Stop()
							end)
							Weld = nil
						end
						
						if VictimTrack and VictimTrack.IsPlaying then
							VictimTrack:Stop()
						end
						
						if BodyVelocity then 
							BodyVelocity:Destroy() 
							BodyVelocity = nil 
						end

						if Stun then
							StunHandler:Unstun(Character, Stun)
							Stun:Destroy()
						end
						iFramesService:RemoveAlliFrames(Character)
						CollisionsModule:SetCollisionGroup(Character, "Players")
						Character:RemoveTag("CantRotate")
						
						Player:SetAttribute("AbilityOneCooldown", CooldownTime)
						task.delay(CooldownTime, function()
							if Player then
								Player:SetAttribute("AbilityOneCooldown", false)
							end
						end)
						
					end)


					Character:AddTag("CantRotate")

					iFramesService:AddAlliFrames(Character)
					iFramesService:AddAlliFrames(EnemyCharacter)
					
					CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")
					
					ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

					AnimationService:stopAll(Character)
					AnimationService:stopAll(EnemyCharacter)
					AnimationService:playAnimation(Character, userFinisher)
					AnimationService:playAnimation(EnemyCharacter, victimFinisher)

					Weld:Start(nil, EnemyPlayer) --No more or player
					RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "finisherStart",})
					RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "FireCharge",})
				else
					UserEvents["kick"] = UserTrack:GetMarkerReachedSignal("kick"):Once(function()
						task.delay(0.3, function()
							if BodyVelocity then
								BodyVelocity:Destroy()
								BodyVelocity = nil

							end
						end)
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })

						--RagdollHandler.ragdoll(EnemyHumanoid, 1.5)
						--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * Vector3.new(40, 0 ,80)})
						local selfToOtherChar = (EnemyHumRP.Position - HumRP.Position).Unit
						local lookVector = Character.HumanoidRootPart.CFrame.LookVector

						local dotProduct = lookVector:Dot(selfToOtherChar)
						if EnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
							dotProduct = 1
						end

						local at = Character.HumanoidRootPart.Position
						local forward = Character.HumanoidRootPart.CFrame.LookVector
						local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))
						
						require(ServerModules.PerfectKnockback).KnockBack(nil, EnemyCharacter, {
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
							canHitWall = true,
							DestroyEnvironment = true,
						}, Character)
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, math.random(13, 17), nil, nil, false, false, true, true, true, nil, nil)				
					end)


					UserEvents["hitend"] = UserTrack:GetMarkerReachedSignal("hitend"):Once(function()
						if BodyVelocity then
							BodyVelocity:Destroy()
							BodyVelocity = nil
						end
					end)

					UserTrack.Stopped:Once(EndFunction)


					SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Victim, EnemyCharacter.Torso)

					--ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
					AnimationService:stopAll(Character)
					AnimationService:stopAll(EnemyCharacter)
					AnimationService:playAnimation(Character, UserAnimation)
				end
			end

			Hitbox:Start()
			task.delay(0.3, function()
				Hitbox:Stop()
				--Hitbox:Destroy()
				Hitbox = nil
			end)
			--Hitbox:Destroy()

			RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "hit",})
		end)

		StartEvents["stopMove"] = StartTrack:GetMarkerReachedSignal("stopMove"):Once(function()
			if BodyVelocity then
				BodyVelocity:Destroy()
				BodyVelocity = nil
			end
		end)

		StartTrack.Stopped:Once(function()
			if BodyVelocity then
				BodyVelocity:Destroy()
				BodyVelocity = nil
			end

			for _,v in StartEvents do
				v:Disconnect()
			end


			if not Hit then

				if BodyVelocity then
					BodyVelocity:Destroy()
					BodyVelocity = nil
				end
				if Hitbox then
					Hitbox:Stop()
					--Hitbox:Destroy()
					Hitbox = nil
				end
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun:Destroy()
					warn("Unstunned from 1st anim")
				end
				
				Player:SetAttribute("AbilityOneCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					if Player then
						Player:SetAttribute("AbilityOneCooldown", false)
					end
				end)
			end
			
			
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)


		SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Start, Character.Torso)
		--SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.StartExtra, Character.Torso)
		RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "start",})
	end
}