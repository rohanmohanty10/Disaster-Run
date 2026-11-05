--!strict
-- Pure level / XP / daily maths. No services or instances, so it runs in the Lune tests
-- (tests/Progression.spec.luau) as well as in the game.

local ProgressionMath = {}

export type Curve = { Base: number, PerLevel: number }

-- XP needed to go from `level` to `level + 1`.
function ProgressionMath.XPToNext(level: number, curve: Curve): number
	return curve.Base + curve.PerLevel * (math.max(level, 1) - 1)
end

-- Adds XP. Returns the new level, the XP into that level, and how many levels were gained.
function ProgressionMath.AddXP(level: number, xp: number, amount: number, curve: Curve, maxLevel: number): (number, number, number)
	local gained = 0
	level = math.max(math.floor(level), 1)
	xp = math.max(xp, 0) + math.max(amount, 0)
	while level < maxLevel do
		local need = ProgressionMath.XPToNext(level, curve)
		if xp < need then
			break
		end
		xp -= need
		level += 1
		gained += 1
	end
	if level >= maxLevel then
		level = maxLevel
		xp = 0
	end
	return level, xp, gained
end

-- ------------------------------------------------------------------ days
-- UTC day number for a Unix time.
function ProgressionMath.Day(unixTime: number): number
	return math.floor(unixTime / 86400)
end

-- Streak after claiming today. Returns (newStreak, canClaim).
function ProgressionMath.ClaimStreak(lastClaimDay: number, streak: number, today: number): (number, boolean)
	if lastClaimDay == today then
		return streak, false
	end
	if lastClaimDay == today - 1 then
		return streak + 1, true
	end
	return 1, true
end

-- Index into a looping reward list for a streak (1-based).
function ProgressionMath.StreakIndex(streak: number, count: number): number
	return ((math.max(streak, 1) - 1) % count) + 1
end

-- ------------------------------------------------------------------ deterministic picks
-- A small seeded generator (same results on every server and client, unlike Random).
function ProgressionMath.Rng(seed: number): () -> number
	local state = math.abs(math.floor(seed)) % 2147483647
	if state == 0 then
		state = 1
	end
	return function(): number
		state = (state * 48271) % 2147483647
		return state / 2147483647
	end
end

-- Picks `count` distinct indexes from 1..size with a seed (order of picking).
function ProgressionMath.PickIndexes(seed: number, size: number, count: number): { number }
	local pool = {}
	for i = 1, size do
		pool[i] = i
	end
	local nextNumber = ProgressionMath.Rng(seed)
	-- Warm up so close seeds don't start alike.
	for _ = 1, 3 do
		nextNumber()
	end
	local picked = {}
	for _ = 1, math.min(count, size) do
		local index = math.floor(nextNumber() * #pool) + 1
		index = math.clamp(index, 1, #pool)
		table.insert(picked, pool[index])
		table.remove(pool, index)
	end
	return picked
end

-- ------------------------------------------------------------------ God priority
export type GodCandidate = { Id: number, HasPass: boolean, Waited: number, Tiebreak: number }

-- Picks the starting Gods (GAME_PLAN.md Section 1, "Priority Queue / God Pass"):
-- God Pass owners first, then the longest wait since last starting as God, then the tiebreak
-- (a random number per candidate). Returns the chosen ids.
function ProgressionMath.PickGods(candidates: { GodCandidate }, count: number): { number }
	local sorted = table.clone(candidates)
	table.sort(sorted, function(a, b)
		if a.HasPass ~= b.HasPass then
			return a.HasPass
		end
		if a.Waited ~= b.Waited then
			return a.Waited > b.Waited
		end
		return a.Tiebreak < b.Tiebreak
	end)
	local chosen = {}
	for i = 1, math.min(count, #sorted) do
		table.insert(chosen, sorted[i].Id)
	end
	return chosen
end

return ProgressionMath
