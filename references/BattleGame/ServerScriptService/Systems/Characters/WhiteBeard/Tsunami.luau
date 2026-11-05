local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).WhiteBeard.Ult
--WhiteBeard Tsunami — SERVER ability module.
--
--Two tsunamis spawn from opposite edges of the map, converge on the point the player
--cast at (their mouse position), and collide there in a final AoE burst.
--
--The VISUAL is fire-and-forget: for each wave the server fires ONE ClientEffects event
--carrying the wave's whole path + timing (Start, Target, Direction, Speed, Duration).
--Your existing tsunami effect animates itself along that path. The server never streams
--per-frame positions — instead it steps a matching box hitbox along the EXACT same path
--at the EXACT same speed, so the water you see and the damage you take stay in sync.
--
--Wire it in like the other WhiteBeard skills, e.g. from WhiteBeard.luau:
--   function WhiteBeard.<Slot>(character, cooldown, damage, extra)
--       require(script.RegularSkillSet.Tsunami).Start(game.Players:GetPlayerFromCharacter(character))
--   end
--(If you hook it into a numbered slot, change COOLDOWN_ATTRIBUTE below to that slot's
-- attribute — e.g. "AbilityFourCooldown" — so the client cooldown UI matches.)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local ServerModules = ServerStorage.SBGModules
local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer = ReplicatedStorage.Remotes
local SoundHandler = require(ReplicatedStorage.Modules.SoundHandler)

local StunHandler = require(ServerModules.StunHandler)
local HitboxHandler = require(ServerModules.HitboxHandler)
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local iFramesService = require(ServerModules.iFramesService)
local StatesHandler = require(ServerModules.StatesHandler)
local AnimationService = require(ServerModules.AnimationService)
local Velocity = require(ReplicatedModules.Velocity)
local DebreeService = require(ServerModules.DebreeService)
local ClientEffects = RemotesContainer.ClientEffects
local ReplicateEffects_Set = RemotesContainer.Replicate.Set

local WBSounds = ReplicatedStorage.Assets.Sounds.Characters.WhiteBeard

--------------------------------------------------------------------------------
-- Tuning
--------------------------------------------------------------------------------
local COOLDOWN = .5              -- seconds
local COOLDOWN_ATTRIBUTE = "TsunamiCooldown" -- change to the slot's attribute if wired into 1-4


local SPAWN_DISTANCE = 800       -- how far out from the cast point each wave spawns ("across the map")
local WAVE_SPEED = 120            -- studs / second (both waves; keep === your effect's travel speed)
local WAVE_SIZE = Vector3.new(235, 120, 157) -- width (across travel), height, depth (along travel)
local WAVE_MAX_LIFETIME = (SPAWN_DISTANCE / WAVE_SPEED) + 10 -- safety cleanup

-- Per-wave hit (as the wall sweeps over you)
local WAVE_DAMAGE = MoveConfig.Damage.Wave
local WAVE_RAGDOLL_TIME = 2.5
local WAVE_KB_FORWARD = 55       -- pushed along the wave's travel direction
local WAVE_KB_UP = 18

-- Collision burst (where the two waves meet)
local BURST_RADIUS = 34
local BURST_DAMAGE = MoveConfig.Damage.Burst
local BURST_RAGDOLL_TIME = 3
local BURST_KB_OUT = 60          -- launched away from the collision point
local BURST_KB_UP = 55

-- Set this to the registered Name of YOUR tsunami effect ModuleScript
-- (the one cached under ReplicatedStorage.Modules.ClientEffects...). It receives the
-- payload table built in launchWaves() below — adapt those keys to whatever it reads.

local DEBUG_VISUALIZE = true   -- draw hitboxes (Studio only; replicates parts to every player when on)

-- Map destruction is prepared once per cast by DebreeService.PrepareTsunami.
-- Character hitboxes below remain independent from map destruction.

--------------------------------------------------------------------------------
-- Params / helpers
--------------------------------------------------------------------------------
-- Ground-only downward ray so the wall hugs the terrain under it.
local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map.Destroyable.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

local GROUND_RAY_UP = Vector3.new(0, 80, 0)
local GROUND_RAY_DOWN = Vector3.new(0, -500, 0)

local function GroundYAt(position: Vector3): number
	local result = workspace:Raycast(position + GROUND_RAY_UP, GROUND_RAY_DOWN, MapRayParams)
	return result and result.Position.Y or position.Y
end

--------------------------------------------------------------------------------
-- Damage application
--------------------------------------------------------------------------------
-- One target, hit by a passing wave. `dir` is that wave's horizontal travel direction.
local function applyWaveHit(Player: Player, Character: Model, EnemyCharacter: Model, dir: Vector3)
	local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChild("Humanoid")
	local EnemyHumRP: BasePart = EnemyCharacter:FindFirstChild("HumanoidRootPart")
	if not EnemyHumanoid or not EnemyHumRP then return end

	if EnemyCharacter == Character
		or iFramesService:HasiFrame(EnemyCharacter, 2)
		or EnemyHumanoid.Health <= 0
		or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
	then
		return
	end

	local HitInfo = DamageHandler:TakeDamage(
		Character, EnemyHumanoid, WAVE_DAMAGE,
		nil, nil,        -- StunTime, Animation
		true,            -- Blockable
		true,            -- Counterable
		true,            -- bypassStunImmunity
		true,            -- addAwkProgress
		true,           -- doFinisher
		nil, nil         -- Type, FinisherRequirement
	)
	if HitInfo and HitInfo.Countered == true then return end

	if EnemyCharacter:HasTag("Ragdolled") then
		RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
	end

	local VelocityObject = Velocity.new(EnemyCharacter)
	VelocityObject.Settings.RemoveTime = 0.25
	VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000)
	VelocityObject.Settings.Velocity = dir * WAVE_KB_FORWARD + Vector3.yAxis * WAVE_KB_UP
	VelocityObject:Fire()

	RagdollHandler.ragdoll(EnemyHumanoid, WAVE_RAGDOLL_TIME, nil, nil, nil, nil, true)

	local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
	if EnemyPlayer then
		shared.fireTo(ReplicateEffects_Set, { EnemyPlayer }, { "ShakeCamera", { Intensity = 4 } })
	end
end

-- The final AoE where the two waves meet. Called once.
local function collideBurst(Player: Player, Character: Model, centerPos: Vector3, axis: Vector3)
	shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 8, Last = 0.35 } })
	
	local rayStart = centerPos + Vector3.new(0, 80, 0)
	local result = workspace:Raycast(rayStart, Vector3.new(0, -500, 0), MapRayParams)
	
	ClientEffects:FireAllClients("WhiteBeardTsunami", {
		SkillType = "collide",
		Attacker  = Character,
		Position  = centerPos,
		Axis      = axis,   -- the line the two waves travel along
		PuddlePos = result and result.Position or centerPos
	})
	
	--SoundHandler:AddSound(WBSounds["Sea Quake"].Collision1, centerPos)
	SoundHandler:AddSound(WBSounds["Sea Quake"].Collision2, centerPos)
	SoundHandler:AddSound(WBSounds["Sea Quake"].Collision3, centerPos)
	
	--DebreeService.Destroy(CFrame.new(result and result.Position or centerPos), Vector3.new(40, 40, 40), {
	--	Shape = "Ball",
	--	Outward = true,
	--	Power = 40,
	--	Lift = 15,
	--	Bounce = 25,
	--	Attacker = Player,
	--})
	
	local Hitbox = HitboxHandler.new()
	Hitbox.Instance = CFrame.lookAlong(centerPos, axis)
	Hitbox.Size = Vector3.new(250, 200, 100)
	--Hitbox.Offset = CFrame.new(0, 0, 0)
	Hitbox.Visualize = DEBUG_VISUALIZE
	Hitbox.Ignore = {Character}
	Hitbox.onTouch = function(EnemyCharacter)
		local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChild("Humanoid")
		local EnemyHumRP: BasePart = EnemyCharacter:FindFirstChild("HumanoidRootPart")
		if not EnemyHumanoid or not EnemyHumRP then return end

		if EnemyCharacter == Character
			or iFramesService:HasiFrame(EnemyCharacter, 2)
			or EnemyHumanoid.Health <= 0
			or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
		then
			return
		end

		local HitInfo = DamageHandler:TakeDamage(
			Character, EnemyHumanoid, BURST_DAMAGE,
			nil, nil,    -- StunTime, Animation
			false,       -- Blockable (the collision breaks through blocks)
			false,       -- Counterable
			true,        -- bypassStunImmunity
			true,        -- addAwkProgress
			true,       -- doFinisher
			nil, nil
		)
		if HitInfo and HitInfo.Countered == true then return end

		if EnemyCharacter:HasTag("Ragdolled") then
			RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
		end

		-- Launch outward from the collision point (+ up).
		local away = EnemyHumRP.Position - centerPos
		away = Vector3.new(away.X, 0, away.Z)
		away = away.Magnitude > 0.001 and away.Unit or Character.HumanoidRootPart.CFrame.LookVector

		local VelocityObject = Velocity.new(EnemyCharacter)
		VelocityObject.Settings.RemoveTime = 0.3
		VelocityObject.Settings.MaxForce = Vector3.new(200000, 200000, 200000)
		VelocityObject.Settings.Velocity = away * BURST_KB_OUT + Vector3.yAxis * BURST_KB_UP
		VelocityObject.Settings.Spin = Vector3.new(
			(math.random() - 0.5) * 2,
			(math.random() - 0.5) * 2,
			(math.random() - 0.5) * 2
		).Unit * 8
		VelocityObject:Fire()

		RagdollHandler.ragdoll(EnemyHumanoid, BURST_RAGDOLL_TIME, nil, nil, nil, nil, true)
	end
	
	Hitbox:Once()
	Hitbox:Destroy()
end

--------------------------------------------------------------------------------
-- One moving wave: an oriented box hitbox stepped from `startPos` to `targetPos`
-- at WAVE_SPEED. Returns a stop() that halts + cleans it up. Calls onArrive() when
-- it reaches the target under its own power.
--------------------------------------------------------------------------------
local function spawnWave(Player: Player, Character: Model, startPos: Vector3, targetPos: Vector3, dir: Vector3, onArrive: () -> (), startedAt: number)
	local hitbox = HitboxHandler.new()
	hitbox.Size = WAVE_SIZE
	hitbox.Ignore = { Character }
	hitbox.Visualize = DEBUG_VISUALIZE
	-- HitType left default (nil) so the whole width of the wall hits everyone it overlaps,
	-- not just the closest. Each wave only hits a given target once (HitboxHandler tracks it).
	hitbox.onTouch = function(EnemyCharacter)
		applyWaveHit(Player, Character, EnemyCharacter, dir)
	end

	-- A follower the sounds ride on. Anchored, non-collidable, invisible.
	local follower = Instance.new("Part")
	follower.Anchored = true
	follower.CanCollide = false
	follower.CanQuery = false
	follower.CanTouch = false
	follower.Transparency = 1
	follower.Size = Vector3.one
	follower.CFrame = CFrame.new(startPos)
	follower.Parent = workspace.World.Visuals
	Debris:AddItem(follower, WAVE_MAX_LIFETIME)

	local totalDist=(targetPos-startPos).Magnitude
	local travelled,stopped=0,false
	local conn
	local function stop()
		if stopped then return end
		stopped=true
		if conn then conn:Disconnect() end
		hitbox:Destroy()
	end
	conn=RunService.Heartbeat:Connect(function(dt)
		if stopped then return end
		travelled=math.clamp((workspace:GetServerTimeNow()-startedAt)*WAVE_SPEED,0,totalDist)
		local pos=startPos:Lerp(targetPos,travelled/math.max(totalDist,0.001))
		hitbox.Instance=CFrame.lookAlong(pos,dir)
		hitbox:Once()
		follower.CFrame=CFrame.new(pos)
		if travelled>=totalDist-30 then stop();if onArrive then onArrive() end end
	end)

	local WindSound = SoundHandler:AddSound(WBSounds["Sea Quake"].Wind, follower)
	local WaterSound = 	SoundHandler:AddSound(WBSounds["Sea Quake"].WaterSFX, follower)


	task.delay(8, function()
		SoundHandler:StopSound(WindSound, 1)
		SoundHandler:StopSound(WaterSound, 1)
	end)
	
	SoundHandler:AddSound(WBSounds["Sea Quake"].Tsunami, follower)
	
	return stop
end

--------------------------------------------------------------------------------
return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player and Player.Character
		if not Character then return end

		local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
		local Humanoid: Humanoid = Character:FindFirstChild("Humanoid")
		if not HumRP or not Humanoid then return end

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute(COOLDOWN_ATTRIBUTE) then return end
		Player:SetAttribute(COOLDOWN_ATTRIBUTE, true)

		local CooldownTime = COOLDOWN
		local Commands = Player:FindFirstChild("Commands")
		if Commands and Commands:FindFirstChild("NoCooldown") and Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end

		local StartAnimation: AnimationTrack = ServerStorage.Assets.Animations.WhiteBeard["Tsunami"].User
		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		-- Cast lock (rooted through the windup + a short recover).
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local finished = false
		local dontStopSound = false
		local mapCast
		local waveCommitted=false
		local waveStops = {}
		local removedConn
		
		local soundPart = Instance.new("Part")
		soundPart.Anchored = true
		soundPart.CanCollide = false
		soundPart.CanQuery = false
		soundPart.CanTouch = false
		soundPart.Transparency = 1
		soundPart.Size = Vector3.one
		soundPart.CFrame = HumRP.CFrame
		soundPart.Parent = workspace.World.Visuals
		Debris:AddItem(soundPart, 15)
		
		SoundHandler:AddSound(WBSounds["Sea Quake"]["gura_lmb3_sfx"], soundPart)
		local punchSFX = SoundHandler:AddSound(WBSounds["Sea Quake"].gura_quake_punch_sfx, soundPart)
		task.delay(2.3, function()
			if punchSFX and punchSFX.Parent then
				SoundHandler:StopSound(punchSFX, .2)
			end
		end)
		
		local Bind = Instance.new("StringValue")
		Bind.Parent = Character
		Bind.Name = "Sea Quake"
		
		local function finish()
			if finished then return end
			finished = true
			if mapCast and not waveCommitted then mapCast:Cancel() end
			
			for _, v in StartEvents do
				v:Disconnect()
			end
			if not waveCommitted then
				for _,stop in waveStops do stop() end
				table.clear(waveStops)
			end
			if removedConn then
				removedConn:Disconnect()
				removedConn = nil
			end
			if punchSFX and punchSFX.Parent then
				if not dontStopSound then
					SoundHandler:StopSound(punchSFX, .2)
				end
			end
			if soundPart then
				if not dontStopSound then
					soundPart:Destroy()
					soundPart = nil
				end
			end
			task.delay(.5, function()
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
			end)
			if Bind then 
				Bind:Destroy()
				Bind = nil
			end
		end
		
		removedConn = Character.AncestryChanged:Connect(function(_, parent)
			if not parent then finish() end
		end)
		
		-- Cooldown runs from the moment of casting (the caster is free after the recover).
		Player:SetAttribute(COOLDOWN_ATTRIBUTE, CooldownTime)
		task.delay(CooldownTime, function()
			if Player and Player.Parent then
				Player:SetAttribute(COOLDOWN_ATTRIBUTE, false)
			end
		end)
		
		StartEvents["orb"] = UserTrack:GetMarkerReachedSignal("orb"):Once(function()
			ClientEffects:FireAllClients("WhiteBeardTsunami", {
				SkillType = "Startup",
				Attacker  = Character,
				Bind = Bind,
			})
			
			SoundHandler:AddSound(WBSounds["Startup Sounds"]["GuraUlt"], HumRP)
		end)

		
		StartEvents["presound"] = UserTrack:GetMarkerReachedSignal("presound"):Once(function()
			local earthQuakeSFX = SoundHandler:AddSound(WBSounds["Sea Quake"]["Gura Earthquake2"], soundPart)
		
			task.delay(4.5, function()
				SoundHandler:StopSound(earthQuakeSFX, .8)
			end)
		end)

		-- Optional cast windup visual / sound (add your own if you have one), e.g.
		-- ClientEffects:FireAllClients(EFFECT_NAME, { SkillType = "cast", Attacker = Character, Target = TargetPos })
		-- Hard safety net in case something wedges.
		StartEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
			if finished or not Character.Parent then return end
			waveCommitted=true
			
			dontStopSound = true
			if Bind then 
				Bind:Destroy()
				Bind = nil
			end
			
			local cframeToUse = HumRP.CFrame

			local TargetPos = Vector3.new(HumRP.Position.X, GroundYAt(HumRP.Position), HumRP.Position.Z)

			local look = Vector3.new(HumRP.CFrame.LookVector.X, 0, HumRP.CFrame.LookVector.Z)
			look = look.Magnitude > 0.001 and look.Unit or Vector3.new(0, 0, -1)
			local axis = Vector3.new(look.Z, 0, -look.X).Unit
			
			
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(40, 20, 30)
			Hitbox.Offset = CFrame.new(0, 0, 0)
			Hitbox.Visualize = DEBUG_VISUALIZE
			Hitbox.Ignore = {Character}
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyPlayer = game.Players:GetPlayerFromCharacter(EnemyCharacter)

				if iFramesService:HasiFrame(EnemyCharacter, 2)
					or EnemyHumanoid.Health <= 0
					or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
				then
					return
				end

				local flat = (EnemyHumRP.Position - HumRP.Position) * Vector3.new(1, 0, 1)
				local dir = flat.Magnitude > 0.01 and flat.Unit or (HumRP.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit

				local HitInfo = DamageHandler:TakeDamage(
					Character,
					EnemyHumanoid,
					MoveConfig.Damage.Push,
					nil,
					nil,
					false,
					true,
					true,
					true,
					true,
					nil,
					20
				)

				if HitInfo and HitInfo.Countered == true then
					return
				end

				if EnemyCharacter:HasTag("Ragdolled") then --Safety
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				local VelocityObject = Velocity.new(EnemyCharacter)
				VelocityObject.Settings.RemoveTime = 0.2
				VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000) --Force
				VelocityObject.Settings.Velocity = dir * 15 + Vector3.new(0, 10, 0)
				VelocityObject.Settings.Spin = Vector3.new(
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2,
					(math.random() - 0.5) * 2
				).Unit * 8
				VelocityObject:Fire()

				RagdollHandler.ragdoll(EnemyHumanoid, 3, false, nil, nil, nil, true)
			end
			
			Hitbox:Once()
			Hitbox:Destroy()
			
			DebreeService.Destroy(HumRP.CFrame * CFrame.new(0, -3, 0), Vector3.new(40, 20, 30), {
				Shape = "Box",
				Direction = Vector3.new(0, -1, 0),
				Bounce = 10,
				KeepGround = true,
				--IgnoreTrees = true,
				--IgnoreBuildings = true,
				Attacker = Player,
			})
			
			
			local destructionWaves={}
			for index=1,2 do
				local sign=if index==1 then 1 else -1
				local position=TargetPos+axis*(SPAWN_DISTANCE*sign)
				position=Vector3.new(position.X,GroundYAt(position),position.Z)
				local direction=(TargetPos-position)*Vector3.new(1,0,1)
				direction=if direction.Magnitude>0.001 then direction.Unit else -axis*sign
				table.insert(destructionWaves,{Start=position,Target=TargetPos,Direction=direction,
					Speed=WAVE_SPEED,Width=WAVE_SIZE.X,Depth=WAVE_SIZE.Z,Below=40,Above=160})
			end
			mapCast=DebreeService.PrepareTsunami(destructionWaves)
			
			task.delay(1.8, function()
				if not Character.Parent then mapCast:Cancel();return end
				local waveStartedAt=workspace:GetServerTimeNow()
				mapCast:Start(waveStartedAt)
				local travelTime = SPAWN_DISTANCE / WAVE_SPEED
				local arrived = 0
				local burstFired = false

				local function onArrive()
					arrived += 1
					if arrived >= 2 and not burstFired then
						burstFired = true
						collideBurst(Player, Character, TargetPos, axis)
						task.delay(0.25, finish)
					end
				end

				for index,wave in destructionWaves do
					local startPos,dir=wave.Start,wave.Direction

					-- Fire-and-forget: hand your effect the whole path + timing; it self-animates.
					-- Rename these keys to whatever your tsunami effect module reads.
					ClientEffects:FireAllClients("WhiteBeardTsunami", {
						SkillType = "wave",
						Attacker = Character,
						Id = index,
						Start = startPos,
						Target = TargetPos,
						Direction = dir,
						Speed = WAVE_SPEED,
						Duration = travelTime,
						StartedAt = waveStartedAt,
					})

					table.insert(waveStops, spawnWave(Player, Character, startPos, TargetPos, dir, onArrive, waveStartedAt))
				end
			end)
			
			ClientEffects:FireAllClients("WhiteBeardTsunami", {
				SkillType = "cracks",
				Attacker = Character,
				CFrameToUse = cframeToUse,
				Seed        = math.random(1, 2^5 - 1),
			})
			
			shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 8, Last = .75} })
			SoundHandler:AddSound(WBSounds["Sea Quake"]["Gura Earthquake3"], soundPart)
			SoundHandler:AddSound(WBSounds["Sea Quake"].core_shockwave, soundPart)
			
			task.delay(2, function()
				SoundHandler:AddSound(WBSounds["Sea Quake"]["shatter1"], soundPart)
				SoundHandler:AddSound(WBSounds["Sea Quake"]["shatter2"], soundPart)
			end)
		end)
		
		UserTrack.Stopped:Once(function()
			finish()
		end)
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		ClientEffects:FireAllClients("WhiteBeardTsunami", {
			SkillType = "Lines",
			Attacker  = Character,
		})
	end,
}
