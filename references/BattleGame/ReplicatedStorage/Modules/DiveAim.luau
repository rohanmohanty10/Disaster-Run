--!strict
-- DiveAim: shared aim resolver used by BOTH the client reticle and the server dive,
-- so the reticle always shows exactly where the dive will land.
local DiveAim = {}

-- Single source of truth for how far you can aim/dive.
DiveAim.MAX_RANGE = 150

local function makeMapParams()
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = { workspace.World.Map.Destroyable:WaitForChild("Map"), workspace.World.Map:WaitForChild("Indestructible Map") }
	params.IgnoreWater = true
	params.RespectCanCollide = true
	return params
end

-- origin    : Vector3 (the HumanoidRootPart position)
-- direction : Vector3 aim direction (camera LookVector on the client)
-- returns   : point, normal, distance, hitSurface(bool)
function DiveAim.resolve(origin: Vector3, direction: Vector3, maxRange: number)
	maxRange = maxRange or DiveAim.MAX_RANGE
	if direction.Magnitude == 0 then direction = Vector3.new(0, -1, 0) end
	direction = direction.Unit
	local params = makeMapParams()

	-- 1) Forward along the aim, capped at max range.
	local forward = workspace:Raycast(origin, direction * maxRange, params)
	if forward then
		return forward.Position, forward.Normal, (forward.Position - origin).Magnitude, true
	end

	-- 2) Nothing within range (sky / over a gap): take the max-range point and drop
	--    straight down so we land on the map instead of flying off into space.
	local farPoint = origin + direction * maxRange
	local down = workspace:Raycast(farPoint, Vector3.new(0, -4000, 0), params)
	if down then
		return down.Position, down.Normal, (down.Position - origin).Magnitude, true
	end

	-- 3) Absolute fallback: cap at max range in the aim direction.
	return farPoint, Vector3.new(0, 1, 0), maxRange, false
end

return DiveAim