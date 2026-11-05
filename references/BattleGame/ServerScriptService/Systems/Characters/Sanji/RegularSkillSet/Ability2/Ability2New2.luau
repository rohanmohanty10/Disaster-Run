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

		local StartAnimation = ServerStorage.Assets.Animations.Sanji.NewGrab.New2.Start
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local Container = {}
		
		Janitor:Add(StartTrack:GetMarkerReachedSignal("jump"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "jump2" })

		end))
		Janitor:Add(StartTrack:GetMarkerReachedSignal("land"):Once(function()
			
		end))

		Janitor:Add(StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			HitboxHandler:SimpleOnce(HumRP, Vector3.new(7, 7, 7.5), CFrame.new(0, 0, -14), { Character }, nil, nil, function(Enemy: Model)
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

				local UserAnimation   = ServerStorage.Assets.Animations.Sanji.NewGrab.New2.User
				local VictimAnimation = ServerStorage.Assets.Animations.Sanji.NewGrab.New2.Victim
				local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)

				EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, 0, 0), -1)

				-- FIX #4: store the ragdoll Janitor in the local scope		
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

			
				--table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit2"):Connect(function()
				--	RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "hit2" })

				--end)))
				--table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit3"):Connect(function()
				--	RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "hit3" })

				--end)))
				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit4"):Connect(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "hit4New" })

				end)))
				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit5"):Connect(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "hit5New" })

				end)))
				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("hit6"):Connect(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "hit6" })

					
					
					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * Vector3.new(60, 0 ,60) + Vector3.new(0, -130, 0) })

					RagdollHandler.ragdoll(EnemyHumanoid, 1.4, false)


					DamageHandler:TakeDamage(Character, EnemyHumanoid, math.random(13, 17), nil, nil, false, false, true, true, true, nil, nil)

					ReplicateEffects_Set:FireAllClients("collisionWall", { root = EnemyHumRP,
						NoCrater = "regularSmokeSmash",
						hit = EnemyCharacter,
						caller = Character,
						OnlyCheck = {workspace.World.Map}, --added
						Justdown  = true, --added
					})
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 6, Last = 0.2 } })

				end)))
				
				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("move"):Connect(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "move" })

				end)))

				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("breakWeld"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("SanjiSecondAbility", { Attacker = Character, SkillType = "hit2" })
					
				end)))
				
				table.insert(UserEvents, Janitor:Add(UserTrack:GetMarkerReachedSignal("finalHit"):Once(function()
					if Weld then pcall(function() Weld:Stop() end) Weld = nil end -- keep attacker ownership for a smooth launch
					if not enemyAlive() then return end                                     -- FIX #6

					
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