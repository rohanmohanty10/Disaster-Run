-- Zoro — Fourth Ability (server)
-- Two animations:
--   Start : startup. Character is frozen in place. Marker "end" -> teleport + swap to the User anim.
--   User  : the actual attack. Marker "hit" -> hitbox, user rises into the air, enemy gets launched.
--
-- Teleport rules (fired on the Start anim's "end" marker):
--   * Cast forward up to TP_RANGE.
--   * If an enemy is inside that cast -> teleport right in front of them and face them.
--   * Otherwise -> teleport TP_RANGE forward, stopping short of any wall (see WALL_FOLDERS)
--     so the character never phases through it.

local ServerStorage     = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService    = game:GetService("Players")
local RunService        = game:GetService("RunService")
local Debris            = game:GetService("Debris")

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
local KnockbackModule  = require(ServerModules.KnockbackModule)
local PerfectKnockback = require(ServerModules.PerfectKnockback)

local ClientEffects        = RemotesContainer.ClientEffects
local ReplicateEffects_Set = RemotesContainer.Replicate.Set

-- ===== CONFIG ============================================================

local MOVE_NAME  = "ZoroAbility4"
local AnimFolder = ServerStorage.Assets.Animations.Zoro.Moveset.RegularMoveSet.Ability4 -- TODO

local START_ANIM = AnimFolder.Start   -- startup    | markers: end
local USER_ANIM  = AnimFolder.User    -- the attack | markers: hit

local COOLDOWN_TIME = 12

-- teleport
local TP_RANGE         = 30   -- how far forward we look for a target / how far we dash without one
local TP_WIDTH         = 12   -- how wide the search is (x)
local TP_HEIGHT        = 12   -- how tall the search is (y)
local TP_STOP_DISTANCE = 6    -- how far in front of the target we land
local WALL_BUFFER      = 5    -- stop this far short of a wall so we do not clip into it
local MATCH_TARGET_HEIGHT = true -- land at the target's height (follows them into the air)

-- the box used for the wall check. roughly character sized, so we cannot slip
-- through a pillar gap or a doorway edge the way a single thin ray can.
local WALL_CAST_SIZE = Vector3.new(4, 5, 1)

-- how long the server holds the character after the teleport, so a client that is
-- mid-turn cannot replicate its old position back over the teleport
local TP_HOLD_TIME = 0.1

-- hit
local HITBOX_SIZE   = Vector3.new(10, 10, 10)
local HITBOX_OFFSET = CFrame.new(0, 0, -5)
local DAMAGE        = 12

-- the user's own rise
local USER_FORWARD_VELOCITY = 15
local USER_UP_VELOCITY      = 40
local USER_LAUNCH_TIME      = 0.3

-- enemy launch
local ENEMY_UP_VELOCITY          = 85
local ENEMY_FINISHER_UP_VELOCITY = 800

-- everything the dash is not allowed to pass through. Destroyable.Map is the FLOOR,
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

local TargetOverlapParams = OverlapParams.new()
TargetOverlapParams.FilterType = Enum.RaycastFilterType.Include
TargetOverlapParams.FilterDescendantsInstances = { workspace.World.Live }

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

		local CooldownTime = COOLDOWN_TIME
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local Hit = {}
		local StartEvents, UserEvents = {}, {}
		local teleported = false
		local cleaned = false

		local function cleanup()
			if cleaned then return end
			cleaned = true

			for _, v in StartEvents do v:Disconnect() end
			for _, v in UserEvents  do v:Disconnect() end

			-- make sure the player always gets their character back
			pcall(function() HumRP:SetNetworkOwner(Player) end)

			--Character:RemoveTag("CantRotate")
			StunHandler:Unstun(Character, Stun)
			Character:SetAttribute("ZoroFourthAbility", nil)

			Player:SetAttribute("AbilityFourCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("AbilityFourCooldown", false)
				end
			end)
		end

		-- ===== startup anim: "end" marker -> teleport, then swap to the attack anim =====
		local StartTrack = AnimationService:getAnimationTrack(Character, START_ANIM)

		StartEvents["end"] = StartTrack:GetMarkerReachedSignal("end"):Once(function()
			if teleported then return end
			teleported = true

			local origin = HumRP.CFrame

			-- flatten the facing, a pitched root would aim the cast into the floor
			local lookDir = Vector3.new(origin.LookVector.X, 0, origin.LookVector.Z)
			lookDir = lookDir.Magnitude > 0.01 and lookDir.Unit or origin.LookVector

			local dashDist = getDashDistance(origin.Position, lookDir, TP_RANGE) -- clipped by walls

			-- closest valid enemy inside the forward cast
			local Target, bestDist = nil, math.huge

			if dashDist > 1 then
				local boxCF = CFrame.lookAt(origin.Position + lookDir * (dashDist / 2), origin.Position + lookDir * dashDist)
				local parts = workspace:GetPartBoundsInBox(boxCF, Vector3.new(TP_WIDTH, TP_HEIGHT, dashDist), TargetOverlapParams)

				for _, part in parts do
					-- limbs sit under the character, accessories one level deeper
					local EnemyCharacter = part.Parent
					if EnemyCharacter and not EnemyCharacter:FindFirstChildOfClass("Humanoid") then
						EnemyCharacter = EnemyCharacter.Parent
					end

					if EnemyCharacter and EnemyCharacter ~= Character then
						local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChildOfClass("Humanoid")
						local EnemyHumRP: BasePart    = EnemyCharacter:FindFirstChild("HumanoidRootPart")
						local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

						if EnemyHumanoid and EnemyHumRP
							and EnemyHumanoid.Health > 0
							and EnemyHumanoid:GetState() ~= Enum.HumanoidStateType.Dead
							and not (EnemyPlayer and not EnemyPlayer:FindFirstChild("LoadedData"))
						then
							-- distance measured along our look direction, so whoever is in front wins
							local dist = (EnemyHumRP.Position - origin.Position):Dot(lookDir)
							if dist > 0 and dist < bestDist then
								Target, bestDist = EnemyCharacter, dist
							end
						end
					end
				end
			end

			local destination
			local newCFrame

			if Target then
				local targetPos = Target.HumanoidRootPart.Position

				-- stand TP_STOP_DISTANCE in front of them, on the side we came from
				local toSelf = origin.Position - targetPos
				toSelf = Vector3.new(toSelf.X, 0, toSelf.Z)
				if toSelf.Magnitude < 0.1 then
					toSelf = -Vector3.new(lookDir.X, 0, lookDir.Z)
				end

				local landY = MATCH_TARGET_HEIGHT and targetPos.Y or origin.Position.Y
				destination = targetPos + toSelf.Unit * TP_STOP_DISTANCE
				destination = Vector3.new(destination.X, landY, destination.Z)

				-- never phase through a wall on the way there
				local toDest = destination - origin.Position
				local travel = toDest.Magnitude
				if travel > 0.01 then
					local allowed = getDashDistance(origin.Position, toDest.Unit, travel)
					if allowed < travel then
						destination = origin.Position + toDest.Unit * allowed
					end
				end

				newCFrame = CFrame.lookAt(destination, Vector3.new(targetPos.X, destination.Y, targetPos.Z))
			else
				destination = origin.Position + lookDir * dashDist
				-- keep the exact same rotation on a plain dash
				newCFrame = CFrame.new(destination) * (origin - origin.Position)
			end

			-- Take the root off the client for a moment. While the player owns it, a client that
			-- is mid-turn keeps streaming its own position up and simply overwrites this CFrame,
			-- which is why turning the camera used to eat the teleport entirely.
			pcall(function() HumRP:SetNetworkOwner(nil) end)

			HumRP.CFrame = newCFrame
			HumRP.AssemblyLinearVelocity = Vector3.zero

			-- hold it for a few frames so any packet already in flight loses
			task.spawn(function()
				local holdUntil = os.clock() + TP_HOLD_TIME
				while os.clock() < holdUntil do
					if cleaned or not HumRP.Parent then break end
					HumRP.CFrame = newCFrame
					RunService.Heartbeat:Wait()
				end

				pcall(function() HumRP:SetNetworkOwner(Player) end)
			end)

			ClientEffects:FireAllClients(MOVE_NAME, {
				Attacker    = Character,
				SkillType   = "teleport",
				Origin      = origin.Position,
				Destination = destination,
				Target      = Target,
			})

			-- ===== swap into the attack anim =====
			for _, v in StartEvents do v:Disconnect() end
			table.clear(StartEvents)
			pcall(function() StartTrack:Stop(0.1) end)

			local UserTrack = AnimationService:getAnimationTrack(Character, USER_ANIM)

			-- ===== attack anim: "hit" marker -> user goes up, enemy gets launched =====
			UserEvents["hit"] = UserTrack:GetMarkerReachedSignal("hit"):Once(function()
				-- the user rides up with the swing.
				-- NOTE: do NOT name this "moveme" — the client movement loop would grab it and keep
				-- re-driving it forward. And do NOT fire clearVelocities around here, the client
				-- handler would delete this the moment it arrives.
				local forwardDirection = HumRP.CFrame.LookVector * USER_FORWARD_VELOCITY
				local upwardDirection  = Vector3.new(0, USER_UP_VELOCITY, 0)

				local combinedVelocity = forwardDirection + upwardDirection

				local thrust = Instance.new("BodyVelocity")
				thrust.Velocity = combinedVelocity
				thrust.P = 1000
				thrust.MaxForce = Vector3.new(8000, 8000, 8000)
				thrust.Parent = HumRP

				Debris:AddItem(thrust, USER_LAUNCH_TIME)

				local Hitbox = HitboxHandler.new()
				Hitbox.Instance  = HumRP
				Hitbox.Size      = HITBOX_SIZE
				Hitbox.Offset    = HITBOX_OFFSET
				Hitbox.Ignore    = { Character }
				Hitbox.Visualize = false
				Hitbox.onTouch = function(EnemyCharacter)
					local EnemyHumanoid: Humanoid = EnemyCharacter:FindFirstChildOfClass("Humanoid")
					local EnemyHumRP: BasePart    = EnemyCharacter:FindFirstChild("HumanoidRootPart")
					if not (EnemyHumanoid and EnemyHumRP) then return end

					if Hit[EnemyCharacter] or iFramesService:HasiFrame(EnemyCharacter, 2) then return end
					if EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead then return end

					local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, DAMAGE, nil, nil, false, true, true, true, true, nil)
					if HitInfo.Countered == true then return end

					Hit[EnemyCharacter] = true

					if EnemyCharacter:HasTag("Ragdolled") then
						RagdollHandler.cancelRagdoll(EnemyHumanoid)
					end

					local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)

					if HitInfo.Finisher == true then
						KnockbackModule:Knockback(EnemyCharacter, HumRP.CFrame.LookVector * 115, Character, nil, nil, nil, true, true)
						NewKnockback:makeEnemyFaceCharacter(EnemyCharacter, Character)
						NewKnockback:Knockback(EnemyCharacter, {
							KnockbackType = "Velocity",
							MaxForce = Vector3.new(1, 1, 1) * math.huge,
							Velocity = Vector3.new(HumRP.CFrame.LookVector.X * 30, ENEMY_FINISHER_UP_VELOCITY, HumRP.CFrame.LookVector.Z * 30),
							Time = .4,
						})

						ReplicateEffects_Set:FireAllClients("Ground Crater", { Seed = math.random(1, 2000000000), start = HumRP.Position, ["end"] = Vector3.new(0, -7, 0), nodebris = true, amount = math.random(6, 8), nosound = true })
						ReplicateEffects_Set:FireAllClients("Ground Crater", { Seed = math.random(1, 2000000000), start = HumRP.Position, ["end"] = Vector3.new(0, -7, 0), nodebris = true, amount = math.random(8, 10), sizemult = 2.5, size = 4, nosound = true })
						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 8, Last = 1 } })
					else
						PerfectKnockback:KnockBack(EnemyCharacter, {
							LookVector        = HumRP.CFrame.LookVector,
							LookForce         = 20,
							LookFinalForce    = 40,
							EscapableCooldown = 5,
							UpVelocityTime    = 0.2,
							LookAt            = CFrame.lookAt((HumRP.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, math.pi, 0)).Position, HumRP.Position),
							UpVelocity        = Vector3.new(0, ENEMY_UP_VELOCITY, 0),
							DestroyRagdoll    = true,
							GroundStunTime    = 1.2,
							Escapable         = true,
							Saitama           = true,
						}, Character)

						shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 1, Last = 1 } })
					end

					ClientEffects:FireAllClients(MOVE_NAME, {
						Attacker  = Character,
						SkillType = "hit",
						Position  = EnemyHumRP.Position,
					})
				end

				Hitbox:Once()
				Hitbox:Destroy()
			end)

			UserTrack.Stopped:Once(cleanup)

			AnimationService:playAnimation(Character, USER_ANIM)
		end)

		-- if the startup anim ends without the marker ever firing, do not leave the player stuck
		StartTrack.Stopped:Once(function()
			task.defer(function()
				if teleported then return end
				cleanup()
			end)
		end)

		-- ===== go =============================================================
		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, START_ANIM)
		StartTrack:AdjustSpeed(1.5)

		--Character:AddTag("CantRotate")

		ClientEffects:FireAllClients(MOVE_NAME, {
			Attacker  = Character,
			SkillType = "start",
		})
	end,
}
