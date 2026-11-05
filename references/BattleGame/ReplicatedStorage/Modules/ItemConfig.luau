-- ReplicatedStorage > Modules > ItemConfig   (ModuleScript, shared by server and client)
--
-- How each usable item behaves. The models live in ReplicatedStorage > Assets > Items.
-- An item is held one of these ways:
--   Joint    = a Motor6D like the one in your animation rig, so the item's animations can move it.
--              Name must match the joint's name in the rig, and the model's main part must have
--              the same name as in the rig (the Sniper's part is called "Rifle").
--   Overhead = like your trash cans/barrels: it stands on the ground, M1 in front of it picks it
--              up (Throwables.Pickup), you carry it over your head (Throwables.Idle) and M1
--              throws it (Throwables.Throw). Getting hit makes you drop it.
--   Grip     = a plain weld to the Right Arm (R6; the arm's bottom is y = -1, forward is -z).
-- Animations: put Animation objects inside the item's model (Assets > Items > <Model>). The
-- client plays these names when it has them: Idle, Run, AimIn, AimIdle, Reload.

local ItemConfig = {}

ItemConfig.Items = {
	Sniper = {
		Name = "Sniper",
		Model = "Rifle",
		Ammo = 3, -- shots before it breaks (JJS: 3)
		HoldScale = 1,
		-- copied from Workspace.mysniper.Torso.Rifle (the rig the animations were made on)
		Joint = {
			Name = "Rifle",
			Part0 = "Torso",
			C0 = CFrame.new(-0.2303, 1.1634, -1.5463),
			C1 = CFrame.new(-0.05, -0.24, 1.1177),
		},
		Controls = "[M1] Shoot   [RMB] Scope   [Backspace] Drop",

		Damage = 30,
		Ragdoll = 1.5,
		Knockback = 35,
		BulletSpeed = 900, -- studs per second; the bullet really travels, so people can dodge it
		Range = 1200,
		ShotCooldown = 1.4, -- includes working the bolt
		WallHole = 3, -- size of the hole a missed shot leaves in walls (0 = none)
	},

	ColaBomb = {
		Name = "Cola Bomb",
		Model = "ColaBomb",
		Ammo = 1, -- one throw, then it's gone
		HoldScale = 0.8, -- size on the ground and over your head
		Overhead = true,
		Bomb = true, -- thrown, then blows up (ItemService ThrowBomb)
		-- where it sits on your HumanoidRootPart (forward is -z, back is +z). On the ground it stands
		-- up; carried, it lies across your arms. Both are the barrel's values from NewCombatSystem.
		Carry = CFrame.new(0, 3.5, 1) * CFrame.Angles(math.rad(90), 0, 0), -- lying flat over your head
		WindUp = CFrame.new(0, 2, 2) * CFrame.Angles(math.rad(140), 0, 0), -- pulled back behind your head before the throw
		WindUpTime = 0.53, -- matches the "swing" marker in Throwables.Throw
		Controls = "[M1] Throw   [Backspace] Put down",

		ThrowRange = 90, -- farthest you can aim a throw
		ThrowTime = 0.8, -- seconds in the air before it lands where you aimed
		ThrowCooldown = 0.9,
		Fuse = 3.75, -- seconds from the throw to the blast (JJS: 7 blinks of 0.5s + 0.25s)
		Radius = 16, -- hurts everyone in range, the thrower too
		HitSelf = true,
		NearDamage = 28,
		FarDamage = 10,
		Ragdoll = 2,
		Knockback = 60,
		Lift = 40,
		Crater = 14, -- Debree hole size (0 = none)
		PieceSize = 3, -- size of each broken piece in studs
	},

	-- Buggy's cannonball. Carried and thrown like the Cola Bomb; once it lands, the Light on top
	-- blinks red every 0.1s (like Portal Asylum's revive bombs) for BlinkTime, then it goes off with
	-- the Buggyball explosion.
	MuggyBall = {
		Name = "Muggy Ball",
		Model = "MuggyBall",
		Ammo = 1,
		HoldScale = 1,
		Overhead = true,
		Bomb = true,
		Carry = CFrame.new(0, 3.7, 0.6), -- over your head
		WindUp = CFrame.new(0, 2.3, 2), -- pulled back behind your head before the throw
		WindUpTime = 0.53,
		Controls = "[M1] Throw   [Backspace] Put down",

		ThrowRange = 100,
		ThrowTime = 0.8,
		ThrowCooldown = 0.9,
		Fuse = 2.3, -- seconds from the throw to the blast: 0.8 in the air + 1.5 blinking
		BlinkTime = 1.5,
		Explosion = "Buggyball", -- ReplicatedStorage > Assets > Effects > Items > Buggyball > explosion
		-- the Buggyball explosion's fire reaches ~20-25 studs out, so the hit and the hole are close to it
		Radius = 22,
		HitSelf = true,
		NearDamage = 35,
		FarDamage = 12,
		Ragdoll = 2.5,
		Knockback = 48,
		Lift = 44,
		Crater = 60, -- the hole's diameter (was 30)
		PieceSize = 6, -- size of each broken piece in studs (was 3): bigger = fewer pieces, less lag
		Destroyed = 0.5, -- share of the broken pieces removed completely, no debris (0 - 1)
	},

	-- The golden Den Den Mushi, aimed like Soulbound's Rocket Launchers. M1 rings it: for AimTime
	-- a red marker follows your mouse (only you see it), then the Marine fleet fires red cannonballs
	-- out of the sky that land on the ground (never on buildings) up to Spread studs around it.
	-- Every explosion is a random size between Scale[1] and Scale[2]; its hit radius, damage and
	-- crater grow with it.
	BusterCall = {
		Name = "Buster Call",
		Model = "denden",
		Ammo = 1,
		HoldScale = 1,
		Grip = CFrame.new(0, -0.7, -0.79) * CFrame.Angles(-math.pi / 2, 0, 0), -- on the end of the arm, half over the fist, head forward (model at 0.6 scale)
		HoldPose = "ArmOut", -- right arm held straight out (ItemsClient sets only the shoulder, so the legs still walk normally)
		HoldWalkSpeed = 16, -- you can only walk while holding it (no running)
		Controls = "[M1] Ring it, then aim with your mouse   [Backspace] Drop",

		AimTime = 3.5, -- seconds the snail rings while the marker follows your mouse (Soulbound: 1.95)
		CallRange = 300, -- farthest spot you can call it on
		-- the barrage comes in waves: Count rockets each, leaving Delay seconds after the first, and
		-- only the first Craters of each wave to land make a hole (the rest just explode)
		Waves = {
			{ Count = 23, Delay = 0, Craters = 20 }, -- the first wave (Soulbound: 18)
			{ Count = 18, Delay = 1.3, Craters = 7 },
			{ Count = 18, Delay = 2.6, Craters = 5 },
		},
		Spread = 90, -- most land within this radius of the middle (the big marker is sized to it)...
		Focus = 1.6, -- ...bunched toward the middle (1 = even, higher = tighter)
		OuterShare = 0.3, -- share that land out past it instead...
		OuterSpread = 150, -- ...up to this far out (Soulbound's MAX_EXPLOSION_OFFSET: 85)
		DistanceDelay = 0.005, -- seconds later per stud from you: the near ones land first, far ones later
		LaunchSpread = 0.25, -- seconds between the first and the last of a wave leaving (Soulbound: all at once)
		-- fired like cannons from a fleet you can't see: far behind you along your look, spread along a line
		FleetDistance = 450, -- studs behind you the cannons fire from...
		FleetHeight = 30, -- ...this high up...
		FleetWidth = 150, -- ...anywhere this far to either side
		FlightTime = { 2.6, 3.4 }, -- seconds in the air
		Gravity = 110, -- studs/s^2 pulling them down: more = a higher, steeper arc (apex ~ Gravity x time^2 / 8 above the line)
		Scale = { 0.5, 2.6 }, -- explosion sizes (Soulbound: 0.6 - 2)
		Explosion = "Buggyball",
		ExplosionAmount = 0.4, -- share of the explosion's particles each rocket uses (30 at 0.4 cost about what 18 at 0.6 did)
		BlastRadius = 24, -- hit radius of a size 1 explosion (its fire reaches ~20 studs)
		FirstDamage = { 25, 32 }, -- damage from the first rocket that hits you (Soulbound: 22 - 27)...
		RepeatDamage = 6, -- ...and from each one after it (Soulbound: 2 - 3)
		MaxHits = 4, -- most rockets that can hurt the same person
		HitSelf = false,
		Ragdoll = 2, -- seconds ragdolled (Soulbound: 2)
		Knockback = 18, -- push away from the blast...
		Lift = 75, -- ...and up into the air
		Crater = 32, -- the hole's diameter for a size 1 explosion (was 16)
		PieceSize = 6, -- size of each broken piece in studs (was 3): bigger = fewer pieces, less lag
		Destroyed = 0.3, -- share of the broken pieces removed completely, no debris (0 - 1)
		FullDestroyChance = 0.2, -- chance a crater removes everything it breaks (no debris at all);
		--                          the others remove Destroyed of it
	},
}

-- The seagull that brings what you buy
ItemConfig.Delivery = {
	Model = "Seagull",
	FlyHeight = 55, -- studs above the drop spot it lets go of the package
	FlyDistance = 220, -- how far away it comes from and leaves to
	ArriveTime = 3, -- seconds from appearing to dropping the package
	LeaveTime = 3, -- seconds from dropping to flying out of sight
	FallTime = 1.2, -- seconds the package takes to fall
	PackageLife = 60, -- seconds a package waits to be opened
	OwnerOnly = 15, -- seconds only the buyer can open it; after that anyone can
	-- The seagull mesh faces this way when it flies straight ahead. If it flies sideways or
	-- backwards, change the angle (in degrees) until it faces forward.
	ModelYaw = 0,
}

ItemConfig.PickupLife = 30 -- seconds a dropped item stays on the ground

function ItemConfig.Get(Id: string)
	return ItemConfig.Items[Id]
end

return ItemConfig
