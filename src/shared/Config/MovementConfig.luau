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
