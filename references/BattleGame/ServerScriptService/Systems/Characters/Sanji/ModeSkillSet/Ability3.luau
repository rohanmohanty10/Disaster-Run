-- Sanji Ability 3
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")
local ServerScriptServices = game:GetService("ServerScriptService")

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
local SoundsModule = require(ServerModules.SoundsModule)
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)
local DiveAim = require(ReplicatedStorage.Modules.DiveAim)

local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)

local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds
local NewAnimLocation = ServerStorage.Assets.Animations.Sanji
local MoveSounds = Sounds.Characters.Sanji

local ReplicateEffects_Set = RemotesContainer.Replicate.Set

local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true


return {
	Start = function(Player: Player)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("ModeAbilityThreeCooldown") then return end

		Player:SetAttribute("ModeAbilityThreeCooldown", true)

		local CooldownTime = 20
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0)
		local idleStarted = false

		Character:SetAttribute("SanjiDiveBomb", workspace:GetServerTimeNow())

		local UserAnimation = NewAnimLocation.Mode.DiveBomb.Jump
		local UserTrack = AnimationService:getAnimationTrack(Character, UserAnimation)
		local UserEvents = {}

		local movemeTest = Instance.new("BodyVelocity")
		movemeTest.Name = "JumpLaunch"
		movemeTest.MaxForce = Vector3.new(0, 100000, 0)
		movemeTest.Velocity = Vector3.new(0, 120, 0)

		local launchHandle = nil

		local activationID = workspace:GetServerTimeNow()
		Character:SetAttribute("DiveActivationID", activationID)
		task.delay(5, function()
			if Character and Character.Parent and Character:GetAttribute("DiveActivationID") == activationID and Character:GetAttribute("SanjiDiveBomb") then
				if idleStarted == false then return end
				local selfModule = require(script)
				selfModule.Release(Player)
			end
		end)

		UserEvents["jump"] = UserTrack:GetMarkerReachedSignal("jump"):Once(function()
			warn("Reached jump")
			if movemeTest then
				--launchHandle = DestructionHandler.attach(HumRP, {
				--	Size = Vector3.new(4.5, 10, 4.5),
				--	Shape = Enum.PartType.Ball,
				--	MaxDuration = 3,
				--	Player = Player,
				--	MinimumSize = 6,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = 1,
				--	Phasing = true,
				--	ExtrapolateWithPing = true,
				--	Shake = true,

				--	VoxelVelocity = function(voxel, hitPos)
				--		local upward = Vector3.new(0, math.random(45, 75), 0)
				--		local rel = voxel.Position - hitPos
				--		local horizontal = Vector3.new(rel.X, 0, rel.Z)
				--		local spread = horizontal.Magnitude > 0
				--			and horizontal.Unit * math.random(25, 45)
				--			or Vector3.new(math.random(-15, 15), 0, math.random(-15, 15))
				--		local jitter = Vector3.new(0, math.random(-10, 20), 0)
				--		return upward + spread + jitter
				--	end,
				--})

				movemeTest.Parent = HumRP
				task.delay(0.4, function()
					if movemeTest and movemeTest.Parent then
						movemeTest:Destroy()
						movemeTest = nil
					end
				end)
			end

			RemotesContainer.ClientEffects:FireAllClients("SanjiDiveBomb", {
				Attacker  = Character,
				SkillType = "Jump",
			})

			SoundHandler:AddSound(MoveSounds.DiveBomb["flame leap"], HumRP)
			SoundHandler:AddSound(MoveSounds.DiveBomb["DiveBombJumpWhoosh"], HumRP)
			SoundHandler:AddSound(MoveSounds.DiveBomb["Whoosh2"], HumRP)
		end)

		UserEvents["float"] = UserTrack:GetMarkerReachedSignal("float"):Once(function()
			warn("Reached float")
			if movemeTest then
				movemeTest:Destroy()
				movemeTest = nil
			end

			if launchHandle then
				launchHandle:Stop()
				launchHandle = nil
			end

			if Character:GetAttribute("IsInAir") then
				RemotesContainer.HoldAimStart:FireClient(Player, "Start")
				Character:SetAttribute("HoldAimStarted", true)
			end

			idleStarted = true

			local IdleAnimation = NewAnimLocation.Mode.DiveBomb.Idle
			local IdleTrack = AnimationService:getAnimationTrack(Character, IdleAnimation)

			IdleTrack.Stopped:Once(function()
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
			end)

			AnimationService:stopAll(Character)
			AnimationService:playAnimation(Character, IdleAnimation)
		end)

		UserTrack.Stopped:Once(function()
			for _,v in UserEvents do
				v:Disconnect()
			end

			if not idleStarted then
				Character:SetAttribute("SanjiDiveBomb", nil)

				Player:SetAttribute("ModeAbilityThreeCooldown", CooldownTime)
				task.delay(CooldownTime, function()
					if Player then
						Player:SetAttribute("ModeAbilityThreeCooldown", false)
					end
				end)

				if movemeTest and movemeTest.Parent then
					movemeTest:Destroy()
				end

				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end

				if launchHandle then
					launchHandle:Stop()
					launchHandle = nil
				end
			end
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, UserAnimation)
	end,

	Release = function(Player: Player)
		warn("In release")
		local Character = Player.Character
		local HumRP:BasePart = Character.HumanoidRootPart

		-- NOTE: do NOT gate on AbilityThreeCooldown here.
		-- Start set it to `true` for the duration of the move, so gating on it
		-- would make Release always bail and freeze the player mid-air.
		-- Being mid-move is gated by SanjiDiveBomb below instead.

		local startTime = Character:GetAttribute("SanjiDiveBomb")
		if not startTime then
			warn("No start time")
			return
		end

		local elapsed = workspace:GetServerTimeNow() - startTime
		local holdDuration = elapsed
		local remaining = 1 - elapsed

		warn("Hold duration: "..holdDuration)

		local function addCooldown()
			local CooldownTime = 20
			if Player.Commands.NoCooldown.Value == true then
				CooldownTime = .5
			end
			Player:SetAttribute("ModeAbilityThreeCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("ModeAbilityThreeCooldown", false)
				end
			end)
		end

		local diveSpeed = 250
		local function doRelease(actualHoldDuration)
			Character:SetAttribute("SanjiDiveBomb", nil)

			if Character:GetAttribute("HoldAimStarted") == true then
				RemotesContainer.HoldAimStart:FireClient(Player, "Stop")
				Character:SetAttribute("HoldAimStarted", false)
				warn("Hold aim gone")
			end

			Character:AddTag("CantRotate")
			local Stun = StunHandler:Stun(Character, nil, true, 5, 0)
			local launchHandle = nil

			Character:SetAttribute("SanjiDiving", true)
			local diveFinalized = false

			local StartAnimation = NewAnimLocation.Mode.DiveBomb.Dive
			local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)

			local flameSound = nil

			local activationID = workspace:GetServerTimeNow()
			Character:SetAttribute("DiveReleaseActivationID", activationID)
			task.delay(6, function()
				if Character and Character.Parent and Character:GetAttribute("DiveReleaseActivationID") == activationID then
					if Character:GetAttribute("SanjiDiving") then
						warn("Failsafe triggered: Stalled 6 seconds.")
						Character:SetAttribute("SanjiDiving", nil)

						if Stun then
							StunHandler:Unstun(Character, Stun)
							Stun = nil
						end
						if launchHandle then
							launchHandle:Stop()
							launchHandle = nil
						end

						Character:RemoveTag("CantRotate")
						RemotesContainer.HoldAimStart:FireClient(Player, "DestroyDiveBV")
						addCooldown() -- ← stall must release the cooldown too
					end
				end
			end)

			local function hitGround(landPos, didHitGround)
				warn("Hit ground")
				local hitboxSize = Vector3.new(20, 20, 20)
				local CFrameToUse = CFrame.new(landPos + Vector3.new(0, hitboxSize.Y / 2, 0))
				
				local landAnchor = Instance.new("Part")
				landAnchor.Name        = "DiveImpactAnchor"
				landAnchor.Anchored    = true
				landAnchor.CanCollide  = false
				landAnchor.CanQuery    = false
				landAnchor.CanTouch = false
				landAnchor.Transparency = 1
				landAnchor.Size        = Vector3.new(1, 1, 1)
				landAnchor.CFrame      = CFrameToUse
				landAnchor.Parent      = workspace.World.Debris
				Debris:AddItem(landAnchor, 5)

				local LandAnimation = NewAnimLocation.Mode.DiveBomb.Landing
				local LandTrack = AnimationService:getAnimationTrack(Character, LandAnimation)
				local LandEvents = {}

				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = landAnchor
				Hitbox.Size = Vector3.new(25, 25, 25)
				Hitbox.Ignore = { Character }
				Hitbox.Visualize = false
				Hitbox.onTouch = function(EnemyCharacter)
					warn("Hit something")
					local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

					if iFramesService:HasiFrame(EnemyCharacter, 2) or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1, nil, nil, false, true, true, true, false, nil, 19.5)
					if HitInfo.Countered == true then return end

					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
					end

					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5 } })

					DamageHandler:TakeDamage(Character, EnemyHumanoid, math.random(13, 17), nil, nil, false, false, true, true, true, nil, nil)

					local KNOCKBACK_HORIZONTAL = 80
					local KNOCKBACK_VERTICAL   = 40

					local away = EnemyHumRP.Position - landAnchor.Position
					local horizontalAway = Vector3.new(away.X, 0, away.Z)
					local outward = horizontalAway.Magnitude > 0
						and horizontalAway.Unit
						or HumRP.CFrame.LookVector

					local knockbackVelocity =
						outward * KNOCKBACK_HORIZONTAL
						+ Vector3.new(0, KNOCKBACK_VERTICAL, 0)

					RagdollHandler.ragdoll(EnemyHumanoid, 1.5)

					NewKnockback:Knockback(EnemyCharacter, {
						KnockbackType = "Velocity",
						MaxForce      = Vector3.new(100000, 50000, 100000),
						Velocity      = knockbackVelocity,
					})
				end

				if didHitGround == true then
					RemotesContainer.ClientEffects:FireAllClients("SanjiDiveBomb", {
						Attacker  = Character,
						SkillType = "GroundVFX",
						Position = landPos,
					})
					for RockValue = 1, 3 do
						local Position = {
							Seed = math.random(1, 8) + RockValue,
							start = CFrameToUse.Position + Vector3.new(0, 0.1, 0),
							["end"] = Vector3.new(0, -14, 0, 0),
							amount = 6 + RockValue / 2,
							nosound = true,
							nosmoke = true,
						}

						local minusValue = false
						if RockValue <= 2 then
							minusValue = { minus = 0 }
						end

						Position.stronger = minusValue
						Position.sizemult = 0.55 * RockValue
						Position.size = 0.85 * RockValue

						ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
					end
					shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 10, Last = 0.4 } })
					SoundHandler:AddSound(MoveSounds.DiveBomb["DiveBombExplosion2"], HumRP)
					SoundHandler:AddSound(MoveSounds.DiveBomb["DiveBombExplosion"], HumRP)
					if flameSound then
						SoundHandler:StopSound(flameSound, 2)
					end

					Hitbox:Once()
					--local results = DestructionHandler.destroy(
					--	Vector3.new(35, 30, 35),
					--	CFrameToUse * CFrame.new(0, -5, 0),
					--	Enum.PartType.Ball,
					--	{
					--		MinimumSize = 4,
					--		TimeToReset = 60,
					--		Player = Player,
					--		VoxelDestroyChance = .7,
					--		FlingDestroyChance = .5,
					--		VoxelVelocity = function(voxel, hitPos)
					--			local outward = voxel.Position - hitPos
					--			outward = outward.Magnitude > 0 and outward.Unit or Vector3.new(0, 1, 0)
					--			return outward * math.random(40, 80) + Vector3.new(0, 20, 0)
					--		end,
					--	}
					--)
				end

				LandEvents["landed"] = LandTrack:GetMarkerReachedSignal("landed"):Once(function()
					warn("Landed hahahah")
					if launchHandle then
						launchHandle:Stop()
						launchHandle = nil
					end
				end)

				LandTrack.Stopped:Once(function()
					for _,v in LandEvents do
						v:Disconnect()
					end

					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end

					if launchHandle then
						launchHandle:Stop()
						launchHandle = nil
					end

					addCooldown()
				end)

				AnimationService:stopAll(Character)
				AnimationService:playAnimation(Character, LandAnimation)

				LandTrack:AdjustSpeed(1.5)
				Character:RemoveTag("CantRotate")
			end

			task.spawn(function()
				local startPos = HumRP.Position
				local diveDir
				local landPos, timeToLand
				local rayResult = nil
				local MAX_RANGE = 150
				local hitSurface = false

				if actualHoldDuration < 1.1 then
					warn("early release")
					local lookVec = HumRP.CFrame.LookVector
					local horizontal = Vector3.new(lookVec.X, 0, lookVec.Z).Unit
					diveDir = (horizontal + Vector3.new(0, -1, 0)).Unit
				else
					diveDir = HumRP.CFrame.LookVector.Unit
				end

				local point, _, distance, surface = DiveAim.resolve(startPos, diveDir, 150)
				landPos = point
				hitSurface = surface
				diveDir = (landPos - startPos).Magnitude > 0 and (landPos - startPos).Unit or diveDir
				timeToLand = distance / diveSpeed

				SoundHandler:AddSound(MoveSounds.DiveBomb["dive whoosh"], HumRP)
				flameSound = SoundHandler:AddSound(MoveSounds.DiveBomb["FlameLoop"], HumRP)

				RemotesContainer.ClientEffects:FireAllClients("SanjiDiveBomb", {
					Attacker  = Character,
					SkillType = "DiveStart",
					Direction = diveDir,
					Speed  = diveSpeed,
					TimeToLand = timeToLand,
				})

				--launchHandle = DestructionHandler.attach(HumRP, {
				--	Size = Vector3.new(10, 10, 10),
				--	Shape = Enum.PartType.Ball,
				--	MaxDuration = 5,
				--	Player = Player,
				--	MinimumSize = 6,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = 1,
				--	LookaheadTime = 0,
				--	MaxLookahead = 15,
				--	Phasing = true,
				--	ExtrapolateWithPing = true,
				--	Shake = true,

				--	Trajectory = function(elapsed)
				--		return CFrame.new(startPos + diveDir * diveSpeed * elapsed)
				--	end,
				--	TrajectoryDir = diveDir,
				--	TrajectorySpeed = diveSpeed,

				--	VoxelVelocity = function(voxel, hitPos)
				--		local forward = diveDir * math.random(50, 90)
				--		local rel = voxel.Position - hitPos
				--		local perp = rel - diveDir * rel:Dot(diveDir)
				--		local spread = perp.Magnitude > 0 and perp.Unit * math.random(15, 30)
				--			or Vector3.new(0, 1, 0) * 10
				--		local up = Vector3.new(0, math.random(15, 25), 0)
				--		return forward + spread + up
				--	end,
				--})

				RemotesContainer.HoldAimStart:FireClient(Player, "Dive", {
					DiveSpeed = diveSpeed,
					ForceDirection = diveDir,
				})

				task.delay(timeToLand, function()
					if not Character.Parent or not HumRP.Parent then return end

					if not Character:GetAttribute("SanjiDiving") then
						warn("Dive was canceled mid-air!")
						return
					end

					diveFinalized = true
					Character:SetAttribute("SanjiDiving", nil)

					RemotesContainer.HoldAimStart:FireClient(Player, "DestroyDiveBV")

					warn("hitGround")
					hitGround(landPos, hitSurface)
				end)
			end)

			StartTrack.Stopped:Once(function()
				if not diveFinalized and Character:GetAttribute("SanjiDiving") then
					RemotesContainer.HoldAimStart:FireClient(Player, "DestroyDiveBV")
					Character:SetAttribute("SanjiDiving", nil)
					if launchHandle then
						launchHandle:Stop()
						launchHandle = nil
					end

					if Stun then
						StunHandler:Unstun(Character, Stun)
						Stun = nil
					end

					Character:RemoveTag("CantRotate")
					if flameSound then
						SoundHandler:StopSound(flameSound, .5)
					end

					addCooldown() -- ← interrupted dive routes through the helper (respects NoCooldown)
				end
			end)

			AnimationService:stopAll(Character)
			AnimationService:playAnimation(Character, StartAnimation)
		end

		if remaining > 0 then
			task.delay(remaining, function()
				if not Character:GetAttribute("SanjiDiveBomb") then return end
				doRelease(holdDuration)
			end)
		else
			if not Character:GetAttribute("SanjiDiveBomb") then return end
			doRelease(holdDuration)
		end
	end,
}