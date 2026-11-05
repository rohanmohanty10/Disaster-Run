-- TacticalAnalysis (server) — core/unblocked, TWO animations (probe -> landed).

local ServerStorage     = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService    = game:GetService("Players")

local ServerModules     = ServerStorage.SBGModules
local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer  = ReplicatedStorage.Remotes

local StunHandler      = require(ServerModules.StunHandler)
local HitboxHandler    = require(ServerModules.HitboxHandler)
local DamageHandler    = require(ServerModules.DamageHandler)
local RagdollHandler   = require(ServerModules.RagdollHandler)
local NewKnockback     = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService   = require(ServerModules.iFramesService)
local CollisionsModule = require(ServerModules.CollisionsModule)
local Trove            = require(ReplicatedModules.Trove)
local SoundHandler = require(ReplicatedModules.SoundHandler)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)

local ClientEffects        = RemotesContainer.ClientEffects
local ReplicateEffects_Set = RemotesContainer.Replicate.Set

local Sounds = ReplicatedStorage.Assets.Sounds
local MoveSounds = Sounds.Characters

-- ===== CONFIG ============================================================

local IndestructibleParams = RaycastParams.new()
IndestructibleParams.FilterType = Enum.RaycastFilterType.Include
IndestructibleParams.FilterDescendantsInstances = { workspace.World.Map["Indestructible Map"] }
IndestructibleParams.RespectCanCollide = true

local WALL_BUFFER = 5

local function getDashDistance(originCF: CFrame, maxDist: number): number
	local result = workspace:Raycast(originCF.Position, originCF.LookVector * maxDist, IndestructibleParams)
	if result then
		return math.max(result.Distance - WALL_BUFFER, 0)
	end
	return maxDist
end



local MOVE_NAME  = "TowerSlash2"
local AnimFolder = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.TowerSlash2 -- TODO
local Animations = ServerStorage.Assets.Animations

local PROBE_ANIM  = AnimFolder.Miss        -- startup/probe   | markers: dash1, vfx, hit1
local LANDED_ANIM = AnimFolder.Landed      -- commit/lunge    | markers: dash2, hit2   -- TODO
--local VICTIM_ANIM = AnimFolder.Victim      -- plays on the enemy on hit                -- TODO

local HITBOX1_SIZE   = Vector3.new(11.25, 7.5, 8.75)
local HITBOX1_OFFSET = CFrame.new(0, 0, -6.25)
local DAMAGE1        = 5

local HITBOX2_SIZE   = Vector3.new(10, 10, 35)
local HITBOX2_OFFSET = CFrame.new(0, 0, -17.5)
local DAMAGE2        = 8
local HIT2_WINDOW    = 0.5
-- =========================================================================

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		if not Character then return end
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityFourCooldown") then return end
		if Character:GetAttribute("ZoroFourthAbility") then return end

		Player:SetAttribute("AbilityFourCooldown", true)
		Character:SetAttribute("ZoroFourthAbility", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end
		local Finisher = false
		local Janitor = Trove.new()
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local landed = false
		local cleaned = false
		local Hit1, Hit2 = {}, {}
		local ProbeEvents, LandedEvents = {}, {}

		local ProbeTrack = AnimationService:getAnimationTrack(Character, PROBE_ANIM)

		local function fx(skillType, extra)
			local data = extra or {}
			data.Attacker  = Character
			data.SkillType = skillType
			ClientEffects:FireAllClients(MOVE_NAME, data)
		end

		local function cleanup()
			--if Finisher then return end
			if cleaned then return end
			cleaned = true
			
			for _, v in ProbeEvents  do v:Disconnect() end
			for _, v in LandedEvents do v:Disconnect() end
			Character:RemoveTag("CantRotate")
			StunHandler:Unstun(Character, Stun)
			--fx("cleanup")
			Janitor:Destroy()
			Character:SetAttribute("ZoroFourthAbility", nil)

			Player:SetAttribute("AbilityFourCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityFourCooldown", false)
				end
			end)
		end

		-- ===== the lunge hitbox (lives on the LANDED anim) =====
		local function startHit2()

			local hbLen = math.max(getDashDistance(HumRP.CFrame, HITBOX2_SIZE.Z), 6)

			local Hitbox = HitboxHandler.new()
			Hitbox.Instance  = HumRP
			Hitbox.Size      = Vector3.new(HITBOX2_SIZE.X, HITBOX2_SIZE.Y, hbLen)  -- CHANGED
			Hitbox.Offset    = CFrame.new(0, 0, -hbLen / 2)                        -- CHANGED
			Hitbox.Ignore    = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChildOfClass("Humanoid")
				local EnemyHumRP: BasePart    = EnemyCharacter:FindFirstChild("HumanoidRootPart")
				if not (EnemyHumanoid and EnemyHumRP) then return end
				if Hit2[EnemyCharacter] or iFramesService:HasiFrame(EnemyCharacter, 2) then return end
				if EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				

				--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, DAMAGE2, nil, nil, false, true, true, true, false, nil, nil)
				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, DAMAGE2, nil, nil, false, true, true, true, false, nil, 8)

				if HitInfo.Countered then return end
				Hit2[EnemyCharacter] = true

				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * 55 + Vector3.new(0, 25, 0) })
				task.delay(0.05, function() RagdollHandler.ragdoll(EnemyHumanoid, 2) end)

				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				fx("hit2", { Position = EnemyHumRP.Position })
				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 3, Last = 0.75 } })
				
				if HitInfo.Finisher then
					DamageHandler:TakeDamage(Character, EnemyHumanoid, EnemyHumanoid.Health, nil, nil, false, false, false, true, true, nil, nil)

				end

				--local p = EnemyHumRP.Position
				--ReplicateEffects_Set:FireAllClients("Ground Crater", {
				--	Seed = math.random(1, 2e9), start = p + Vector3.new(0, 0.1, 0),
				--	["end"] = Vector3.new(0, -14, 0), amount = 5, sizemult = 1.55, size = 1.4, nosound = true,
				--})
			end
			Hitbox:Start()
			task.delay(HIT2_WINDOW, function() pcall(function() Hitbox:Destroy() end) end)
		end

		-- ===== transition into the landed animation (once) =====
		local function onLanded(EnemyCharacter)
			if landed then return end
			landed = true

			-- victim animation on the enemy (synced)
			--pcall(function()
			--	AnimationService:stopAll(EnemyCharacter)
			--	AnimationService:playAnimation(EnemyCharacter, VICTIM_ANIM)
			--end)

			-- stop the probe, play the commit anim
			pcall(function() ProbeTrack:Stop(0.3) end)
			local LandedTrack = AnimationService:getAnimationTrack(Character, LANDED_ANIM)
			SoundHandler:AddSound(MoveSounds.Zoro.Moves.TowerSlash.dash_old, HumRP)
			LandedEvents["dash2"] = LandedTrack:GetMarkerReachedSignal("dash2"):Once(function()
				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
				
				
				--local results = DestructionHandler.destroy(
				--	Vector3.new(10, 10, 45),                           -- CHANGED: was 60
				--	HumRP.CFrame * CFrame.new(0, 2, -(45 / 2 + 5)),
				--	Enum.PartType.Block,
				--	{
				--		MinimumSize = 6, --5.5,
				--		TimeToReset = 30,
				--		Player = Player,
				--		VoxelDestroyChance = .3,
				--		FlingDestroyChance = 1,
				--		VoxelVelocity = HumRP.CFrame.LookVector * 30,
				--		Visualize = false,
				--		IgnoreFloor = true,
				--	}
				--)
				
				
				fx("dash2")
				fx("vfx")
				SoundHandler:AddSound(MoveSounds.Zoro.Moves.TowerSlash.hit, HumRP)

			end)
			SoundHandler:AddSound(MoveSounds.Zoro.Moves.TowerSlash.EnemyHit, HumRP)

			LandedEvents["hit2"] = LandedTrack:GetMarkerReachedSignal("hit2"):Once(startHit2)
			LandedTrack.Stopped:Once(cleanup)

			AnimationService:playAnimation(Character, LANDED_ANIM)
		end

		-- ===== probe animation markers =====
		ProbeEvents["dash1"] = ProbeTrack:GetMarkerReachedSignal("dash1"):Once(function()
			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
			fx("dash1")
			
		end)

		ProbeEvents["vfx"] = ProbeTrack:GetMarkerReachedSignal("vfx"):Once(function()
			--fx("vfx")
		end)

		ProbeEvents["hit1"] = ProbeTrack:GetMarkerReachedSignal("hit1"):Once(function()
			--fx("hit1", { Position = EnemyHumRP.Position })
			print("Hit1 server")
			RemotesContainer.ClientEffects:FireAllClients("TowerSlash2", {Attacker = Character, SkillType =  "hit1"})

			local Hitbox = HitboxHandler.new()
			Hitbox.Instance  = HumRP
			Hitbox.Size      = HITBOX1_SIZE
			Hitbox.Offset    = HITBOX1_OFFSET
			Hitbox.Ignore    = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChildOfClass("Humanoid")
				local EnemyHumRP: BasePart    = EnemyCharacter:FindFirstChild("HumanoidRootPart")
				if not (EnemyHumanoid and EnemyHumRP) then return end
				if Hit1[EnemyCharacter] or iFramesService:HasiFrame(EnemyCharacter, 2) then return end
				if EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end
				if EnemyCharacter:GetAttribute("Ragdolled") then return end

				
				--local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 5, nil, nil, false, true, true, true, false, nil, 15)
				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 3, 0.75, Animations.Character.Damaged["Damaged" ..tostring(math.random(0, 4))], true, true, true, true, false, nil, nil)

				if HitInfo.Countered then return end
				
				if HitInfo.Blocked == true then
					return
				end
				
				Hit1[EnemyCharacter] = true

				-- StunLong: hold them for the followup
				--RemotesContainer.ClientEffects:FireAllClients("TowerSlash2", {Attacker = Character, SkillType =  "vfx"})
				Finisher = HitInfo.Finisher == true
				--if Finisher then
				--	Finisher = true
				--	--shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 6, Last = 0.2 } })


				--	task.delay(1, function()
				--		if EnemyCharacter:HasTag("Ragdolled") then
				--			RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				--		end
				--	end)
					
					
					
				--	EnemyCharacter:AddTag("CantRotate")
				--	Character:AddTag("CantRotate")

				--	iFramesService:AddAlliFrames(Character)
				--	iFramesService:AddAlliFrames(EnemyCharacter)
				--	CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				--	CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")
				--	local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
					
				--	local selfToOtherChar = (EnemyHumRP.Position - HumRP.Position).Unit
				--	local lookVector = Character.HumanoidRootPart.CFrame.LookVector

				--	local dotProduct = lookVector:Dot(selfToOtherChar)
				--	if EnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
				--		dotProduct = 1
				--	end

				--	local at = Character.HumanoidRootPart.Position
				--	local forward = Character.HumanoidRootPart.CFrame.LookVector
				--	local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))

				--	require(ServerModules.PerfectKnockback).KnockBack(nil, EnemyCharacter, {
				--		LookVector = lookposition.LookVector,
				--		LookForce = 58.5,
				--		LookFinalForce = 55,
				--		LookAt = lookposition,
				--		DestroyRagdoll = true,
				--		GroundStunTime = 0.95,
				--		Escapable = false,
				--		FallingDetectDelay = 0.2,
				--		Dot = dotProduct,
				--		DotParams = {0.4, 1},
				--		canHitWall = true
				--	}, Character)

				--	local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.FirstSkill

				--	local UserFinisherStart = NewAnimLocation.Finisher.UserFinisherStart
				--	local VictimFinisher = NewAnimLocation.Finisher.VictimFinisher

				--	local VictimTrackFinisher = AnimationService:getAnimationTrack(EnemyCharacter, VictimFinisher)
				--	local UserTrackFinisher, UserEventsFinisher = AnimationService:getAnimationTrack(Character, UserFinisherStart)

				--	UserEventsFinisher["SwordTransparency"] = UserTrackFinisher:GetMarkerReachedSignal("SwordTransparency"):Once(function()
				--		RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--			Attacker  = Character,
				--			SkillType = "SwordTransparent1", 
				--			Target = EnemyCharacter,
				--		})
				--	end)
				--	UserEventsFinisher["dashstart"] = UserTrackFinisher:GetMarkerReachedSignal("dashstart"):Once(function()
				--		EnemyHumRP.CFrame = CFrame.lookAt(EnemyHumRP.Position, EnemyHumRP.Position - HumRP.CFrame.LookVector)
				--		RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--			Attacker  = Character,
				--			SkillType = "SwordUnTransparent1", 
				--			Target = EnemyCharacter,
				--		})
				--		RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--			Attacker  = Character,
				--			SkillType = "FinisherDash", 
				--			Target = EnemyCharacter,
				--		})

				--	end)
				--	UserEventsFinisher["vicAnim"] = UserTrackFinisher:GetMarkerReachedSignal("vicAnim"):Once(function()
				--		--freeze too
				--		AnimationService:stopAll(EnemyCharacter)
				--		AnimationService:playAnimation(EnemyCharacter, VictimFinisher)
				--		VictimTrackFinisher:AdjustSpeed(0)

				--	end)
				--	UserEventsFinisher["dashend"] = UserTrackFinisher:GetMarkerReachedSignal("dashend"):Once(function()

				--	end)
				--	UserEventsFinisher["stop"] = UserTrackFinisher:GetMarkerReachedSignal("stop"):Once(function()

				--	end)
				--	UserEventsFinisher["SwordTransparent"] = UserTrackFinisher:GetMarkerReachedSignal("SwordTransparent"):Once(function()
				--		RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--			Attacker  = Character,
				--			SkillType = "SwordTransparent1", 
				--			Target = EnemyCharacter,
				--		})
				--	end)
				--	UserEventsFinisher["cutscene"] = UserTrackFinisher:GetMarkerReachedSignal("cutscene"):Once(function()
				--		RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--			Attacker      = Character,
				--			SkillType     = "FinisherCam",
				--			Target        = EnemyCharacter,
				--			TimeBetween   = 2.5,
				--			--StartTime     = 0,
				--			StartTime   = workspace:GetServerTimeNow() - 2.5,
				--		})
				--	end)

				--	UserEventsFinisher["freeze"] = UserTrackFinisher:GetMarkerReachedSignal("freeze"):Once(function()
				--		UserTrackFinisher:AdjustSpeed(0)
				--		task.delay(5, function()
				--			VictimTrackFinisher:AdjustSpeed(1)
				--			UserTrackFinisher:AdjustSpeed(1)

				--		end)
				--		--RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--		--	Attacker  = Character,
				--		--	SkillType = "Finisher", 
				--		--	Target = EnemyCharacter,
				--		--})



				--	end)


				--	VictimTrackFinisher.Stopped:Once(function()
				--		StunHandler:Unstun(EnemyCharacter, EnemyStun)
				--		iFramesService:RemoveAlliFrames(EnemyCharacter)
				--		CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
				--		EnemyCharacter:RemoveTag("CantRotate")

				--	end)

				--	UserTrackFinisher.Stopped:Once(function()
				--		RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--			Attacker  = Character,
				--			SkillType = "SwordUnTransparent1", 
				--			Target = EnemyCharacter,
				--		})
				--		RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--			Attacker  = Character,
				--			SkillType = "SwordDestroy", 
				--			Target = EnemyCharacter,
				--		})
				--		StunHandler:Unstun(Character, Stun)
				--		iFramesService:RemoveAlliFrames(Character)
				--		CollisionsModule:SetCollisionGroup(Character, "Players")
				--		Character:RemoveTag("CantRotate")



				--		for _,v in UserEventsFinisher do
				--			v:Disconnect()
				--		end

				--	end)

				--	--task.wait(1)
				--	task.wait(.3)
				--	AnimationService:stopAll(Character)
				--	--AnimationService:stopAll(EnemyCharacter)

				--	AnimationService:playAnimation(Character, UserFinisherStart)
					
					
				--	--AnimationService:playAnimation(EnemyCharacter, VictimFinisher)
				--	RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--		Attacker  = Character,
				--		SkillType = "SwordTemp",
				--	})
				--	RemotesContainer.ClientEffects:FireAllClients("ZoroFirstAbility", {
				--		Attacker  = Character,
				--		SkillType = "Afterimages",
				--	})
				
				
				--else

					local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
					EnemyCharacter:AddTag("CantRotate")
					task.delay(2, function()
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyCharacter:RemoveTag("CantRotate")
					end)


					onLanded(EnemyCharacter)              -- transition into the landed anim
				--end


				
			end
			Hitbox:Once()
		end)

		-- miss: probe finishes without landing -> just clean up
		ProbeTrack.Stopped:Once(function()
			if not landed then cleanup() end
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, PROBE_ANIM)
		SoundHandler:AddSound(MoveSounds.Zoro.Moves.TowerSlash.start, HumRP)

	end,
}