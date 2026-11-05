local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).BlackBeard[3]
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")


local ServerModules = ServerStorage.SBGModules
local DebreeService = require(ServerModules.DebreeService)

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
--local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedModules.Velocity)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


--local NewAnimLocation = ServerStorage.Assets.Animations.Sanji
local NewAnimLocation = ServerStorage.Assets.Animations["BlackBeard"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ReplicatedStorage.Assets.Animations


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

local tbl_13_upvr = {}
local activeTweens = {}
local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		local Animator: Animator = Humanoid.Animator

		--iFramesService:AddAlliFrames(Character)
		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityThreeCooldown") then return end

		Player:SetAttribute("AbilityThreeCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end


		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local Hit = false
		local grabHit = false
		local Finisher = false
		local EnemyCharacter = nil

		local Janitor = Trove.new()
		local Container = {}
		local Assets = {}
		local function MoveChar(Params)
			for _, v in pairs(Container) do
				v:Destroy()
			end

			local BodyVelocity = Janitor:Add(Instance.new("BodyVelocity"))

			table.insert(Assets, BodyVelocity)
			table.insert(Container, BodyVelocity)

			BodyVelocity.Name = "moveme"
			BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000, 0)
			BodyVelocity:SetAttribute("Speed", Params.speed or 100)
			BodyVelocity:SetAttribute("Fallout", Params.fallout or 0.95)
			BodyVelocity:SetAttribute("End", Params.endd or 5)
			BodyVelocity.Parent = HumRP

			Debris:AddItem(BodyVelocity, Params.deletiontime or 5)
		end
		local BodyVelocity = Janitor:Add(Instance.new("BodyVelocity"))
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		BodyVelocity:SetAttribute("Speed", 30)
		BodyVelocity:SetAttribute("Fallout", .92)
		BodyVelocity:SetAttribute("End", 2)
		
		local GrabSound  = SoundHandler:AddSound(MoveSounds.BlackBeard.Grab.Grab, HumRP)
		local WindDebris = SoundHandler:AddSound(MoveSounds.BlackBeard.Grab["Wind and debris hitting car sound effect"], HumRP)
		local StartAnimation = NewAnimLocation.BlackHoleGrab.Miss		

		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		StartEvents["Charge"] = StartTrack:GetMarkerReachedSignal("Charge"):Once(function()
			BodyVelocity.Parent	= HumRP
		end)

		StartEvents["grab"] = StartTrack:GetMarkerReachedSignal("grab"):Once(function()
			print("grab")
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(8, 12, 8) --8, 12, 8
			Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			Hitbox.Ignore = { Character }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if grabHit == true or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead or EnemyCharacter == Character then return end


				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Grab, nil, nil, false, true, true, true, false, nil, 19.5)
				if HitInfo.Countered == true then return end --Simple and easy

				--local Finisher = false --- HitInfo.Finisher == true
				grabHit = true
				local Finisher = HitInfo.Finisher == true


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

				EnemyCharacter:AddTag("CantRotate")

				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -4) * CFrame.Angles(0, math.pi, 0), -1)	
				

				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				

				local UserAnimation = NewAnimLocation.BlackHoleGrab.User
				local VictimAnimation = NewAnimLocation.BlackHoleGrab.Target
				local UserTrack
				local UserEvents = {}

				local VictimTrack
				local VictimEvents = {}
				
				RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "VortexSphere",})
				local WindSound = SoundHandler:AddSound(MoveSounds.BlackBeard.Grab["Bubble Pass By Liquid Whoosh Multiple Versio (SFX)"], HumRP)
				local BlackholeStartup = nil

				UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
				VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				
				if Finisher then
					--print("Finisher")
					UserEvents["end"] = UserTrack:GetMarkerReachedSignal("end"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "finisherHit",})
						
						RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "explode",
							Victim = EnemyCharacter
						})
						
						--SoundHandler:AddSound(MoveSounds.BlackBeard.Grab["Blood Splatter SFX"], EnemyHumRP)
						
						SoundHandler:AddSound(MoveSounds.BlackBeard.Grab.Hit, HumRP)
						SoundHandler:AddSound(MoveSounds.BlackBeard.Grab.Hit2, HumRP)
						SoundHandler:StopSound(WindSound, 1)
						SoundHandler:StopSound(BlackholeStartup, 1)
						SoundHandler:StopSound(WindDebris, 1)
					end)
					
					UserEvents["throw"] = UserTrack:GetMarkerReachedSignal("throw"):Once(function()

						if Weld then
							pcall(function()
								Weld:Stop()
							end)
							Weld = nil
						end
						
						EnemyCharacter:AddTag("DontDoDieFunction")
						
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						EnemyCharacter:RemoveTag("CantRotate")
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						
						DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, true, true, true, nil, nil)

						--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.UpVector * 40 + Vector3.new(0, 20, 30) })
						NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 100000, 100000), Velocity = HumRP.CFrame.LookVector * 50 + Vector3.new(0, 20, 0) })
						--local VelocityObject = Velocity.new(EnemyCharacter);
						--VelocityObject.Settings.RemoveTime = 0.2
						--VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000) --Force
						--VelocityObject.Settings.Velocity = HumRP.CFrame.LookVector * 50 + Vector3.yAxis * 20 --KnockbackVelocity * 40 + Vector3.yAxis * 8.5
						--VelocityObject:Fire()
						
						RagdollHandler.ragdoll(EnemyHumanoid, 2)

						--DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, true, true, true, nil, nil)
						--DamageHandler:TakeDamage(Character, EnemyHumanoid, 6, nil, nil, false, false, true, true, true, nil, nil)
						--task.delay(0.25, function()           -- let the smooth ragdoll/knockback play out first
						--end)
						RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "throw",})

					end)
				else
					--print("Normal")
					UserEvents["end"] = UserTrack:GetMarkerReachedSignal("end"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "finisherHit",})
						SoundHandler:AddSound(MoveSounds.BlackBeard.Grab.Hit, HumRP)
						SoundHandler:AddSound(MoveSounds.BlackBeard.Grab.Hit2, HumRP)
						SoundHandler:StopSound(WindSound, 1)
						SoundHandler:StopSound(BlackholeStartup, 1)
						SoundHandler:StopSound(WindDebris, 1)
					end)
					
					UserEvents["throw"] = UserTrack:GetMarkerReachedSignal("throw"):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "throw",})

						if Weld then
							pcall(function()
								Weld:Stop()
							end)
							Weld = nil
						end

						iFramesService:RemoveAlliFrames(EnemyCharacter)
						EnemyCharacter:RemoveTag("CantRotate")
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						StunHandler:Unstun(EnemyCharacter, EnemyStun)


						DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Throw, nil, nil, false, false, true, true, true, nil, nil)
						--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.UpVector * 40 + Vector3.new(0, 20, 30) })
						--RagdollHandler.ragdoll(EnemyHumanoid, 2)
						--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 100000, 100000), Velocity = HumRP.CFrame.LookVector * 40 + Vector3.new(0, 20, 0) })
						local selfToOtherChar = (EnemyHumRP.Position - HumRP.Position).Unit
						local lookVector = Character.HumanoidRootPart.CFrame.LookVector

						local dotProduct = lookVector:Dot(selfToOtherChar)
						if EnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
							dotProduct = 1
						end

						local at = Character.HumanoidRootPart.Position
						local forward = Character.HumanoidRootPart.CFrame.LookVector
						local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))

						--require(ServerModules.PerfectKnockback).KnockBack(nil, EnemyCharacter, {
						--	LookVector = lookposition.LookVector,
						--	LookForce = 58.5,
						--	LookFinalForce = 55,
						--	LookAt = lookposition,
						--	DestroyRagdoll = true,
						--	GroundStunTime = 0.95,
						--	Escapable = false,
						--	FallingDetectDelay = 0.2,
						--	Dot = dotProduct,
						--	DotParams = {0.4, 1},
						--	canHitWall = true,
						--	--DestroyEnvironment = true,
						--}, Character)
						
						----NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 100000, 100000), Velocity = HumRP.CFrame.LookVector * 50 + Vector3.new(0, 20, 0) })
						local VelocityObject = Velocity.new(EnemyCharacter);
						VelocityObject.Settings.RemoveTime = 0.2
						VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000) --Force
						VelocityObject.Settings.Velocity = HumRP.CFrame.LookVector * 40 + Vector3.yAxis * 18 --KnockbackVelocity * 40 + Vector3.yAxis * 8.5
						VelocityObject:Fire()
						RagdollHandler.ragdoll(EnemyHumanoid, 2)
					end)
				end

			

				local Ended = false
				local function EndFunction()
					task.spawn(function()
						if Ended then return end
						Ended = true


						for _,v in UserEvents do
							v:Disconnect()
						end

						for _,v in VictimEvents do
							v:Disconnect()
						end


						if Weld then
							pcall(function()
								Weld:Stop()
							end)
							Weld = nil
						end
						
						if Stun then 
							StunHandler:Unstun(Character, Stun)
							Stun = nil
						end
						
						iFramesService:RemoveAlliFrames(Character)
						CollisionsModule:SetCollisionGroup(Character, "Players")
					end)
				end

				UserEvents["strongerPull"] = UserTrack:GetMarkerReachedSignal("strongerPull"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "violentPart",})
				end)

				

				UserEvents["charge"] = UserTrack:GetMarkerReachedSignal("charge"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "armAura",})
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
					Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
					task.delay(CooldownTime, function()
						if Player then
							Player:SetAttribute("AbilityThreeCooldown", false)
						end
					end)
					
				end)


				VictimTrack.Stopped:Once(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end

					StunHandler:Unstun(EnemyCharacter, EnemyStun)
					EnemyCharacter:RemoveTag('CantRotate')
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
				end)

				iFramesService:AddBaseiFrames(Character)
				iFramesService:AddBaseiFrames(EnemyCharacter)

				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
				
				BlackholeStartup = SoundHandler:AddSound(MoveSounds.BlackBeard.Grab.blackholestartup, HumRP)

				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })

				Weld:Start(.3, Player)
				
				local EnemyHead = EnemyCharacter:FindFirstChild("Head") or EnemyCharacter:FindFirstChild("HumanoidRootPart")
				local blackHoleAnchor = Instance.new("Attachment")
				blackHoleAnchor.Name = "BlackHoleAnchor"
				blackHoleAnchor.Position = Vector3.new(0, 1, 0)  -- nudge to match your VortexSphere position
				blackHoleAnchor.Parent = EnemyHead
				Debris:AddItem(blackHoleAnchor, 6)

				-- Small rubble around the grabbed enemy gets pulled into the black hole on their head
				DebreeService.Absorb(CFrame.new(blackHoleAnchor.WorldPosition), Vector3.new(20, 20, 20), {
					Target = blackHoleAnchor,
					Attacker = Player,
					RubbleOnly = true,
					MaxPieceSize = 3,
					Style = "Tumble",
				})
				
				local pullAnchor = Instance.new("Attachment")
				pullAnchor.Name = "AbyssalAnchor"
				pullAnchor.Position = Vector3.new(0, 1, 0)
				pullAnchor.Parent = EnemyHead
				Debris:AddItem(pullAnchor, 5)

				RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {
					Attacker = Character, SkillType = "GroundDebris", targetAttachment = pullAnchor,
				})

			end

			Hitbox:Once()
			Hitbox:Destroy()
		end)

		StartTrack.Stopped:Once(function()
			for _,v in StartEvents do
				v:Disconnect()
			end

			if not grabHit then
				--warn("Missed, cleaning up")
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
				iFramesService:RemoveAlliFrames(Character)
				SoundHandler:StopSound(GrabSound, 1)
				SoundHandler:StopSound(WindDebris, 1)
				
				Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					if Player then
						Player:SetAttribute("AbilityThreeCooldown", false)
					end
				end)
			end
		end)


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		RemotesContainer.ClientEffects:FireAllClients("BlackBeardThirdAbility", {Attacker = Character, SkillType =  "start"})
	end
}
