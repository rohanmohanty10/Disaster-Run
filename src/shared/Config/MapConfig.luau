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
	Bunker = 300, -- concrete: survives most single strikes (GAME_PLAN.md Section 4)
}

-- Chunk themes (GAME_PLAN.md Section 4: RuinsChunk, BunkerChunk, PillarFieldChunk,
-- ChasmBridgeChunk). Each 100-stud chunk picks one by weight; every chunk keeps 2+ lanes open.
MapConfig.Chunks = {
	{ Name = "Ruins", Weight = 4 }, -- mixed ruins, pillars, low walls, boulders, trees
	{ Name = "Bunker", Weight = 2 }, -- roofed concrete bunkers (shelter from overhead strikes)
	{ Name = "PillarField", Weight = 2 }, -- clusters of pillars
	{ Name = "ChasmBridge", Weight = 1 }, -- a hazard strip across the canyon, bridges on the open lanes
}
MapConfig.FirstChunkSafe = true -- the chunk past the start barrier is never a ChasmBridge

-- Chokepoint hazards (ChasmBridge chunks): lava or quicksand across the canyon floor.
-- Standing in it hurts and slows; the bridges over the open lanes are safe.
MapConfig.Hazard = {
	Depth = 22, -- studs along the course
	BridgeWidth = 9,
	BridgeHeight = 2,
	Tick = 0.25,
	Kinds = {
		Lava = { DamagePerSecond = 30, Slow = 0.6, Color = Color3.fromRGB(255, 90, 20), Material = Enum.Material.Neon },
		Quicksand = { DamagePerSecond = 12, Slow = 0.35, Color = Color3.fromRGB(205, 175, 110), Material = Enum.Material.Sand },
	},
}

-- Cover destruction (DestructionService): broken cover shatters into voxels on every client.
MapConfig.Destruction = {
	CellSize = 3, -- voxel size in studs
	MaxCells = 40, -- per broken part (bigger parts use bigger voxels)
	DebrisLife = 2.5, -- seconds before voxels fade (mobile performance)
	Power = 45, -- launch speed
	CrackAt = 0.5, -- cover darkens when its health drops below this fraction
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
