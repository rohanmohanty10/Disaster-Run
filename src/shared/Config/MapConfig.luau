--!strict
-- The simple generated canyon (MapService). Kept plain on purpose: floor, walls, start bunker,
-- Sanctuary gate and reshuffled cover. Origin is the start barrier; the course runs toward -Z.

local MapConfig = {}

MapConfig.Origin = Vector3.new(600, 0, 0) -- away from the lobby baseplate
MapConfig.Length = 1200
MapConfig.Width = 170
MapConfig.WallHeight = 60

MapConfig.ChunkLength = 100
MapConfig.Lanes = 5 -- cover is placed per lane; at least two lanes per chunk stay open
MapConfig.CoverDensity = 0.75 -- chance a blocked lane actually gets cover

MapConfig.CoverHealth = {
	Ruin = 120,
	Pillar = 80,
	Wall = 60,
}

MapConfig.Colors = {
	Floor = Color3.fromRGB(92, 84, 76),
	Wall = Color3.fromRGB(110, 90, 72),
	Bunker = Color3.fromRGB(70, 75, 85),
	Ruin = Color3.fromRGB(150, 120, 100),
	Boulder = Color3.fromRGB(120, 110, 100),
	Gate = Color3.fromRGB(235, 225, 200),
}

return MapConfig
