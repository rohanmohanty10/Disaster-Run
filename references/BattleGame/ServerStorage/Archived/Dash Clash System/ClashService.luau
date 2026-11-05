--!strict
-- ClashService
-- Place at: ServerStorage.SBGModules.ClashService  (ModuleScript)
-- Server-only orchestration for the dash clash.
--
-- Called from the combat server script's front-dash handler:
--     local ClashService = require(SvSt.SBGModules.ClashService)
--     if ClashService.tryStartClash(Character, EnemyCharacter) then ... end
--
-- Two resolution modes, switched live by workspace.Configuration.ClashMode:
--     "QTE"    -> reuses the QuickTimeEvents module (the provided bar UI)
--     "Random" -> instant server roll of win / lose / draw
--
-- Flow guarantees:
--   * both players are welded face-to-face and tagged CantRotate (no spinning)
--   * the weld is ALWAYS broken before any knockback
--   * loser-only knockback on win/lose; BOTH knocked on a draw (PerfectKnockback)
--   * cleanup is guaranteed even if the decider errors or hangs (pcall + watchdog),
--     so a clash can never leave a player frozen forever

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local SvSt = game:GetService("ServerStorage")

--==================================================================================
-- CONFIG — your paths
--==================================================================================

-- The QTE asset (must be in ReplicatedStorage so its client UI can replicate).
local QuickTimeEvents = require(RS.Modules.QuickTimeEvents)

-- Holds the Idle / Winner / Looser / Knockback animations.
local ClashModel = SvSt.Assets.Animations.Clash

-- Reuse existing server modules.
local SvModules = SvSt.SBGModules
local DamageHandler = require(SvModules.DamageHandler)
local StunHandler = require(SvModules.StunHandler)
local AnimationService = require(SvModules.AnimationService)
local SoundsModule = require(SvModules.SoundsModule)
local PerfectKnockback = require(SvModules.PerfectKnockback)

local WeldSystem = require(RS.Modules.WeldSystem)

local Remotes = RS.Remotes
local ReplicateSet = Remotes.Replicate.Set
local ClashRemotes = Remotes:WaitForChild("Clash") -- folder with: Start, Result

--==================================================================================
-- Tunables
--==================================================================================

-- Weld offset for part1 (enemy HRP) relative to part0 (initiator HRP). The
-- CFrame.Angles(0, math.pi, 0) faces them at each other, like your skill welds.
local CLASH_WELD_C0 = CFrame.new(0, 0, -3.5) * CFrame.Angles(0, math.pi, 0)
local CLASH_DAMAGE = 15
local GUARD_CLEAR_DELAY = 0.5

-- RANDOM mode only: how long the two stay locked/struggling before the winner is
-- rolled. Change this number, OR add a NumberValue "ClashRandomDuration" under
-- workspace.Configuration to tune it live without editing code.
local RANDOM_CLASH_DURATION = 2

-- Optional winner punch-back animation (see _applyOutcome). If an animation with
-- this name exists in your Clash anim folder, the winner plays it and the knockback
-- fires on its marker; otherwise it falls back to the "Winner" anim + instant knock.
local WINNER_PUNCH_ANIM = "WinnerPunch"
local WINNER_PUNCH_MARKER = "hit"

-- Hard ceiling: if the decider never returns (e.g. QTE hangs), force a draw and
-- free both players after this many seconds. Keep it above RANDOM_CLASH_DURATION
-- and the QTE timeout.
local CLASH_MAX_DURATION = 8

--==================================================================================
-- Helpers
--==================================================================================

local function getConfigString(name: string, default: string): string
	local v = workspace.Configuration:FindFirstChild(name)
	return (v and v.Value) or default
end

local function getConfigNumber(name: string, default: number): number
	local v = workspace.Configuration:FindFirstChild(name)
	-- tonumber so a StringValue ("2") still works instead of erroring on compare.
	return (v and tonumber(v.Value)) or default
end

-- Recursive lookup so you don't have to hard-code the exact sub-path of each anim.
local function findAnim(name: string): Animation?
	local found = ClashModel:FindFirstChild(name, true)
	return (found and found:IsA("Animation")) and found or nil
end

local ClashService = {}

-- charactersInClash[character] = true while it is mid-clash. Used as the dedupe
-- guard so the two dash handlers (A->B and B->A) can't both start a clash.
local charactersInClash: { [Model]: boolean } = {}

--==================================================================================
-- Entry point
--==================================================================================

function ClashService._canClash(char: Model): boolean
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum or hum.Health <= 0 then return false end
	if char:GetAttribute("IsHeavyStun") then return false end
	if char:GetAttribute("InClash") then return false end
	if char:HasTag("Ragdolled") then return false end
	return true
end

-- Returns true if a clash was claimed (caller should then cancel its normal dash hit).
function ClashService.tryStartClash(charA: Model, charB: Model): boolean
	if charactersInClash[charA] or charactersInClash[charB] then return false end
	if not ClashService._canClash(charA) or not ClashService._canClash(charB) then return false end

	charactersInClash[charA] = true
	charactersInClash[charB] = true
	charA:SetAttribute("InClash", true)
	charB:SetAttribute("InClash", true)

	task.spawn(ClashService._runClash, charA, charB)
	return true
end

--==================================================================================
-- Main flow
--==================================================================================

function ClashService._runClash(charA: Model, charB: Model)
	local hrpA = charA:FindFirstChild("HumanoidRootPart") :: BasePart
	local hrpB = charB:FindFirstChild("HumanoidRootPart") :: BasePart
	local plrA = Players:GetPlayerFromCharacter(charA)
	local plrB = Players:GetPlayerFromCharacter(charB)
	local mode = getConfigString("ClashMode", "QTE")
	print(("[ClashService] %s vs %s — mode: %s"):format(charA.Name, charB.Name, mode))

	-- Freeze + lock rotation for the duration.
	local stunA = StunHandler:Stun(charA, nil, true, 0, 0, true)
	local stunB = StunHandler:Stun(charB, nil, true, 0, 0, true)
	charA:AddTag("CantRotate")
	charB:AddTag("CantRotate")

	-- Weld them face-to-face (charA is part0). -1 = stays until we Stop() it.
	local weld = WeldSystem.new(hrpA, hrpB, CLASH_WELD_C0, -1)
	weld:Start(nil, plrA)

	-- Struggle / idle "push" animation on both (from the Clash anim folder).
	local idleAnim = findAnim("Idle")
	if idleAnim then
		AnimationService:stopAll(charA)
		AnimationService:stopAll(charB)
		AnimationService:playAnimation(charA, idleAnim)
		AnimationService:playAnimation(charB, idleAnim)
	end

	-- Shared cinematic feel.
	if plrA then ClashRemotes.Start:FireClient(plrA, { Mode = mode, Opponent = charB }) end
	if plrB then ClashRemotes.Start:FireClient(plrB, { Mode = mode, Opponent = charA }) end
	ReplicateSet:FireAllClients("smokeEffect", { time = 0.3, char = charA })
	ReplicateSet:FireAllClients("smokeEffect", { time = 0.3, char = charB })

	-- ----------------------------------------------------------------------------
	-- finish(): runs exactly once. Breaks the weld + frees both BEFORE knockback.
	-- ----------------------------------------------------------------------------
	local finished = false
	local function finish(winner: Model?, loser: Model?)
		if finished then return end
		finished = true

		if idleAnim then
			AnimationService:stopAnimation(charA, idleAnim)
			AnimationService:stopAnimation(charB, idleAnim)
		end

		-- 1) BREAK THE WELD FIRST.
		if weld then
			pcall(function() weld:Stop() end)
			weld = nil
		end

		-- 2) Unlock rotation + unfreeze so the knockback can actually move them.
		charA:RemoveTag("CantRotate")
		charB:RemoveTag("CantRotate")
		StunHandler:Unstun(charA, stunA)
		StunHandler:Unstun(charB, stunB)

		-- 3) Let the weld removal settle a frame, THEN knock back.
		task.wait()

		if winner and loser then
			ClashService._applyOutcome(winner, loser)
			local wp = Players:GetPlayerFromCharacter(winner)
			local lp = Players:GetPlayerFromCharacter(loser)
			if wp then ClashRemotes.Result:FireClient(wp, { Result = "win" }) end
			if lp then ClashRemotes.Result:FireClient(lp, { Result = "lose" }) end
		else
			ClashService._applyDraw(charA, charB)
			if plrA then ClashRemotes.Result:FireClient(plrA, { Result = "draw" }) end
			if plrB then ClashRemotes.Result:FireClient(plrB, { Result = "draw" }) end
		end

		task.delay(GUARD_CLEAR_DELAY, function()
			charactersInClash[charA] = nil
			charactersInClash[charB] = nil
			charA:SetAttribute("InClash", nil)
			charB:SetAttribute("InClash", nil)
		end)
	end

	-- Watchdog: never let the clash hang (e.g. if the QTE never returns).
	task.delay(CLASH_MAX_DURATION, function()
		if not finished then
			warn("[ClashService] clash timed out — forcing draw")
			finish(nil, nil)
		end
	end)

	-- Decide the winner. pcall so a decider error can't skip cleanup.
	local ok, winner, loser = pcall(function()
		if mode == "Random" then
			return ClashService._resolveRandom(charA, charB)
		else
			return ClashService._resolveQTE(plrA, plrB, charA, charB)
		end
	end)
	if not ok then
		warn("[ClashService] decider error:", winner) -- 'winner' holds the error message
		winner, loser = nil, nil
	end

	finish(winner, loser)
end

--==================================================================================
-- Deciders
--==================================================================================

-- Random mode: ALWAYS a draw. Both players get perfect-knocked back after a
-- configurable hold. No winner/loser is ever chosen in this mode.
function ClashService._resolveRandom(charA: Model, charB: Model): (Model?, Model?)
	-- Stay locked + struggling for this long before resolving.
	task.wait(getConfigNumber("ClashRandomDuration", RANDOM_CLASH_DURATION))
	return nil, nil -- draw -> _applyDraw knocks BOTH away
end

-- QTE: reuse the provided QuickTimeEvents module (type "KeysSequence").
-- VERIFY against the real module in Studio:
--   * the exact activateQTE(...) argument order
--   * the param keys it reads (goalPoints / leader / timeoutTime)
--   * what its return value is (a Player? a Character? the string "draw"?)
-- The interpretation below handles Player OR Character OR "draw"/nil.
function ClashService._resolveQTE(plrA: Player?, plrB: Player?, charA: Model, charB: Model): (Model?, Model?)
	if not plrA or not plrB then
		-- A clash needs two real players for the bar; fall back to a draw.
		return nil, nil
	end

	local result = QuickTimeEvents.activateQTE(plrA, plrB, "KeysSequence", {
		goalPoints = { 5, 5 },  -- presses needed per side -- VERIFY shape
		leader = plrA,          -- VERIFY meaning in KeysSequence
		timeoutTime = 5,
	})

	if result == plrA or result == charA then
		return charA, charB
	elseif result == plrB or result == charB then
		return charB, charA
	else
		return nil, nil -- "draw" / timeout / nil
	end
end

--==================================================================================
-- Outcome application (PerfectKnockback) — weld is already broken before these run.
--==================================================================================

-- Knocks `victimChar` away from `attackerChar` using the same PerfectKnockback
-- pattern as your skill scripts.
function ClashService._perfectKnockAway(attackerChar: Model, victimChar: Model)
	local attackerHrp = attackerChar:FindFirstChild("HumanoidRootPart") :: BasePart
	local victimHrp = victimChar:FindFirstChild("HumanoidRootPart") :: BasePart
	local victimHum = victimChar:FindFirstChildOfClass("Humanoid")
	if not attackerHrp or not victimHrp or not victimHum then return end

	DamageHandler:TakeDamage(attackerChar, victimHum, CLASH_DAMAGE, nil, nil, false, false, true, true, true, nil, nil)

	-- Direction = away from the attacker (flattened to the ground plane).
	local flat = (victimHrp.Position - attackerHrp.Position) * Vector3.new(1, 0, 1)
	local dir = flat.Magnitude > 0.1 and flat.Unit or attackerHrp.CFrame.LookVector

	local dotProduct = attackerHrp.CFrame.LookVector:Dot(dir)
	if victimHum.FloorMaterial ~= Enum.Material.Air then
		dotProduct = 1
	end

	local at = attackerHrp.Position
	local lookposition = CFrame.lookAt(at, at + dir)

	PerfectKnockback.KnockBack(nil, victimChar, {
		LookVector = lookposition.LookVector,
		LookForce = 58.5,
		LookFinalForce = 55,
		LookAt = lookposition,
		DestroyRagdoll = true,
		GroundStunTime = 0.95,
		Escapable = false,
		FallingDetectDelay = 0.2,
		Dot = dotProduct,
		DotParams = { 0.4, 1 },
		canHitWall = true,
	}, attackerChar)

	ReplicateSet:FireAllClients("Ring", {
		FirstProps = { Size = Vector3.new(0.6, 0.6, 0.6), Transparency = 0 },
		CF = victimHrp.CFrame,
		TN_Info = { Time = 0.25, Style = "Quad", Direction = "Out" },
		FinalProps = { Size = Vector3.new(12, 0.6, 12), Transparency = 1 },
	})

	local impact = RS.Assets.Sounds.Clash.IdleImpact
	if impact and impact:IsA("Sound") then
		SoundsModule:PlaySound(impact, victimHrp)
	end
end

-- Win/Lose: only the loser is knocked back.
function ClashService._applyOutcome(winner: Model, loser: Model)
	local loseAnim = findAnim("Looser") -- spelled "Looser" in the reference assets
	if loseAnim then AnimationService:playAnimation(loser, loseAnim) end

	local wp = Players:GetPlayerFromCharacter(winner)
	if wp then ReplicateSet:FireClient(wp, "ShakeCamera", { Intensity = 3 }) end

	-- ===== WINNER ANIMATION SECTION =====================================================
	-- Drop a winner "punch them back" animation named WINNER_PUNCH_ANIM into your Clash
	-- anim folder (SvSt.Assets.Animations.Clash) and it will play here, with the knockback
	-- firing on its WINNER_PUNCH_MARKER ("hit") so the loser flies exactly when the punch
	-- connects. If that animation doesn't exist, we fall back to the "Winner" anim and
	-- knock back immediately.
	-- (Tip: if you want the loser held still during the windup, re-stun them here and
	--  unstun in the marker callback just before _perfectKnockAway.)
	local punchAnim = findAnim(WINNER_PUNCH_ANIM)
	if punchAnim then
		local punchTrack = AnimationService:getAnimationTrack(winner, punchAnim)
		local knocked = false
		local function doKnock()
			if knocked then return end
			knocked = true
			ClashService._perfectKnockAway(winner, loser)
		end

		local markerConn = punchTrack:GetMarkerReachedSignal(WINNER_PUNCH_MARKER):Connect(doKnock)
		punchTrack.Stopped:Once(function()
			markerConn:Disconnect()
			doKnock() -- fallback: if the anim has no marker, knock at the end
		end)

		AnimationService:stopAll(winner)
		AnimationService:playAnimation(winner, punchAnim)
	else
		local winAnim = findAnim("Winner")
		if winAnim then AnimationService:playAnimation(winner, winAnim) end
		ClashService._perfectKnockAway(winner, loser)
	end
	-- ====================================================================================
end

-- Draw: BOTH are knocked away from each other.
function ClashService._applyDraw(charA: Model, charB: Model)
	ClashService._perfectKnockAway(charA, charB) -- knock B away from A
	ClashService._perfectKnockAway(charB, charA) -- knock A away from B
end

return ClashService
