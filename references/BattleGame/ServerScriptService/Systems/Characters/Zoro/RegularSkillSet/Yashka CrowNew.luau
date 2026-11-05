local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Zoro[1]
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
local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.FirstSkill

local MoveAnims = Animations.Zoro.Moveset.RegularMoveSet.FirstSkill
local MoveSounds = Sounds.Characters

--local CombatAnims = Animations.Combat
--local CombatSounds = Sounds.Combat


--local ComSet = RemotesContainer.Comunicator.Set
local ComGet = RemotesContainer.Comunicator.Get


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

local loopedSound1 = nil
local loopedSound2 = nil



return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		
		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityOneCooldown") then return end
		if Character:GetAttribute("ZoroFirstAbility") then return end

		Player:SetAttribute("AbilityOneCooldown", true)
		Character:SetAttribute("ZoroFirstAbility", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)


		local StartAnimation = MoveAnims.MissOld
		local StartTrack, StartEvents = AnimationService:getAnimationTrack(Character, StartAnimation)


		local Hit, Finisher = false, false
		local HitCount = 1



		--local secondmoveme = Instance.new("BodyVelocity")
		--secondmoveme.MaxForce = Vector3.new(40000, 40000, 40000)
		--secondmoveme.Name = "moveme"
		--secondmoveme:SetAttribute("Aerial", 21)
		--secondmoveme:SetAttribute("End", 5)
		--secondmoveme:SetAttribute("Fallout", 0.92)
		--secondmoveme:SetAttribute("Speed", 100)

		local movemeTest = Instance.new("BodyVelocity")
		movemeTest.MaxForce = Vector3.new(40000, 40000, 40000)
		movemeTest.Name = "moveme"
		movemeTest:SetAttribute("Speed", 40)
		movemeTest:SetAttribute("Fallout", 0.99)
		movemeTest:SetAttribute("Aerial", 22.5) -- half the old 45 (and half the decay), so half the height over the same time
		movemeTest:SetAttribute("AerialDecrease", .25)
		movemeTest:SetAttribute("End", 5)


		table.insert(StartEvents, StartTrack:GetMarkerReachedSignal("hit"):Connect(function()
			--secondmoveme.Parent = HumRP

			-- ── Always play UserAnimation and fire VFX regardless of hit ──
			local UserAnimation = MoveAnims.User
			local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)

			RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", { Attacker = Character, SkillType = "trails" })
			table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("spin"):Once(function()
				RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", { Attacker = Character, SkillType = "spin" })
				loopedSound1 = 	SoundHandler:AddSound(MoveSounds.Zoro.Moves.Crow.loop, HumRP)
				loopedSound2 = 	SoundHandler:AddSound(MoveSounds.Zoro.Moves.Crow.GroundScrape, HumRP)


			end))

			table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("spinStop"):Once(function()
				RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
					Attacker  = Character,
					SkillType = "stopSpin",
				})
				--loopedSound = SoundHandler:StopSound(MoveSounds.Zoro.Moves.Crow.loop, HumRP)
				SoundHandler:StopSound(loopedSound1, .1)
				SoundHandler:StopSound(loopedSound2, .2)
				task.delay(.2, function()
					loopedSound2 = nil
					loopedSound1 = nil

				end)

				--SoundHandler:AddSound(MoveSounds.Zoro.Moves.Crow.endsound, HumRP)
			end))

			-- slam marker: only do enemy stuff if Hit is true
			table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slam"):Once(function()
				RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
					Attacker  = Character,
					SkillType = "slam",
				})
				SoundHandler:AddSound(MoveSounds.Zoro.Moves.Crow.Woosh, HumRP)

				
				
				if movemeTest then
					movemeTest:Destroy()
					movemeTest = nil
				end
				--task.delay(0, function()
					RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
						Attacker  = Character,
						SkillType = "up",
					})
				--end)
			end))

			UserTrack.Stopped:Once(function()
				--if Finisher then return end
				
				StunHandler:Unstun(Character, Stun)
				iFramesService:RemoveAlliFrames(Character)
				CollisionsModule:SetCollisionGroup(Character, "Players")
				
				for _,v in UserEvents do
					v:Disconnect()
				end
				
				Character:SetAttribute("ZoroFirstAbility", nil)

				Player:SetAttribute("AbilityOneCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					if Player then
						Player:SetAttribute("AbilityOneCooldown", false)
					end
				end)
			end)

			AnimationService:stopAll(Character)
			AnimationService:playAnimation(Character, UserAnimation)

			--task.delay(.3, function()
				--if movemeTest then
					movemeTest.Parent = HumRP
				--end
			--end)

			-- ── Hitbox: enemy-specific logic only runs if someone is hit ──
			HitboxHandler:SimpleOnce(HumRP, Vector3.new(7, 14, 7), CFrame.new(0, 0, -5), { Character }, nil, nil, function(EnemyCharacter: Model)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2) then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Grab, nil, nil, false, EnemyCharacter:HasTag('DEATH') and true or false, true, true, false, nil, 15)
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

				local VictimAnimation = MoveAnims.Victim
				local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)

				-- quick hits while they're carried up, until the slam
				local Slammed = false
				task.spawn(function()
					for _ = 1, MoveConfig.MaxTicks do
						task.wait(MoveConfig.TickInterval)
						if Slammed or not Weld or EnemyHumanoid.Health <= 0 then break end
						DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Tick, nil, nil, false, false, true, true, false, nil, nil)
					end
				end)

				-- override the slam handler now that we have an enemy
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slam"):Once(function()
					Slammed = true
					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, MoveConfig.Damage.Slam, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, 10)
					Finisher = HitInfo.Finisher == true
					
					
					
					if Weld then
						pcall(function() Weld:Stop() end)
						Weld = nil
					end

					StunHandler:Unstun(EnemyCharacter, EnemyStun)
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					EnemyCharacter:RemoveTag("CantRotate")

					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * Vector3.new(60, 0, 60) + Vector3.new(0, -130, 0) })

					RagdollHandler.ragdoll(EnemyHumanoid, 1.4, false)

					--DamageHandler:TakeDamage(Character, EnemyHumanoid, math.random(13, 17), nil, nil, false, false, true, true, true, nil, nil)

					ReplicateEffects_Set:FireAllClients("collisionWall", {
						root = EnemyHumRP,
						NoCrater = "regularSmokeSmash",
						hit = EnemyCharacter,
						caller = Character,
						OnlyCheck = { workspace.World.Map },
						Justdown = true,
					})
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 6, Last = 0.2 } })
					if Finisher then
						DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, false, true, true, nil, nil)

					end
						
					
					
				end))

				VictimTrack.Stopped:Once(function()
					if Weld then
						pcall(function() Weld:Stop() end)
						Weld = nil
					end
					

					StunHandler:Unstun(EnemyCharacter, EnemyStun)
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					EnemyCharacter:RemoveTag("CantRotate")
				end)

				AnimationService:stopAll(EnemyCharacter)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)

				Weld:Start(nil, Player)

				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 4, Last = 3 } })
			end)
		end))


		StartTrack.Stopped:Once(function()
			--if secondmoveme then
			--	task.wait(.2)
			--	secondmoveme:Destroy()
			--	secondmoveme = nil
			--end
			--StunHandler:Unstun(Character, Stun)
		end)


		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		SoundHandler:AddSound(MoveSounds.Zoro.Moves.Crow.start, HumRP)

	end
}