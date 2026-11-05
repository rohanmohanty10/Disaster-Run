--!strict
-- Pure strike geometry and damage maths used by God skills. No services, no instances,
-- so it runs in the Lune tests (tests/StrikeMath.spec.luau) as well as in the game.

local StrikeMath = {}

export type CourseBounds = {
	Origin: Vector3, -- centre of the start line; the course runs toward -Z
	Length: number,
	Width: number,
}

export type LineSpec = {
	Start: Vector3, -- ground point where the line begins
	Direction: Vector3, -- flat unit vector the line runs along
	Length: number,
}

local function flat(v: Vector3): Vector3
	local f = Vector3.new(v.X, 0, v.Z)
	if f.Magnitude < 1e-4 then
		return Vector3.new(0, 0, -1)
	end
	return f.Unit
end

-- Course bounds from MapConfig (pass the config table so this stays pure).
function StrikeMath.CourseFromConfig(config: { Origin: Vector3, Length: number, Width: number }): CourseBounds
	return { Origin = config.Origin, Length = config.Length, Width = config.Width }
end

-- Is a point inside the canyon's floor area (with a margin past the walls)?
function StrikeMath.InCourse(point: Vector3, course: CourseBounds, margin: number?): boolean
	local m = margin or 0
	local halfWidth = course.Width / 2 + m
	local dx = math.abs(point.X - course.Origin.X)
	local z = point.Z
	return dx <= halfWidth and z <= course.Origin.Z + m and z >= course.Origin.Z - course.Length - m
end

-- A line that cuts straight across the canyon, wall to wall, through `target` (World Slash).
-- Inside the course it always spans the full width along X; outside (lobby, test areas) it
-- runs perpendicular to the God's aim, centred on the target, `fallbackLength` long.
function StrikeMath.CrossCanyonLine(target: Vector3, aim: Vector3, course: CourseBounds?, fallbackLength: number): LineSpec
	if course and StrikeMath.InCourse(target, course, 10) then
		local start = Vector3.new(course.Origin.X - course.Width / 2, target.Y, target.Z)
		return { Start = start, Direction = Vector3.new(1, 0, 0), Length = course.Width }
	end
	local forward = flat(aim)
	local across = Vector3.new(-forward.Z, 0, forward.X) -- 90 degrees to the aim
	return { Start = target - across * (fallbackLength / 2), Direction = across, Length = fallbackLength }
end

-- The path a projectile takes into `target`: it starts `length` studs back along the aim.
function StrikeMath.ArrowPath(target: Vector3, aim: Vector3, length: number): LineSpec
	local forward = flat(aim)
	return { Start = target - forward * length, Direction = forward, Length = length }
end

-- Cleave: a share of the victim's current health, kept between min and max.
function StrikeMath.HealthPercentDamage(health: number, percent: number, min: number, max: number): number
	return math.clamp(math.max(health, 0) * percent, min, max)
end

-- Energy cost after a multiplier (Four Arms), rounded to the nearest whole point.
function StrikeMath.DiscountedCost(cost: number, multiplier: number): number
	return math.floor(cost * multiplier + 0.5)
end

-- Is a ground point within `radius` of `center` (ignoring height)?
function StrikeMath.InCircle(point: Vector3, center: Vector3, radius: number): boolean
	local offset = Vector3.new(point.X - center.X, 0, point.Z - center.Z)
	return offset.Magnitude <= radius
end

return StrikeMath
