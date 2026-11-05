--ServerStorage/.../Luffy/GumGumBazooka (server ability)
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
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)

local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds
local MoveSounds = Sounds.Characters

-- adjust to wherever you drop the Bazooka anim
local NewAnimLocation = ServerStorage.Assets.Animations.Luffy.Bazooka

local ReplicateEffects_Set = RemotesContainer.Replicate.Set


return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		if not Character then return end
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityTwoCooldown") then return end
		if Character:GetAttribute("LuffyBazooka") then return end

		Player:SetAttribute("AbilityTwoCooldown", true)
		Character:SetAttribute("LuffyBazooka", true)

		local CooldownTime = 10
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Janitor = Trove.new()

		-- self stun for the whole cast; movement lock like your kick
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		-- multi-target: each enemy can only be caught once by this cast
		local HitList = {}
		local Hitbox = nil

		local StartAnimation = NewAnimLocation.Bazooka
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local function CleanupCast()
			for _, v in StartEvents do
				pcall(function() v:Disconnect() end)
			end
			table.clear(StartEvents)

			if Hitbox then
				pcall(function() Hitbox:Stop() end)
				Hitbox = nil
			end

			if Stun then
				StunHandler:Unstun(Character, Stun)
				pcall(function() Stun:Destroy() end)
				Stun = nil
			end

			Character:SetAttribute("LuffyBazooka", nil)

			-- tell clients to retract the gum arms / reset limb transparency
			--RemotesContainer.ClientEffects:FireAllClients("Bazooka", { Attacker = Character, SkillType = "reset" })

			Janitor:Destroy()
		end

		-- ARMS STRETCH BACK (windup)
		StartEvents["prep"] = StartTrack:GetMarkerReachedSignal("prep"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("Bazooka", { Attacker = Character, SkillType = "prep" })
		end)

		-- PULL / CHARGE just before the thrust
		StartEvents["pull"] = StartTrack:GetMarkerReachedSignal("start"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("Bazooka", { Attacker = Character, SkillType = "start" })
		end)
		
		StartEvents["reset"] = StartTrack:GetMarkerReachedSignal("reset"):Once(function()

			RemotesContainer.ClientEffects:FireAllClients("Bazooka", { Attacker = Character, SkillType = "reset" })
		end)

		-- THRUST FORWARD: open the hitbox for the burst
		StartEvents["shoot"] = StartTrack:GetMarkerReachedSignal("shoot"):Once(function()
			print("shoot")

			RemotesContainer.ClientEffects:FireAllClients("Bazooka", { Attacker = Character, SkillType = "shoot" })
			shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 8, Last = 0.15 } })

			Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(11, 11, 16)
			Hitbox.Offset = CFrame.new(0, 0, -(Hitbox.Size.Z / 2) - 1) -- pushed out in front
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChild("Humanoid")
				local EnemyHumRP: BasePart = EnemyCharacter:FindFirstChild("HumanoidRootPart")
				if not EnemyHumanoid or not EnemyHumRP then return end

				if HitList[EnemyCharacter] then return end
				if iFramesService:HasiFrame(EnemyCharacter, 2) then return end
				if EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if EnemyCharacter:GetAttribute("Ragdolled") then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, math.random(22, 28), nil, nil, false, false, true, true, true, nil, nil)
				if HitInfo.Countered == true then return end
				if HitInfo.Blocked == true then return end

				HitList[EnemyCharacter] = true

				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 9, Last = 0.2 } })

				RagdollHandler.ragdoll(EnemyHumanoid, 2.5, false, Character, nil, nil, true, {
					DestructionAttach = true,
					Size = Vector3.new(12, 12, 12),
					MaxDuration = 2.5,
					Player = Player,
					MinimumSize = 6,
					VoxelDestroyChance = 0,
					FlingDestroyChance = 0,
					ExtrapolateWithPing = true,
					Shake = true,

					LaunchKnockback = {
						KnockbackType = "Velocity",
						MaxForce = Vector3.new(100000, 50000, 100000),
						-- straight-line bazooka launch: hard back + moderate lift
						Velocity = HumRP.CFrame.LookVector * 220 + Vector3.new(0, 55, 0),
					},
					VoxelVelocity = function(voxel, hitPos)
						local outward = voxel.Position - hitPos
						outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
						return outward * math.random(50, 80)
					end,
				})

				-- second-tick lethal check so it kills if the launch already did the work,
				-- same pattern as your Mutton finisher
				task.delay(.1, function()
					if EnemyHumanoid and EnemyHumanoid.Parent then
						DamageHandler:TakeDamage(Character, EnemyHumanoid, 0, nil, nil, false, false, false, true, false, nil, nil)
					end
				end)

				-- wall slam / crater when they collide with the map
				--ReplicateEffects_Set:FireAllClients("collisionWall", {
				--	root = EnemyHumRP,
				--	NoCrater = "LuffyBazookaExplosion",
				--	hit = EnemyCharacter,
				--	caller = Character,
				--	OnlyCheck = { workspace.World.Map.Destroyable.Map },
				--})
			end

			Hitbox:Start()
			task.delay(0.25, function()
				if Hitbox then
					Hitbox:Stop()
					Hitbox = nil
				end
			end)
		end)

		-- arms retract
		StartEvents["end"] = StartTrack:GetMarkerReachedSignal("end"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("Bazooka", { Attacker = Character, SkillType = "end" })
		end)

		StartTrack.Stopped:Once(function()
			CleanupCast()

			Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityTwoCooldown", false)
				end
			end)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)

		-- swap this to your bazooka startup sound
		SoundsModule:PlaySound(MoveSounds.Neon.Mode.headfirst.Start, Character.Torso)
	end
}