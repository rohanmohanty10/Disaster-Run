local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Crocodile[3]
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
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
local DebreeService = require(ServerModules.DebreeService)

local Velocity = require(ReplicatedStorage.Modules.Velocity)
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds

-- PLACEHOLDER — swap for the real animation folder.
local NewAnimLocation = ServerStorage.Assets.Animations.Crocodile

local ReplicateEffects_Set = RemotesContainer.Replicate.Set

-- ===== Tuning ================================================================

-- Must match the ModuleScript name under ClientEffects — the dispatcher in
-- ClientEffects.client.lua caches every effect module by module.Name.
local EFFECT_NAME = "SunaGrab"
-- Grab window. Rides the HumanoidRootPart so it tracks the dash. It opens on
-- the "grab" marker and closes on the "end" marker, so the animation owns how
-- long it stays open — retime the swing and the hitbox retimes with it.
local GRAB_SIZE = Vector3.new(7, 7, 13)
local GRAB_OFFSET = CFrame.new(0, 0, -3)

-- The victim rides 2 studs in front of the user, turned to face them, tweened
-- into place over WELD_TWEEN so the snap isn't instant.
local WELD_TWEEN = .15

local GRAB_DAMAGE = MoveConfig.Damage.Grab
local THROW_DAMAGE = MoveConfig.Damage.Throw
local THROW_FORCE = 70 -- horizontal throw speed along where the user is aiming
local THROW_UPLIFT = 70 -- vertical component added on top of the throw
local THROW_RAGDOLL = 2

-- ===== Velocity ==============================================================
-- All caster movement runs on the caster's own client (LinearVelocity on a
-- RenderStepped loop) — the server only ships these numbers in the marker
-- payloads and the client obeys them. Tune everything from here.

-- Startup dash: fires on the "dash" marker and coasts to a stop. The floor of
-- DASH_MIN keeps it moving right up until the loop is cut, so the dash never
-- stalls out mid-animation. Force axes are left unrestricted.
local DASH_SPEED = 170
local DASH_DECAY = 300 -- studs/sec lost per second
local DASH_MIN = 10
local DASH_TIME = 0.8
local DASH_WALL_CHECK = 5 -- a wall this close clamps the speed
local DASH_WALL_SPEED = 20
local DASH_CAMERA_PROBE = 10 -- how far ahead the camera-look probe reaches

-- Grab drag: force is clamped to the horizontal plane so gravity still behaves
-- normally while the user hauls the victim along. Unlike the dash there is no
-- minimum speed — the drag is meant to bleed out on its own.
local DRAG_SPEED = 90
local DRAG_DECAY = 45
local DRAG_TIME = 2.8
local DRAG_WALL_CHECK = 5
local DRAG_WALL_SPEED = 20

-- The slam is not a second mover. The "slam" marker flips the SAME loop's speed
-- negative, which adds a downward bias to the travel direction and unlocks the
-- Y axis so the downward force actually lands. The negative speed then climbs
-- back to zero at DRAG_SLAM_DECAY, so the user plants and stops.
local DRAG_SLAM_SPEED = -70
local DRAG_SLAM_DECAY = 200
local DRAG_SLAM_DROP = 0.5

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		if Character:HasTag("Stunned") then
			return
		end
		if Player:GetAttribute("AbilityThreeCooldown") then
			return
		end

		Player:SetAttribute("AbilityThreeCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local grabHit = false

		-- Assigned when the "grab" marker opens the hitbox, called by the "end"
		-- marker to close it. Hoisted up here so both marker handlers — and the
		-- Stopped backstop below — can all reach the same function.
		local killGrabHitbox = nil

		-- PLACEHOLDER — swap for the real animations.
		local StartAnimation = NewAnimLocation.Grab.Start
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}
		
		local SandSound
		
		-- ===== One way out =====
		-- Every exit of the move calls EndMove: the grab animation stopping, a whiff, and
		-- the failsafes. It only runs once per cast, so a late caller can't break a later cast.
		local Ended = false
		local GrabCleanup: (() -> ())? = nil -- set when a grab lands: weld, grab stun, drag sound, victim
		local function EndMove()
			if Ended then
				return
			end
			Ended = true

			for _, v in StartEvents do
				v:Disconnect()
			end
			if killGrabHitbox then
				killGrabHitbox()
			end
			if GrabCleanup then
				GrabCleanup()
			end

			-- the start-up stun: it used to be released only on a whiff
			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
			iFramesService:RemoveAlliFrames(Character)
			CollisionsModule:SetCollisionGroup(Character, "Players")
			task.delay(1, function()
				Character:RemoveTag("CantRotate")
			end)

			if SandSound then
				SoundHandler:StopSound(SandSound, 1)
				SandSound = nil
			end

			-- the client side too: flight VFX, and the dash/drag loop if it's still running
			RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, { Attacker = Character, SkillType = "flightEnd" })
			RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, { Attacker = Character, SkillType = "Cancel" })

			Player:SetAttribute("AbilityThreeCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityThreeCooldown", false)
				end
			end)
		end

		-- "dash" marker: the user lunges forward. Velocity lives on their own
		-- client, so all the server does here is clear whatever mover was
		-- already on them and hand the client the dash numbers.
		StartEvents["dash"] = StartTrack:GetMarkerReachedSignal("dash"):Once(function()
			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

			RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
				Attacker = Character,
				SkillType = "Dash",
				Speed = DASH_SPEED,
				Decay = DASH_DECAY,
				MinSpeed = DASH_MIN,
				Duration = DASH_TIME,
				WallCheck = DASH_WALL_CHECK,
				WallSpeed = DASH_WALL_SPEED,
				CameraProbe = DASH_CAMERA_PROBE,
			})
			
			--SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Sand Startup"], HumRP)
			SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Wind Burst"], HumRP)
			SandSound = SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike.Sand, HumRP)
			--SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Wind Burst Shockwave"], HumRP)
		end)

		-- "grab" marker: open the grab window. The hitbox is anchored to the
		-- HumanoidRootPart rather than a static part, so it sweeps forward with
		-- the dash instead of sitting where the marker fired.
		StartEvents["grab"] = StartTrack:GetMarkerReachedSignal("grab"):Once(function()
			local Hitbox = HitboxHandler.new()
			Hitbox.Instance = HumRP
			Hitbox.Size = GRAB_SIZE
			Hitbox.Offset = GRAB_OFFSET
			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false

			-- Destroy() is reachable from three places (the "end" marker, a
			-- landed grab, and the track being cut short), so gate it — the
			-- metatable is stripped on the first call and a second one throws.
			local hitboxDead = false
			killGrabHitbox = function()
				if hitboxDead then
					return
				end
				hitboxDead = true

				pcall(function()
					Hitbox:Destroy()
				end)
			end

			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if grabHit == true
					or EnemyCharacter == Character
					or iFramesService:HasiFrame(EnemyCharacter, 2)
					or EnemyHumanoid.Health <= 0
					or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
				then
					return
				end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, GRAB_DAMAGE, nil, nil, false, true, true, true, false, nil, 19.5)

				if HitInfo.Countered == true then
					return
				end

				grabHit = true
				killGrabHitbox()

				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				EnemyCharacter:AddTag("CantRotate")

				iFramesService:AddBaseiFrames(Character)
				iFramesService:AddBaseiFrames(EnemyCharacter)

				CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "NoCol")

				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
				local GrabStun = StunHandler:Stun(Character, nil, true, 0, 0, true)
				--local Weld = nil
				
				local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0), -1)	

				local GrabEvents = {}

				-- The victim's way out: unweld them and give them back control. Runs once; the
				-- throw, the victim's animation stopping and EndMove can all call it.
				local VictimReleased = false
				local function ReleaseVictim()
					if VictimReleased then
						return
					end
					VictimReleased = true
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
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					EnemyCharacter:RemoveTag("CantRotate")
				end

				-- Failsafe: if nothing has ended the move 8 s after the grab landed, end it. If it
				-- already ended, this does nothing (EndMove only runs once).
				task.delay(8, EndMove)

				-- Start both animations together, synced.
				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = EnemyCharacter })
				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)

				-- PLACEHOLDER — swap for the real animations.
				local userAnimation = NewAnimLocation.Grab.User
				local victimAnimation = NewAnimLocation.Grab.Target

				local UserGrabTrack = AnimationService:getAnimationTrack(Character, userAnimation)
				local VictimGrabTrack = AnimationService:getAnimationTrack(EnemyCharacter, victimAnimation)
				
				local dragSound = SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Dragging 2"], HumRP)
				SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Grab Sound"], HumRP)

				-- What EndMove has to undo for a landed grab
				GrabCleanup = function()
					for _, v in GrabEvents do
						v:Disconnect()
					end
					ReleaseVictim()
					if GrabStun then
						StunHandler:Unstun(Character, GrabStun)
						GrabStun = nil
					end
					if dragSound then
						SoundHandler:StopSound(dragSound, 1)
						dragSound = nil
					end
				end
				
				GrabEvents["throw"] = UserGrabTrack:GetMarkerReachedSignal("throw"):Once(function()
					local Flat = HumRP.CFrame.LookVector * Vector3.new(1, 0, 1)
					Flat = if Flat.Magnitude > 1e-3 then Flat.Unit else Vector3.new(0, 0, -1)
					local CFrameToUse: CFrame = CFrame.lookAt(HumRP.Position, HumRP.Position + Flat)
					
					--SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Sand explosion"], HumRP)
					SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Spike"].Cast, HumRP)
					SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Spike"].SandBoom, HumRP)
					--SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Spike"].sandy, HumRP)
					--SoundHandler:AddSound(Sounds.Characters.Crocodile.GrabSpike["Spike"].Pass, HumRP)
					if dragSound then
						SoundHandler:StopSound(dragSound, 1)
					end
					
					ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
					ReleaseVictim()

					if EnemyHumanoid.Health <= 0 or not EnemyHumRP.Parent then
						return
					end
					
				
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 6, Last = 0.2 } })
					
					--RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
					--	Attacker = Character,
					--	SkillType = "Spike2",
					--})
					RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
						Attacker = Character,
						SkillType = "IceStomp2",
						Startup = true,
						Explode = true,
						SoundParent = HumRP,
						CFrameToUse = CFrameToUse,
					})
					
					RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
						Attacker = Character,
						SkillType = "EmitSpikeFX",
						CFrameDirectionToUse = CFrameToUse.Rotation,
						CFrameToUse = CFrameToUse,
					})
					
					RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
						Attacker = Character,
						SkillType = "flightEnd",
					})
					
					-- Covers the spike (3.4 to 26.3 studs ahead, 10 left to 12.5 right) and starts 1 stud in front
					-- of you, so a wall you're pressed against breaks too (the old box started 6.5 studs out).
					DebreeService.Destroy(CFrameToUse * CFrame.new(1, 4, -14), Vector3.new(23, 15, 26), {
						KeepGround = true,
						Shape = "Box",
						Direction = CFrameToUse.LookVector,
						Power = 30,
						Lift = 10,
						Attacker = Player,
					})
					

					DamageHandler:TakeDamage(Character, EnemyHumanoid, THROW_DAMAGE, nil, nil, false, false, true, true, true, nil, nil)

					local dir = CFrameToUse.LookVector
					dir = dir.Magnitude > 0.01 and dir.Unit or Vector3.zAxis

					--NewKnockback:Knockback(EnemyCharacter, {
					--	KnockbackType = "Velocity",
					--	MaxForce = Vector3.new(100000, 100000, 100000),
					--	Velocity = dir * THROW_FORCE + Vector3.new(0, THROW_UPLIFT, 0),
					--})
					
					local VelocityObject = Velocity.new(EnemyCharacter)
					VelocityObject.Settings.RemoveTime = 0.2
					VelocityObject.Settings.MaxForce = Vector3.new(100000, 100000, 100000) --Force
					VelocityObject.Settings.Velocity = dir * THROW_FORCE + Vector3.new(0, THROW_UPLIFT, 0)
					VelocityObject.Settings.Spin = Vector3.new(
						(math.random() - 0.5) * 2,
						(math.random() - 0.5) * 2,
						(math.random() - 0.5) * 2
					).Unit * 8
					VelocityObject:Fire()

					RagdollHandler.ragdoll(EnemyHumanoid, THROW_RAGDOLL, nil, nil, nil, nil, true)
					
					--ReplicateEffects_Set:FireAllClients("collisionWall", {
					--	root = EnemyHumRP,
					--	NoCrater = "regularSmokeSmash",
					--	hit = EnemyCharacter,
					--	caller = Character,
					--	OnlyCheck = { workspace.World.Map },
					--	Justdown = true,
					--})
				end)

				GrabEvents["crater"] = UserGrabTrack:GetMarkerReachedSignal("crater"):Once(function()
					--shared.fireTo(ReplicateEffects_Set, { Player }, { "ShakeCamera", { Intensity = 3, Last = .2 } })

					--ReplicateEffects_Set:FireAllClients('RockTrail', { parent = HumRP, size = 1.5, side = 0.75, t = 5, height = 5, spawnrate = 0.075, duration = 1 })
					--ReplicateEffects_Set:FireAllClients("RockTrail", {
					--	Part = HumRP,
					--	Settings = { "Look", 1, 1.5, 0, 0.075 },
					--	Offset = Vector3.new(0, 0, 0),
					--})
					
					
					
					--ReplicateEffects_Set:FireAllClients('RockTrail2', { parent = HumRP, size = 1.5, side = 0.75, t = 5, height = 5, spawnrate = 0.025, duration = .8, debrisThreshold = 0, debrisRate = 0.5, debrisMax = 3, debrisForce = 1.5, debrisMinVel = 16, debrisMaxVel = 24, debrisAngleMin = 5, debrisAngleMax = 20, debrisSize = 0.9, debrisFloat = 0.5 })
					ReplicateEffects_Set:FireAllClients('RockTrail2', { parent = HumRP, size = 1.5, side = 0.75, t = 5, height = 5, spawnrate = 0.025, duration = .8, debrisThreshold = 0, debrisRate = 0.05, debrisMin = 3, debrisMax = 6, debrisForce = 2, debrisMinVel = 15, debrisMaxVel = 25, debrisAngleMin = 5, debrisAngleMax = 25, debrisSize = .75 })
					--ReplicateEffects_Set:FireAllClients('Ground Crater',{ Seed = math.random(1, 2000000000), start = EnemyHumRP, ["end"] = Vector3.new(0, -17, 0), Crater2 = true }) --sound is to loud. 
				end)
				
				GrabEvents["end"] = UserGrabTrack:GetMarkerReachedSignal("end"):Once(function()
					if GrabStun then
						StunHandler:Unstun(Character, GrabStun)
						GrabStun = nil
					end

					iFramesService:RemoveAlliFrames(Character)
					CollisionsModule:SetCollisionGroup(Character, "Players")
				end)


				UserGrabTrack.Stopped:Once(EndMove)
				VictimGrabTrack.Stopped:Once(ReleaseVictim)

				AnimationService:playAnimation(Character, userAnimation)
				AnimationService:playAnimation(EnemyCharacter, victimAnimation)

				Weld:Start(WELD_TWEEN, Player)
				
				RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
					Attacker = Character,
					SkillType = "Drag",
					Speed = DRAG_SPEED,
					Decay = DRAG_DECAY,
					Duration = DRAG_TIME,
					WallCheck = DRAG_WALL_CHECK,
					WallSpeed = DRAG_WALL_SPEED,
					SlamDrop = DRAG_SLAM_DROP,
					SlamDecay = DRAG_SLAM_DECAY,
				})				
			end

			Hitbox:Start()
		end)
		
		
		

		-- "end" marker: the grab window closes. Nothing is on a timer, so this
		-- is what ends the swing — if it never fires the window stays open until
		-- the track stops. Note this is the start animation's "end", separate
		-- from the user grab animation's "end" further down.
		StartEvents["end"] = StartTrack:GetMarkerReachedSignal("end"):Once(function()
			if killGrabHitbox then
				killGrabHitbox()
			end
		end)

		StartTrack.Stopped:Once(function()
			for _, v in StartEvents do
				v:Disconnect()
			end
			-- if the track was cut before the "end" marker, this is what closes the window
			if killGrabHitbox then
				killGrabHitbox()
			end
			-- A whiff: nothing else will end the move. When a grab lands, this track is stopped on
			-- purpose (stopAll before the grab animations), and EndMove runs when they stop instead.
			if not grabHit then
				EndMove()
			end
		end)

		-- Failsafe for a whiff whose track never reports Stopped (character removed mid-swing).
		-- A landed grab has its own 8 s failsafe; and if the move already ended, this does nothing.
		task.delay(6, function()
			if not grabHit then
				EndMove()
			end
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
			Attacker = Character,
			SkillType = "flight",
		})
	end,
}
