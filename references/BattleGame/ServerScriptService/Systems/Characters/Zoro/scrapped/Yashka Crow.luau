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

local Sounds = ReplicatedStorage.Assets.Sounds
local Animations = ServerStorage.Assets.Animations
--local Models = ServerStorage.Assets.Models


--local Weapons = Models.Weapons

local MoveAnims = Animations.Zoro.Moveset.RegularMoveSet.FirstSkill
local MoveSounds = Sounds.Characters

--local CombatAnims = Animations.Combat
--local CombatSounds = Sounds.Combat


--local ComSet = RemotesContainer.Comunicator.Set
local ComGet = RemotesContainer.Comunicator.Get


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad
--local StartAirDetect = ServerStorage.Bindables.AirDetector

--local Assets = shared.Assets

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



		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)


		local StartAnimation = MoveAnims.MissOld
		local StartTrack, StartEvents = AnimationService:getAnimationTrack(Character, StartAnimation)


		local Hit, Finisher = false, false
		local HitCount = 1



		local secondmoveme = Instance.new("BodyVelocity")
		secondmoveme.MaxForce = Vector3.new(40000, 40000, 40000)
		secondmoveme.Name = "moveme"
		--secondmoveme:SetAttribute("Aerial", 42)
		secondmoveme:SetAttribute("Aerial", 21)

		secondmoveme:SetAttribute("End", 5)
		secondmoveme:SetAttribute("Fallout", 0.92)
		secondmoveme:SetAttribute("Speed", 100)
		
		local movemeTest = Instance.new("BodyVelocity")
		movemeTest.MaxForce = Vector3.new(40000, 40000, 40000)  -- Y must be nonzero for Aerial to work
		movemeTest.Name = "moveme"
		movemeTest:SetAttribute("Speed", 40)       -- forward speed
		movemeTest:SetAttribute("Fallout", 0.99)   -- gentle deceleration
		movemeTest:SetAttribute("Aerial", 45)      -- upward force, decreases each tick
		movemeTest:SetAttribute("AerialDecrease", .5)  -- how fast Aerial drains
		movemeTest:SetAttribute("End", 5)          -- stop when speed hits 5


		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("hit"):Connect(function()
			--task.wait(.05)
			secondmoveme.Parent = HumRP

			HitboxHandler:SimpleOnce(HumRP, Vector3.new(7, 14, 7), CFrame.new(0, 0, -5), { Character }, nil, nil, function(EnemyCharacter: Model)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name)  then return end
				if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2)  then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1.5, nil, nil, false, EnemyCharacter:HasTag('DEATH') and true or false, true, true, false, nil, 15)
				if HitInfo.Countered then return end
				Hit = true


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				EnemyCharacter:AddTag("CantRotate")

				iFramesService:AddAlliFrames(Character)
				iFramesService:AddAlliFrames(EnemyCharacter)

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")


				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0), -1)


				local UserAnimation = MoveAnims.User
				local VictimAnimation = MoveAnims.Victim

				local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)

				ReplicateEffects_Set:FireAllClients("HammerHeelAir", { Char = Character, Stage = "Trails" })

				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("spin"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {Attacker = Character, SkillType =  "spin",})

				end))
				
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("spinStop"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
						Attacker  = Character,
						SkillType = "stopSpin",
					})
				end))
				
				
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slam"):Once(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end
					
					if movemeTest then
						movemeTest:Destroy()
						movemeTest = nil
					end
					RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
						Attacker  = Character,
						SkillType = "slam",
					})

					StunHandler:Unstun(EnemyCharacter, EnemyStun)
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					EnemyCharacter:RemoveTag("CantRotate")

				
					
					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * Vector3.new(60, 0 ,60) + Vector3.new(0, -130, 0) })
					
					RagdollHandler.ragdoll(EnemyHumanoid, 1.4, false)


					DamageHandler:TakeDamage(Character, EnemyHumanoid, math.random(13, 17), nil, nil, false, false, true, true, true, nil, nil)

					--ReplicateEffects_Set:FireAllClients("HammerHeelAir", { Char = Character, Stage = "Throw" })
					ReplicateEffects_Set:FireAllClients("collisionWall", { root = EnemyHumRP,
						NoCrater = "regularSmokeSmash",
						hit = EnemyCharacter,
						caller = Character,
						OnlyCheck = {workspace.World.Map}, --added
						Justdown  = true, --added
					})
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 6, Last = 0.2 } })
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
				end)


				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)
				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
				
				task.delay(.3, function()
					movemeTest.Parent = HumRP

				end)
				
				Weld:Start(nil, Player)


				--ReplicateEffects_Set:FireAllClients("HammerHeelAir", { Char = Character, Target = EnemyCharacter, Stage = "HitSec" })
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 4, Last = 3 } })
			end)
		end))


		StartTrack.Stopped:Once(function()
			

			if secondmoveme then
				task.wait(.2)
				secondmoveme:Destroy()
				secondmoveme = nil
			end
			StunHandler:Unstun(Character, Stun)

			--if not Hit then
			--	StatesHandler.DoEndLag(Player, Stun, 0.3)
			--end
			
			
		end)


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)


		
	end
}