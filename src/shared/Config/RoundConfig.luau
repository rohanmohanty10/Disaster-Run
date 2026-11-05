--!strict
-- Match / round timings, roles and Cash rewards (GAME_PLAN.md Sections 1 and 6).

local RoundConfig = {}

RoundConfig.MinPlayers = 2 -- players needed to start a match (1 in Studio for solo testing)
RoundConfig.IntermissionTime = 20
RoundConfig.PreparationTime = 5 -- countdown in the start bunker
RoundConfig.RoundTime = 105 -- the crossing
RoundConfig.RoundEndTime = 6
RoundConfig.MatchEndTime = 15 -- MVP leaderboard on screen

RoundConfig.PlayersPerStartingGod = 10 -- round 1: one God per this many players (min 1)

-- Starting Gods are picked by priority (GAME_PLAN.md Section 1): God Pass owners first, then
-- whoever has gone the most matches without being a starting God. 0 = no God Pass yet.
RoundConfig.GodPassGamePassId = 0

-- God resource
RoundConfig.GodEnergy = {
	Max = 150,
	Regen = 10, -- per second
	Start = 60,
}
RoundConfig.GodPlatformHeight = 250 -- God bodies wait this high above the course

-- Course. If workspace has a Model named "Course" with parts named "StartSpawn" and "Sanctuary",
-- those are used. Otherwise two invisible markers are placed on the baseplate (no map is built).
RoundConfig.DefaultCourse = {
	Start = Vector3.new(0, 5, 60),
	Sanctuary = Vector3.new(0, 5, -540),
	SanctuarySize = Vector3.new(160, 30, 20),
}

-- Cash (GAME_PLAN.md Section 6A)
RoundConfig.Rewards = {
	MidPoint = 500,
	Survived = 1500,
	SurvivedPerRound = 250, -- extra × round number
	Kill = 400,
	Assist = 150,
	GodWipeBounty = 2500, -- split between the Gods when nobody survives a round
	MatchWinner = 5000,
	MVPAward = 1000,
	Participation = 200,
}

-- MVP score (GAME_PLAN.md Section 6C)
RoundConfig.MVPScore = {
	RoundsSurvived = 100,
	TimeSurvived = 1,
	Kills = 75,
	Assists = 25,
	DamageDealt = 0.5,
	Dodges = 10,
	MatchWinner = 500,
}

return RoundConfig
