--slashNigiri

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
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)
local PerfectKnockback = require(ServerModules.PerfectKnockback)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)

local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds.Characters.Zoro
local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.ModeMoveSet.Slashes
--local MoveSounds = Sounds.Characters

local ReplicateEffects_Set = RemotesContainer.Replicate.Set
local Animations = ServerStorage.Assets.Animations

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
		if Player:GetAttribute("ModeAbilityThreeCooldown") then return end
		if Character:GetAttribute("ZoroThirdAbility") then return end

		Player:SetAttribute("ModeAbilityThreeCooldown", true)
		Character:SetAttribute("ZoroThirdAbility", true)

		local CooldownTime = 12
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local StartAnimation = NewAnimLocation.User
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		-- Weld target state
		local WeldedCharacter = nil
		local WeldedHumanoid = nil
		local WeldedHumRP = nil
		local WeldedPlayer = nil
		local WeldedStun = nil
		local Weld = nil
		local GrabHit = false  -- did we grab anyone at all
		
		local destructionHandle
		local destructionHandle2
		
		
		local finisherStarted = false
		local cleanedUp = false

		local function finishAbility()
			if cleanedUp then return end
			cleanedUp = true

			-- attacker
			StunHandler:Unstun(Character, Stun)
			iFramesService:RemoveAlliFrames(Character)
			CollisionsModule:SetCollisionGroup(Character, "Players")
			Character:RemoveTag("CantRotate")
			Character:SetAttribute("ZoroThirdAbility", nil)
			
			Player:SetAttribute("ModeAbilityThreeCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then Player:SetAttribute("ModeAbilityThreeCooldown", false) end
			end)

			-- enemy (only if we grabbed one and it still exists)
			if WeldedCharacter and WeldedCharacter.Parent then
				StunHandler:Unstun(WeldedCharacter, WeldedStun)
				iFramesService:RemoveAlliFrames(WeldedCharacter)
				CollisionsModule:SetCollisionGroup(WeldedCharacter, "Players")
				WeldedCharacter:RemoveTag("CantRotate")
			end

			if Weld then pcall(function() Weld:Stop() end); Weld = nil end
			if destructionHandle then destructionHandle:Stop(); destructionHandle = nil end
			if destructionHandle2 then destructionHandle2:Stop(); destructionHandle2 = nil end
		end
		-- ─────────────────────────────────────────────────────────
		-- Helper: AOE slash hitbox around the attacker.
		-- Damages every enemy in range EXCEPT the already-welded target
		-- (the welded target gets hit by the dedicated weld-hit calls).
		-- ─────────────────────────────────────────────────────────
		--local function fireAOESlash(slashIndex, size, offset, damage, knockbackForce, knockbackDir)
		--	local AOEHitbox = HitboxHandler.new()
		--	AOEHitbox.Instance = HumRP
		--	AOEHitbox.Size = size
		--	AOEHitbox.Offset = offset
		--	AOEHitbox.Ignore = { Character }
		--	AOEHitbox.Visualize = false
		--	AOEHitbox.onTouch = function(EnemyCharacter)
		--		-- skip the welded target; they get hit separately
		--		if EnemyCharacter == WeldedCharacter then return end

		--		local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChild("Humanoid")
		--		local EnemyHumRP: BasePart = EnemyCharacter:FindFirstChild("HumanoidRootPart")
		--		if not EnemyHumanoid or EnemyHumanoid.Health <= 0 then return end
		--		if iFramesService:HasiFrame(EnemyCharacter, 2) then return end

		--		local HitInfo = DamageHandler:TakeDamage(
		--			Character, EnemyHumanoid, damage, 0.5,
		--			Animations.Character.Damaged["Damaged" .. tostring(math.random(0, 4))],
		--			true, false, true, true, false, nil, 0   -- was 95
		--		)
		--		if HitInfo.Countered then return end

		--		StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, false)

		--		NewKnockback:Knockback(EnemyCharacter, {
		--			KnockbackType = "Velocity",
		--			MaxForce = Vector3.new(1e5, 1e5, 1e5),
		--			Velocity = (knockbackDir or HumRP.CFrame.LookVector) * knockbackForce
		--		})
		--	end
		--	AOEHitbox:Once()
		--end
		
		-- ─────────────────────────────────────────────────────────
		-- Helper: AOE slash hitbox around the attacker.
		-- Uses HitboxHandler:SimpleOnce (same instant-AOE pattern as Crowd Buster).
		-- Hits every enemy in range EXCEPT the welded target.
		-- ─────────────────────────────────────────────────────────
		local function fireAOESlash(slashIndex, size, offset, damage, knockbackForce, knockbackDir, ragdollTime)
			task.spawn(function()
				-- ignore self + the welded target (it's hit by the dedicated weld calls)
				local ignoreList = { Character }
				if WeldedCharacter then
					table.insert(ignoreList, WeldedCharacter)
				end

				local VoxelParameters = {
					Velocity = HumRP.CFrame.LookVector,
					Multiplier = { 5, 10 },
					Size = size,
					CFrame = HumRP.CFrame * offset
				}

				local DestroyParams = {
					Owner = Player,
					Velocity = -HumRP.CFrame.LookVector * size + Vector3.new(0, 25, 0)
				}

				HitboxHandler:SimpleOnce(HumRP, size, offset, ignoreList, nil, nil, function(EnemyCharacter2: Model)
					local EnemyHumanoid2: Humanoid = EnemyCharacter2:FindFirstChild("Humanoid")
					if not EnemyHumanoid2 or EnemyHumanoid2.Health <= 0 then return end
					if iFramesService:HasiFrame(EnemyCharacter2, 2) then return end

					local AOEHitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid2, damage, nil, nil, true, false, true, true, true, nil, nil)
					if AOEHitInfo.Countered then return end

					if not AOEHitInfo.Blocked then
						RagdollHandler.ragdoll(EnemyHumanoid2, ragdollTime or 1.5)
					end

					NewKnockback:Knockback(EnemyCharacter2, {
						KnockbackType = "Velocity",
						MaxForce = Vector3.new(1e5, 1e5, 1e5),
						Velocity = (knockbackDir or HumRP.CFrame.LookVector) * knockbackForce
					})
				end, DestroyParams, VoxelParameters)
			end)
		end
		

		-- ─────────────────────────────────────────────────────────
		-- Startup grab hitbox  (slash1 marker)
		-- ─────────────────────────────────────────────────────────
		local GrabHitbox = HitboxHandler.new()
		StartEvents["slash1"] = StartTrack:GetMarkerReachedSignal("slash1"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
				Attacker  = Character,
				SkillType = "slash1",
			})
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Used.S7, HumRP)
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Overlay.S1, HumRP)
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Wind.S5, HumRP)
			
			GrabHitbox.Instance = HumRP
			GrabHitbox.Size = Vector3.new(8, 8, 12)
			GrabHitbox.Offset = CFrame.new(0, 0, -6)
			GrabHitbox.Ignore = { Character }
			GrabHitbox.Visualize = false
			GrabHitbox.onTouch = function(EnemyCharacter)
				GrabHitbox:Destroy()

				local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChild("Humanoid")
				local EnemyHumRP: BasePart = EnemyCharacter:FindFirstChild("HumanoidRootPart")
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

				if not EnemyHumanoid or EnemyHumanoid.Health <= 0 then return end
				if iFramesService:HasiFrame(EnemyCharacter, 2) then return end
				if GrabHit then return end

				local HitInfo = DamageHandler:TakeDamage(
					Character, EnemyHumanoid, 6, 0.5,
					Animations.Character.Damaged["Damaged" .. tostring(math.random(0, 4))],
					true, false, true, true, false, nil, 6   -- was 99999
				)
				if HitInfo.Countered then return end

				GrabHit = true
				WeldedCharacter = EnemyCharacter
				WeldedHumanoid = EnemyHumanoid
				WeldedHumRP = EnemyHumRP
				WeldedPlayer = EnemyPlayer

				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
				end

				EnemyCharacter:AddTag("CantRotate")
				--Character:AddTag("CantRotate")

				iFramesService:AddAlliFrames(Character)
				iFramesService:AddAlliFrames(EnemyCharacter)
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "Phasing")

				WeldedStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)

				-- Face enemy same direction as attacker
				local myLook = HumRP.CFrame.LookVector
				local targetPos = EnemyHumRP.Position
				EnemyHumRP.CFrame = CFrame.lookAt(targetPos, targetPos + myLook)

				-- Weld enemy to attacker in front
				Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, 0, 0), -1)
				Weld:Start(nil, EnemyPlayer)

				RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
					Attacker  = Character,
					SkillType = "grabbed",
					Target    = EnemyCharacter,
				})

				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, {
					"ShakeCamera", { Intensity = 5, Last = 0.2 }
				})
			end
			
			GrabHitbox:Start()
			
			-- Continous Destruction Starts Here
			CollisionsModule:SetCollisionGroup(Character, "Phasing")
			--destructionHandle = DestructionHandler.attach(HumRP, {
			--	Size = Vector3.new(15, 7, 10),
			--	Shape = Enum.PartType.Ball,
			--	MaxDuration = 7,
			--	Player = Player,
			--	MinimumSize = 5,
			--	VoxelDestroyChance = .5,
			--	FlingDestroyChance = 1,
			--	Phasing = false,
			--	ExtrapolateWithPing = true,
			--	Shake = true,
			--	IgnoreFloor = true,
			--	Visualize = false,

			--	VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
			--})
		end)

		-- ─────────────────────────────────────────────────────────
		-- Slash 2  — hits welded target + AOE
		-- ─────────────────────────────────────────────────────────
		StartEvents["slash2"] = StartTrack:GetMarkerReachedSignal("slash2"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
				Attacker  = Character,
				SkillType = "slash2",
			})
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Used.S8, HumRP)
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Overlay.S2, HumRP)
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Wind.S10, HumRP)

			-- Hit welded target
			if WeldedCharacter and WeldedHumanoid and WeldedHumanoid.Health > 0 then
				local HitInfo = DamageHandler:TakeDamage(
					Character, WeldedHumanoid, 6, nil, ServerStorage.Assets.Animations.Character.Damaged["Damaged" .. tostring(math.random(0, 4))],
					false, false, true, true, false, nil, 6   -- was 99999
				)
				shared.fireTo(ReplicateEffects_Set, { Player, WeldedPlayer }, {
					"ShakeCamera", { Intensity = 7, Last = 0.2 }
				})
			end

			fireAOESlash("slash2", Vector3.new(15, 8, 15), CFrame.new(0, 0, -6), 4, 30, HumRP.CFrame.LookVector + Vector3.new(0, 0.3, 0))
		end)

		-- ─────────────────────────────────────────────────────────
		-- Slash 3  — hits welded target + AOE
		-- ─────────────────────────────────────────────────────────
		StartEvents["slash3"] = StartTrack:GetMarkerReachedSignal("slash3"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
				Attacker  = Character,
				SkillType = "slash3",
			})
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Used.S9, HumRP)
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Overlay.S3, HumRP)
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Wind.S11, HumRP)

			if WeldedCharacter and WeldedHumanoid and WeldedHumanoid.Health > 0 then
				local HitInfo = DamageHandler:TakeDamage(
					Character, WeldedHumanoid, 6, nil, ServerStorage.Assets.Animations.Character.Damaged["Damaged" .. tostring(math.random(0, 4))],
					false, false, true, true, false, nil, 6   -- was 99999
				)
				shared.fireTo(ReplicateEffects_Set, { Player, WeldedPlayer }, {
					"ShakeCamera", { Intensity = 7, Last = 0.2 }
				})
			end

			fireAOESlash("slash3", Vector3.new(15, 8, 15), CFrame.new(0, 0, -6), 4, 30, HumRP.CFrame.LookVector + Vector3.new(0, 0.3, 0))
		end)

		-- ─────────────────────────────────────────────────────────
		-- Slash 4  — finisher: release weld, knock back welded
		--            target upward, then big final AOE slash
		-- ─────────────────────────────────────────────────────────
		StartEvents["slash4"] = StartTrack:GetMarkerReachedSignal("slash4"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
				Attacker  = Character,
				SkillType = "slash4",
			})
			SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.Used.S4, HumRP)
			
			if WeldedCharacter and WeldedHumanoid and WeldedHumanoid.Health > 0 then
				local HitInfo = DamageHandler:TakeDamage(
					Character, WeldedHumanoid, 8, nil, ServerStorage.Assets.Animations.Character.Damaged["Damaged" .. tostring(math.random(0, 4))],
					false, false, true, true, false, nil, 8   -- was 99999
				)
				shared.fireTo(ReplicateEffects_Set, { Player, WeldedPlayer }, {
					"ShakeCamera", { Intensity = 7, Last = 0.2 }
				})
			end

			-- Release the weld so the enemy flies
			if Weld then
				pcall(function() Weld:Stop() end)
				Weld = nil
			end
			
			if destructionHandle then
				destructionHandle:Stop()
				destructionHandle = nil
			end
			
			-- AOE everyone else first
			fireAOESlash("slash4", Vector3.new(15, 8, 15), CFrame.new(0, 0, -6), 4, 30, HumRP.CFrame.LookVector + Vector3.new(0, 0.3, 0))

			-- Finisher sequence on the welded target
			if WeldedCharacter and WeldedHumanoid and WeldedHumanoid.Health > 0 then
				finisherStarted = true
				local EnemyCharacter = WeldedCharacter
				local EnemyHumanoid  = WeldedHumanoid
				local EnemyHumRP     = WeldedHumRP
				local EnemyPlayer    = WeldedPlayer

				local selfToOtherChar = (EnemyHumRP.Position - HumRP.Position).Unit
				local lookVector = HumRP.CFrame.LookVector
				local dotProduct = lookVector:Dot(selfToOtherChar)
				if EnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
					dotProduct = 1
				end

				local at = HumRP.Position
				local forward = HumRP.CFrame.LookVector
				local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))
				Character:AddTag("CantRotate")
				
				--destructionHandle2 = DestructionHandler.attach(HumRP, {
				--	Size = Vector3.new(15, 10, 5),
				--	Shape = Enum.PartType.Ball,
				--	MaxDuration = 7,
				--	Player = Player,
				--	MinimumSize = 5,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = 1,
				--	Phasing = false,
				--	ExtrapolateWithPing = true,
				--	Shake = true,
				--	IgnoreFloor = true,
				--	VoxelVelocity = HumRP.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
				--})
				
				PerfectKnockback.KnockBack(nil, EnemyCharacter, {
					LookVector = lookposition.LookVector,
					LookForce = 110,
					LookFinalForce = 110,
					LookAt = lookposition,
					DestroyRagdoll = false,
					GroundStunTime = 0.95,
					Escapable = false,
					FallingDetectDelay = 0.2,
					Dot = dotProduct,
					DotParams = { 0.4, 1 },
					canHitWall = true,
					SkipStun = true,
					DestroyEnvironment = true,
				}, Character)
				

				RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
					Attacker  = Character,
					SkillType = "transparent",
					Target    = EnemyCharacter,
				})

				task.wait(0.35)
				SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.S6, HumRP)
				SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.NigiriGP, HumRP)
				SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.dash, HumRP)
				SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.Dash1, HumRP)
				SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.Dash2, HumRP)

				local UserAnimationFinisher   = NewAnimLocation.UserFinisher
				local VictimAnimationFinisher = NewAnimLocation.VictimFinisher

				local VictimTrack            = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimationFinisher)
				local UserTrack, UserEvents  = AnimationService:getAnimationTrack(Character, UserAnimationFinisher)

				UserEvents["slash"] = UserTrack:GetMarkerReachedSignal("slash"):Once(function()
					local HitInfo = DamageHandler:TakeDamage(Character, WeldedHumanoid, 10, nil, ServerStorage.Assets.Animations.Character.Damaged["Damaged" .. tostring(math.random(0, 4))],
						false, false, true, true, true, nil, nil  -- nil = normal finisher threshold
					)
					RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
						Attacker  = Character,
						SkillType = "TowerSlash",
						Target    = EnemyCharacter,
					})
					SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.Nigiri, HumRP)
					SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.Nigiri2, HumRP)
					SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.SwordWind, HumRP)

					task.delay(0.35, function()
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, {
							"ShakeCamera", { Intensity = 13, Last = 0.3 }
						})
						RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
							Attacker  = Character,
							SkillType = "FinalSlash",
							Target    = EnemyCharacter,
						})
						SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.explodeslash, HumRP)
						SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.FinalStab, HumRP)
						SoundHandler:AddSound(Sounds.Moves.ModeSlashMove.FinalNigiri.FinalStab2, HumRP)
						NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 50000), Velocity = HumRP.CFrame.UpVector * 75 })

						RagdollHandler.ragdoll(EnemyHumanoid, 2)
					end)
				end)

				VictimTrack.Stopped:Once(function()
					
				end)

				UserTrack.Stopped:Once(function()	
					if not EnemyCharacter:HasTag("Ragdolled") then -- Cause this removes ragdoll stun early for some reason
						if WeldedStun then
							StunHandler:Unstun(EnemyCharacter, WeldedStun)
							WeldedStun = nil
						end
					end	
					
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					EnemyCharacter:RemoveTag("CantRotate")
					
					finishAbility()
				end)

				RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
					Attacker  = Character,
					SkillType = "NigiriFinisherDash",
					Target    = EnemyCharacter,
				})
				RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
					Attacker  = Character,
					SkillType = "FinisherDashEffect",
					Target    = EnemyCharacter,
				})

				task.wait(0.35)
				AnimationService:stopAll(Character)
				AnimationService:playAnimation(Character, UserAnimationFinisher)

				RemotesContainer.ClientEffects:FireAllClients("SlashNigiri", {
					Attacker  = Character,
					SkillType = "untransparent",
					Target    = EnemyCharacter,
				})
			end
		end)

		-- ─────────────────────────────────────────────────────────
		-- Animation stopped — cleanup if we never finished
		-- ─────────────────────────────────────────────────────────
		StartTrack.Stopped:Once(function()
			if GrabHitbox then
				pcall(function() GrabHitbox:Destroy() end)
			end

			for _, v in StartEvents do
				v:Disconnect()
			end

			-- if slash4 finisher is running, it handles its own cleanup
			if finisherStarted then return end 
			finishAbility()
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		print("Animation played")
	end
}