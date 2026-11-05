local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).BlackBeard[1]
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
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)

local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Velocity = require(ReplicatedStorage.Modules.Velocity)

local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds

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

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid
		if not (Character and Humanoid and HumRP) or Humanoid.Health <= 0 then
			return
		end
		local Animator: Animator = Humanoid.Animator

		if Character:HasTag("Stunned") then
			return
		end
		if Player:GetAttribute("AbilityOneCooldown") then
			return
		end

		local TargetParams = RaycastParams.new()
		TargetParams.FilterType = Enum.RaycastFilterType.Include
		TargetParams.FilterDescendantsInstances = { workspace.World.Live }

		-- 2. CAST THE RAY (35 Studs Forward)
		local rayOrigin = HumRP.Position
		local rayDirection = HumRP.CFrame.LookVector * 50
		local rayResult = workspace:Spherecast(rayOrigin, 2, rayDirection, TargetParams)
		-- 3. VALIDATION CHECK
		local EnemyCharacter = nil
		if rayResult and rayResult.Instance then
			local HitModel = rayResult.Instance:FindFirstAncestorOfClass("Model")
			if HitModel and HitModel:FindFirstChild("Humanoid") then
				-- Optional: Check if they are already i-framed or dead
				if not iFramesService:HasiFrame(HitModel, 2) and HitModel.Humanoid.Health > 0 then
					EnemyCharacter = HitModel
					RemotesContainer.ClientEffects:FireAllClients(
						"BlackBeardFirstAbility",
						{ Attacker = Character, SkillType = "pullEffect", EnemyCharacter = EnemyCharacter }
					)
				end
			end
		end

		-- 4. THE "ALL OR NOTHING" RETURN
		if not EnemyCharacter then
			warn("No target found in range. Move cancelled.")
			return
		end

		Player:SetAttribute("AbilityOneCooldown", true)
		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local EnemyStun
		
		Character:AddTag("CantRotate")
		
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		BodyVelocity:SetAttribute("Speed", 40)
		BodyVelocity:SetAttribute("Fallout", 0.97)
		BodyVelocity:SetAttribute("End", 5)

		--local Hit = false
		local grabHit = false
		local pullGrabReached = false
		local pullDestructionHandle = nil

		local Janitor = Trove.new()
		
		local function doGrab(EnemyCharacter)
			local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
			if EnemyCharacter == Character
				or iFramesService:HasiFrame(EnemyCharacter, 2)
				or EnemyHumanoid.Health <= 0
				or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
			then
				return
			end

			if grabHit == true
				or iFramesService:HasiFrame(EnemyCharacter, 2)
				or EnemyHumanoid.Health <= 0
				or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
			then
				return
			end

			local HitInfo = DamageHandler:TakeDamage(
				Character,
				EnemyHumanoid,
				MoveConfig.Damage.Grab,
				nil,
				nil,
				false,
				true,
				true,
				true,
				false,
				nil,
				nil
			)
			if HitInfo.Countered == true then
				return
			end

			if EnemyCharacter:HasTag("Ragdolled") then
				RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
			end

			grabHit = true

			EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

			CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
			CollisionsModule:SetCollisionGroup(EnemyCharacter, "NoCol")

			Character:RemoveTag("CantRotate")
			EnemyCharacter:AddTag("CantRotate")

			local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -4) * CFrame.Angles(0, math.rad(180), 0), -1) --* CFrame.Angles(0, math.pi, 0), 10)

			local UserAnimation = NewAnimLocation["Abyssal Vortex"].UserNew
			local VictimAnimation = NewAnimLocation["Abyssal Vortex"].TargetNewer
			local UserTrack
			local UserEvents = {}

			local VictimTrack
			local VictimEvents = {}

			UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
			VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)

			local Ended = false
			local function EndFunction()
				task.spawn(function()
					if Ended then
						return
					end
					Ended = true

					for _, v in UserEvents do
						v:Disconnect()
					end

					for _, v in VictimEvents do
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

			UserEvents["hit1"] = UserTrack:GetMarkerReachedSignal("hit1"):Once(function()
				RemotesContainer.ClientEffects:FireAllClients(
					"BlackBeardFirstAbility",
					{ Attacker = Character, SkillType = "newHit", Enemy = EnemyCharacter }
				)
				SoundHandler:AddSound(MoveSounds.BlackBeard.Abyss.HitsFolder["Ga Hit 2"], HumRP)
			end)

			UserEvents["hit2"] = UserTrack:GetMarkerReachedSignal("hit2"):Once(function()
				RemotesContainer.ClientEffects:FireAllClients(
					"BlackBeardFirstAbility",
					{ Attacker = Character, SkillType = "newHit", Enemy = EnemyCharacter }
				)
				SoundHandler:AddSound(MoveSounds.BlackBeard.Abyss.HitsFolder["Ga Hit 3"], HumRP)
			end)

			UserEvents["move"] = UserTrack:GetMarkerReachedSignal("move"):Once(function()
				print("move")
				RemotesContainer.ClientEffects:FireAllClients(
					"BlackBeardFirstAbility",
					{ Attacker = Character, SkillType = "rightArmAura", Enemy = EnemyCharacter }
				)

				BodyVelocity.Parent = HumRP
			end)

			UserEvents["slam"] = UserTrack:GetMarkerReachedSignal("slam"):Once(function()
				--CollisionsModule:SetCollisionGroup(Character, "Players")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

				if BodyVelocity then
					BodyVelocity:Destroy()
					BodyVelocity = nil
				end

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
				iFramesService:RemoveAlliFrames(Character)

				AnimationService:stopAnimation(EnemyCharacter, NewAnimLocation["Abyssal Vortex"].TargetNewer, 0.1)

				DamageHandler:TakeDamage(
					Character,
					EnemyHumanoid,
					MoveConfig.Damage.Slam,
					nil,
					nil,
					false,
					false,
					true,
					true,
					true,
					nil,
					nil
				)

				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 10 } })
				SoundHandler:AddSound(MoveSounds.BlackBeard.FirstSkillOld["Ground Slam JJS"], HumRP)
				--SoundHandler:AddSound(MoveSounds.BlackBeard.FirstSkill.SlamExtraExtra, HumRP)

				local VelocityObject = Velocity.new(EnemyCharacter)
				--VelocityObject.Settings.Duration = 0.6
				VelocityObject.Settings.RemoveTime = 0.2
				VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000) --Force
				VelocityObject.Settings.Velocity = HumRP.CFrame.UpVector * 50 -- + Vector3.yAxis * 8.5 --KnockbackVelocity * 40 + Vector3.yAxis * 8.5
				--VelocityObject.Settings.Controllable = true
				--VelocityObject.Settings.Z = 60
				VelocityObject.Settings.Spin = Vector3.new(
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2
				).Unit * 8
				VelocityObject:Fire()

				RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)
				
				RemotesContainer.ClientEffects:FireAllClients(
					"BlackBeardFirstAbility",
					{ Attacker = Character, SkillType = "finalHit", Enemy = EnemyCharacter }
				)
				
				task.spawn(function()
					--ReplicateEffects_Set:FireAllClients("Ground Crater", { start = Character.PrimaryPart.Position, Seed = math.random(1,2147483647), ["end"] = Vector3.new(0, -7, 0), nosound = true })
					ReplicateEffects_Set:FireAllClients("Ground Crater", {
						["end"] = Vector3.new(0, -17, 0),
						start = (Character.PrimaryPart.CFrame * CFrame.new(0, 0, -3)).Position,
						Seed = math.random(1, 2147483647),
						size = 2,
						nosound = true,
						nosmoke = true, 
					})
					RemotesContainer.ClientEffects:FireAllClients(
						"BlackBeardFirstAbility",
						{ Attacker = Character, SkillType = "FinalRockDebree" }
					)
				end)

				--DestructionHandler.destroy(
				--	Vector3.new(25, 25, 25),
				--	HumRP.CFrame * CFrame.new(0, 8, -3),
				--	Enum.PartType.Ball,
				--	{
				--		MinimumSize = 5,
				--		TimeToReset = 60,
				--		Player = Player,
				--		VoxelDestroyChance = 0.6,
				--		FlingDestroyChance = 1,
				--		VoxelVelocity = function(voxel, hitPos)
				--			local outward = voxel.Position - hitPos
				--			outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
				--			return outward * math.random(40, 80) + Vector3.new(0, 20, 0)
				--		end,
				--		IgnoreFloor = true,
				--	}
				--)

			end)

			UserTrack.Stopped:Once(function()
				for _, v in UserEvents do
					v:Disconnect()
				end

				if Weld then
					pcall(function()
						Weld:Stop()
					end)
					Weld = nil
				end

				if BodyVelocity then
					BodyVelocity:Destroy()
					BodyVelocity = nil
				end

				Character:RemoveTag("CantRotate")

				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end

				iFramesService:RemoveAlliFrames(Character)
				CollisionsModule:SetCollisionGroup(Character, "Players")

				Player:SetAttribute("AbilityOneCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					Player:SetAttribute("AbilityOneCooldown", false)
				end)
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
					EnemyStun = nil
				end

				iFramesService:RemoveAlliFrames(EnemyCharacter)

				if not EnemyCharacter:HasTag("Ragdolled") then
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					EnemyCharacter:RemoveTag("CantRotate")
				end
			end)

			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

			iFramesService:AddBaseiFrames(Character)
			iFramesService:AddBaseiFrames(EnemyCharacter)

			AnimationService:stopAll(Character)
			AnimationService:stopAll(EnemyCharacter)
			AnimationService:playAnimation(Character, UserAnimation)
			AnimationService:playAnimation(EnemyCharacter, VictimAnimation)
			--task.delay(.13, function()
			--	--SoundHandler:AddSound(MoveSounds.BlackBeard.Abyss.Hits, HumRP)
			--end)
			SoundHandler:AddSound(MoveSounds.BlackBeard.Abyss.EndPull, HumRP)

			shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 2 } })
			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardFirstAbility",
				{ Attacker = Character, SkillType = "leftArmAura", Enemy = EnemyCharacter }
			)

			--Weld:Start(0.5, Player)
			Weld:Start(0.15, Player)

		end

		local function PullEnemy(EnemyCharacter)
			local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
			local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
			local EnemyHRP = EnemyCharacter.HumanoidRootPart

			Character:SetAttribute("VortexGrabbedVfxEnd", true)
			task.delay(0.15, function()
				Character:SetAttribute("VortexGrabbedVfxEnd", false)
				Character:SetAttribute("VortexGrabbedVfxEnd", nil)
			end)

			if EnemyCharacter == Character
				or iFramesService:HasiFrame(EnemyCharacter, 2)
				or EnemyHumanoid.Health <= 0
				or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
			then
				return false
			end

			if pullGrabReached == true
				or iFramesService:HasiFrame(EnemyCharacter, 2)
				or EnemyHumanoid.Health <= 0
				or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
			then
				return false
			end

			local HitInfo = DamageHandler:TakeDamage(
				Character,
				EnemyHumanoid,
				MoveConfig.Damage.PullGrab,
				nil,
				nil,
				true, -- Blockable: a blocking target denies the pull (was false = unblockable)
				true,
				true,
				true,
				false,
				nil,
				nil
			)
			if HitInfo.Blocked == true or HitInfo.Countered == true then
				return false
			end

			EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0)

			EnemyCharacter:AddTag("CantRotate")

			pcall(function() EnemyHRP:SetNetworkOwner(Player) end)

			local AttackerAttachment = Instance.new("Attachment")
			AttackerAttachment.Name = "PullAttachment"
			AttackerAttachment.Position = Vector3.new(0, 0, -3) -- 3 studs in front
			AttackerAttachment.Parent = HumRP -- Your RootPart

			local distance = (HumRP.Position - EnemyHRP.Position).Magnitude
			local pullSpeed = 30 -- Studs per second
			local travelTime = distance / pullSpeed --20/200

			-- 3. Create an Attachment on the Enemy
			local EnemyAttachment = Instance.new("Attachment")
			EnemyAttachment.Parent = EnemyHRP

			-- 4. Use AlignPosition to "Pull" them to your attachment
			local AlignPos = Instance.new("AlignPosition")
			AlignPos.Mode = Enum.PositionAlignmentMode.TwoAttachment
			AlignPos.Attachment0 = EnemyAttachment
			AlignPos.Attachment1 = AttackerAttachment
			AlignPos.MaxForce = 1000000 -- High force for a strong pull
			AlignPos.Responsiveness = 20 -- How "snappy" the pull is (higher = faster)
			AlignPos.Parent = EnemyHRP

			local lookDir = HumRP.CFrame.LookVector
			local flat = Vector3.new(lookDir.X, 0, lookDir.Z)
			flat = (flat.Magnitude > 1e-4) and flat.Unit or Vector3.new(0, 0, -1)
			local goalCF = CFrame.lookAt(EnemyHRP.Position, EnemyHRP.Position - flat)

			local AlignOrient = Instance.new("AlignOrientation")
			AlignOrient.Mode = Enum.OrientationAlignmentMode.OneAttachment
			AlignOrient.Attachment0 = EnemyAttachment
			AlignOrient.CFrame = goalCF -- only the rotation part is used in OneAttachment mode
			AlignOrient.RigidityEnabled = false -- snap & hold exactly; set false + tune torque if you want easing
			AlignOrient.MaxTorque = 1000
			AlignOrient.Responsiveness = 13
			AlignOrient.MaxAngularVelocity = 5
			AlignOrient.Parent = EnemyHRP

			--RagdollHandler.ragdoll(EnemyHumanoid, 2)
			RagdollHandler.ragdoll(EnemyHumanoid, 2.25, false, Character, nil, nil, true, {
				DestructionAttach = true, -- ← add this; it's what your handler checks
				Size = Vector3.new(5, 5, 5),
				MaxDuration = 2.25,
				Player = EnemyPlayer,
				MinimumSize = 2,
				VoxelDestroyChance = 0.5,
				FlingDestroyChance = 0,
				ExtrapolateWithPing = true,
				Shake = true,
				IgnoreFloor = true,

				--VoxelVelocity = HumRP.CFrame.LookVector * 10 + Vector3.new(0, 10, 0),
				VoxelVelocity = function(voxel, hitPos)
					local outward = voxel.Position - hitPos
					outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)

					local linear = outward * math.random(60, 100) + Vector3.new(0, 20, 0)
					local angular = Vector3.new(math.random(-20, 20), math.random(-20, 20), math.random(-20, 20))
					return linear, angular
				end,
				
				Cosmetic = true, -- Only for ragdoll not attach stuff.
			})

			task.delay(0.6, function()
				RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				if EnemyCharacter and EnemyCharacter.Parent then
					task.delay(0.1, function()
						AttackerAttachment:Destroy()
						EnemyAttachment:Destroy()
						AlignPos:Destroy()
						AlignOrient:Destroy()

						if pullDestructionHandle then
							pullDestructionHandle:Stop()
							pullDestructionHandle = nil
						end

						pullGrabReached = true
						doGrab(EnemyCharacter)
					end)
				end
			end)
			AnimationService:stopAll(EnemyCharacter)
			RemotesContainer.ClientEffects:FireAllClients(
				"BlackBeardFirstAbility",
				{ Attacker = Character, SkillType = "EnemyPulledRocks", EnemyCharacter = EnemyCharacter }
			)

			return true
		end

		local StartAnimation = NewAnimLocation["Abyssal Vortex"].Miss

		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		StartEvents["vfx"] = StartTrack:GetMarkerReachedSignal("vfx"):Once(function()
			StartTrack:AdjustSpeed(0.2)
			local didPull = PullEnemy(EnemyCharacter)

			if didPull ~= true then
				local BLOCKED_ENDLAG = 0.55
				StartTrack:AdjustSpeed(1)
				task.delay(BLOCKED_ENDLAG, function()
					if pullGrabReached ~= true and StartTrack.IsPlaying then
						StartTrack:Stop(0.2)
					end
				end)
			end
		end)

		StartTrack.Stopped:Once(function()
			for _, v in StartEvents do
				v:Disconnect()
			end
			if pullGrabReached ~= true then
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end

				Player:SetAttribute("AbilityOneCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					Player:SetAttribute("AbilityOneCooldown", false)
				end)
			end
			iFramesService:RemoveAlliFrames(Character)
			Character:RemoveTag("CantRotate")
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		StartTrack:AdjustSpeed(2)

		RemotesContainer.ClientEffects:FireAllClients(
			"BlackBeardFirstAbility",
			{ Attacker = Character, SkillType = "Vortex" }
		)
		
		RemotesContainer.ClientEffects:FireAllClients(
			"BlackBeardFirstAbility",
			{ Attacker = Character, SkillType = "VortexOrbSpawn" }
		)

		local debrisList = {
			{
				Vector3.new(30, 0, 30),
				Vector3.new(0, 45, 0),
				Color3.fromRGB(100, 100, 100),
				Enum.Material.Slate,
				Vector3.new(2, 2, 2),
			},
			{
				Vector3.new(-30, 0, -30),
				Vector3.new(10, 0, 5),
				Color3.fromRGB(100, 100, 100),
				Enum.Material.Slate,
				Vector3.new(1, 1, 1),
			},
		}

		local pullAnchor = Instance.new("Attachment")
		pullAnchor.Name = "AbyssalAnchor"
		pullAnchor.Position = Vector3.new(0, 0, -6)
		pullAnchor.Parent = HumRP
		Debris:AddItem(pullAnchor, 5)

		RemotesContainer.ClientEffects:FireAllClients(
			"BlackBeardFirstAbility",
			{ Attacker = Character, SkillType = "Rocks", debrisList = debrisList, targetAttachment = pullAnchor }
		)
		SoundHandler:AddSound(MoveSounds.BlackBeard.Abyss.Pull, HumRP)
		SoundHandler:AddSound(MoveSounds.BlackBeard.G.KurozuStart, HumRP)

		-- Rubble already lying in front of Blackbeard gets pulled into the vortex (walls aren't broken)
		DebreeService.Absorb(HumRP.CFrame * CFrame.new(0, 0, -15), Vector3.new(25, 20, 40), {
			Target = pullAnchor,
			Attacker = Player,
			RubbleOnly = true,
			Style = "Fast",
		})
	end,
}
