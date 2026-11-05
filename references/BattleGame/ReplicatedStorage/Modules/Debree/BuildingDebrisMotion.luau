-- Shared tsunami budgets and debris motion. Budgets are final voxel counts, not source-part counts.
return {
	Enabled = true,
	VoxelSize = 10,
	SourcePartsPerBuilding = 30,
	ServerVoxelsPerBuilding = 24,
	ClientVoxelsPerBuilding = 160,
	MaxActiveServerVoxels = 64,
	MaxServerVoxels = 256,
	MaxClientParts = 480,
	ClientDecorPerCast = 80,
	ClientVoxelsPerDecor = 2,
	RemainVariants = 3,
	PrepareBudgetMs = 2,
	WorkBudgetMs = 2,
	JobsPerFrame = 48,
	SpawnPerFrame = 32,
	ContactBurst = 12,
	CriticalWorkBudgetMs = 4,
	CriticalJobsPerFrame = 512,
	DecorWorkBudgetMs = 0.75,
	DecorJobsPerFrame = 64,
	ClientDistance = 450,
	CollisionGroup = "TsunamiClientDebris",
	ServerCollisionGroup = "TsunamiServerDebris",
	TreeCollisionGroup = "TsunamiTrees",
	TreeSpeedRatio = 0.5,
	TreeLift = 12,
	TreeCollisionParts = 3,

	-- Building collapse (server)
	BuildingSweepRatio = 1, -- buildings fail front-to-back at this fraction of wave speed
	BuildingCrumbleJitter = 0.12, -- seconds of random per-part delay
	MotionFlushInterval = 0.1, -- server batches debris packets per building at this interval

	-- Server rubble: real physics, carried by forces, then released to fall and settle
	ServerSpeedRatio = 0.85, -- launch impulse vs wave speed
	ServerLift = 14,
	ServerCarryCollisionGroup = "TsunamiServerCarry", -- while carried: never hits players
	ServerCarryRatioMin = 0.75, ServerCarryRatioMax = 1.0, -- carried speed vs wave speed
	ServerCarryMin = 0.8, ServerCarryMax = 2.2, -- seconds carried before release
	ServerCarryDrag = 2.5,
	ServerBuoyancy = 0.6, -- fraction of gravity cancelled while carried
	ServerTurbulence = 40, -- studs/s^2 of noise up/down
	ServerVerticalDrag = 1.2,
	ServerSettleSpeed = 1.2,
	ServerSettleAngularSpeed = 0.8,
	ServerSettleSeconds = 0.6,
	ServerMaxMoveSeconds = 8,

	-- Client debris: math carry -> local physics fall -> anchored rest
	-- Weight class is a weighted roll per piece; size only shifts the odds (big pieces lean heavy).
	ClassWeights = { Heavy = 0.3, Medium = 0.5, Light = 0.2 },
	SizeBias = 0.8, -- 0 = size ignored; 1 = a full 10-stud cube is twice as likely to be heavy
	Classes = {
		-- Entry: launch speed (x wave). Speed: carried speed (x wave). Lift: launch up (studs/s).
		-- Buoyancy: gravity cancelled in water. Drag: how hard water drags it. Roll: how much the
		-- rolling water moves it. Spin: rotation scale. Carry: carry-time scale.
		-- Friction: ground scrape. Kick: turbulence-kick scale. MinSpin: spin never drops below this (rad/s).
		Heavy = { Entry = 0.75, Speed = 0.7, Lift = { 6, 16 }, Buoyancy = 0.4, Drag = 1.8, Roll = 0.4, Spin = 0.7, Carry = 0.8, Friction = 0.8, Kick = 0.7, MinSpin = 0.8 },
		Medium = { Entry = 1.0, Speed = 0.95, Lift = { 12, 28 }, Buoyancy = 0.8, Drag = 3, Roll = 1, Spin = 1, Carry = 1, Friction = 2, Kick = 1, MinSpin = 1.5 },
		Light = { Entry = 1.15, Speed = 1.15, Lift = { 35, 60 }, Buoyancy = 0.95, Drag = 3.5, Roll = 1, Spin = 1.4, Carry = 1.2, Friction = 2.5, Kick = 1.3, MinSpin = 2.5 },
	},
	HangMin = 0.04, HangMax = 0.14, -- pause before a piece breaks loose
	CrestHeight = 110, -- visual wave height above the ground
	RollerShear = 0.6, -- top of the wave runs faster than the base (carries pieces up and over)
	RollerLift = 0.5, -- base lifts pieces, top pushes them back down
	-- Each piece also loops through the wave on its own cycle (up the back, over the top, down the front).
	LoopPeriodMin = 1, LoopPeriodMax = 2.5, -- seconds per loop
	LoopRadiusMin = 10, LoopRadiusMax = 35, -- studs
	-- Per-piece randomness so pieces at the same height still drift apart.
	SpeedJitter = 0.2, BuoyancyJitter = 0.15, DragJitter = 0.3,
	-- Turbulence kicks: sudden shoves at random intervals; some throw the piece out of the crest.
	KickIntervalMin = 0.3, KickIntervalMax = 1.0,
	KickStrength = 25, -- studs/s
	BigKickChance = 0.1, BigKickStrength = 80,
	KickSpin = 4, -- rad/s of spin added per kick
	-- Noise (per piece), as a fraction of wave speed.
	TurbulenceForward = 0.2, TurbulenceVertical = 0.4, LateralTurbulence = 0.15,
	NoiseScale = 14, NoiseRate = 1.8, -- smaller scale / higher rate = choppier
	FrontSkin = 6, -- studs ahead of the front still counted as in the water
	AirPushDistance = 40, AirPush = 0.25, -- pieces just ahead of the front get a weaker push
	SideDrag = 2,
	Bounce = 0.3, -- ground friction is per class
	ShearSpin = 0.15, Wobble = 1.2, MaxSpin = 9, SpinResponse = 2.5,
	SpinDrift = 0.6, -- how fast each piece's spin axis wanders
	GroundProbeInterval = 0.25, -- seconds between ground raycasts per piece
	CarrySecondsMin = 1.2, CarrySecondsMax = 3.5, -- time in the wave before it's dumped
	MaxCarrySeconds = 12,
	MaxFallingParts = 160, -- pieces simulated by physics at once; extras sink and fade instead
	FallCollisionGroup = "NonPColDebri", -- hits the map, never players, ignored by the camera
	HandoffVelocityScale = 0.6,
	HandoffNoCollide = 0.12, -- seconds without collision right after hand-off (avoids pops)
	SettleSpeed = 1.5, SettleAngularSpeed = 1, SettleSeconds = 0.5, FallMaxSeconds = 6,
	SinkLifetime = 2, -- debris packets arriving later than wave end + this are ignored
	ReleaseStagger = 0.35, -- when the wave ends, pieces leave it spread over this many seconds
	DropGravityBase = 1.6, DropGravityPerStud = 0.03, DropGravityMax = 5, -- gravity multiplier out of the wave, grows with height above ground
	DropHorizontalDrag = 0.6,
	ThroughGroundDepth = 8, -- over-cap pieces fall through the ground and are deleted this far below it (no fade)
	DropMaxSeconds = 6,
	FadeBeforeResetMin = 1,
	FadeBeforeResetMax = 3,
	FadeSeconds = 1,
	LateJoinReplayAge = 1,
}
