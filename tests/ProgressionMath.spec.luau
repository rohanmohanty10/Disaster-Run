--!nocheck
-- Unit tests for src/shared/Util/ProgressionMath.luau: XP / levels, daily streaks, the seeded
-- picker used by quests and the shard shop, and the God priority queue.
-- Run from the repo root:  lune run tests/ProgressionMath.spec.luau

local fs = require("@lune/fs")
local luau = require("@lune/luau")
local process = require("@lune/process")

local source = fs.readFile("src/shared/Util/ProgressionMath.luau")
local P = luau.load(source, { debugName = "ProgressionMath" })()

local passed, failed = 0, 0

local function test(name: string, fn: () -> ())
	local ok, err = pcall(fn)
	if ok then
		passed += 1
		print(`  PASS  {name}`)
	else
		failed += 1
		print(`  FAIL  {name}\n        {err}`)
	end
end

local function eq(a, b, label: string?)
	if a ~= b then
		error(`{label or "value"}: expected {b}, got {a}`, 2)
	end
end

local CURVE = { Base = 100, PerLevel = 50 }

print("ProgressionMath")

test("XPToNext: 100 at level 1, +50 per level", function()
	eq(P.XPToNext(1, CURVE), 100)
	eq(P.XPToNext(2, CURVE), 150)
	eq(P.XPToNext(10, CURVE), 550)
	eq(P.XPToNext(0, CURVE), 100, "levels below 1 count as 1")
end)

test("AddXP: no level-up below the threshold", function()
	local level, xp, gained = P.AddXP(1, 0, 99, CURVE, 200)
	eq(level, 1)
	eq(xp, 99)
	eq(gained, 0)
end)

test("AddXP: carries leftover XP across several level-ups", function()
	-- 100 (1->2) + 150 (2->3) = 250, 30 left over
	local level, xp, gained = P.AddXP(1, 0, 280, CURVE, 200)
	eq(level, 3)
	eq(xp, 30)
	eq(gained, 2)
end)

test("AddXP: stops at the max level with 0 XP", function()
	local level, xp, gained = P.AddXP(4, 10, 1e9, CURVE, 5)
	eq(level, 5)
	eq(xp, 0)
	eq(gained, 1)
end)

test("AddXP: negative amounts do nothing", function()
	local level, xp, gained = P.AddXP(3, 20, -500, CURVE, 200)
	eq(level, 3)
	eq(xp, 20)
	eq(gained, 0)
end)

test("Day: UTC day number", function()
	eq(P.Day(0), 0)
	eq(P.Day(86399), 0)
	eq(P.Day(86400), 1)
end)

test("ClaimStreak: same day can't claim, next day continues, a gap resets", function()
	local streak, can = P.ClaimStreak(100, 4, 100)
	eq(can, false, "same day")
	eq(streak, 4)
	streak, can = P.ClaimStreak(99, 4, 100)
	eq(can, true, "next day")
	eq(streak, 5)
	streak, can = P.ClaimStreak(97, 4, 100)
	eq(can, true, "after a gap")
	eq(streak, 1)
	streak, can = P.ClaimStreak(0, 0, 100)
	eq(can, true, "first ever claim")
	eq(streak, 1)
end)

test("StreakIndex: loops through the reward list", function()
	eq(P.StreakIndex(1, 7), 1)
	eq(P.StreakIndex(7, 7), 7)
	eq(P.StreakIndex(8, 7), 1)
	eq(P.StreakIndex(15, 7), 1)
	eq(P.StreakIndex(0, 7), 1)
end)

test("PickIndexes: distinct, in range, deterministic per seed", function()
	local a = P.PickIndexes(12345, 9, 3)
	local b = P.PickIndexes(12345, 9, 3)
	eq(#a, 3)
	local seen = {}
	for i, v in a do
		eq(v, b[i], "same seed, same picks")
		assert(v >= 1 and v <= 9, "in range")
		assert(not seen[v], "distinct")
		seen[v] = true
	end
end)

test("PickIndexes: count larger than size returns everything once", function()
	local picks = P.PickIndexes(7, 4, 10)
	eq(#picks, 4)
	table.sort(picks)
	for i = 1, 4 do
		eq(picks[i], i)
	end
end)

test("PickIndexes: different seeds spread across the pool", function()
	local counts = {}
	for seed = 1, 900 do
		for _, v in P.PickIndexes(seed * 131, 9, 3) do
			counts[v] = (counts[v] or 0) + 1
		end
	end
	for i = 1, 9 do
		-- 900 × 3 / 9 = 300 expected each; allow a wide margin.
		assert((counts[i] or 0) > 150 and (counts[i] or 0) < 450, `index {i} picked {counts[i]} times`)
	end
end)

test("PickGods: God Pass first, then longest wait, then tiebreak", function()
	local candidates = {
		{ Id = 1, HasPass = false, Waited = 9, Tiebreak = 0.5 },
		{ Id = 2, HasPass = true, Waited = 0, Tiebreak = 0.9 },
		{ Id = 3, HasPass = false, Waited = 9, Tiebreak = 0.1 },
		{ Id = 4, HasPass = false, Waited = 2, Tiebreak = 0.0 },
	}
	local chosen = P.PickGods(candidates, 3)
	eq(chosen[1], 2, "pass owner")
	eq(chosen[2], 3, "longest wait, lower tiebreak")
	eq(chosen[3], 1, "longest wait")
	eq(#P.PickGods(candidates, 0), 0, "zero Gods")
	eq(#P.PickGods(candidates, 10), 4, "never more than the candidates")
end)

print(`\n{passed} passed, {failed} failed`)
if failed > 0 then
	process.exit(1)
end
