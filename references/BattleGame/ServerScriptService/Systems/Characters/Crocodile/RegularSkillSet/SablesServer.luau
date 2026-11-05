local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Crocodile[4]
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
local StatesHandler = require(ServerModules.StatesHandler)
local DebreeService = require(ServerModules.DebreeService)

local SoundHandler = require(ReplicatedModules.SoundHandler)

local Sounds = ReplicatedStorage.Assets.Sounds
local MoveSounds = Sounds.Characters

-- CHANGE this to your character's animation folder.
local NewAnimLocation = ServerStorage.Assets.Animations["Crocodile"]

local RNG = Random.new()

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

--------------------------------------------------------------------------------
-- Tuning
--------------------------------------------------------------------------------
local EFFECT_NAME = "Sables"

local DURATION = 2.5 -- how long the tornado lives / travels (independent of the anim)
local FORWARD_SPEED = 13 -- studs/sec drift
local START_DISTANCE = 8 -- studs in front of the caster where it spawns
local FLOOR_SNAP = 14

local CATCH_SIZE = Vector3.new(20, 20, 20)

-- Carve + capture (tornado destruction). Every CARVE_INTERVAL the tornado's funnel grabs some of
-- the loose rubble around it to spin on clients (Debree's "Funnel" absorb style), then breaks a
-- bite at its front (real rubble, flung outward, stays until the reset).
local CARVE_INTERVAL = 0.2 -- seconds between bites (lower = more destruction, more server work)
local CARVE_SIZE = Vector3.new(14, 16, 14) -- each bite (an oval: width, height, depth)
local CARVE_AHEAD = 4 -- studs in front of the tornado's center the bite is taken
local CARVE_FLOOR_GAP = 1 -- the bite's bottom sits this far above the ground, so floors stay
local ROOT_HEIGHT = 3 -- studs the tornado's root sits above the ground (it spawns at the caster's root height)
local CAPTURE_SIZE = Vector3.new(18, 20, 18) -- area around the tornado its funnel grabs rubble from
local CAPTURE_PER_BITE = 15 -- most rubble pieces grabbed per bite
local FUNNEL_MAX = 80 -- most rubble pieces grabbed per cast

local ORBIT_RADIUS_MIN, ORBIT_RADIUS_MAX = 4, 7
local ORBIT_SPEED_MIN, ORBIT_SPEED_MAX = 1.2, 2.6
local ORBIT_HEIGHT_MIN, ORBIT_HEIGHT_MAX = 2,5
local BOB_SPEED_MIN, BOB_SPEED_MAX = 1.5, 3
local BOB_RANGE_MIN, BOB_RANGE_MAX = 1, 3
local SPIN_MIN, SPIN_MAX = 4, 10

local PULL_FORCE = 45000
local PULL_RESPONSIVE = 30
local PULL_MAXVEL = 55

local CATCH_DAMAGE = MoveConfig.Damage.Catch
local TICK_DAMAGE = MoveConfig.Damage.Tick
local TICK_INTERVAL = 0.25
local THROW_UP = 90
local THROW_OUT = 20
local THROW_DAMAGE = MoveConfig.Damage.Throw

--------------------------------------------------------------------------------

return {
	Start = function(Player: Player, Cooldown: number)
		local Character = Player.Character
		local HumRP: BasePart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid: Humanoid = Character and Character:FindFirstChild("Humanoid")
		if not (Character and Humanoid and HumRP) or Humanoid.Health <= 0 then
			return
		end

		if Character:HasTag("Stunned") then
			return
		end
		if Player:GetAttribute("AbilityFourCooldown") then
			return
		end

		Player:SetAttribute("AbilityFourCooldown", true)

		local CooldownTime = Cooldown
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = 0.5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		Character:AddTag("NoHeadFollow")

		-- CHANGE "DesertTornado" to your animation name; must fire a "throw" marker.
		local StartAnimation = NewAnimLocation.Sables.user4
		local UserTrack = AnimationService:getAnimationTrack(Character, StartAnimation)

		local hitList = {} -- [EnemyCharacter] = victim data

		-- Live handles for the tornado, cleaned up on DURATION (NOT on the anim).
		local TornadoRoot: BasePart? = nil
		local driftConn: RBXScriptConnection? = nil
		local despawnConn: RBXScriptConnection? = nil
		local mainHitbox = nil
		local throwMarker: RBXScriptConnection? = nil

		local dissipated = false
		-- Matches this cast's NewTornado and Dissipate on clients (they drive their own anchor)
		local tornadoId = ("%d_%d"):format(Player.UserId, RNG:NextInteger(1, 2 ^ 30))
		local casterCleaned = false

		-- Release one victim: kill their orbit, hand ownership back, fling them up.
		local function releaseVictim(EnemyCharacter, data, throw)
			if data.Released then
				return
			end
			data.Released = true

			if data.OrbitConn then
				data.OrbitConn:Disconnect()
			end
			if data.AlignPos then
				data.AlignPos:Destroy()
			end
			if data.OrbAttachment then
				data.OrbAttachment:Destroy()
			end
			if data.EnemyAttachment then
				data.EnemyAttachment:Destroy()
			end
			if data.Spin then
				data.Spin:Destroy()
			end

			local EnemyHumRP = EnemyCharacter:FindFirstChild("HumanoidRootPart")
			local EnemyHumanoid = EnemyCharacter:FindFirstChild("Humanoid")
			EnemyCharacter:RemoveTag("CantRotate")

			if EnemyHumRP and EnemyHumanoid then
				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				pcall(function()
					EnemyHumRP:SetNetworkOwner(EnemyPlayer)
				end)
				EnemyHumRP.AssemblyLinearVelocity = Vector3.zero
				EnemyHumRP.AssemblyAngularVelocity = Vector3.zero

				if throw then
					if THROW_DAMAGE > 0 then
						DamageHandler:TakeDamage(
							Character,
							EnemyHumanoid,
							THROW_DAMAGE,
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
					end
					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid)
					end
					RagdollHandler.ragdoll(EnemyHumanoid, 2)

					local scatter = Vector3.new(
						(RNG:NextNumber() - 0.5) * 2 * THROW_OUT,
						0,
						(RNG:NextNumber() - 0.5) * 2 * THROW_OUT
					)
					NewKnockback:Knockback(EnemyCharacter, {
						KnockbackType = "Velocity",
						MaxForce = Vector3.new(100000, 100000, 100000),
						Velocity = Vector3.new(0, THROW_UP, 0) + scatter,
					})
				end
			end

			hitList[EnemyCharacter] = nil
		end

		-- End the tornado: stop drift/hitbox, throw victims, fade the visual.
		local function finishTornado(throw)
			if dissipated then
				return
			end
			dissipated = true

			if driftConn then
				driftConn:Disconnect()
				driftConn = nil
			end
			if despawnConn then
				despawnConn:Disconnect()
				despawnConn = nil
			end
			if mainHitbox then
				pcall(function()
					mainHitbox:Stop()
					mainHitbox:Destroy()
				end)
				mainHitbox = nil
			end

			for EnemyCharacter, data in hitList do
				releaseVictim(EnemyCharacter, data, throw)
			end

			RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
				Attacker = Character,
				SkillType = "Dissipate",
				Root = TornadoRoot,
				Id = tornadoId,
			})

			-- Destroying the Root ends the client tornado (its Follow part is gone).
			task.delay(0.3, function()
				if TornadoRoot and TornadoRoot.Parent then
					TornadoRoot:Destroy()
					TornadoRoot = nil
				end
			end)
		end

		-- Free the caster only. Tied to the animation; leaves the tornado running.
		local function finishCaster()
			if casterCleaned then
				return
			end
			casterCleaned = true

			if throwMarker then
				throwMarker:Disconnect()
			end
			if Stun then
				StunHandler:Unstun(Character, Stun)
				Stun = nil
			end
			Character:RemoveTag("NoHeadFollow")
			iFramesService:RemoveAlliFrames(Character)

			Player:SetAttribute("AbilityFourCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityFourCooldown", false)
				end
			end)
		end

		-- Catch one enemy: damage, ragdoll, and start their random orbit + tumble.
		local function catch(EnemyCharacter)
			local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChild("Humanoid")
			local EnemyHumRP: BasePart = EnemyCharacter:FindFirstChild("HumanoidRootPart")
			if not (EnemyHumanoid and EnemyHumRP) then
				return
			end
			if hitList[EnemyCharacter] then
				return
			end
			if
				EnemyCharacter == Character
				or iFramesService:HasiFrame(EnemyCharacter, 2)
				or EnemyHumanoid.Health <= 0
				or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
			then
				return
			end

			local HitInfo =
				DamageHandler:TakeDamage(Character, EnemyHumanoid, CATCH_DAMAGE, 1, nil, true, true, true, true, false, nil, 13)
			if HitInfo.Countered == true then
				return
			end

			EnemyCharacter:AddTag("CantRotate")
			RagdollHandler.ragdoll(EnemyHumanoid, DURATION + 1, false, Character, nil, nil, false, { Cosmetic = true })
			pcall(function()
				EnemyHumRP:SetNetworkOwner(nil)
			end)
			EnemyHumRP.AssemblyLinearVelocity = Vector3.zero
			EnemyHumRP.AssemblyAngularVelocity = Vector3.zero

			local OrbAttachment = Instance.new("Attachment")
			OrbAttachment.Parent = workspace.Terrain

			local EnemyAttachment = Instance.new("Attachment")
			EnemyAttachment.Parent = EnemyHumRP

			local AlignPos = Instance.new("AlignPosition")
			AlignPos.Mode = Enum.PositionAlignmentMode.TwoAttachment
			AlignPos.Attachment0 = EnemyAttachment
			AlignPos.Attachment1 = OrbAttachment
			AlignPos.MaxForce = PULL_FORCE
			AlignPos.Responsiveness = PULL_RESPONSIVE
			AlignPos.MaxVelocity = PULL_MAXVEL
			AlignPos.Parent = EnemyHumRP

			local spinAttach = EnemyHumRP:FindFirstChild("RootAttachment") or Instance.new("Attachment")
			if not spinAttach.Parent then
				spinAttach.Parent = EnemyHumRP
			end
			local function spinAxis()
				return (RNG:NextInteger(0, 1) == 0 and 1 or -1) * RNG:NextNumber(SPIN_MIN, SPIN_MAX)
			end
			local Spin = Instance.new("AngularVelocity")
			Spin.Attachment0 = spinAttach
			Spin.RelativeTo = Enum.ActuatorRelativeTo.World
			Spin.AngularVelocity = Vector3.new(spinAxis(), spinAxis(), spinAxis())
			Spin.MaxTorque = 1e9
			Spin.Parent = EnemyHumRP

			local data = {
				Humanoid = EnemyHumanoid,
				HumRP = EnemyHumRP,
				OrbAttachment = OrbAttachment,
				EnemyAttachment = EnemyAttachment,
				AlignPos = AlignPos,
				Spin = Spin,
				Released = false,
				Radius = RNG:NextNumber(ORBIT_RADIUS_MIN, ORBIT_RADIUS_MAX),
				AngSpeed = (RNG:NextInteger(0, 1) == 0 and 1 or -1) * RNG:NextNumber(ORBIT_SPEED_MIN, ORBIT_SPEED_MAX),
				Height = RNG:NextNumber(ORBIT_HEIGHT_MIN, ORBIT_HEIGHT_MAX),
				BobSpeed = RNG:NextNumber(BOB_SPEED_MIN, BOB_SPEED_MAX),
				BobRange = RNG:NextNumber(BOB_RANGE_MIN, BOB_RANGE_MAX),
				Angle = RNG:NextNumber(0, math.pi * 2),
				T = 0,
				TickClock = 0,
			}

			data.OrbitConn = RunService.Heartbeat:Connect(function(dt)
				if dissipated or not TornadoRoot or not TornadoRoot.Parent or not EnemyHumRP.Parent then
					return
				end
				data.T += dt
				local ang = data.Angle + data.AngSpeed * data.T
				local bob = math.sin(data.T * data.BobSpeed) * data.BobRange
				local center = TornadoRoot.Position
				OrbAttachment.WorldPosition = center
					+ Vector3.new(math.cos(ang) * data.Radius, data.Height + bob, math.sin(ang) * data.Radius)

				if TICK_DAMAGE > 0 then
					data.TickClock += dt
					if data.TickClock >= TICK_INTERVAL then
						data.TickClock -= TICK_INTERVAL
						
						if EnemyHumRP.Parent then
							SoundHandler:AddSound(MoveSounds.Crocodile.Sables["Slash"], EnemyHumRP)
							
							RemotesContainer.ClientEffects:FireAllClients("Sables", {
								Attacker  = Character,
								SkillType = "HitEnemy", 
								Enemy = EnemyCharacter
							})
						end
						
						if EnemyHumanoid.Health > 0 then
							DamageHandler:TakeDamage(
								Character,
								EnemyHumanoid,
								TICK_DAMAGE,
								nil,
								nil,
								false,
								false,
								false,
								true,
								false,
								nil,
								nil
							)
						end
					end
				end
			end)
			
			hitList[EnemyCharacter] = data
		end

		-- "throw" marker: spawn everything; it runs for DURATION on its own.
		throwMarker = UserTrack:GetMarkerReachedSignal("throw"):Once(function()
			local look = HumRP.CFrame.LookVector
			local forward = Vector3.new(look.X, 0, look.Z)
			forward = forward.Magnitude > 0 and forward.Unit or HumRP.CFrame.LookVector

			--local spawnPos = HumRP.Position + forward * START_DISTANCE
			--local floor = workspace:Raycast(
			--	spawnPos + Vector3.new(0, FLOOR_SNAP, 0),
			--	Vector3.new(0, -FLOOR_SNAP * 3, 0),
			--	MapRayParams
			--)
			--local basePos = floor and floor.Position or (spawnPos - Vector3.new(0, 3, 0))


			local spawnPos = HumRP.Position + forward * START_DISTANCE
			-- Keep the spawn at your height so it doesn't drop off edges; the tornado
			-- travels forward at a constant Y anyway.
			local basePos = Vector3.new(spawnPos.X, HumRP.Position.Y, spawnPos.Z)

			TornadoRoot = Instance.new("Part")
			TornadoRoot.Name = "SunaTornadoRoot"
			TornadoRoot.Anchored = true
			TornadoRoot.CanCollide = false
			TornadoRoot.CanTouch = false
			TornadoRoot.CanQuery = false
			TornadoRoot.Transparency = 1
			TornadoRoot.Size = Vector3.new(1, 1, 1)
			TornadoRoot.CFrame = CFrame.new(basePos, basePos + forward)
			TornadoRoot.Parent = workspace.World.Visuals
			Debris:AddItem(TornadoRoot, DURATION + 8)

			--RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
			--	Attacker = Character,
			--	SkillType = "Spawn",
			--	Root = TornadoRoot,
			--	Duration = DURATION,
			--})
			
			local TRAVEL_DISTANCE = 32 -- studs the tornado covers

			local destPos = basePos + forward * TRAVEL_DISTANCE
			local destHit = workspace:Raycast(destPos + Vector3.new(0, FLOOR_SNAP, 0), Vector3.new(0, -FLOOR_SNAP * 3, 0), MapRayParams)
			if destHit then
				destPos = destHit.Position
			end

			--RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
			--	Attacker    = Character,
			--	SkillType   = "Spawn",
			--	Root        = TornadoRoot,
			--	Destination = destPos,      -- NEW
			--	Tornado     = 1,            -- NEW (any id; only used for a tag)
			--	Duration    = DURATION,
			--})
			
			-- Clients don't use Root: with StreamingEnabled a part made this same frame usually
			-- hasn't reached them when this arrives, so it shows up as nil. They drive their own
			-- anchor along the same straight path the Root tweens along below, synced to server time.
			RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
				SkillType   = "NewTornado",
				Id          = tornadoId,
				Start       = TornadoRoot.CFrame,
				Destination = CFrame.new(destPos.X, basePos.Y, destPos.Z) * TornadoRoot.CFrame.Rotation,
				Duration    = DURATION,
				StartTime   = workspace:GetServerTimeNow(),
			})
						
			SoundHandler:AddSound(MoveSounds.Crocodile.Sables["Sand Wind"], TornadoRoot)

			mainHitbox = HitboxHandler.new()
			mainHitbox.Instance = TornadoRoot
			mainHitbox.Size = CATCH_SIZE
			mainHitbox.Offset = CFrame.new(0, CATCH_SIZE.Y / 2 - 3, 0)
			mainHitbox.Visualize = false
			mainHitbox.onTouch = function(EnemyCharacter)
				catch(EnemyCharacter)
			end
			mainHitbox:Start()

			-- Carve + capture (see CARVE_INTERVAL). Capture comes first each bite, so the funnel only
			-- grabs rubble from earlier bites: a piece grabbed in the same frame it was made could
			-- reach a client before the piece itself does.
			task.spawn(function()
				local captured = 0
				while not dissipated and TornadoRoot and TornadoRoot.Parent do
					local base = TornadoRoot.CFrame
					if captured < FUNNEL_MAX then
						captured += DebreeService.Absorb(base * CFrame.new(0, CAPTURE_SIZE.Y / 2 - ROOT_HEIGHT, 0), CAPTURE_SIZE, {
							Shape = "Oval",
							RubbleOnly = true,
							MaxTake = math.min(CAPTURE_PER_BITE, FUNNEL_MAX - captured),
							TargetId = tornadoId,
							Style = "Funnel",
							Attacker = Player,
						})
					end
					DebreeService.Destroy(base * CFrame.new(0, CARVE_SIZE.Y / 2 - ROOT_HEIGHT + CARVE_FLOOR_GAP, -CARVE_AHEAD), CARVE_SIZE, {
						Shape = "Oval",
						Outward = true,
						Attacker = Character,
						KeepGround = true,
					})
					task.wait(CARVE_INTERVAL)
				end
			end)

			-- Travel the SAME way the client vfx does: linear tween to the same
			-- destination over DURATION, so the hitbox + orbiting victims ride
			-- exactly with the visual (keep spawn height, like the client).
			local travelTarget = CFrame.new(destPos.X, basePos.Y, destPos.Z) * TornadoRoot.CFrame.Rotation
			TweenService:Create(TornadoRoot, TweenInfo.new(DURATION, Enum.EasingStyle.Linear), {
				CFrame = travelTarget,
			}):Play()
			
			task.spawn(function()
				while not dissipated and TornadoRoot and TornadoRoot.Parent do
					local Position = {
						Seed = math.random(1, 100000),
						start = (TornadoRoot.CFrame * CFrame.new(0.1, 0.1, -2.12)).Position,
						["end"] = Vector3.new(0, -10, 0),
						amount = math.floor(1 * RNG:NextNumber(2, 4) + 0.5),
						nosound = true,
						nosmoke = true,
						sizemult = 0.35 * RNG:NextNumber(0.7, 1.3),
						size = 0.5 * RNG:NextNumber(0.7, 1.3),
						nodebris = true,
					}
					
					RemotesContainer.Replicate.Set:FireAllClients('Ground Crater', Position)
					RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
						SkillType = "Rocks",
						Root      = TornadoRoot,
						TornadoCFrame = TornadoRoot.CFrame * CFrame.new(0, 5, 0),
					})

					task.wait(.4)
				end
			end)

			-- Safety: caster despawns mid-flight -> tear the tornado down (no throw).
			despawnConn = Character.AncestryChanged:Connect(function(_, parent)
				if not parent then
					finishTornado(false)
				end
			end)

			-- Natural end: fling everyone up and fade out.
			task.delay(DURATION, function()
				finishTornado(true)
			end)
		end)

		UserTrack:GetMarkerReachedSignal("hold"):Once(function()
			print("Hold")
			RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
				SkillType = "SablesHold",
				Attacker  = Character,
			})
		end)

		-- Animation ending only frees the CASTER; the tornado keeps going.
		UserTrack.Stopped:Once(function()
			finishCaster()
		end)
		
		

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		RemotesContainer.ClientEffects:FireAllClients(EFFECT_NAME, {
			SkillType = "Jump",
			Attacker  = Character,
		})
		
	end,
}