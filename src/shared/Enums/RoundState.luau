--!strict
-- Round states (FRAMEWORK_PLAN.md Section 3). The current state is the "RoundState" attribute
-- on ReplicatedStorage, with "RoundEndsAt" (server time) and "RoundNumber" beside it.

local RoundState = {
	Waiting = "Waiting", -- not enough players
	Intermission = "Intermission",
	RoleSelection = "RoleSelection",
	MapGeneration = "MapGeneration",
	Preparation = "Preparation",
	ActiveRun = "ActiveRun",
	RoundEnd = "RoundEnd",
	MatchEnd = "MatchEnd",
}

export type RoundState = "Waiting" | "Intermission" | "RoleSelection" | "MapGeneration" | "Preparation" | "ActiveRun" | "RoundEnd" | "MatchEnd"

return table.freeze(RoundState)
