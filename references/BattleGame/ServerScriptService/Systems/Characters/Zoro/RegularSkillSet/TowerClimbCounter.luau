local MoveConfig = require(game:GetService("ServerScriptService").CharacterConfig).Zoro[4]
-- Zoro — Fourth Ability, COUNTER version (server)
--
-- Same two animations as Ability4, used differently:
--   Start : the counter STANCE. You hold it, slowed but not frozen. The counter window is
--           exactly as long as this animation. Its "end" marker is unused here.
--   User  : the punish, played only if someone actually hits you. Marker "hit" -> damage,
--           user rises into the air, enemy gets launched.
--
-- How the counter fires: DamageHandler skips the damage branch when the victim has the
-- "Countering" tag and the attack was flagged Counterable, but CombatLogger still parents a
-- DamagedLog ObjectValue into your character, tagged "Counterable", whose .Value is the
-- attacker's character. Watching ChildAdded for that is how every counter in this game works.

local ServerStorage     = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService    = game:GetService("Players")
local RunService        = game:GetService("RunService")
local Debris            = game:GetService("Debris")

local ServerModules     = ServerStorage.SBGModules
local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer  = ReplicatedStorage.Remotes

local StunHandler      = require(ServerModules.StunHandler)
local DamageHandler    = require(ServerModules.DamageHandler)
local RagdollHandler   = require(ServerModules.RagdollHandler)
local NewKnockback     = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService   = require(ServerModules.iFramesService)
local CollisionsModule = require(ServerModules.CollisionsModule)
local KnockbackModule  = require(ServerModules.KnockbackModule)
local PerfectKnockback = require(ServerModules.PerfectKnockback)

local ClientEffects        = RemotesContainer.ClientEffects
local ReplicateEffects_Set = RemotesContainer.Replicate.Set

-- ===== CONFIG ============================================================

local MOVE_NAME  = "ZoroAbility4Counter"
local AnimFolder = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.Ability4 -- TODO

local START_ANIM = AnimFolder.Start2   -- the stance | markers: none used
local USER_ANIM  = AnimFolder.User2    -- the punish | markers: hit

local COOLDOWN_TIME       = MoveConfig.Cooldown   -- after a successful counter
local COOLDOWN_TIME_WHIFF = MoveConfig.CooldownWhiff    -- after the stance runs out with nothing caught

local STANCE_WALKSPEED = 5    -- you can shuffle while holding the stance. 0 to root yourself.

-- closing on the attacker. we land BEHIND them, squared up with their own facing,
-- so we end up directly at their back looking the same way they are.
local TP_TO_ATTACKER     = true -- false = punish from wherever you are standing
local TP_BEHIND_DISTANCE = 6    -- how far behind their back we land
local WALL_BUFFER        = 5    -- stop this far short of a wall so we do not clip into it
local WALL_CAST_SIZE   = Vector3.new(4, 5, 1)
local TP_HOLD_TIME     = 0.1  -- server holds the root this long so the client cannot undo it

-- hit
local DAMAGE = MoveConfig.Damage.Counter

-- the user's own rise
local USER_FORWARD_VELOCITY = 15
local USER_UP_VELOCITY      = 40
local USER_LAUNCH_TIME      = 0.3



-- enemy launch
local ENEMY_UP_VELOCITY          = 85
local ENEMY_LAUNCH_FORWARD       = 40   -- replaces PerfectKnockback's LookFinalForce
local ENEMY_RAGDOLL_TIME         = 2    -- PerfectKnockback owned the stun; ragdoll takes over
local ENEMY_FINISHER_UP_VELOCITY = 500


-- everything the close-in is not allowed to pass through. Destroyable.Map is the FLOOR,
-- so it is deliberately left out — add more folders here if a wall still gets skipped.
local WALL_FOLDERS = {}
do
	local Map = workspace.World.Map

	local Indestructible = Map:FindFirstChild("Indestructible Map")
	if Indestructible then table.insert(WALL_FOLDERS, Indestructible) end

	local Destroyable = Map:FindFirstChild("Destroyable")
	if Destroyable then
		for _, name in { "Buildings" } do
			local folder = Destroyable:FindFirstChild(name)
			if folder then table.insert(WALL_FOLDERS, folder) end
		end
	end
end

local WallParams = RaycastParams.new()
WallParams.FilterType = Enum.RaycastFilterType.Include
WallParams.FilterDescendantsInstances = WALL_FOLDERS
WallParams.RespectCanCollide = true
WallParams.IgnoreWater = true

-- how far we can travel before a wall stops us
local function getDashDistance(originPos: Vector3, direction: Vector3, maxDist: number): number
	local castCF = CFrame.lookAt(originPos, originPos + direction)
	local result = workspace:Blockcast(castCF, WALL_CAST_SIZE, direction * maxDist, WallParams)
	if result then
		return math.max(result.Distance - WALL_BUFFER, 0)
	end
	return maxDist
end

-- =========================================================================

return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		if not Character then return end

		local Humanoid: Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumRP: BasePart    = Character:FindFirstChild("HumanoidRootPart")
		if not (Humanoid and HumRP) then return end

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("AbilityFourCooldown") then return end
		if Character:GetAttribute("ZoroFourthAbility") then return end

		Player:SetAttribute("AbilityFourCooldown", true)
		Character:SetAttribute("ZoroFourthAbility", true)

		local NoCooldown = Player.Commands.NoCooldown.Value == true

		local Stun = StunHandler:Stun(Character, nil, true, STANCE_WALKSPEED, 0, true)

		local COUNTER = false
		local cleaned = false
		local CounterConnection: RBXScriptConnection
		local UserEvents = {}

		local function startCooldown(duration: number)
			if NoCooldown then duration = .5 end

			Player:SetAttribute("AbilityFourCooldown", duration)
			task.delay(duration, function()
				if Player then
					Player:SetAttribute("AbilityFourCooldown", false)
				end
			end)
		end

		-- ===== the stance runs out with nothing caught =====
		local StartTrack = AnimationService:getAnimationTrack(Character, START_ANIM)

		StartTrack.Stopped:Once(function()
			if COUNTER then return end -- the punish owns the cleanup from here

			if CounterConnection then
				CounterConnection:Disconnect()
				CounterConnection = nil
			end

			Character:RemoveTag("Countering")
			StunHandler:Unstun(Character, Stun)
			Character:SetAttribute("ZoroFourthAbility", nil)

			startCooldown(COOLDOWN_TIME_WHIFF)

			ClientEffects:FireAllClients(MOVE_NAME, { Attacker = Character, SkillType = "whiff" })
		end)

		-- ===== something hit us =====
		CounterConnection = Character.ChildAdded:Connect(function(child)
			if child.Name ~= "DamagedLog" or not child:HasTag("Counterable") then return end

			local EnemyCharacter: Model = child.Value
			if not EnemyCharacter or not EnemyCharacter.Parent then return end

			local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChildOfClass("Humanoid")
			local EnemyHumRP: BasePart    = EnemyCharacter:FindFirstChild("HumanoidRootPart")
			if not (EnemyHumanoid and EnemyHumRP) then return end
			if EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

			COUNTER = true

			CounterConnection:Disconnect()
			CounterConnection = nil

			Character:RemoveTag("Countering")

			local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

			-- lock both of us down for the punish
			local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)
			Stun:SetAttribute("WalkSpeed", 0) -- the stance let us shuffle, freeze us now

			iFramesService:AddAlliFrames(Character)
			iFramesService:AddAlliFrames(EnemyCharacter)

			CollisionsModule:SetCollisionGroup(Character, "GrabbedPlayers")
			CollisionsModule:SetCollisionGroup(EnemyCharacter, "GrabbedPlayers")

			Character:AddTag("CantRotate")
			EnemyCharacter:AddTag("CantRotate")

			if EnemyCharacter:HasTag("Ragdolled") then
				RagdollHandler.cancelRagdoll(EnemyHumanoid)
			end

			local function cleanup()
				if cleaned then return end
				cleaned = true

				for _, v in UserEvents do v:Disconnect() end

				pcall(function() HumRP:SetNetworkOwner(Player) end)

				StunHandler:Unstun(Character, Stun)
				Character:RemoveTag("CantRotate")
				Character:RemoveTag("Countering")
				iFramesService:RemoveAlliFrames(Character)
				CollisionsModule:SetCollisionGroup(Character, "Players")

				Character:SetAttribute("ZoroFourthAbility", nil)
				startCooldown(COOLDOWN_TIME)
			end

			-- ===== close the distance on whoever hit us =====
			if TP_TO_ATTACKER then
				local origin    = HumRP.CFrame
				local targetPos = EnemyHumRP.Position

				-- their facing, flattened. everything below is measured off this so we end up
				-- at their back rather than wherever we happened to be standing.
				local enemyLook = EnemyHumRP.CFrame.LookVector
				local enemyFlat = Vector3.new(enemyLook.X, 0, enemyLook.Z)
				if enemyFlat.Magnitude < 0.01 then
					-- ragdolled root lying flat, fall back to the line between us
					local fallback = targetPos - origin.Position
					fallback = Vector3.new(fallback.X, 0, fallback.Z)
					enemyFlat = fallback.Magnitude > 0.01 and fallback or Vector3.new(0, 0, -1)
				end
				enemyFlat = enemyFlat.Unit

				-- straight back from their chest, TP_BEHIND_DISTANCE behind them
				local destination = targetPos - enemyFlat * TP_BEHIND_DISTANCE
				destination = Vector3.new(destination.X, targetPos.Y, destination.Z)

				-- never phase through a wall on the way there
				local toDest = destination - origin.Position
				local travel = toDest.Magnitude
				if travel > 0.01 then
					local allowed = getDashDistance(origin.Position, toDest.Unit, travel)
					if allowed < travel then
						destination = origin.Position + toDest.Unit * allowed
					end
				end

				-- face the SAME way they are facing, not at them — we are at their back
				local newCFrame = CFrame.lookAt(destination, destination + enemyFlat)

				-- take the root off the client for a moment, otherwise a client that is
				-- mid-turn replicates its own position straight back over this
				pcall(function() HumRP:SetNetworkOwner(nil) end)

				HumRP.CFrame = newCFrame
				HumRP.AssemblyLinearVelocity = Vector3.zero

				task.spawn(function()
					local holdUntil = os.clock() + TP_HOLD_TIME
					while os.clock() < holdUntil do
						if cleaned or not HumRP.Parent then break end
						HumRP.CFrame = newCFrame
						RunService.Heartbeat:Wait()
					end

					pcall(function() HumRP:SetNetworkOwner(Player) end)
				end)

				-- deliberately NOT calling makeEnemyFaceCharacter here — spinning them round
				-- would put us back in front of them, which is the whole thing we just avoided

				ClientEffects:FireAllClients(MOVE_NAME, {
					Attacker    = Character,
					SkillType   = "teleport",
					Origin      = origin.Position,
					Destination = destination,
					Target      = EnemyCharacter,
				})
			end

			-- ===== the punish =====
			-- stop everything FIRST. connecting Stopped before this point means a leftover
			-- User track being stopped here would fire cleanup before the punish even starts.
			ClientEffects:FireAllClients(MOVE_NAME, {
				Attacker  = Character,
				SkillType = "counter",
				Target    = EnemyCharacter,
			})

			pcall(function() StartTrack:Stop(0.1) end)

			AnimationService:stopAll(Character)
			AnimationService:stopAll(EnemyCharacter)

			local UserTrack = AnimationService:getAnimationTrack(Character, USER_ANIM)

			UserEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
				-- the user rides up with the swing.
				-- NOTE: do NOT name this "moveme" — the client movement loop would grab it and keep
				-- re-driving it forward. And do NOT fire clearVelocities around here, the client
				-- handler would delete this the moment it arrives.
				local forwardDirection = HumRP.CFrame.LookVector * USER_FORWARD_VELOCITY
				local upwardDirection  = Vector3.new(0, USER_UP_VELOCITY, 0)

				local thrust = Instance.new("BodyVelocity")
				thrust.Velocity = forwardDirection + upwardDirection
				thrust.P = 1000
				thrust.MaxForce = Vector3.new(8000, 8000, 8000)
				thrust.Parent = HumRP

				Debris:AddItem(thrust, USER_LAUNCH_TIME)

				-- no hitbox — a counter already knows exactly who it is punishing
				if not EnemyCharacter.Parent or EnemyHumanoid.Health <= 0 then return end

				-- iFrames are ours, drop the enemy's so the punish lands
				iFramesService:RemoveAlliFrames(EnemyCharacter)

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, DAMAGE, nil, nil, false, false, true, true, true, nil)

				if HitInfo.Finisher == true then
					KnockbackModule:Knockback(EnemyCharacter, HumRP.CFrame.LookVector * 115, Character, nil, nil, nil, true, true)
					NewKnockback:Knockback(EnemyCharacter, {
						KnockbackType = "Velocity",
						MaxForce = Vector3.new(1, 1, 1) * math.huge,
						Velocity = Vector3.new(HumRP.CFrame.LookVector.X * 100, ENEMY_FINISHER_UP_VELOCITY, HumRP.CFrame.LookVector.Z * 30),
						Time = .4,
					})

					ReplicateEffects_Set:FireAllClients("Ground Crater", { Seed = math.random(1, 2000000000), start = HumRP.Position, ["end"] = Vector3.new(0, -7, 0), nodebris = true, amount = math.random(6, 8), nosound = true })
					ReplicateEffects_Set:FireAllClients("Ground Crater", { Seed = math.random(1, 2000000000), start = HumRP.Position, ["end"] = Vector3.new(0, -7, 0), nodebris = true, amount = math.random(8, 10), sizemult = 2.5, size = 4, nosound = true })
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 8, Last = .5 } })
				else
					--ReplicateEffects_Set:FireAllClients("Ring", {
					--	FirstProps = {
					--		Size         = Vector3.new(3, 8, 3),    -- narrow + TALL
					--		Transparency = 0.1,
					--	},

					--	--CF = CFrame.new(EnemyHumRP.Position - Vector3.new(0, -3, 0)),
					--	CF = CFrame.new(HumRP.Position + Vector3.new(0, 3, -1)),

					--	TN_Info = {
					--		Time      = 0.35,
					--		Style     = "Quad",
					--		Direction = "Out",
					--	},

					--	FinalProps = {
					--		Size         = Vector3.new(18, 0.3, 18),  -- WIDE + flat
					--		Transparency = .9,
					--	},
					--})
					local RING_FORWARD = 6    -- studs out in front
					local RING_HEIGHT  = 5    -- studs up
					local RING_TILT    = -15   -- degrees, front edge lifts

					local look     = HumRP.CFrame.LookVector
					local flatLook = Vector3.new(look.X, 0, look.Z)
					flatLook = flatLook.Magnitude > 0.01 and flatLook.Unit or Vector3.new(0, 0, -1)

					local ringPos = HumRP.Position
						+ flatLook * RING_FORWARD
						+ Vector3.new(0, RING_HEIGHT, 0)

					ReplicateEffects_Set:FireAllClients("Ring", {
						FirstProps = {
							Size         = Vector3.new(3, 8, 3),    -- narrow + TALL
							Transparency = 0.1,
						},

						-- lookAt keeps the ring flat and squared to our facing, then the
						-- Angles tips it back along the enemy's launch arc
						CF = CFrame.lookAt(ringPos, ringPos + flatLook)
							* CFrame.Angles(math.rad(RING_TILT), 0, 0),

						TN_Info = {
							Time      = 0.35,
							Style     = "Quad",
							Direction = "Out",
						},

						FinalProps = {
							Size         = Vector3.new(18, 0.3, 18),  -- WIDE + flat
							Transparency = .9,
						},
					})
					
					--PerfectKnockback:KnockBack(EnemyCharacter, {
					--	LookVector        = HumRP.CFrame.LookVector,
					--	LookForce         = 20,
					--	LookFinalForce    = 40,
					--	EscapableCooldown = 5,
					--	UpVelocityTime    = 0.2,
					--	LookAt            = CFrame.lookAt((HumRP.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, math.pi, 0)).Position, HumRP.Position),
					--	UpVelocity        = Vector3.new(0, ENEMY_UP_VELOCITY, 0),
					--	DestroyRagdoll    = true,
					--	GroundStunTime    = 1.2,
					--	Escapable         = true,
					--	Saitama           = true,
					--}, Character)
					
					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid)
					end
					RagdollHandler.ragdoll(EnemyHumanoid, 2)
					
					NewKnockback:Knockback(EnemyCharacter, {
						KnockbackType = "Velocity",
						MaxForce = Vector3.new(100000, 50000, 100000),
						Velocity = HumRP.CFrame.LookVector * ENEMY_LAUNCH_FORWARD
							+ Vector3.new(0, ENEMY_UP_VELOCITY, 0),
					})
					shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 5, Last = .3 } })

					--task.delay(0.05, function()
						--RagdollHandler.ragdoll(EnemyHumanoid, ENEMY_RAGDOLL_TIME)
					--end)
					

					--shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 1, Last = 1 } })
				end

				-- PerfectKnockback runs its own stun, so hand the enemy back
				StunHandler:Unstun(EnemyCharacter, EnemyStun)
				EnemyCharacter:RemoveTag("CantRotate")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")

				-- Target is what the client module needs to stick the wind + trail rings on
				ClientEffects:FireAllClients(MOVE_NAME, {
					Attacker  = Character,
					SkillType = "enemyAir",
					Target    = EnemyCharacter,
					Position  = EnemyHumRP.Position,
				})
			end)

			UserTrack.Stopped:Once(cleanup)

			AnimationService:playAnimation(Character, USER_ANIM)

			-- if the punish never reaches its Stopped (death, respawn), do not strand anyone
			task.delay(6, function()
				if not cleaned then
					pcall(function()
						StunHandler:Unstun(EnemyCharacter, EnemyStun)
						EnemyCharacter:RemoveTag("CantRotate")
						iFramesService:RemoveAlliFrames(EnemyCharacter)
						CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")
					end)
					cleanup()
				end
			end)
		end)

		-- ===== go =============================================================
		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, START_ANIM)

		Character:AddTag("Countering")

		ClientEffects:FireAllClients(MOVE_NAME, {
			Attacker  = Character,
			SkillType = "stance",
		})
	end,
}
