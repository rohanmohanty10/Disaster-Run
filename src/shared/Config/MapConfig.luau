--!strict
-- The simple generated canyon (MapService). Kept plain on purpose: floor, walls, start bunker,
-- Sanctuary gate and reshuffled cover. Origin is the start barrier; the course runs toward -Z.

local MapConfig = {}

MapConfig.Origin = Vector3.new(600, 0, 0) -- away from the lobby baseplate
MapConfig.Length = 1200
MapConfig.Width = 170
MapConfig.WallHeight = 60

MapConfig.SlopeDepth = 22 -- grassy valley slopes along both cliffs; cover stays off them
MapConfig.PlayableWidth = MapConfig.Width - MapConfig.SlopeDepth * 2

MapConfig.ChunkLength = 100
MapConfig.Lanes = 5 -- cover is placed per lane; at least two lanes per chunk stay open
MapConfig.CoverDensity = 0.75 -- chance a blocked lane actually gets cover

MapConfig.CoverHealth = {
	Ruin = 120,
	Pillar = 80,
	Wall = 60,
}

MapConfig.Colors = {
	Floor = Color3.fromRGB(86, 140, 62), -- grass
	Wall = Color3.fromRGB(112, 100, 82), -- cliffs
	Bunker = Color3.fromRGB(150, 146, 136),
	Ruin = Color3.fromRGB(150, 146, 136), -- weathered stone
	Boulder = Color3.fromRGB(98, 104, 84), -- mossy rock
	Gate = Color3.fromRGB(235, 230, 215),
	Wood = Color3.fromRGB(110, 78, 50),
	Leaves = Color3.fromRGB(70, 130, 60),
}

return MapConfig
