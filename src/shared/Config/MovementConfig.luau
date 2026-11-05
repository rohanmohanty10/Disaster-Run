--!strict
-- Runner movement numbers (GAME_PLAN.md Section 2B / FRAMEWORK_PLAN.md Section 4).

local MovementConfig = {}

MovementConfig.WalkSpeed = 16
MovementConfig.SprintSpeed = 26

MovementConfig.Stamina = {
	Max = 100,
	SprintDrain = 20, -- per second while sprinting and moving
	RegenDelay = 1.5, -- seconds after the last drain before regen starts
	Regen = 25, -- per second
}

MovementConfig.Slide = {
	Key = Enum.KeyCode.LeftControl,
	AltKey = Enum.KeyCode.C,
	Speed = 42, -- studs/s at the start of the slide
	Duration = 0.45,
	IFrames = 0.35,
	Cooldown = 1.2,
	StaminaCost = 15,
}

MovementConfig.SprintKey = Enum.KeyCode.LeftShift

-- Shoulder-shove: every Runner has it, whatever their kit (GAME_PLAN.md Section 2B).
-- Pushes the nearest Runner in front of you; it doesn't damage, it moves them (into God strikes).
MovementConfig.Shove = {
	Key = Enum.KeyCode.F,
	Cooldown = 4,
	StaminaCost = 10,
	Range = 7, -- studs from your root to theirs
	Angle = 80, -- degrees, cone in front of you
	Power = 60, -- knockback speed
	Lift = 14,
	Stun = 0.4, -- short stagger so they can't instantly walk back
}

-- Server-side movement checks (MovementGuardService). The server owns stamina and watches how
-- far each Runner moves; a Runner moving faster than they're allowed is pulled back.
MovementConfig.AntiCheat = {
	Enabled = true,
	SampleInterval = 0.25, -- seconds between position checks
	SpeedTolerance = 1.6, -- allowed speed × this (lag, slopes, jump momentum)
	ExtraStuds = 4, -- flat allowance per sample
	Strikes = 3, -- violations within StrikeWindow before a pull-back
	StrikeWindow = 4,
	-- Shortest time a crossing can take: course length ÷ (sprint speed × this).
	MinCrossingSpeedFactor = 3,
}

-- A God strike that lands within this many studs of a Runner without hitting them is a near miss.
MovementConfig.NearMiss = {
	Radius = 6,
	StaminaRefund = 15,
}

-- Runner camera
MovementConfig.Camera = {
	ShiftLockKey = Enum.KeyCode.LeftAlt,
	FieldOfView = 70,
}

return MovementConfig
