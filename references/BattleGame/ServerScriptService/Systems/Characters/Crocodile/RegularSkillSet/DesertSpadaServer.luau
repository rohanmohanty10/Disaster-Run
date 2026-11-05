local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Crocodile[2]
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


local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)
local Trove = require(ReplicatedModules.Trove)

local Sounds = ReplicatedStorage.Assets.Sounds

local NewAnimLocation = ServerStorage.Assets.Animations.Crocodile

local ReplicateEffects_Set = RemotesContainer.Replicate.Set

-- ===== Tuning ================================================================

-- Line hitbox, per segment (see SEGMENT_COUNT). CRACK_DISTANCE must match the client DesertSpada module.
local CRACK_DISTANCE = 90
local LINE_WIDTH = 14
local LINE_HEIGHT = 24
-- Seconds after the "spada" marker before the sand erupts on clients:
-- crack travel (~20 segments at 60fps ≈ 0.33s) + BURST_DELAY + SAND_DELAY.
local ERUPTION_DELAY = 0.45

-- Line explosion (destruction). The line is broken by SEGMENT_COUNT hits, fired near to far.
local SEGMENT_COUNT = 6 -- hits along the line (90 / 6 = 15 studs each)
local SEGMENT_WIDTH = 10 -- each hit's width (same as LINE_WIDTH)
local SEGMENT_HEIGHT = 16 -- each hit's height
local SEGMENT_FLOOR_DEPTH = 1.5 -- studs each hit reaches below the ground: a shallow fissure (0 = floor untouched)
local SEGMENT_POWER = 25 -- outward launch speed of broken pieces (Debree's default is 18)
local SEGMENT_LIFT = 35 -- extra upward launch: the eruption (Debree's default is 1)
local RIPPLE_TIME = 0.15 -- seconds from the first hit to the last (0 = whole line at once); match the client
local STEP_LIMIT = 8 -- most the ground may step UP between segments (studs), so the line never climbs walls; must match the client
local DROP_LIMIT = 40 -- most it may drop between segments (studs), so the line runs off ledges; must match the client


local LINE_DAMAGE = MoveConfig.Damage.Line -- caught by the eruption
local SLAM_DAMAGE = MoveConfig.Damage.Slam -- the knockdown
local SLAM_PUSH = 45 -- horizontal throw speed toward where the user is aiming
-- The victim's rise is tweened on an anchored root so the height and timing
-- are exact every time (physics knockback was reaching inconsistent heights).
-- It is timed so the victim arrives at LAUNCH_HEIGHT exactly when the "tp"
-- frame of the UserKick animation plays.


local ANIM_FPS = 30 -- framerate the animation was authored at (Roblox default)


local TP_FRAME = 35
local RISE_TIME = (TP_FRAME - 3) / ANIM_FPS -- rise ends ~3 frames early (~1.1s)




local LAUNCH_HEIGHT = 30 -- studs the victim rises before getting welded

local POP_VELOCITY = 60 -- upward pop for extra (non-grabbed) enemies
--local TELEPORT_OFFSET = 4 -- studs in front of the victim the user appears at
local SLAM_VELOCITY = 130 -- downward knockdown speed
-- The hang duration is animation-driven: it's the time between the "tp" and
-- "hit" markers in the Spada.UserKick animation.

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		if Character:HasTag("Stunned") then
			return
		end
		if Player:GetAttribute("AbilityTwoCooldown") then
			return
		end

		Player:SetAttribute("AbilityTwoCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end

		local Bind = Instance.new("StringValue")
		Bind.Parent = Character
		Bind.Name = "Tremor"

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local HoldAlignPosition
		local GyroAlignOrientation

		local StartAnimation = NewAnimLocation.Spada.StartNew
		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		StartEvents["back"] = UserTrack:GetMarkerReachedSignal("back"):Once(function()
			local CFrameToUse = HumRP.CFrame

			ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
			RemotesContainer.ClientEffects:FireAllClients("DesertSpada", { Attacker = Character, SkillType = "Dash",
				CFrameToUse = CFrameToUse }
			)
		end)
		StartEvents["slow"] = UserTrack:GetMarkerReachedSignal("slow"):Once(function()
			UserTrack:AdjustSpeed(2)

		end)
		StartEvents["normal"] = UserTrack:GetMarkerReachedSignal("normal"):Once(function()
			UserTrack:AdjustSpeed(1)

		end)

		StartEvents["spada"] = UserTrack:GetMarkerReachedSignal("spada"):Once(function()
			-- The clients build the crack from this grounded CFrame; snap it
			-- down onto the map floor, keeping the facing direction.
			local lineOrigin = HumRP.CFrame
			do
				local world = workspace:FindFirstChild("World")
				local map = world and world:FindFirstChild("Map")

				local params = RaycastParams.new()
				params.FilterType = Enum.RaycastFilterType.Include
				-- plus Debree's pieces: where the floor was already broken, its part has left the map and
				-- Debree's pieces stand in for it (on the server: bodies under the server camera)
				params.FilterDescendantsInstances = { map or workspace, DebreeService.GetBodiesFolder() }
				params.IgnoreWater = true
				params.RespectCanCollide = true -- only what you can stand on (the client probes the same way)

				local result = workspace:Raycast(lineOrigin.Position, Vector3.new(0, -10, 0), params)
				if result then
					lineOrigin = CFrame.new(lineOrigin.X, result.Position.Y, lineOrigin.Z) * lineOrigin.Rotation
				end
			end
			
			RemotesContainer.ClientEffects:FireAllClients("DesertSpada", { Attacker = Character, SkillType = "SpadaVFX", Origin = lineOrigin, })

			task.delay(0.2, function()
				if Bind then
					Bind:Destroy()
					Bind = nil
				end
			end)

			-- Fire the hitbox where and when the sand erupts on clients.
			task.delay(ERUPTION_DELAY, function()
				if Humanoid.Health <= 0 then
					return
				end
				
				local victimTaken = false

				local Hitbox = HitboxHandler.new()
				Hitbox.Instance = lineOrigin -- moved onto each segment below
				Hitbox.Size = Vector3.new(LINE_WIDTH, LINE_HEIGHT, CRACK_DISTANCE / SEGMENT_COUNT) -- one segment
				Hitbox.Offset = CFrame.new(0, LINE_HEIGHT / 4, 0) -- 6 studs under the ground to 18 over it
				Hitbox.Visualize = false
				Hitbox.onTouch = function(EnemyCharacter)
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

					--local HitInfo = DamageHandler:TakeDamage(
					--	Character,
					--	EnemyHumanoid,
					--	LINE_DAMAGE,
					--	nil,
					--	nil,
					--	false,
					--	true,
					--	true,
					--	true,
					--	true,
					--	nil,
					--	13
					--)
					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, LINE_DAMAGE, nil, nil, false, EnemyCharacter:HasTag('DEATH') and true or false, true, true, false, nil, 15)


					if HitInfo.Countered == true then
						return
					end

					-- Only the first enemy gets the full grab; anyone else
					-- caught by the line just gets popped up and ragdolled.
					if victimTaken then
						if EnemyCharacter:HasTag("Ragdolled") then
							RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
						end

						NewKnockback:Knockback(EnemyCharacter, {
							KnockbackType = "Velocity",
							MaxForce = Vector3.new(100000, 100000, 100000),
							Velocity = Vector3.new(0, POP_VELOCITY, 0),
						})

						RagdollHandler.ragdoll(EnemyHumanoid, 1.5, nil, nil, nil, nil, true)
						return
					end
					victimTaken = true

					-- ===== The grab sequence =====
					-- Both animations start on the same frame so they stay in
					-- sync. The UserKick animation's markers drive everything:
					--   "tp"  -> teleport + weld the victim to the user
					--   "hit" -> knockdown slam
					task.spawn(function()
						if EnemyCharacter:HasTag("Ragdolled") then
							RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
						end

						-- Grab hygiene: lock rotation, iFrames, and collisions
						-- for both characters while the sequence runs.
						EnemyCharacter:AddTag("CantRotate")

						iFramesService:AddAlliFrames(Character)
						iFramesService:AddAlliFrames(EnemyCharacter)

						CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

						local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
						local Weld = nil
						local riseCFrame = nil
						local GrabEvents = {}
						local slamDir = HumRP.CFrame.LookVector
						local GrabStun = StunHandler:Stun(Character, nil, true, 0, 0, true)
						
						-- Pre-create the hold + aim constraints DISABLED, so they're already
						-- replicated to the owner's client when the tp hands ownership over.
						local RootAttachment = HumRP:FindFirstChild("RootAttachment")

						HoldAlignPosition = Instance.new("AlignPosition")
						HoldAlignPosition.Name = "SpadaHold"
						HoldAlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
						HoldAlignPosition.Attachment0 = RootAttachment
						HoldAlignPosition.RigidityEnabled = true
						HoldAlignPosition.Enabled = false
						HoldAlignPosition.Position = HumRP.Position
						HoldAlignPosition.Parent = HumRP

						GyroAlignOrientation = Instance.new("AlignOrientation")
						GyroAlignOrientation.Name = "SpadaGyro"
						GyroAlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
						GyroAlignOrientation.Attachment0 = RootAttachment
						GyroAlignOrientation.RigidityEnabled = true
						GyroAlignOrientation.Enabled = false
						GyroAlignOrientation.CFrame = HumRP.CFrame.Rotation
						GyroAlignOrientation.Parent = HumRP
						
						-- The victim is always welded to the user during the			
						-- Failsafe: whatever happens, never leave anyone
						-- welded, anchored, or locked.
						task.delay(8, function()
							--local hold = HumRP:FindFirstChild("SpadaHold")
							--if hold then hold:Destroy() end
							
							--local gyro = HumRP:FindFirstChild("SpadaGyro")
							--if gyro then gyro:Destroy() end
							if GyroAlignOrientation then
								GyroAlignOrientation:Destroy()
								GyroAlignOrientation = nil
							end
							if HoldAlignPosition then
								HoldAlignPosition:Destroy()
								HoldAlignPosition = nil
							end
							
							Character:RemoveTag("CantRotate")

							if GrabStun then
								StunHandler:Unstun(Character, GrabStun)
								GrabStun = nil
							end
							
							
							for _, v in GrabEvents do
								v:Disconnect()
							end
							if Weld then
								pcall(function() Weld:Stop() end)
								Weld = nil
							end
							if HumRP then
								HumRP.Anchored = false
							end
							if EnemyHumRP then
								EnemyHumRP.Anchored = false
							end
							if EnemyStun then
								StunHandler:Unstun(EnemyCharacter, EnemyStun)
								EnemyStun = nil

								iFramesService:RemoveAlliFrames(EnemyCharacter)
								CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
								EnemyCharacter:RemoveTag("CantRotate")
							end
						end)

						-- Start both animations together, synced.
						ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = EnemyCharacter })
						AnimationService:stopAll(EnemyCharacter)
						AnimationService:stopAll(Character)
						local userAnimation =  NewAnimLocation.Spada.New.User
						local victimAnimation =  NewAnimLocation.Spada.New.Victim


						local UserGrabTrack = AnimationService:getAnimationTrack(Character, userAnimation)

						-- "tp" marker: the victim is frozen at the top of the
						-- rise; welding the user onto them IS the teleport —
						-- the weld snaps the user in front of the victim.
						GrabEvents["invis"] = UserGrabTrack:GetMarkerReachedSignal("invis"):Once(function()
							RemotesContainer.ClientEffects:FireAllClients("DesertSpada", { Attacker = Character, SkillType = "Vanish" })
							SoundHandler:AddSound(Sounds.Characters.Crocodile.DesertSpada.TP, HumRP) --disappearing sound
						end)
						
						GrabEvents["tp"] = UserGrabTrack:GetMarkerReachedSignal("tp"):Once(function()
							RemotesContainer.ClientEffects:FireAllClients("DesertSpada", { Attacker = Character, SkillType = "TP" })
							SoundHandler:AddSound(Sounds.Characters.Crocodile.DesertSpada.TP, HumRP) -- reappearing sound

							if EnemyHumanoid.Health <= 0 or not EnemyHumRP.Parent then
								return
							end
							--ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })
							
							--Weld = WeldSystem.new(EnemyHumRP, HumRP, CFrame.new(0, 0, -TELEPORT_OFFSET) * CFrame.Angles(0, math.pi, 0), -1)
							--Weld = WeldSystem.new(EnemyHumRP, HumRP, CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), -1)

							--Weld:Start(0, Player)
							
							-- The enemy is anchored and settled at the apex. Snap the user to the
							-- same spot the old weld used to place them (identity offset = their CFrame).
							if riseCFrame then
								EnemyHumRP.CFrame = riseCFrame
							end
							HumRP.CFrame = EnemyHumRP.CFrame
							HumRP.AssemblyLinearVelocity = Vector3.zero

							Character:AddTag("CantRotate")

							HoldAlignPosition.Position = HumRP.Position
							HoldAlignPosition.Enabled = true

							GyroAlignOrientation.CFrame = HumRP.CFrame.Rotation
							GyroAlignOrientation.Enabled = true

							-- Hand the enemy over: unanchor them and weld them to the user
							-- (user is master — same layout as the Zoro grab).
							EnemyHumRP.Anchored = false
							EnemyHumRP.AssemblyLinearVelocity = Vector3.zero

							Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, -3) * CFrame.Angles(0, math.pi, 0), -1)
							Weld:Start(nil, Player)			
							
						end)
						
						GrabEvents["reduce"] = UserGrabTrack:GetMarkerReachedSignal("reduce"):Once(function()
							
							--UserGrabTrack:AdjustSpeed(1)
							
						end)
						GrabEvents["normal"] = UserGrabTrack:GetMarkerReachedSignal("normal"):Once(function()
							
						end)
						GrabEvents["punch"] = UserGrabTrack:GetMarkerReachedSignal("punch"):Once(function()

						end)
						-- "hit" marker: release and slam the victim down.
						GrabEvents["hit"] = UserGrabTrack:GetMarkerReachedSignal("hit"):Once(function()
							RemotesContainer.ClientEffects:FireAllClients("DesertSpada", { Attacker = Character, SkillType = "Punch" })

							--local hold = HumRP:FindFirstChild("SpadaHold")
							--if hold then hold:Destroy() end
							if HoldAlignPosition then
								HoldAlignPosition:Destroy()
								HoldAlignPosition = nil
							end
							
							if Weld then
								pcall(function() Weld:Stop() end)
								Weld = nil
							end
							HumRP.Anchored = false
							EnemyHumRP.Anchored = false

							if EnemyStun then
								StunHandler:Unstun(EnemyCharacter, EnemyStun)
								EnemyStun = nil
							end
							iFramesService:RemoveAlliFrames(EnemyCharacter)
							CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
							EnemyCharacter:RemoveTag("CantRotate")
							
							
							--local gyro = HumRP:FindFirstChild("SpadaGyro")
							--if gyro then gyro:Destroy() end
							if GyroAlignOrientation then
								GyroAlignOrientation:Destroy()
								GyroAlignOrientation = nil
							end
							
							--Humanoid.AutoRotate = true
							Character:RemoveTag("CantRotate")

							if EnemyHumanoid.Health <= 0 or not EnemyHumRP.Parent then
								return
							end

							DamageHandler:TakeDamage(Character, EnemyHumanoid, SLAM_DAMAGE, nil, nil, false, true, true, true, true, nil, 13)
							AnimationService:stopAll(EnemyCharacter)

							
							--local aim = HumRP.CFrame.LookVector
							--local flatDir = Vector3.new(aim.X, 0, aim.Z)
							--flatDir = flatDir.Magnitude > 0.01 and flatDir.Unit or slamDir

							--NewKnockback:Knockback(EnemyCharacter, {
							--	KnockbackType = "Velocity",
							--	MaxForce = Vector3.new(100000, 50000, 100000),
							--	Velocity = flatDir * SLAM_PUSH + Vector3.new(0, -SLAM_VELOCITY, 0),
							--})
							
							local dir = HumRP.CFrame.LookVector
							dir = dir.Magnitude > 0.01 and dir.Unit or -Vector3.yAxis

							NewKnockback:Knockback(EnemyCharacter, {
								KnockbackType = "Velocity",
								MaxForce = Vector3.new(100000, 100000, 100000),
								Velocity = dir * SLAM_VELOCITY,
							})
							
							
							RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, true)

							ReplicateEffects_Set:FireAllClients("collisionWall", {
								root = EnemyHumRP,
								NoCrater = "regularSmokeSmash",
								hit = EnemyCharacter,
								caller = Character,
								OnlyCheck = { workspace.World.Map },
								Justdown = true,
							})
							shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 6, Last = 0.2 } })
						end)

						-- When the user's grab animation ends, restore the
						-- user's state no matter how the sequence went.
						UserGrabTrack.Stopped:Once(function()
							--local hold = HumRP:FindFirstChild("SpadaHold")
							--if hold then hold:Destroy() end
							
							--local gyro = HumRP:FindFirstChild("SpadaGyro")
							--if gyro then gyro:Destroy() end
							if HoldAlignPosition then
								HoldAlignPosition:Destroy()
								HoldAlignPosition = nil
							end
							if GyroAlignOrientation then
								GyroAlignOrientation:Destroy()
								GyroAlignOrientation = nil
							end
							
							--Humanoid.AutoRotate = true
							Character:RemoveTag("CantRotate")
							
							if GrabStun then
								StunHandler:Unstun(Character, GrabStun)
								GrabStun = nil
							end
							
							
							RemotesContainer.ClientEffects:FireAllClients("DesertSpada", { Attacker = Character, SkillType = "TPCancel" })

							HumRP.Anchored = false
							iFramesService:RemoveAlliFrames(Character)
							CollisionsModule:SetCollisionGroup(Character, "Players")
						end)

						AnimationService:playAnimation(EnemyCharacter, victimAnimation)
						AnimationService:playAnimation(Character, userAnimation)

						-- Rise: anchor the victim right away and tween them up
						-- LAUNCH_HEIGHT studs over RISE_TIME, so they're at the
						-- exact height the moment the "tp" frame plays. They
						-- stay anchored (frozen) until the "hit" marker
						-- releases them.
						EnemyHumRP.CFrame = CFrame.new(EnemyHumRP.Position) * HumRP.CFrame.Rotation
						
						EnemyHumRP.AssemblyLinearVelocity = Vector3.zero
						EnemyHumRP.Anchored = true

						--local riseCFrame = EnemyHumRP.CFrame + Vector3.new(0, LAUNCH_HEIGHT, 0)
						riseCFrame = EnemyHumRP.CFrame + Vector3.new(0, LAUNCH_HEIGHT, 0)

						RemotesContainer.ClientEffects:FireAllClients("DesertSpada", {
							Attacker = Character,
							SkillType = "Rise",
							Victim = EnemyCharacter,
							TargetCFrame = riseCFrame,
							RiseTime = RISE_TIME,
						})

						-- one server-side snap at the top, after clients have already tweened there
						task.delay(RISE_TIME, function()
							if EnemyHumRP.Parent and EnemyHumRP.Anchored then
								EnemyHumRP.CFrame = riseCFrame
							end
						end)
					end)
				end

				-- The line, near to far. Each segment follows the ground under it exactly the way the
				-- client's crack does (STEP_LIMIT), breaks what's there and hits who's there. It's one
				-- Hitbox moved along the line, so its Characters list keeps anyone from being hit twice.
				local world = workspace:FindFirstChild("World")
				local map = world and world:FindFirstChild("Map")
				local rayParams = RaycastParams.new()
				rayParams.FilterType = Enum.RaycastFilterType.Include
				-- The whole map: most standable ground isn't in the Floor folder (Indestructible Map,
				-- docks, building floors). Plus Debree's pieces: where the floor was already broken, its
				-- part has left the map and Debree's pieces stand in for it. On the server those are
				-- bodies under the server camera; World.Voxel is the client's pool and is empty here.
				rayParams.FilterDescendantsInstances = { map or workspace, DebreeService.GetBodiesFolder() }
				rayParams.IgnoreWater = true
				rayParams.RespectCanCollide = true

				local segmentLength = CRACK_DISTANCE / SEGMENT_COUNT
				local groundY = lineOrigin.Y
				for segment = 1, SEGMENT_COUNT do
					-- the crack starts 2.5 studs ahead of the caster (the stab)
					local along = lineOrigin * CFrame.new(0, 0, -(2.5 + (segment - 0.5) * segmentLength))
					-- Follow the ground from just above it: a ray that starts inside a wall doesn't hit
					-- that wall, so walls on the line get hit at their base, not on their tops. It starts
					-- only STEP_LIMIT above the last ground (a roof or a treetop never pulls the line up)
					-- and reaches DROP_LIMIT below it (the line runs off ledges onto the ground below).
					local hit = workspace:Raycast(
						Vector3.new(along.X, groundY + STEP_LIMIT, along.Z),
						Vector3.new(0, -(STEP_LIMIT + DROP_LIMIT), 0),
						rayParams
					)
					-- No ground there (a pit, the edge of the map): the crack isn't drawn there either,
					-- so this segment neither breaks nor hits anything
					if hit then
						groundY = hit.Position.Y
						local ground = CFrame.new(along.X, groundY, along.Z) * lineOrigin.Rotation

						DebreeService.Destroy(
							ground * CFrame.new(0, SEGMENT_HEIGHT / 2 - SEGMENT_FLOOR_DEPTH, 0),
							Vector3.new(SEGMENT_WIDTH, SEGMENT_HEIGHT, segmentLength),
							{
								Outward = true,
								Power = SEGMENT_POWER,
								Lift = SEGMENT_LIFT,
								Attacker = Character,
								GridSize = 3,
								KeepGround = true,
							}
						)
						Hitbox.Instance = ground
						Hitbox:Once()
					end

					if RIPPLE_TIME > 0 and segment < SEGMENT_COUNT then
						task.wait(RIPPLE_TIME / SEGMENT_COUNT)
					end
				end
				Hitbox:Destroy()
			end)
		end)

		UserTrack.Stopped:Once(function()
			if Bind then
				Bind:Destroy()
				Bind = nil
			end

			for _, v in StartEvents do
				v:Disconnect()
			end

			task.delay(0.1, function()
				if Stun then
					StunHandler:Unstun(Character, Stun)
					Stun = nil
				end
			end)

			Player:SetAttribute("AbilityTwoCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityTwoCooldown", false)
				end
			end)
		end)

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
	end,
}
