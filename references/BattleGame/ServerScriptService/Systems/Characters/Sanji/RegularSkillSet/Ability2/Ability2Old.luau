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
--local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds

local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad

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

		if Player:GetAttribute("AbilityTwoCooldown") then return end
		Player:SetAttribute("AbilityTwoCooldown", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		-- single source of truth for the cooldown so every exit path resolves it once
		local cooldownStarted = false
		local function startCooldown()
			if cooldownStarted then return end
			cooldownStarted = true
			Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then Player:SetAttribute("AbilityTwoCooldown", false) end
			end)
		end
		
		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false

		--local initialAnim = NewAnimLocation.Miss

		local StartAnimation = ServerStorage.Assets.Animations.Sanji.NewGrab.Start
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local Assets = {}
		local Container = {}

		table.insert(StartEvents, Janitor:Add(StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			HitboxHandler:SimpleOnce(HumRP, Vector3.new(7, 7, 7.5), CFrame.new(0, 0, -3.5), { Character }, nil, nil, function(EnemyCharacter: Model)
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

				if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyCharacter:FindFirstChild("Ragdolled") then return end
				Hit = true

				if EnemyCharacter:HasTag("Ragdolled") then --Safety
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

				iFramesService:AddAlliFrames(Character)
				iFramesService:AddAlliFrames(EnemyCharacter)


				EnemyCharacter:AddTag("CantRotate")


				local UserAnimation = ServerStorage.Assets.Animations.Sanji.NewGrab.User
				local VictimAnimation = ServerStorage.Assets.Animations.Sanji.NewGrab.Victim

				local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)


				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -6) * CFrame.Angles(0, math.rad(180), 0), -1)

				local cancelFloat = nil
				local movemeTest = Instance.new("BodyVelocity")
				movemeTest.MaxForce = Vector3.new(40000, 40000, 40000)  -- Y must be nonzero for Aerial to work
				movemeTest.Name = "moveme"
				movemeTest:SetAttribute("Speed", 40)       -- forward speed
				movemeTest:SetAttribute("Fallout", 0.95)   -- gentle deceleration
				movemeTest:SetAttribute("End", 5)          -- stop when speed hits 5
				movemeTest.Parent = HumRP

				local movemeTest2 = Instance.new("BodyVelocity")
				movemeTest2.MaxForce = Vector3.new(40000, 40000, 40000)  -- Y must be nonzero for Aerial to work
				movemeTest2.Name = "moveme"
				movemeTest2:SetAttribute("Speed", 50)       -- forward speed
				movemeTest2:SetAttribute("Fallout", 0.99)   -- gentle deceleration
				movemeTest2:SetAttribute("Aerial", 20)      -- upward force, decreases each tick
				movemeTest2:SetAttribute("AerialDecrease", .18)  -- how fast Aerial drains
				movemeTest2:SetAttribute("End", 4)         
				movemeTest2:SetAttribute("EndExclusion", true)
				movemeTest2:SetAttribute("YForceImmunity", true)

				task.delay(3, function()
					if movemeTest and movemeTest.Parent then
						movemeTest:Destroy()
					end

					if movemeTest2 and movemeTest2.Parent then
						movemeTest2:Destroy()
					end
				end)
				
				local noset = false

				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit"):Connect(function() --Looped
					DamageHandler:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, false, true, false, nil, nil)

					if movemeTest and movemeTest.Parent then
						movemeTest:Destroy()
					end

					movemeTest2.Parent = HumRP

					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", {Attacker = Character, SkillType =  "hit1",})
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 2, Last = .1} })
				end)))

				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit2"):Connect(function() --Looped
					--warn("hit2")
					DamageHandler:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, false, true, false, nil, nil)

					--if movemeTest and movemeTest.Parent then
					--	movemeTest:SetAttribute("Aerial", nil)
					--	movemeTest:SetAttribute("AerialDecrease", nil)
					--	movemeTest:SetAttribute("Speed", 35)      -- give it new forward speed
					--	movemeTest:SetAttribute("Fallout", 0.98)
					--	movemeTest:SetAttribute("Float", 2)       -- client locks Y for 2 seconds
					--end
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", {Attacker = Character, SkillType =  "hit2",})
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 2, Last = .1} })
				end)))

				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("barrage"):Connect(function() --Looped
					--warn("barrage")
					DamageHandler:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, false, true, false, nil, nil)

					--if movemeTest and movemeTest.Parent then
					--	movemeTest:SetAttribute("Float", nil)  
					--	movemeTest:SetAttribute("Aerial", 30)
					--	movemeTest:SetAttribute("AerialDecrease", 1)
					--	movemeTest:SetAttribute("Speed", 50)      -- give it new forward speed
					--	movemeTest:SetAttribute("Fallout", 0.98)
					--end
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", {Attacker = Character, SkillType =  "barrage",})

					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 2, Last = .5 } })
				end)))
				
				--table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("breakWeld"):Once(function()
				--	--warn("Reached breakWeld")
					
				--end)))

				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("breakWeld"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", {Attacker = Character, SkillType =  "hit2",})
					--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, nil, nil, false, false, true, true, false, nil, 13)
				
					local launchDir = HumRP.CFrame.LookVector
					
					if Weld then
						pcall(function() Weld:Stop(false, true) end)
						Weld = nil
					end
					
					--if EnemyStun then
					--	StunHandler:Unstun(EnemyCharacter, EnemyStun)
					--	EnemyStun = nil
					--end
					
					--iFramesService:RemoveAlliFrames(EnemyCharacter)
					--EnemyCharacter:RemoveTag("CantRotate")
					--EnemyHumRP.AssemblyLinearVelocity = Vector3.zero
					--EnemyHumRP.AssemblyAngularVelocity = Vector3.zero

					--DamageHandler:TakeDamage(Character, EnemyHumanoid, 4, nil, nil, false, false, false, true, true, nil, nil)
					--RagdollHandler.ragdoll(EnemyHumanoid, 2.25, nil, nil, nil, nil, nil, {
					--	Velocity = launchDir  * 60,
					--	MaxForce = Vector3.new(10000, 10000, 10000),
					--	Time = 0.1,
					--})
					
					--NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(75000, 75000, 75000), Velocity = HumRP.CFrame.LookVector * 60 + Vector3.new(0, 0, 0) })
					local FinalKnockback = Vector3.new(60, 0, 60)
					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = 'Velocity', MaxForce = Vector3.new(10000, 10000, 10000), Velocity = HumRP.CFrame.LookVector * FinalKnockback + Vector3.new(0, 20, 0) })
					RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
					
					noset = true
				end)))


				VictimTrack.Stopped:Once(function()
					warn("Victim Track Stopped")
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
					
					--if not (EnemyCharacter:HasTag("Ragdolled") or EnemyCharacter:GetAttribute("Ragdolled")) then
					if noset == false then
						warn("Ragdolled within animation stop")
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
						EnemyCharacter:RemoveTag("CantRotate")
					end
					--CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					--EnemyCharacter:RemoveTag("CantRotate")
				end)

				UserTrack.Stopped:Once(function()
					for _,v in UserEvents do
						v:Disconnect()
					end
					
					if Janitor then
						pcall(function()
							Janitor:Destroy()
						end)
						Janitor = nil
					end

					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end
					
					--if movemeTest and movemeTest.Parent then movemeTest:Destroy() end
					--if movemeTest2 and movemeTest2.Parent then movemeTest2:Destroy() end
					
					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end
					
					if noset == false then
						if movemeTest and movemeTest.Parent then movemeTest:Destroy() end
						if movemeTest2 and movemeTest2.Parent then movemeTest2:Destroy() end
					end
					
					iFramesService:RemoveAlliFrames(Character)
					CollisionsModule:SetCollisionGroup(Character, "Players")
					Character:RemoveTag("CantRotate")
					
					Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
					task.delay(CooldownTime, function()
						if Player then
							Player:SetAttribute("AbilityTwoCooldown", false)
						end
					end)
				end)

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)
				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
				RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", {Attacker = Character, SkillType =  "hit2",})

				Weld:Start(nil, Player)


				--ReplicateEffects_Set:FireAllClients("BrutalKicks", { Stage = "Hit", Char = Character })
				--SoundsModule:PlaySound(Sounds.Dark["Brutal Kicks"].PlayerStrikes, Character.Torso)
				--SoundsModule:PlaySound(Sounds.Dark["Brutal Kicks"].EnemyStrikes, EnemyCharacter.Torso)

			end)
			
			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 2.5, Last = 0.2})
		end)))


		StartTrack.Stopped:Once(function()
			if not Hit then
				if Janitor then
					pcall(function()
						Janitor:Destroy()
					end)
					Janitor = nil
				end

				StunHandler:Unstun(Character, Stun)
				iFramesService:RemoveAlliFrames(Character)
				
				Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					if Player then
						Player:SetAttribute("AbilityTwoCooldown", false)
					end
				end)
			end
		end)



		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)


		--SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Start, Character.Torso)
		--SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.StartExtra, Character.Torso)
		--RemotesContainer.ClientEffects:FireAllClients("SanjiFirstAbility", {Attacker = Character, SkillType =  "start",})

	end
}
]]

return {
	Start = function(Player: Player, Tool: Tool)
		-- FIX #5: validate BEFORE touching the cooldown, so a nil character can't lock the ability
		local Character = Player.Character
		if not Character or not Character.Parent then return end
		local Humanoid: Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
		if not Humanoid or not HumRP or Humanoid.Health <= 0 then return end

		if Player:GetAttribute("AbilityTwoCooldown") then return end
		Player:SetAttribute("AbilityTwoCooldown", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		-- single source of truth for the cooldown so every exit path resolves it once
		local cooldownStarted = false
		local function startCooldown()
			if cooldownStarted then return end
			cooldownStarted = true
			Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then Player:SetAttribute("AbilityTwoCooldown", false) end
			end)
		end

		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local Hit = false

		-- forward declares shared across the hit callback + cleanup
		local Weld, EnemyStun, UserTrack, UserEvents
		local EnemyCharacter, EnemyHumanoid: Humanoid, EnemyHumRP: BasePart
		local movers = {}              -- FIX #1: track the moveme BVs for guaranteed teardown
		local ragdollApplied = false   -- FIX #4: gates who restores the victim's collision/CantRotate
		local cleanupVictim            -- assigned inside the hit callback

		local attackerCleaned = false
		local function cleanupAttacker()
			if attackerCleaned then return end
			attackerCleaned = true

			if cleanupVictim then cleanupVictim() end  -- FIX #7: don't leave the enemy locked if the attacker exits first

			if UserEvents then
				for _, v in UserEvents do pcall(function() v:Disconnect() end) end
			end

			for _, mv in movers do                     -- FIX #1: kill the moveme BVs the moment the move ends
				if mv and mv.Parent then mv:Destroy() end
			end
			table.clear(movers)

			if Janitor then pcall(function() Janitor:Destroy() end) Janitor = nil end
			if Stun then StunHandler:Unstun(Character, Stun) Stun = nil end

			iFramesService:RemoveAlliFrames(Character)
			CollisionsModule:SetCollisionGroup(Character, "Players")
			Character:RemoveTag("CantRotate")
			startCooldown()
		end

		-- FIX #2: attacker failsafes so cleanup runs even if UserTrack.Stopped never fires
		Janitor:Add(Humanoid.Died:Connect(cleanupAttacker))
		Janitor:Add(Character.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanupAttacker() end
		end))
		task.delay(10, cleanupAttacker) -- hard backstop; combo is well under 10s

		local StartAnimation = ServerStorage.Assets.Animations.Sanji.NewGrab.Start
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local Container = {}

		Janitor:Add(StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			HitboxHandler:SimpleOnce(HumRP, Vector3.new(7, 7, 7.5), CFrame.new(0, 0, -3.5), { Character }, nil, nil, function(Enemy: Model)
				if Hit == true or iFramesService:HasiFrame(Enemy, 2) or Enemy:FindFirstChild("Ragdolled") then return end
				Hit = true

				EnemyCharacter = Enemy
				EnemyHumRP = Enemy.HumanoidRootPart
				EnemyHumanoid = Enemy.Humanoid
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(Enemy)

				-- FIX #6: shared liveness guard for every damage/launch step
				local function enemyAlive()
					return EnemyCharacter and EnemyCharacter.Parent and EnemyHumanoid and EnemyHumanoid.Health > 0
				end

				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")
				iFramesService:AddAlliFrames(Character)
				iFramesService:AddAlliFrames(EnemyCharacter)
				EnemyCharacter:AddTag("CantRotate")

				local UserAnimation   = ServerStorage.Assets.Animations.Sanji.NewGrab.User
				local VictimAnimation = ServerStorage.Assets.Animations.Sanji.NewGrab.Victim
				local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)

				EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -6) * CFrame.Angles(0, math.rad(180), 0), -1)

				-- victim cleanup (idempotent). ragdollApplied gates the collision/CantRotate restore.
				local victimCleaned = false
				cleanupVictim = function()
					if victimCleaned then return end
					victimCleaned = true

					if Weld then pcall(function() Weld:Stop() end) Weld = nil end
					if EnemyStun then StunHandler:Unstun(EnemyCharacter, EnemyStun) EnemyStun = nil end
					if EnemyCharacter and EnemyCharacter.Parent then
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						if not ragdollApplied then -- FIX #4/#7: only restore here if the ragdoll didn't take over
							CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
							EnemyCharacter:RemoveTag("CantRotate")
						end
					end
				end

				-- FIX #3: victim failsafes
				Janitor:Add(EnemyHumanoid.Died:Connect(cleanupVictim))
				Janitor:Add(EnemyCharacter.AncestryChanged:Connect(function(_, parent)
					if not parent then cleanupVictim() end
				end))

				local movemeTest = Instance.new("BodyVelocity")
				movemeTest.MaxForce = Vector3.new(40000, 40000, 40000)
				movemeTest.Name = "moveme"
				movemeTest:SetAttribute("Speed", 40)
				movemeTest:SetAttribute("Fallout", 0.95)
				movemeTest:SetAttribute("End", 5)
				movemeTest.Parent = HumRP
				table.insert(movers, movemeTest)

				local movemeTest2 = Instance.new("BodyVelocity")
				movemeTest2.MaxForce = Vector3.new(40000, 40000, 40000)
				movemeTest2.Name = "moveme"
				movemeTest2:SetAttribute("Speed", 50)
				movemeTest2:SetAttribute("Fallout", 0.99)
				movemeTest2:SetAttribute("Aerial", 20)
				movemeTest2:SetAttribute("AerialDecrease", .18)
				movemeTest2:SetAttribute("End", 4)
				movemeTest2:SetAttribute("EndExclusion", true)
				movemeTest2:SetAttribute("YForceImmunity", true)
				table.insert(movers, movemeTest2)
				-- FIX #1: removed the flat task.delay(3) destroy; cleanupAttacker owns these now

				local function looped(skill, intensity, last)
					if not enemyAlive() then return end
					DamageHandler:TakeDamage(Character, EnemyHumanoid, 2, nil, nil, false, false, false, true, false, nil, nil)
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = skill })
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = intensity, Last = last } })
				end

				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit"):Connect(function()
					if movemeTest and movemeTest.Parent then movemeTest:Destroy() end
					movemeTest2.Parent = HumRP
					looped("hit1", 2, .1)
				end)))
				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit2"):Connect(function()
					looped("hit2", 2, .1)
				end)))
				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("barrage"):Connect(function()
					looped("barrage", 2, .5)
				end)))

				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("breakWeld"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "hit2" })
					movemeTest2:SetAttribute("Speed", 0)
				end)))
				
				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("finalHit"):Once(function()
					if Weld then pcall(function() Weld:Stop() end) Weld = nil end -- keep attacker ownership for a smooth launch
					if not enemyAlive() then return end                                     -- FIX #6

					-- FIX #4: decide ragdollApplied from the SAME conditions ragdoll() checks, BEFORE calling it,
					-- so there's no race with VictimTrack.Stopped and no stranded enemy when NoRagdoll is on.
					--local blocked = workspace.Configuration.NoRagdoll.Value == true
					--	or (EnemyPlayer and EnemyPlayer.Commands.NoRagdoll.Value == true)
					--EnemyHumRP:SetNetworkOwner(nil)
					ragdollApplied = true --not blocked

					local FinalKnockback = Vector3.new(60, 0, 60)

					--RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true, true)
					RagdollHandler.ragdoll(EnemyHumanoid, 2)


					NewKnockback:Knockback(EnemyCharacter, {
						KnockbackType = "Velocity",
						MaxForce = Vector3.new(10000, 10000, 10000),
						Velocity = HumRP.CFrame.LookVector * FinalKnockback + Vector3.new(0, 20, 0),
					})
				end)))


				VictimTrack.Stopped:Once(cleanupVictim) -- FIX #3/#7: routed through the guarded function
				UserTrack.Stopped:Once(cleanupAttacker) -- FIX #2: routed through the guarded function

				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)
				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
				RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "hit2" })

				Weld:Start(nil, Player)
			end)

			ReplicateEffects_Set:FireClient(Player, "ShakeCamera", { Intensity = 2.5, Last = 0.2 })
		end))

		StartTrack.Stopped:Once(function()
			if not Hit then cleanupAttacker() end -- FIX #2/#5: miss path resolves cooldown + state through one place
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
	end
}