--ServerScriptServices/Data/Data Manager

return {
	
	--Booleans
	Update_2_SawLog = false,
	CompletedQuest = false,
	



	Gold = 0,
	
	EmoteSpins = 0,

	TotalTimeSpent = 0,

	TotalKills = 0,

	MonthlyKills = 0,

	MonthlyDonated = 0,

	LeaderboardSeason = "", -- UTC month ("2026-11") that MonthlyKills / MonthlyDonated belong to

	MonthlyHistory = {}, -- past months, newest first: { Season = "2026-10", Kills, Donated, KillsRank, DonatedRank } (rank 0 = outside the top 100)
	
	LongestCombo = 0,

	TotalDamageDone = 0,

	TotalDamageTaken = 0,

	TotalCountersLanded = 0,
	
	TotalEmotesSpun = 0,
	
	TotalRobuxSpentOnEmotes = 0,
	
	TotalRobuxSpentOnGold = 0,
	
	TotalRobuxSpentOnGifts = 0,

	TotalRobuxDonated = 0,
	
	TotalRobuxSpent = 0,

	LastCharacter = "Zoro",

	AdminLevel = 0, -- 0 = Player, 1 = Tester, 2 = Moderator, 3 = Admin, 4 = Owner
	IsBanned = false,
	BanReason = "",

	AdminStatistics = {
		CommandsUsed = 0,
		PlayersKicked = 0,
		PlayersBanned = 0,
	},

	UnlockedCharacters = {
		Zoro = true,
	},

	CharacterStatistics = {
		Sanji = {
			TimeSpent = 0,
			Kills = 0,
			Deaths = 0,
			DamageDone = 0,
			DamageTaken = 0,
			CountersLanded = 0,
			LongestCombo = 0,
			HighestKillStreak = 0,
			AbilityUsageCount = {First = 0, Second = 0, Third = 0, Fourth = 0, Awakening = 0,},
		}		
	},

	-- Maybe i'll rework this and instead do Slot1 and Slot2 instead. But I need to make sure to clear my data if I do this.
	Emotes = {
		OwnedEmotes = {"Resolute"},
		EquippedEmotes = {
			["1_1"] = "Resolute",
			["1_2"] = "Resolute",
			["1_3"] = "Resolute",
			["1_4"] = "Resolute",
			["1_5"] = "Resolute",
			["1_6"] = "Resolute",
			["1_7"] = "Resolute",
			["1_8"] = "Resolute",
			["2_1"] = "Resolute",
			["2_2"] = "Resolute",
			["2_3"] = "Resolute",
			["2_4"] = "Resolute",
			["2_5"] = "Resolute",
			["2_6"] = "Resolute",
			["2_7"] = "Resolute",
			["2_8"] = "Resolute",
		}
	},

	Cosmetics = {
		OwnedAuras = {},
		OwnedAccessories = {},
		OwnedTitles = {},

		EquippedAuras = "",
		EquippedAccessories = {},
		EquippedTitle = "",
	},

	PurchaseIdCache = {},
	OutgoingGifts = {},
	PendingItems = {}, -- items bought with Robux or gifted, waiting for a seagull to bring them (ShopService)
	RedeemedCodes = {}, -- [CODE] = when it was redeemed (CodeService)

	--Boolean values like true and false depending on if they have it or not. The Ids need to be strings so we can go through them from first to last
	Gamepasses = {
		["2064380272"] = {owned = false, awarded = false}, --VIP 
		["2063706242"] = {owned = false, awarded = false}, --MoreEmotes
		["2063782093"] = {owned = false, awarded = false}, --SecondPage
		["2064411304"] = {owned = false, awarded = false}, --EarlyAccess
	},

	Settings = {
		-- General
		["Auto Use"]            = true,
		["Character Packages"]  = false,
		["Fast Mode"]           = false,
		["Day Night Cicle"]     = true,
		["Auto Run"]            = true,

		-- Audio
		["Awakening Music"]     = true,
		["Emote Music"]         = true,
		["Volume"]              = 1,
		["MusicVolume"] = .5,

		-- Visual / Performance
		["Camera Shake"]        = true,
		["Reduce Camera Shake"] = false,
		["Camera Follow"]       = true,      
		["Destruction Physics"] = true,
		["Blood"]               = true,
		["Low Graphics"]        = false,

		-- UI
		["Hide Gold"]           = false,
		["Show Console Controls"] = true,
		["Shiftlock Offset"]    = 1.75,
		["Hide FPS"]            = false,

		-- VIP only
		["Hide Kills"]          = false,
		["Hide Killstreak"]     = false,
		["Hide VIP Join Message"] = false,

		-- Player preferences (saved via UpdateSettings remote)
		["Changelogs"]              = true,
		["CustomizeKillSound"]      = false,
		["CustomizeAwakeningOutfit"] = false,
		["CustomizeVIPCape"]        = false,
	},

	-- Mobile touch-button custom positions/sizes (set via SaveButtonsPos/SaveButtonSize)
	ButtonsInfo = {
		Dash = {
			ScaleX = 0, OffsetX = 0, ScaleY = 0, OffsetY = 0,
			SizeMultiplier = 1,
		},
		M1 = {
			ScaleX = 0, OffsetX = 0, ScaleY = 0, OffsetY = 0,
			SizeMultiplier = 1,
		},
		Block = {
			ScaleX = 0, OffsetX = 0, ScaleY = 0, OffsetY = 0,
			SizeMultiplier = 1,
		},
		Shiftlock = {
			ScaleX = 0, OffsetX = 0, ScaleY = 0, OffsetY = 0,
			SizeMultiplier = 1,
		},
	},
	
	Ranked = {
		Season = "",              -- e.g. "2026-11"; the month this data belongs to
		Rating1v1 = 1000,
		Rating2v2 = 1000,
		Peak1v1 = 1000,           -- highest rating this season
		Peak2v2 = 1000,
		Played1v1 = 0,
		Wins1v1 = 0,
		Played2v2 = 0,
		Wins2v2 = 0,
		RegionMatchmaking = true,
		LastMatchId = "",         -- stops a match result from applying twice
		History = {},             -- past seasons, newest first, last 12 kept
	},
}

