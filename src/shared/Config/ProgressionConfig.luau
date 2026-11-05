--!strict
-- Player levels, XP and the non-Cash match rewards (GAME_PLAN.md Section 3C: Spin Tokens are
-- "earned through matches, quests, and level-ups"). Every number here is a starting value for
-- the balance pass.

local ProgressionConfig = {}

-- XP needed to go from `level` to `level + 1` is Base + PerLevel × (level − 1).
ProgressionConfig.XPCurve = {
	Base = 100,
	PerLevel = 50,
}
ProgressionConfig.MaxLevel = 200

-- XP for match events (RoundService). Paid at the same moments as the Cash rewards.
ProgressionConfig.XP = {
	Participation = 25, -- end of every match you took part in
	MidPoint = 15,
	RoundSurvived = 40,
	Kill = 20,
	Assist = 8,
	Shove = 3, -- per shove landed on another Runner
	Dodge = 2, -- per God hit dodged with iframes
	MatchWinner = 100,
	MVPAward = 30, -- per award card won
}

-- Spin Tokens for levelling up (normal spins, added to BOTH vaults).
-- TODO(design): one spin per level per vault; every 10th level also gives a Lucky Spin per vault.
ProgressionConfig.LevelUpRewards = {
	Spins = 1,
	LuckySpinsEvery = 10, -- levels
	LuckySpins = 1,
	Cash = 250,
}

-- Spin Tokens at the end of every match (normal spins, added to BOTH vaults).
-- TODO(design): small numbers on purpose; the Cash fallback is still the main F2P spin source.
ProgressionConfig.MatchSpinRewards = {
	Participation = 1,
	MatchWinner = 2,
}

return ProgressionConfig
