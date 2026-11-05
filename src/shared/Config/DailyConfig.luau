--!strict
-- Daily login rewards and daily quests (GAME_PLAN.md Section 3C / 3E).
-- A "day" is a UTC day (os.time() // 86400), the same on every server.

export type Reward = {
	Cash: number?,
	Spins: number?, -- normal spins, added to BOTH vaults
	LuckySpins: number?, -- lucky spins, added to BOTH vaults
	BoostedSpins: number?, -- ad / daily boosted spins (doubled high-tier odds), BOTH vaults
	XP: number?,
}

export type QuestDef = {
	Id: string,
	Text: string, -- "{goal}" is replaced by the goal number
	Stat: string, -- counter it listens to (QuestService.Increment)
	Goal: number,
	Reward: Reward,
}

local DailyConfig = {}

-- Login streak: day N of the streak gets Rewards[N]; after the last day it loops back to day 1.
-- Missing a day resets the streak. Every claim also gives the boosted spins below (GAME_PLAN 3E).
DailyConfig.BoostedSpinsPerClaim = 3
DailyConfig.Rewards = {
	{ Cash = 500 },
	{ Cash = 750, Spins = 1 },
	{ Cash = 1000 },
	{ Cash = 1250, Spins = 1 },
	{ Cash = 1500 },
	{ Cash = 2000, Spins = 2 },
	{ Cash = 3000, LuckySpins = 1 },
} :: { Reward }

-- Daily quests: each day every player gets QuestsPerDay quests picked from the pool
-- (the same picks all day, different for every player).
DailyConfig.QuestsPerDay = 3

-- Counters quests can use. RoundService / GachaService report these through QuestService.Increment.
--   MatchesPlayed, RoundsSurvived, MidPoints, Kills, Assists, DamageDealt, Dodges, Shoves, Spins
DailyConfig.Quests = {
	{ Id = "Play2", Text = "Play {goal} matches", Stat = "MatchesPlayed", Goal = 2, Reward = { Cash = 1000, XP = 50 } },
	{ Id = "Survive3", Text = "Survive {goal} rounds", Stat = "RoundsSurvived", Goal = 3, Reward = { Spins = 1, XP = 60 } },
	{ Id = "MidPoint5", Text = "Reach the canyon mid-point {goal} times", Stat = "MidPoints", Goal = 5, Reward = { Cash = 1500, XP = 50 } },
	{ Id = "Kills5", Text = "Eliminate {goal} Runners as a God", Stat = "Kills", Goal = 5, Reward = { Spins = 1, XP = 60 } },
	{ Id = "Assists5", Text = "Get {goal} assists as a God", Stat = "Assists", Goal = 5, Reward = { Cash = 1500, XP = 40 } },
	{ Id = "Damage500", Text = "Deal {goal} damage as a God", Stat = "DamageDealt", Goal = 500, Reward = { Cash = 2000, XP = 50 } },
	{ Id = "Dodge10", Text = "Dodge {goal} God strikes", Stat = "Dodges", Goal = 10, Reward = { Spins = 1, XP = 50 } },
	{ Id = "Shove5", Text = "Shove {goal} Runners", Stat = "Shoves", Goal = 5, Reward = { Cash = 1500, XP = 40 } },
	{ Id = "Spin10", Text = "Spin {goal} times in either vault", Stat = "Spins", Goal = 10, Reward = { Cash = 2000, XP = 30 } },
} :: { QuestDef }

return DailyConfig
