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
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedModules.Velocity)

local Sounds = ReplicatedStorage.Assets.Sounds


local NewAnimLocation = ServerStorage.Assets.Animations.Sanji.Up
local initialAnim = NewAnimLocation.InitialHit
local attackerAnim = NewAnimLocation.Attacker

local targetAnim = NewAnimLocation.Target




--local Weapons = Models.Weapons

--local MoveAnims = Animations.Moves
local MoveSounds = Sounds.Characters

--local CombatAnims = Animations.Combat
--local CombatSounds = Sounds.Combat


--local ComSet = RemotesContainer.Comunicator.Set
--local ComGet = RemotesContainer.Comunicator.Get


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad
--local StartAirDetect = ServerStorage.Bindables.AirDetector

--local Assets = shared.Assets

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

--[[
return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		if not Character or not Character.Parent then return end
		local Humanoid: Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
		if not Humanoid or not HumRP or Humanoid.Health <= 0 then return end

		if Player:GetAttribute("AbilityThreeCooldown") then return end
		Player:SetAttribute("AbilityThreeCooldown", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		-- single source of truth for the cooldown
		local cooldownStarted = false
		local function startCooldown()
			if cooldownStarted then return end
			cooldownStarted = true
			Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then Player:SetAttribute("AbilityThreeCooldown", false) end
			end)
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false
		local ragdollApplied = false
		
		local Hitbox = nil
		
		local StartAnimation = initialAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		StartEvents["hit"] = StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(8, 12, 8)
			Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -5)
			Hitbox.Ignore = { Character }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end


				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)
				if HitInfo.Countered == true then return end --Simple and easy

				local Finisher = false --- HitInfo.Finisher == true
				Hit = true


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

				EnemyCharacter:AddTag("CantRotate")

				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -7) * CFrame.Angles(0, math.pi, 0), 10)	
				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				local UserAnimation, VictimAnimation
				local UserTrack
				local UserEvents = {}
				
				local VictimTrack
				local VictimEvents = {}
				
				local moveme

				print("BodyVelocity added")
				
				
				UserAnimation = attackerAnim
				VictimAnimation = targetAnim
				UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
				VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)

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
						
						if moveme then moveme:Destroy() moveme = nil end

						if VictimTrack and VictimTrack.IsPlaying then
							VictimTrack:Stop()
						end
						
						if Stun then
							StunHandler:Unstun(Character, Stun)
							Stun = nil
						end
						
						iFramesService:RemoveAlliFrames(Character)
						CollisionsModule:SetCollisionGroup(Character, "Players")
						
						Player:SetAttribute("AbilityThreeCooldown", CooldownTime)

						task.delay(CooldownTime, function()
							if Player then
								Player:SetAttribute("AbilityThreeCooldown", false)
							end
						end)
					end)
				end

				UserEvents["jump"] = UserTrack:GetMarkerReachedSignal("jump"):Once(function()	
					for RockValue = 1, 2 do
						local Position = {
							Seed = math.random(1, 10) + RockValue, 
							start = HumRP.Position + Vector3.new(0, 0.1, 0, 0), 
							["end"] = Vector3.new(0, -5, 0, 0), 
							amount = 6 + RockValue / 2, 
							nosound = true, 
							nosmoke = RockValue > 2
						}

						local minusValue = false
						if RockValue <= 2 then
							minusValue = {
								minus = 0
							}
						end

						Position.sizemult = 0.25 * RockValue  
						Position.size = 0.5 * RockValue      
						Position.amount = 6 + RockValue / 2                   -- fewer rocks in the ring


						ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
					end
					
					moveme = Instance.new("BodyVelocity")
					moveme.MaxForce = Vector3.new(40000, 0, 40000)
					moveme.Name = "moveme"
					moveme:SetAttribute("End", 1)
					moveme:SetAttribute("Fallout", 0.95)
					moveme:SetAttribute("Speed", 50)
					moveme.Parent = HumRP

					ReplicatedStorage.Remotes.ClientEffects:FireAllClients("SanjiThirdAbility", {Attacker = Character, SkillType =  "jump",})
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 7 } })
				end)

				UserEvents["spin"] = UserTrack:GetMarkerReachedSignal("spin"):Once(function()
					print("spin")
					RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", {Attacker = Character, SkillType =  "spin",})
				end)
				
				UserEvents["senddown"] = UserTrack:GetMarkerReachedSignal("senddown"):Once(function()	
					if moveme then
						moveme:Destroy()
						moveme = nil
						warn("moveme is gone")
					end
					
					if Weld then
						pcall(function()
							Weld:Stop()
							warn("Weld gone")
						end)
						Weld = nil
					end

					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(40000, 4000, 40000), Velocity = HumRP.CFrame.LookVector * 100 })
				end)

				UserEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", {Attacker = Character, SkillType =  "hit"})
				end)
				
				VictimEvents["hitground"] = VictimTrack:GetMarkerReachedSignal("hitground"):Once(function()				
					RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", {Attacker = Character, SkillType =  "hitground", Target = EnemyCharacter})

					SoundHandler:AddSound(MoveSounds.Neon.Mode.headfirst.Slam, HumRP)
					SoundHandler:AddSound(MoveSounds.Neon.Mode.headfirst.SlamExtra, HumRP)
					SoundHandler:AddSound(MoveSounds.Neon.Mode.headfirst.SlamExtraExtra, HumRP)

					for RockValue = 1, 2 do
						local Position = {
							Seed = math.random(1, 10) + RockValue, 
							start = EnemyHumRP.Position + Vector3.new(0, 0.1, 0, 0), 
							["end"] = Vector3.new(0, -14, 0, 0), 
							amount = 6 + RockValue / 2, 
							nosound = true, 
							--nosmoke = RockValue > 2
							nosmoke = true,
						}

						local minusValue = false
						if RockValue <= 2 then
							minusValue = {
								minus = 0
							}
						end

						Position.stronger = minusValue
						Position.sizemult = 0.55 * RockValue
						Position.size = 0.85 * RockValue

						ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
					end
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 8, Last = 0.6 } })

					iFramesService:RemoveAlliFrames(EnemyCharacter)
					
					if EnemyStun then
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyStun = nil
					end
					ragdollApplied = true
					DamageHandler:TakeDamage(Character, EnemyHumanoid, 17.5, nil, nil, false, false, true, true, true, nil, nil)
					RagdollHandler.ragdoll(EnemyHumanoid, 2)
				end)
				
				UserTrack.Stopped:Once(EndFunction)

				VictimTrack.Stopped:Once(function()
					EndFunction()

					if EnemyStun then
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyStun = nil
					end
					
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					if not ragdollApplied then -- let cancelRagdoll own the restore
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						EnemyCharacter:RemoveTag("CantRotate")
					end
				end)

				iFramesService:AddBaseiFrames(Character)
				iFramesService:AddBaseiFrames(EnemyCharacter)

				SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Victim, EnemyCharacter.Torso)
				
				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })

				Weld:Start(nil, Player)
				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
			end

			if Hitbox then
				Hitbox:Once()
			end

			if Hitbox then
				Hitbox:Destroy()
				Hitbox = nil
			end

			RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", {Attacker = Character, SkillType =  "startup",})
		end)

		StartTrack.Stopped:Once(function()
			for _,v in StartEvents do
				v:Disconnect()
			end
			
			if not Hit then
				Character:SetAttribute("SanjiHeadFirst", nil)

				if Hitbox then
					Hitbox:Stop()
					Hitbox:Destroy()
					Hitbox = nil
				end

				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
				
				Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					if Player then
						Player:SetAttribute("AbilityThreeCooldown", false)
					end
				end)
			end
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)


		SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Start, Character.Torso)
		--SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.StartExtra, Character.Torso)
	end
}
]]

local WATCHDOG = 10
return {
	Start = function(Player: Player, Tool: Tool)
		-- FIX #5: validate BEFORE touching any state/cooldown
		local Character = Player.Character
		if not Character or not Character.Parent then return end
		local Humanoid: Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
		if not Humanoid or not HumRP or Humanoid.Health <= 0 then return end

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityThreeCooldown") then return end

		Player:SetAttribute("AbilityThreeCooldown", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false
		local Hitbox = nil
		local Finisher = false

		-- forward-declared grab state (assigned once a target is committed)
		local Weld, EnemyStun, UserTrack, VictimTrack, moveme
		local UserEvents, VictimEvents = {}, {}
		local EnemyCharacter, EnemyHumanoid, EnemyHumRP, EnemyPlayer
		local ragdollApplied = false           -- FIX #1: gates the post-ragdoll restore
		local diedConn, goneConn               -- forward decl so EndFunction can clear them
		
		local launchHandle = nil
		local launchHandleEnemy = nil

		local StartAnimation = initialAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local function enemyAlive()
			return EnemyCharacter and EnemyCharacter.Parent and EnemyHumanoid and EnemyHumanoid.Health > 0
		end

		-- ENEMY cleanup (idempotent). collision/CantRotate restore is gated on ragdollApplied
		-- so it never fights the ragdoll started in hitground.  FIX #1 / #4
		local victimCleaned = false
		local function cleanupVictim()
			if victimCleaned then return end
			victimCleaned = true

			for _, v in VictimEvents do pcall(function() v:Disconnect() end) end
			
			if launchHandleEnemy then
				launchHandleEnemy:Stop()
				launchHandleEnemy = nil
			end

			if Weld then pcall(function() Weld:Stop() end) Weld = nil end
			if EnemyStun then StunHandler:Unstun(EnemyCharacter, EnemyStun) EnemyStun = nil end

			if EnemyCharacter and EnemyCharacter.Parent then
				iFramesService:RemoveAlliFrames(EnemyCharacter)
				if not ragdollApplied then
					--CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					EnemyCharacter:RemoveTag("CantRotate")
				end
			end
		end

		-- ATTACKER cleanup (idempotent). Also resolves the enemy + cooldown.  FIX #2 / #6 / #7
		local attackerCleaned = false
		local function EndFunction()
			if attackerCleaned then return end
			attackerCleaned = true

			--cleanupVictim() -- never leave the enemy locked if the attacker exits first
			if launchHandle then
				launchHandle:Stop()
				launchHandle = nil
			end

			for _, v in StartEvents do pcall(function() v:Disconnect() end) end
			for _, v in UserEvents do pcall(function() v:Disconnect() end) end

			if Hitbox then pcall(function() Hitbox:Stop() Hitbox:Destroy() end) Hitbox = nil end
			if moveme then moveme:Destroy() moveme = nil end
			--if VictimTrack and VictimTrack.IsPlaying then pcall(function() VictimTrack:Stop() end) end

			if Stun then StunHandler:Unstun(Character, Stun) Stun = nil end

			iFramesService:RemoveAlliFrames(Character)
			--CollisionsModule:SetCollisionGroup(Character, "Players")
			Character:RemoveTag("CantRotate")

			if diedConn then diedConn:Disconnect() diedConn = nil end
			if goneConn then goneConn:Disconnect() goneConn = nil end

			--Character:SetAttribute("SanjiThirdAbility", nil)

			Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityThreeCooldown", false)
				end
			end)
		end

		-- FIX #2: failsafes so cleanup runs no matter how the move ends
		diedConn = Humanoid.Died:Connect(EndFunction)
		goneConn = Character.AncestryChanged:Connect(function(_, parent)
			if not parent then EndFunction() end
		end)
		--task.delay(WATCHDOG, EndFunction)

		StartEvents["hit"] = StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(5, 10, 5)
			Hitbox.Offset = CFrame.new(0, (Hitbox.Size.Y / 2) - 3, -Hitbox.Size.Z / 2)
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = true
			Hitbox.onTouch = function(HitChar)
				local hitHumanoid = HitChar:FindFirstChildOfClass("Humanoid")
				if Hit == true or not hitHumanoid or iFramesService:HasiFrame(HitChar, 2) or hitHumanoid.Health <= 0 or hitHumanoid:GetState() == Enum.HumanoidStateType.Dead then
					return
				end

				local HitInfo = DamageHandler:TakeDamage(Character, hitHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)
				if HitInfo.Countered == true then return end
				Hit = true
				
				Finisher = HitInfo.Finisher == true
				
				

				
				-- commit the grab target
				EnemyCharacter = HitChar
				EnemyHumanoid = hitHumanoid
				EnemyHumRP = HitChar.HumanoidRootPart
				EnemyPlayer = PlayersService:GetPlayerFromCharacter(HitChar)

				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				--CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				--CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")
				EnemyCharacter:AddTag("CantRotate")
				Character:AddTag("CantRotate")

				Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -7) * CFrame.Angles(0, math.pi, 0), 10)
				EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				local UserAnimation = attackerAnim
				local VictimAnimation = targetAnim
				UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
				VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)

				-- FIX #2: enemy failsafes (now that the enemy exists)
				table.insert(VictimEvents, EnemyHumanoid.Died:Connect(cleanupVictim))
				table.insert(VictimEvents, EnemyCharacter.AncestryChanged:Connect(function(_, parent)
					if not parent then cleanupVictim() end
				end))

				UserEvents["jump"] = UserTrack:GetMarkerReachedSignal("jump"):Once(function()
					--if Finisher then
					--	Finisher = true
					--	print("Finisher")
					--	RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", { Attacker = Character, SkillType = "FinisherSpin" })

					----else
					--	--RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", { Attacker = Character, SkillType = "spin" })

					--end
					
					for RockValue = 1, 2 do
						local Position = {
							Seed = math.random(1, 10) + RockValue,
							start = HumRP.Position + Vector3.new(0, 0.1, 0),
							["end"] = Vector3.new(0, -5, 0),
							amount = 6 + RockValue / 2,
							nosound = true,
							nosmoke = RockValue > 2,
							sizemult = 0.25 * RockValue,
							size = 0.5 * RockValue,
						}
						ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
					end

					moveme = Instance.new("BodyVelocity")
					moveme.MaxForce = Vector3.new(40000, 0, 40000)
					moveme.Name = "moveme"
					moveme:SetAttribute("End", 1)
					moveme:SetAttribute("Fallout", 0.91)
					moveme:SetAttribute("Speed", 50)
					moveme.Parent = HumRP
					Debris:AddItem(moveme, WATCHDOG) -- FIX #3: backstop; normally killed at senddown/EndFunction

					RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", { Attacker = Character, SkillType = "jump" })
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 7 } })
				end)

				UserEvents["spin"] = UserTrack:GetMarkerReachedSignal("spin"):Once(function()
					--if Finisher then
						--Finisher = true
						--print("Finisher")
						--RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", { Attacker = Character, SkillType = "FinisherSpin" })

					--else
						RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", { Attacker = Character, SkillType = "spin" })
				end)

				UserEvents["senddown"] = UserTrack:GetMarkerReachedSignal("senddown"):Once(function()
					if moveme then moveme:Destroy() moveme = nil end
					if Weld then pcall(function() Weld:Stop() end) Weld = nil end
					if not enemyAlive() then return end -- FIX #5

					--NewKnockback:Knockback(EnemyCharacter, {
					--	KnockbackType = "Velocity",
					--	MaxForce = Vector3.new(40000, 40000, 40000),
					--	Velocity = HumRP.CFrame.LookVector * 20,
					--})
					local MaxForce = Vector3.new(1, 0, 1) * 100000
					local VictimVelocityObject = Velocity.new(EnemyCharacter);
					VictimVelocityObject.Settings.RemoveTime = 0.3
					VictimVelocityObject.Settings.MaxForce = MaxForce
					VictimVelocityObject.Settings.Velocity = HumRP.CFrame.LookVector * 50
					VictimVelocityObject:Fire()
				end)

				UserEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", { Attacker = Character, SkillType = "hit" })
				end)

				VictimEvents["hitground"] = VictimTrack:GetMarkerReachedSignal("hitground"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", { Attacker = Character, SkillType = "hitground", Target = EnemyCharacter })

					SoundHandler:AddSound(MoveSounds.Neon.Mode.headfirst.Slam, HumRP)
					SoundHandler:AddSound(MoveSounds.Neon.Mode.headfirst.SlamExtra, HumRP)
					SoundHandler:AddSound(MoveSounds.Neon.Mode.headfirst.SlamExtraExtra, HumRP)

					--if not enemyAlive() then return end -- FIX #5

					for RockValue = 1, 2 do
						local Position = {
							Seed = math.random(1, 10) + RockValue,
							start = EnemyHumRP.Position + Vector3.new(0, 0.1, 0),
							["end"] = Vector3.new(0, -14, 0),
							amount = 6 + RockValue / 2,
							nosound = true,
							nosmoke = true,
							sizemult = 0.55 * RockValue,
							size = 0.85 * RockValue,
						}
						ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
					end
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 8, Last = 0.6 } })

					iFramesService:RemoveAlliFrames(EnemyCharacter)
					if EnemyStun then StunHandler:Unstun(EnemyCharacter, EnemyStun) EnemyStun = nil end
					Character:RemoveTag("CantRotate")
					if Stun then StunHandler:Unstun(Character, Stun) Stun = nil end

					-- FIX #1: decide who owns the restore BEFORE ragdolling
					-- (precheck avoids both the stopAll race and the NoRagdoll strand)
					--local blocked = workspace.Configuration.NoRagdoll.Value == true or (EnemyPlayer and EnemyPlayer.Commands.NoRagdoll.Value == true)
					ragdollApplied = true
					DamageHandler:TakeDamage(Character, EnemyHumanoid, 17.5, nil, nil, false, false, true, true, true, nil, nil)
					RagdollHandler.ragdoll(EnemyHumanoid, 2)
				end)

				UserTrack.Stopped:Once(EndFunction)
				VictimTrack.Stopped:Once(cleanupVictim)

				iFramesService:AddBaseiFrames(Character)
				iFramesService:AddBaseiFrames(EnemyCharacter)

				SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Victim, EnemyCharacter.Torso)
				--ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)
				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
				Weld:Start(nil, Player)
				
				--launchHandle = DestructionHandler.attach(Character:FindFirstChild("Torso"), {
				--	Size = Vector3.new(8, 8, 8),
				--	Shape = Enum.PartType.Ball,
				--	MaxDuration = 7,
				--	Player = Player,
				--	MinimumSize = 4,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = .7,
				--	Phasing = true,
				--	ExtrapolateWithPing = true,
				--	Shake = true,
				--	IgnoreFloor = true,
					
				--	LookaheadTime = 0,
				--	MaxLookahead = 0,
					
				--	VoxelVelocity = function(voxel, hitPos)
				--		local outward = voxel.Position - hitPos
				--		outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
				--		return outward * math.random(40, 80) + Vector3.new(0, 20, 0)
				--	end,
				--})
				
				--launchHandleEnemy = DestructionHandler.attach(EnemyCharacter:FindFirstChild("Torso"), {
				--	Size = Vector3.new(8, 8, 8),
				--	Shape = Enum.PartType.Ball,
				--	MaxDuration = 7,
				--	Player = EnemyPlayer,
				--	MinimumSize = 4,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = .7,
				--	Phasing = true,
				--	ExtrapolateWithPing = true,
				--	Shake = true,
						
				--	LookaheadTime = 0,
				--	MaxLookahead = 0,
					
				--	VoxelVelocity = function(voxel, hitPos)
				--		local outward = voxel.Position - hitPos
				--		outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
				--		return outward * math.random(40, 80) + Vector3.new(0, 20, 0)
				--	end,
				--	IgnoreFloor = true,
				--})
				
				
			end

			if Hitbox then Hitbox:Once() end
			if Hitbox then Hitbox:Destroy() Hitbox = nil end

			RemotesContainer.ClientEffects:FireAllClients("SanjiThirdAbility", { Attacker = Character, SkillType = "startup" })
		end)

		StartTrack.Stopped:Once(function()
			if not Hit then
				EndFunction() -- miss path: resolves stun + cooldown through one place
			end
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Start, Character.Torso)
	end
}