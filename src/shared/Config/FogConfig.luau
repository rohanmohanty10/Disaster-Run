--!strict
-- Fog of War (GAME_PLAN.md Section 4B). Fog only blocks the Gods' view.
--
-- ROADMAP.md marks fog as "idea only — don't build until Rohan says so", so the whole system is
-- built but switched OFF. Set Enabled = true to turn it on (server and clients read the same flag).
--
-- Fog volumes are parts tagged "FogZone" with a Kind attribute ("Spawn" or "Patch").
-- Parts with a Radius attribute (or Ball / Cylinder shape) count as round; others as boxes.

local FogConfig = {}

FogConfig.Enabled = false

-- Spawn Fog: auto-created over the start bunker if the course has no "Spawn" FogZone.
FogConfig.Spawn = {
	PastBarrier = 120, -- studs the fog reaches past the start barrier
	Height = 40,
}

-- Fog Patches placed by MapService on every new canyon seed.
FogConfig.Patches = {
	PerChunk = { Min = 0, Max = 2 },
	Radius = { Min = 15, Max = 45 },
	Height = 30,
}

-- Exposure (anti-hiding).
FogConfig.Exposure = {
	FogLimit = 8, -- seconds in any fog before you're Exposed
	SpawnFogLimit = 10, -- seconds in the Spawn Fog (counted once the run starts)
	NoProgressLimit = 15, -- seconds without moving forward before you're Exposed
	ProgressStep = 5, -- studs of forward progress that count as "moving forward"
	MinDuration = 5, -- Exposed lasts at least this long
	ClearAfterOutOfFog = 3, -- ...and until you've been out of fog this long
	ResetAfterOutOfFog = 10, -- the fog timer only resets after this long out of fog
}

FogConfig.Tick = 0.2 -- server update interval

-- Client visuals.
FogConfig.GodFogTransparency = 0.15 -- thick fog for Gods
FogConfig.RunnerFogTransparency = 0.85 -- light haze for Runners
FogConfig.FogColor = Color3.fromRGB(205, 210, 220)
FogConfig.ExposedColor = Color3.fromRGB(255, 255, 255)

return FogConfig
