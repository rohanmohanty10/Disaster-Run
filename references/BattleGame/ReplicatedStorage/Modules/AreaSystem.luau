local AreaSystem = {}

-- === TUNE THESE FOR YOUR ISLAND ===
local ISLAND_CENTER = Vector3.new(0, 0, 0) -- X/Z center of your island
--local ISLAND_CENTER = Vector3.new(243.448, 0, 3721.051) -- X/Z center of your island

local SHORE_RADIUS = 600   -- distance from center where the beach/water meets
local CALM_FALLOFF = 500   -- studs beyond the shore over which waves ramp to full strength

function AreaSystem.getWaterDepth(position)
	local flatPos = Vector3.new(position.X, 0, position.Z)
	local flatCenter = Vector3.new(ISLAND_CENTER.X, 0, ISLAND_CENTER.Z)
	local dist = (flatPos - flatCenter).Magnitude
	return math.clamp((dist - SHORE_RADIUS) / CALM_FALLOFF, 0, 1)
end

return AreaSystem