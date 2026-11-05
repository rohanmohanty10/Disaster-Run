--[[
	DrownService (Script)
	Place in: ServerScriptService

	SERVER half of drowning: authority only (ragdoll + damage).
	While a character's entire body is below sea level:
	- they get ragdolled (no drowning animation -- the body just goes limp)
	- they get stunned
	- they take damage over time via your DamageHandler (self as attacker,
	  so no kill/streak is wrongly credited)

	The CLIENT (DrownSink LocalScript) handles the velocity kill and the sink.
	The ragdoll lives here because RagdollHandler is server-authoritative.

	Death/respawn is handled by your DataInit HealthChanged handler when HP
	hits 0 (ragdoll + delayed respawn).
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local ServerModules = ServerStorage.SBGModules
local DamageHandler = require(ServerModules.DamageHandler)
local StunHandler = require(ServerModules.StunHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)

-- ============================================================
-- Config (keep SEA_LEVEL / SUBMERGE_MARGIN matching DrownSink)
-- ============================================================

local SEA_LEVEL       = 0    -- water surface Y
local SUBMERGE_MARGIN = 0    -- extra studs the head must be under before it counts
local TICK_INTERVAL   = 0.5  -- seconds between damage ticks
local DAMAGE_PER_TICK  = 6   -- HP removed each tick (0.5s). ~12 HP/sec at defaults.
local NO_DROWN_TAG    = "NoDrown" -- characters with this tag never drown

-- ============================================================
-- Damage via your DamageHandler (self as attacker = no kill credit)
-- ============================================================

local function applyDrownDamage(character, humanoid)
	DamageHandler:TakeDamage(
		character,       -- Damager (self; your module guards Damager == Damaged)
		humanoid,        -- EnemyHumanoid
		DAMAGE_PER_TICK, -- Damage
		nil,             -- StunTime (we handle the stun ourselves)
		nil,             -- Animation (none -- the ragdoll is the visual)
		false,           -- Blockable
		false,           -- Counterable
		true,            -- bypassStunImmunity
		false,           -- addAwkProgress
		true,            -- doFinisher
		"Drown",         -- Type
		nil              -- FinisherRequirement
	)
end

-- ============================================================
-- State
-- ============================================================

local drowning = {} -- [character] = { stun, nextTick, nextRagdollTry }

local RAGDOLL_RETRY = 0.5 -- seconds between re-ragdoll attempts while still under

-- Indefinite ragdoll (-1) so the body stays limp for as long as they're under.
-- checkAir = false: there's nothing to land on out at sea, so the air detector
-- would just spin a pointless client loop.
-- ragdoll() applies its own stun, but that one respects StunImmunity (which
-- cancelRagdoll hands out for .5s), so we keep our own that ignores it to be
-- sure they stay locked down while submerged.
local function applyDrownRagdoll(character, humanoid, state)
	RagdollHandler.ragdoll(humanoid, -1, false, nil, nil, nil, false)

	if not (state.stun and state.stun.Parent) then
		state.stun = StunHandler:Stun(character, nil, true, 0, 0) -- 5-arg form, like DataInit
	end
end

local function startDrown(character, humanoid)
	if drowning[character] then return end

	local state = { stun = nil, nextTick = 0, nextRagdollTry = 0 }
	drowning[character] = state
	applyDrownRagdoll(character, humanoid, state)
end

local function stopDrown(character)
	local state = drowning[character]
	if not state then return end
	drowning[character] = nil

	-- Leave a dead body alone: DataInit ragdolls it on death and we'd undo that.
	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	if humanoid and humanoid.Health > 0 then
		pcall(function()
			RagdollHandler.cancelRagdoll(humanoid, nil, false, nil, false, true)
		end)
	end

	if state.stun then
		pcall(function() StunHandler:Unstun(character, state.stun) end)
	end
end

-- ============================================================
-- Per-frame check
-- ============================================================

RunService.Heartbeat:Connect(function()
	local now = os.clock()

	for _, player in Players:GetPlayers() do
		local character = player.Character
		if not character then continue end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		local head = character:FindFirstChild("Head")

		if not (humanoid and head) or humanoid.Health <= 0 then
			if drowning[character] then stopDrown(character) end
			continue
		end

		if character:HasTag(NO_DROWN_TAG) then
			if drowning[character] then stopDrown(character) end
			continue
		end

		-- Entire body under water = top of the head is below the surface
		local topOfHead = head.Position.Y + head.Size.Y / 2
		if topOfHead < (SEA_LEVEL - SUBMERGE_MARGIN) then
			if not drowning[character] then
				startDrown(character, humanoid)
			end
			local state = drowning[character]

			-- They can evasive out of a ragdoll; while still under, put them
			-- straight back into it. Throttled so a blocked ragdoll (NoRagdoll
			-- command/config) doesn't retry every frame.
			if state and not character:HasTag("Ragdolled") and now >= state.nextRagdollTry then
				state.nextRagdollTry = now + RAGDOLL_RETRY
				applyDrownRagdoll(character, humanoid, state)
			end

			if state and now >= state.nextTick then
				state.nextTick = now + TICK_INTERVAL
				applyDrownDamage(character, humanoid)
			end
		else
			if drowning[character] then
				stopDrown(character)
			end
		end
	end
end)

-- Cleanup on death / leaving
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.Died:Once(function()
			stopDrown(character)
		end)
	end)
	player.CharacterRemoving:Connect(function(character)
		stopDrown(character)
	end)
end)