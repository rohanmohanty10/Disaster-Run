-- ReplicatedStorage > Modules > QuestConfig   (ModuleScript, shared by server and client)
--
-- Daily, weekly and monthly quests. QuestService (server) tracks progress and pays rewards;
-- QuestClient shows them.
--
-- Metric = what counts toward the quest:
--   Kills        knock out another player (the same player counts once a minute)
--   Damage       damage dealt to other players
--   Blocks       hits you blocked from other players
--   Minutes      minutes spent in the game
--   ItemsUsed    items used (a sniper shot, a cola bomb throw)
--   DailyClaims  daily quests claimed
-- Rewards: Gold, and optionally Spins (emote spins).
--
-- Pricing: a kill pays 70 Gold (150 with VIP) and an emote spin costs 1,000 Gold. A full day of
-- dailies pays about 1,200 Gold (~17 kills), a week ~6,300 Gold + a spin, a month ~15,500 Gold +
-- 6 spins. Changing quests? Bump Version so everyone's progress starts fresh.

local QuestConfig = {}

QuestConfig.Version = 2
QuestConfig.AllowStudioProgress = true
-- Character categories use the Info.Movesets keys (the player's "Character" attribute).
QuestConfig.Categories = { "Daily", "Weekly", "Monthly", "BlackBeard", "WhiteBeard", "Crocodile", "Zoro" }

-- Character quests never reset and only count while playing as that character.
QuestConfig.Permanent = { BlackBeard = true, WhiteBeard = true, Crocodile = true, Zoro = true }

-- Names shown in the menu (anything missing shows its key)
QuestConfig.Display = { BlackBeard = "Blackbeard", WhiteBeard = "Whitebeard", Crocodile = "Crocodile", Zoro = "Zoro" }

QuestConfig.Quests = {
	Daily = {
		{ Id = "daily_kills", Title = "Bounty Hunter", Description = "Knock out 5 players.", Metric = "Kills", Goal = 5, Gold = 125 },
		{ Id = "daily_damage", Title = "Heavy Hitter", Description = "Deal 2,000 damage to players.", Metric = "Damage", Goal = 2000, Gold = 100 },
		{ Id = "daily_blocks", Title = "Iron Wall", Description = "Block 20 attacks from players.", Metric = "Blocks", Goal = 20, Gold = 75 },
		{ Id = "daily_minutes", Title = "Set Sail", Description = "Play for 20 minutes.", Metric = "Minutes", Goal = 20, Gold = 75 },
		{ Id = "daily_items", Title = "Supply Run", Description = "Use an item from the Store.", Metric = "ItemsUsed", Goal = 1, Gold = 75 },
		{ Id = "daily_claims", Title = "Daily Discipline", Description = "Claim 4 other daily quests.", Metric = "DailyClaims", Goal = 4, Gold = 150 },
	},

	Weekly = {
		{ Id = "weekly_kills", Title = "Rampage", Description = "Knock out 40 players.", Metric = "Kills", Goal = 40, Gold = 750 },
		{ Id = "weekly_damage", Title = "Unstoppable Force", Description = "Deal 20,000 damage to players.", Metric = "Damage", Goal = 20000, Gold = 600 },
		{ Id = "weekly_blocks", Title = "Impenetrable", Description = "Block 150 attacks from players.", Metric = "Blocks", Goal = 150, Gold = 400 },
		{ Id = "weekly_minutes", Title = "Grand Voyage", Description = "Play for 3 hours.", Metric = "Minutes", Goal = 180, Gold = 500 },
		{ Id = "weekly_items", Title = "Quartermaster", Description = "Use 10 items from the Store.", Metric = "ItemsUsed", Goal = 10, Gold = 400 },
		{ Id = "weekly_claims", Title = "Weekly Champion", Description = "Claim 20 daily quests.", Metric = "DailyClaims", Goal = 20, Gold = 500, Spins = 1 },
	},

	Monthly = {
		{ Id = "monthly_kills", Title = "Calamity", Description = "Knock out 150 players.", Metric = "Kills", Goal = 150, Gold = 2000, Spins = 1 },
		{ Id = "monthly_damage", Title = "Apex Predator", Description = "Deal 80,000 damage to players.", Metric = "Damage", Goal = 80000, Gold = 1750, Spins = 1 },
		{ Id = "monthly_minutes", Title = "Seasoned Pirate", Description = "Play for 15 hours.", Metric = "Minutes", Goal = 900, Gold = 1500, Spins = 1 },
		{ Id = "monthly_claims", Title = "Dedicated Warrior", Description = "Claim 75 daily quests.", Metric = "DailyClaims", Goal = 75, Gold = 2500, Spins = 3 },
	},

	-- One-time character quests (~4,500 Gold + a spin per character)
	BlackBeard = {
		{ Id = "bb_kills", Title = "Darkness Swallows All", Description = "Knock out 25 players as Blackbeard.", Metric = "Kills", Goal = 25, Gold = 400 },
		{ Id = "bb_damage", Title = "Black Hole", Description = "Deal 15,000 damage as Blackbeard.", Metric = "Damage", Goal = 15000, Gold = 350 },
		{ Id = "bb_minutes", Title = "Emperor's Ambition", Description = "Play for 60 minutes as Blackbeard.", Metric = "Minutes", Goal = 60, Gold = 250 },
		{ Id = "bb_kills_2", Title = "Yonko of Darkness", Description = "Knock out 100 players as Blackbeard.", Metric = "Kills", Goal = 100, Gold = 1250, Spins = 1 },
	},

	WhiteBeard = {
		{ Id = "wb_kills", Title = "Quake Fist", Description = "Knock out 25 players as Whitebeard.", Metric = "Kills", Goal = 25, Gold = 400 },
		{ Id = "wb_damage", Title = "Seaquake", Description = "Deal 15,000 damage as Whitebeard.", Metric = "Damage", Goal = 15000, Gold = 350 },
		{ Id = "wb_blocks", Title = "Strongest Man Alive", Description = "Block 100 attacks as Whitebeard.", Metric = "Blocks", Goal = 100, Gold = 250 },
		{ Id = "wb_kills_2", Title = "Newgate's Legacy", Description = "Knock out 100 players as Whitebeard.", Metric = "Kills", Goal = 100, Gold = 1250, Spins = 1 },
	},

	Crocodile = {
		{ Id = "cr_kills", Title = "Desert Spada", Description = "Knock out 25 players as Crocodile.", Metric = "Kills", Goal = 25, Gold = 400 },
		{ Id = "cr_damage", Title = "Ground Death", Description = "Deal 15,000 damage as Crocodile.", Metric = "Damage", Goal = 15000, Gold = 350 },
		{ Id = "cr_minutes", Title = "Baroque Works Boss", Description = "Play for 60 minutes as Crocodile.", Metric = "Minutes", Goal = 60, Gold = 250 },
		{ Id = "cr_kills_2", Title = "Warlord of the Sea", Description = "Knock out 100 players as Crocodile.", Metric = "Kills", Goal = 100, Gold = 1250, Spins = 1 },
	},

	Zoro = {
		{ Id = "zo_kills", Title = "Three Sword Style", Description = "Knock out 25 players as Zoro.", Metric = "Kills", Goal = 25, Gold = 400 },
		{ Id = "zo_damage", Title = "Ashura", Description = "Deal 15,000 damage as Zoro.", Metric = "Damage", Goal = 15000, Gold = 350 },
		{ Id = "zo_blocks", Title = "Nothing Happened", Description = "Block 100 attacks as Zoro.", Metric = "Blocks", Goal = 100, Gold = 250 },
		{ Id = "zo_kills_2", Title = "Greatest Swordsman", Description = "Knock out 100 players as Zoro.", Metric = "Kills", Goal = 100, Gold = 1250, Spins = 1 },
	},
}

-- how the menu shows each reward (images are TEMP placeholders)
QuestConfig.RewardArt = {
	Gold = { Name = "Gold", Art = "rbxassetid://80297771892932", Rarity = "Legendary" }, -- the Gold display's coin
	Spins = { Name = "Emote Spin", Art = "rbxassetid://90522187215691", Rarity = "Epic" },
}

-- UTC resets: daily at midnight, weekly on Monday, monthly on the 1st
function QuestConfig.Period(Category: string, Timestamp: number): (string, number)
	if QuestConfig.Permanent[Category] then
		return "permanent", 0
	end
	local Day = math.floor(Timestamp / 86400)
	if Category == "Daily" then
		return tostring(Day), (Day + 1) * 86400
	elseif Category == "Weekly" then
		local Monday = Day - ((Day + 3) % 7)
		return tostring(Monday), (Monday + 7) * 86400
	end
	local Date = os.date("!*t", Timestamp)
	local Leap = Date.year % 4 == 0 and (Date.year % 100 ~= 0 or Date.year % 400 == 0)
	local DaysInMonth = { 31, if Leap then 29 else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
	local Reset = (Day + DaysInMonth[Date.month] - Date.day + 1) * 86400
	return string.format("%04d-%02d", Date.year, Date.month), Reset
end

function QuestConfig.Find(Category: string, Id: string)
	for _, Quest in QuestConfig.Quests[Category] or {} do
		if Quest.Id == Id then
			return Quest
		end
	end
	return nil
end

return QuestConfig
