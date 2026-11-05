--[[
	CharacterConfig

	Every character's moves in one place. Change a number here and it applies the next
	time the server starts (stop and press Play again in Studio).

	[1]-[4]  = hotbar moves (keys 1-4)
	Ult      = the move G fires (no cooldown; it's gated by the awakening bar)

	Name     = what the hotbar shows
	Cooldown = seconds before the move can be used again
	Damage   = damage per hit. Players have 100 HP. Some hits land many times
	           (the comment says roughly how many), so the move's total is bigger.

	Finishers that kill a low-HP target aren't listed; they always deal the
	target's remaining health.
]]

local CharacterConfig = {}

-- M1 combo, all characters. One entry per punch in the 4-hit string.
CharacterConfig.M1Damage = { 2, 2, 2, 4 }

CharacterConfig.Zoro = {
	[1] = {
		Name = "Yaksha Crow", Cooldown = 20,
		TickInterval = 0.1, MaxTicks = 14, -- Tick lands this often while they're carried up, until the slam
		Damage = { Grab = 2, Tick = 0.5, Slam = 8 }, -- ~17 total
	},
	[2] = {
		Name = "Slash Barrage", Cooldown = 20,
		Damage = { BarrageHit = 0.75, FinisherTick = 0.75 }, -- ~18 barrage hits + ~10 finisher ticks, ~20 total
	},
	[3] = {
		Name = "Onigiri", Cooldown = 20,
		Damage = { Hit = 18 },
	},
	[4] = {
		Name = "Tower Climb", Cooldown = 18, CooldownWhiff = 16, -- counter: CooldownWhiff applies when nothing hits you during the stance
		Damage = { Counter = 18 },
	},
	Ult = {
		Name = "Tatsumaki",
		TickTime = 3.2, TickInterval = 0.15, -- TickTotal is split over this many seconds while they spin
		FinisherHP = 30, -- the final slam kills anyone at or below this much HP
		Damage = { Pull = 15, TickTotal = 50, Final = 28 }, -- Pull lands twice when they're caught
	},
}

CharacterConfig.BlackBeard = {
	[1] = {
		Name = "Abyssal Pull", Cooldown = 22,
		Damage = { Grab = 1, Slam = 10, PullGrab = 1 }, -- ~11 total
	},
	[2] = {
		Name = "Blackhole", Cooldown = 20,
		Damage = { Pull = 3, Burst = 8 }, -- ~11 total
	},
	[3] = {
		Name = "Dark Vortex", Cooldown = 20,
		Damage = { Grab = 5, Throw = 8 }, -- ~13 total
	},
	[4] = {
		Name = "Devour", Cooldown = 20,
		Damage = { Hit = 12 },
	},
	Ult = {
		Name = "Liberation",
		Damage = { Tick = 0.75, Pull = 1, Final = 70 }, -- ~75 total
	},
}

CharacterConfig.WhiteBeard = {
	[1] = {
		Name = "Tremor Punch", Cooldown = 22,
		Damage = { Near = 18, Far = 6 }, -- scales from Near (point blank) to Far (max range)
	},
	[2] = {
		Name = "Sweep", Cooldown = 20,
		Damage = { Tick = 0.75, Final = 10 }, -- ~14 ticks + final, ~20 total
	},
	[3] = {
		Name = "Seismic Leap", Cooldown = 20,
		Damage = { KnockUp = 10, Landing = 5, Shockwave = 5, Combo1 = 3, Combo2 = 3, ComboFinal = 6 },
	},
	[4] = {
		Name = "Heaven and Earth", Cooldown = 20,
		Damage = { Stomp = 15, Grab = 5, Fissure = { 6, 9, 12, 15 } }, -- Fissure: near end -> far end
	},
	Ult = {
		Name = "Tsunami",
		Damage = { Wave = 30, Burst = 35, Push = 10 }, -- up to ~75 total
	},
}

CharacterConfig.Crocodile = {
	[1] = {
		Name = "Slash", Cooldown = 18,
		Damage = { Hit = 14 },
	},
	[2] = {
		Name = "Desert Spada", Cooldown = 20,
		Damage = { Line = 8, Slam = 12 }, -- ~20 total
	},
	[3] = {
		Name = "Suna Grab", Cooldown = 20,
		Damage = { Grab = 5, Throw = 9 }, -- ~14 total
	},
	[4] = {
		Name = "Sables", Cooldown = 20,
		Damage = { Throw = 10, Catch = 6, Tick = 0.75 }, -- Tick hits every 0.25s while caught in the tornado
	},
	Ult = {
		Name = "Sables Pesado",
		Damage = { Center = 75, Edge = 50 }, -- explosion scales from Center to Edge of the blast
	},
}

return CharacterConfig
