--!strict
-- ReplicatedStorage > Modules > Debree > Config   (ModuleScript, shared by server and client)
--
-- Every Debree tuning number in one place.
--   (JJS)  copied from JJS's client code. Don't change these, or we stop matching JJS.
--   (tune) estimated from the JJS video. Tune these side by side with JJS in a playtest.

local Config = {
	------------------------------------------------------------------
	-- Debug (server)
	------------------------------------------------------------------
	ShowHitboxes = true, -- true = every Destroy call briefly draws its hit volume (everyone sees it)
	HitboxShowTime = 1, -- seconds the drawn hitbox stays
	HitboxColor = Color3.fromRGB(255, 60, 60),

	------------------------------------------------------------------
	-- Splitting (server)
	------------------------------------------------------------------
	GridSize = 2, -- target cell size in studs; a part's "GridSize" attribute overrides it (tune)
	Shrink = 0.95, -- debris cells are scaled by this about their centers. JJS: 2x3 -> 1.9x2.85
	MaxCellsPerPart = 1500, -- if one hit would cut more cells than this from one part, the grid doubles
	MaxHitSize = 200, -- hit volumes are clamped to this size on every axis
	MaxEraseSize = 1000, -- ...and Erase volumes to this (a tsunami wave is 400 wide)
	BreakOverlap = 0.1, -- a cell breaks once the hitbox reaches this far into it, as a fraction of the cell's
	--                     size: 0.1 = a tenth of the way in, 0 = any touch, 0.5 = only if it covers the center
	SeamEdgeCells = false, -- cells the hit only grazes (less than BreakOverlap): false = they stay part of the
	--                        wall, full size with no seams; true = cut out with seams but left in place

	------------------------------------------------------------------
	-- Which parts break (server)
	------------------------------------------------------------------
	IgnoreNonCollidable = true, -- parts with CanCollide off (leaves, decor) stay intact:
	--                             pieces are always solid, so breaking them would make them solid
	-- Floors crack in place; everything else breaks like a wall. Anything in Destroyable.Map.Floor is a floor,
	-- and so is a floor-shaped part:
	GroundMaxSlope = 15, -- a slab whose thinnest side faces up, tilted at most this many degrees (ramps, stairs and
	--                      pitched roofs are steeper, so they break like walls, as in JJS)...
	GroundMaxThickness = 12, -- ...at most this thick...
	GroundMinSpan = 4, -- ...and in both other directions at least this wide and twice as wide as it is thick...
	GroundThinRatio = 4, -- ...or, for a thin slab, at least this many times as wide as it is thick (road lines, curbs,
	--                      planks). Bars and beams stay walls...
	GroundStepUp = 1, -- ...whose top isn't more than this above the attacker's feet. A floor-shaped part that is
	--                   higher (a stair landing, a window sill) is in front of them, not under them: it breaks like a wall
	MaxLift = 0.25, -- a piece cut where it sat sunk into whatever is under it is lifted out by up to this share of
	--               its height, then moves. Sunk deeper (a step built half inside the landing under it), it stays
	--               where it broke instead of popping up, like JJS's stair pieces
	LooseMaxSize = 8, -- non-block parts (meshes, unions, wedges) up to this long are launched whole;
	--                   bigger ones (roofs, building shells) stay intact

	------------------------------------------------------------------
	-- Wall launch (server)
	------------------------------------------------------------------
	WallSpeed = 18, -- studs/s along the attacker's flat look direction, at any angle like JJS: hit a wall at an
	--                 angle and the pieces are driven into the wall beside them, so they only scrape out a little (tune)
	WallLift = 1, -- extra upward studs/s (tune)
	WallJitter = 0.05, -- up to +/-5% random speed per piece, so rows don't move in lockstep (tune)
	BodyFriction = 0.15, -- friction of the server's physics copies. Measured on a flat floor: 5-6 studs
	--                      in ~0.6 s, upright (JJS: 3-6 studs in ~0.5-0.6 s) (tune)
	StackedFriction = 0.08, -- friction of a wall piece while it's on top of other wall pieces (moving or stopped).
	--                         The rows below slow down on the floor, the rows above slide on and topple off,
	--                         like JJS. Measured: 2-row wall -> bottom 4.2 studs upright, top 8.2 toppled (tune)
	LandedFriction = 0.5, -- ...and once a toppled piece lands on anything else, so it stops near where it fell (tune)
	TipTries = 2, -- a wall piece that still stops on top of another wall piece is tipped off it, toward open
	--               space, up to this many times, so upper rows end up on the floor like JJS (0 = never)
	TipSpeed = 8, -- studs/s it's tipped off with (tune)
	TipSpin = 4, -- radians/s it's tipped over with (tune)
	BodyElasticity = 0, -- no bouncing
	BodyWeight = 100, -- FrictionWeight and ElasticityWeight, so a piece's values beat the floor's
	BodyCollisionGroup = "DebreeBodies", -- the server's invisible physics copies use this group (made at start)...
	BodyIgnoresGroups = { "Players", "GrabbedPlayers" }, -- ...which doesn't collide with these, so a player or a
	--                     knocked-back victim standing in the way can't stop pieces on the server. The pieces
	--                     players see and stand on are unaffected (Default group, solid).
	StaticBodyCollisionGroup = "DebreeStatic", -- ...but while a piece sits still (what's left of a floor or wall,
	--                     settled rubble) its copy uses this group, which characters DO stand on. Without
	--                     it, a character the server simulates (a dummy) sank through a broken floor,
	--                     since the floor's part is gone and the pieces under it let characters through.

	------------------------------------------------------------------
	-- Ground (server)
	------------------------------------------------------------------
	GroundTilt = 0, -- max random tilt of ground debris, in degrees. 0 = flat cracks like JJS; anything
	--                 above ~1 makes bumps that stop wall pieces sliding over the cracked floor (tune)
	GroundHeightJitter = 0, -- max random extra height of ground debris, in studs (same reason) (tune)
	GroundSideJitter = 1, -- max random sideways studs/s when a move uses Bounce (tune)

	------------------------------------------------------------------
	-- Resting and re-hits (server)
	------------------------------------------------------------------
	SleepSpeed = 0.1, -- studs/s; slower than this counts as still
	SleepAngularSpeed = 0.2, -- radians/s; slower spin than this counts as still
	SleepTime = 0.5, -- seconds still before a piece is anchored and sent as settled
	MaxMoveTime = 8, -- seconds; a piece still moving after this is anchored where it is
	RehitCooldown = 0.15, -- seconds before the same piece can be launched again
	FallenMargin = 20, -- pieces within this many studs of FallenPartsDestroyHeight are removed

	------------------------------------------------------------------
	-- Streaming (server)
	------------------------------------------------------------------
	PhysicsHz = 10, -- Physics updates per second; JJS's client tweens are built for about 10 Hz
	RecordsPerTick = 300, -- most Physics records sent per update
	RecordsPerFire = 40, -- most Physics records per UnreliableRemoteEvent fire (40 x 21 = 840 bytes,
	--                     under Roblox's ~900-byte unreliable payload limit)
	SettleResends = { 0.3, 1 }, -- only if Remotes.Debree.Settle is missing: seconds after settling to
	--                             send the final position again over the unreliable Physics remote
	SoundsPerHit = 5, -- most piece IDs sent in one Sound fire; each one plays a sound (tune)
	SnapshotChunk = 2000, -- most pieces per Create fire in the late-join snapshot
	PropChunk = 4000, -- most IDs per Prop fire
	MoveEpsilon = 0.02, -- studs; smaller moves aren't sent
	TurnEpsilon = math.rad(0.5), -- radians; smaller turns aren't sent

	------------------------------------------------------------------
	-- Reset (server)
	------------------------------------------------------------------
	ResetTime = 30, -- seconds after the last hit on a part before it's restored
	ResetCheckInterval = 0.5, -- seconds between reset checks

	------------------------------------------------------------------
	-- IDs (server)
	------------------------------------------------------------------
	MaxLivePieces = 32767, -- hard safety limit; JJS's client reads sound IDs as i16

	------------------------------------------------------------------
	-- Client pool (JJS)
	------------------------------------------------------------------
	PoolSize = 2000, -- DebreeRef copies made up front (JJS)
	PoolGrow = 20, -- copies added each time the pool runs out (JJS)
	ParkCFrame = CFrame.new(0, 10000000, 0), -- where unused copies wait, far out of sight (JJS)

	------------------------------------------------------------------
	-- Client distances, all Manhattan (|dx| + |dy| + |dz|) from the camera (JJS)
	------------------------------------------------------------------
	NearDistance = 100, -- movedBuf groups closer than this get smooth tweens (JJS)
	FlyingDistance = 150, -- flyingBuf groups farther than this aren't drawn at all (JJS)
	DustDistance = 200, -- DustBreak only runs closer than this (JJS)
	SoundDistance = 300, -- debris sounds only play closer than this (JJS)

	------------------------------------------------------------------
	-- Client motion (JJS)
	------------------------------------------------------------------
	FlyingFadeDelay = 3, -- seconds before a flying piece starts fading (JJS)
	FlyingFadeTime = 1, -- seconds the fade takes (JJS)
	MoveTweenTime = 0.2, -- Physics flag 0: linear tween length (JJS)
	MoveOvershoot = 1.5, -- Physics flag 0: tween to Lerp(target, 1.5) to hide network delay (JJS)
	SettleTweenTime = 0.4, -- Physics flag 1: Quad Out tween length (JJS)
	InterpolateMarkPerFrame = 20, -- background loop marks this many pieces per frame (JJS)

	------------------------------------------------------------------
	-- Client DustBreak (JJS)
	------------------------------------------------------------------
	DustRayLength = 8, -- default ray length into the surface (JJS)
	DustSideSpeed = 20, -- random sideways speed, +/- (JJS)
	DustUpSpeedMin = 20, -- random upward speed range (JJS)
	DustUpSpeedMax = 40,
	DustSpin = 200, -- random spin, +/- (JJS)
	DustLifetime = 3, -- seconds before fading (JJS)
	DustFadeTime = 1, -- seconds the fade takes (JJS)
	DustCollisionGroup = "NonPColDebri", -- dust chips never hit players (JJS uses its "Effects" group)
}

table.freeze(Config.SettleResends)
table.freeze(Config.BodyIgnoresGroups)
return table.freeze(Config)

