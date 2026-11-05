--!strict
-- Config.luau
-- Single source of truth for every tunable value. Logic modules stay clean by
-- reading from here; designers only ever touch this file.

local Config = {}

-- ── Debug ────────────────────────────────────────────────────────────────────
-- Key to toggle the whole system on/off at runtime. Set to nil to disable.
Config.DebugToggleKey = Enum.KeyCode.P

-- ── 1. Visual rain (camera-locked particle curtain) ──────────────────────────
-- Depth is faked with TWO emitter layers: a NEAR layer (big/fast/sparser) and a
-- FAR layer (small/slow/denser). Parallax between them reads as 3D depth without
-- per-particle size randomisation (ParticleEmitter.Size is a per-lifetime curve,
-- not a per-particle range, so layering is the correct tool here).
Config.Visual = {
	-- Boxes ride the camera POSITION only (axis-aligned), so streaks always fall
	-- straight down and the volume never tilts when you look up/down.
	NearOffset = Vector3.new(0, 6, 0),
	FarOffset = Vector3.new(0, 12, 0),
	NearVolumeSize = Vector3.new(42, 16, 42),
	FarVolumeSize = Vector3.new(95, 36, 95),

	-- TODO: replace with a tall, thin, bright-white gradient streak texture.
	StreakTexture = "rbxassetid://241868005",
	-- TODO: replace with a soft droplet/streak texture for the on-screen overlay.
	DropletTexture = "rbxassetid://241868005",

	NearColor = Color3.fromRGB(255, 255, 255),
	FarColor = Color3.fromRGB(226, 236, 255),

	NearRate = 200,
	FarRate = 520,

	NearSize = 3.0, -- base streak scale (thickness comes from the texture)
	FarSize = 1.0,
	NearSpeed = NumberRange.new(95, 125), -- per-particle random → some variety
	FarSpeed = NumberRange.new(45, 65),
	NearSquash = 6.0, -- stretches the particle along velocity into a long streak
	FarSquash = 3.0,

	Lifetime = NumberRange.new(0.4, 0.7),
	Gravity = Vector3.new(0, -160, 0), -- extra downward acceleration

	-- Screen overlay ("water on the lens")
	OverlayDropletCount = 6,
	OverlayMinInterval = 1.2,
	OverlayMaxInterval = 3.6,
	OverlayPeakTransparency = 0.72, -- stays subtle; never fully opaque
}

Config.Rig = {
	TemplateParent = script,
	TemplateName = "Rain", -- still has Sky (emitter template) + Floor

	CellSize = 30, -- studs per cell; smaller = sharper roof edges but more rays
	GridRadius = 3, -- cells out from player → (2*3+1)^2 = 49 cells, ~84 studs across
	-- replace SkyHeight / UpRayMargin with:
	ScanTop = 120,     -- start each cell's down-ray this far above the player
	ScanBottom = 80,   -- ...scan this far below too (finds ground in dips)
	LayerHeight = 18,  -- emit rain this high above whatever surface it lands on
	-- (SearchUp/SearchDown no longer needed — the floor reuses the center cell)
	UpdateInterval = 0.12, -- seconds between grid re-evaluations (raycast budget)

	SearchUp = 4,
	SearchDown = 60,
	OrientFloorToSurface = true,
}

-- ── 2. Occlusion / roof detection ────────────────────────────────────────────
Config.Occlusion = {
	Interval = 0.5, -- slow loop; only runs while the system is active
	MaxDistance = 60, -- how far up we look for a roof
	MaxIterations = 4, -- re-casts allowed when skipping small parts
	ProbeSize = Vector3.new(3, 1, 3), -- torso-ish footprint swept upward
	HeadOffset = 2, -- start the cast near head height, not the feet

	-- Size filtering: a hit only counts as a roof if it is genuinely big.
	MinVolume = 40, -- X*Y*Z; rejects 1x1x1 props, wires, small details
	MinWidth = 4, -- OR its two broadest dimensions clear this (thin wide slab)
}

-- ── 3. Audio ─────────────────────────────────────────────────────────────────
Config.Audio = {
	OutdoorSoundId = "rbxassetid://7149420366", -- TODO: looping outdoor rain
	RoofSoundId = "rbxassetid://9112853554", -- TODO: looping rain-on-roof patter
	StepSoundIds = { "rbxassetid://9117940486", "rbxassetid://9117940486", "rbxassetid://9117940139", "rbxassetid://9117948616" }, -- TODO: one or more wet splash steps

	OutdoorVolume = 0.6, -- full volume when exposed
	OutdoorMuffledVolume = 0.18, -- ducked when protected
	RoofVolume = 0.5, -- target roof-patter volume when protected
	MuffledHighGain = -22, -- EQ high band (dB) when indoors → muffled
	MuffledMidGain = -6,
	TweenTime = 0.8, -- how long volume/EQ transitions take

	StepStride = 6, -- studs travelled per footstep
	StepVolume = 0.5,
}

-- ── 4. Character VFX (dripping / drying) ─────────────────────────────────────
Config.VFX = {
	DryTime = 0, -- 0 = destroy on cover instantly; >0 keeps emitting that long first

	-- Each entry clones ITS OWN emitter onto the listed parts.
	-- Author each ParticleEmitter in Studio, parent it under this Config script,
	-- and reference it by name here. anchor positions it on the part:
	-- "Top" | "Bottom" | "Center" (default Center).
	Effects = {
		{ template = script.VFX:FindFirstChild("ArmDrip"),    parts = { "Left Arm", "Right Arm" }, anchor = "Bottom" },
		{ template = script.VFX:FindFirstChild("TorsoEffect"), parts = { "Torso" },                 anchor = "Center" },
		{ template = script.VFX.HeadEffect:FindFirstChild("Specs1"),  parts = { "Head" },                  anchor = "Top" },
		{ template = script.VFX.HeadEffect:FindFirstChild("Specs2"),  parts = { "Head" },                  anchor = "Top" },
		{ template = script.VFX.HeadEffect:FindFirstChild("Specs3"),  parts = { "Head" },                  anchor = "Top" },

		-- add as many as you want; multiple entries can target the same part
	},
}


-- ── 5. Ground splashes ───────────────────────────────────────────────────────
Config.Splash = {
	DropletTexture = "rbxassetid://11026658044", -- TODO: small bright droplet/spark texture
	PoolSize = 24, -- reusable splash objects (object pool)
	Interval = 0.06, -- seconds between spawn batches
	RaysPerTick = 5, -- downward rays per batch
	Radius = 40, -- spread of rays around the camera (studs)
	RayHeight = 60, -- start rays this far above camera height
	RayDepth = 80, -- ...and probe this far below
	DropletsPerSplash = 6,
}

return Config