--!nocheck
-- Unit tests for src/shared/Util/StrikeMath.luau (King of Curses geometry and damage maths).
-- Run from the repo root:  lune run tests/StrikeMath.spec.luau
--
-- Lune has Roblox datatypes in @lune/roblox but not as globals, so the module is loaded with
-- Vector3 injected into its environment.

local fs = require("@lune/fs")
local luau = require("@lune/luau")
local process = require("@lune/process")
local roblox = require("@lune/roblox")

local Vector3 = roblox.Vector3

local source = fs.readFile("src/shared/Util/StrikeMath.luau")
local StrikeMath = luau.load(source, { debugName = "StrikeMath", environment = { Vector3 = Vector3 } })()

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

local function near(a: number, b: number, label: string?)
	if math.abs(a - b) > 1e-3 then
		error(`{label or "value"}: expected {b}, got {a}`, 2)
	end
end

local function nearV(a, b, label: string?)
	if (a - b).Magnitude > 1e-3 then
		error(`{label or "vector"}: expected {b}, got {a}`, 2)
	end
end

-- Same numbers as MapConfig: origin (600, 0, 0), 1200 long toward -Z, 170 wide.
local course = StrikeMath.CourseFromConfig({ Origin = Vector3.new(600, 0, 0), Length = 1200, Width = 170 })

print("StrikeMath")

test("InCourse: centre of the canyon is inside", function()
	assert(StrikeMath.InCourse(Vector3.new(600, 0, -500), course) == true)
end)

test("InCourse: lobby and points past the walls are outside", function()
	assert(StrikeMath.InCourse(Vector3.new(0, 0, 0), course) == false)
	assert(StrikeMath.InCourse(Vector3.new(600 + 85 + 1, 0, -500), course) == false)
	assert(StrikeMath.InCourse(Vector3.new(600, 0, -1201), course) == false)
	assert(StrikeMath.InCourse(Vector3.new(600 + 85 + 1, 0, -500), course, 5) == true, "margin should include it")
end)

test("CrossCanyonLine: spans wall to wall at the reticle, whatever the aim", function()
	for _, aim in { Vector3.new(0, 0, -1), Vector3.new(1, 0, 0), Vector3.new(0.3, 0, 0.7) } do
		local line = StrikeMath.CrossCanyonLine(Vector3.new(620, 2, -400), aim, course, 220)
		nearV(line.Start, Vector3.new(515, 2, -400), "start")
		nearV(line.Direction, Vector3.new(1, 0, 0), "direction")
		near(line.Length, 170, "length")
		local finish = line.Start + line.Direction * line.Length
		near(finish.X, 685, "far wall X")
	end
end)

test("CrossCanyonLine: outside the course it's perpendicular to the aim and centred", function()
	local target = Vector3.new(0, 0, 0)
	local line = StrikeMath.CrossCanyonLine(target, Vector3.new(0, 0, -1), course, 220)
	near(line.Direction:Dot(Vector3.new(0, 0, -1)), 0, "perpendicular")
	near(line.Length, 220, "length")
	local mid = line.Start + line.Direction * (line.Length / 2)
	nearV(mid, target, "centre")
end)

test("CrossCanyonLine: works with no course at all", function()
	local line = StrikeMath.CrossCanyonLine(Vector3.new(10, 0, 10), Vector3.new(1, 0, 0), nil, 100)
	near(line.Length, 100, "length")
	near(math.abs(line.Direction.Z), 1, "runs along Z when aiming along X")
end)

test("CrossCanyonLine: a vertical or zero aim falls back to a valid direction", function()
	local line = StrikeMath.CrossCanyonLine(Vector3.new(0, 0, 0), Vector3.new(0, -1, 0), nil, 50)
	near(line.Direction.Magnitude, 1, "unit direction")
	assert(line.Direction == line.Direction, "not NaN")
end)

test("ArrowPath: ends exactly on the target, flat, the right length", function()
	local target = Vector3.new(50, 3, -20)
	local path = StrikeMath.ArrowPath(target, Vector3.new(0, -0.5, -2), 60)
	nearV(path.Start + path.Direction * path.Length, target, "end")
	near(path.Direction.Y, 0, "flat")
	near(path.Length, 60, "length")
	nearV(path.Start, Vector3.new(50, 3, 40), "start is behind the target")
end)

test("HealthPercentDamage: Cleave deals 40% of current health within 15-40", function()
	near(StrikeMath.HealthPercentDamage(100, 0.4, 15, 40), 40, "full health")
	near(StrikeMath.HealthPercentDamage(80, 0.4, 15, 40), 32, "80 HP")
	near(StrikeMath.HealthPercentDamage(20, 0.4, 15, 40), 15, "low health floors at 15")
	near(StrikeMath.HealthPercentDamage(500, 0.4, 15, 40), 40, "never above 40")
	near(StrikeMath.HealthPercentDamage(-5, 0.4, 15, 40), 15, "negative health")
end)

test("DiscountedCost: Four Arms takes 15% off, rounded", function()
	near(StrikeMath.DiscountedCost(30, 0.85), 26, "Dismantle 25.5 -> 26")
	near(StrikeMath.DiscountedCost(35, 0.85), 30, "Cleave 29.75 -> 30")
	near(StrikeMath.DiscountedCost(60, 0.85), 51, "Flame Arrow")
	near(StrikeMath.DiscountedCost(80, 0.85), 68, "World Slash")
	near(StrikeMath.DiscountedCost(140, 0.85), 119, "Shrine of Calamity")
	near(StrikeMath.DiscountedCost(140, 1), 140, "no discount")
end)

test("InCircle: ignores height, includes the edge", function()
	assert(StrikeMath.InCircle(Vector3.new(40, 99, 0), Vector3.zero, 40) == true)
	assert(StrikeMath.InCircle(Vector3.new(40.1, 0, 0), Vector3.zero, 40) == false)
end)

print(`\n{passed} passed, {failed} failed`)
if failed > 0 then
	process.exit(1)
end
