-- Shared ranked settings. Lives in ReplicatedStorage so the client UI can read it too.
-- This folder is a package shared by Demon Fruits, Lobby and Arena: edit it once, publish the package.
local Config = {}

Config.PlaceIds = {
	Main = 83585307041701,
	Lobby = 123013063215361,
	Arena = 116423306986582,
}

-- Flip to true once the Lobby matchmaker exists (the Lobby shows "matchmaker not live yet" until then).
Config.MatchmakerLive = true

Config.StartRating = 1000

-- Monthly seasons: ratings move this fraction of the way back to StartRating at each new month.
Config.SoftResetFactor = 0.5
-- Past seasons kept in each profile's Ranked.History (newest first).
Config.HistoryLimit = 12

-- One entry per card/size combination. The key is the queue id sent to the server.
Config.Queues = {
	Casual1v1 = { Kind = "Casual", Size = "1v1", Ranked = false, TeamSize = 1 },
	Ranked1v1 = { Kind = "Ranked", Size = "1v1", Ranked = true, TeamSize = 1 },
	Casual2v2 = { Kind = "Casual", Size = "2v2", Ranked = false, TeamSize = 2 },
	Ranked2v2 = { Kind = "Ranked", Size = "2v2", Ranked = true, TeamSize = 2 },
}

-- OrderedDataStore names for the "Highest Elo" boards ("_Test" is added in Studio).
Config.LeaderboardStores = {
	["1v1"] = "RankedRating1v1",
	["2v2"] = "RankedRating2v2",
}

-- MemoryStore hash map the Lobby writes match records into, keyed by the reserved
-- server's PrivateServerId (the second value ReserveServer returns).
Config.MatchStore = "ArenaMatches"

Config.VipGamepassId = "2064380272"

-- Lobby matchmaker and parties.
Config.Matchmaking = {
	TickSeconds = 2,              -- how often the matcher runs and servers check for results
	TicketExpiry = 60,            -- a ticket nobody refreshes disappears after this (crashed server)
	RefreshSeconds = 15,          -- owning server re-touches its tickets this often
	ClaimTimeout = 30,            -- a ticket claimed this long without becoming a match is released
	RatingWindowStart = 100,      -- ranked: start matching within +-100
	RatingWindowStep = 50,        -- ...widen by 50
	RatingWindowStepSeconds = 10, -- ...every 10 s of waiting
	RatingWindowMax = 400,        -- ...up to +-400
	CasualAnyRatingAfter = 10,    -- casual ignores rating after this many seconds
	NeighborRegionsAfter = 30,    -- region matchmaking on: neighbour regions after 30 s
	AnyRegionAfter = 90,          -- ...anyone after 90 s, so small regions never wait forever
	PartySize = 2,                -- duos (2v2 only)
	InviteSeconds = 30,
	InviteCooldown = 5,           -- seconds between invites from one player (Jump Showdown used 5)
	SameTargetCooldown = 15,      -- seconds before inviting the same person again
	JoinTeleportSeconds = 60,     -- invitee from another Lobby server has this long to arrive
	TeleportRetries = 2,
}

-- Arena match rules.
Config.Arena = {
	Lives = 3,
	RecordTimeout = 15,      -- seconds to wait for the Lobby's match record
	LoadTimeout = 30,        -- seconds for every player to arrive and load; anyone missing = match cancelled
	SelectSeconds = 15,      -- character select (frozen at spawns)
	CountdownSeconds = 3,
	RespawnDelay = 3,
	SelectRespawnDelay = 0.5, -- respawn after swapping character during select
	SpawnProtection = 2,     -- seconds; attacking ends it early
	SuddenDeathWindow = 0.1, -- both teams' last lives gone this close together = sudden death
	ResultsSeconds = 8,
	FallY = -40,             -- below this height you are dead (falls through a crater)
	KillCreditWindow = 10,   -- a death credits whoever damaged you within this many seconds
	AfkWarnSeconds = 20,
	AfkKickSeconds = 30,
	DodgePenalty = 10,       -- ranked: leaving before the fight starts
	KFactor = 32,
	PlacementKFactor = 48,
	PlacementLifetimeMatches = 10, -- first 10 matches ever (per size)
	PlacementSeasonMatches = 5,    -- first 5 matches of every season (per size)
	MinAccountAgeDays = 0,   -- ranked queues; enforced by the Lobby matchmaker (0 = anyone can queue; was 7)
	CountTotalKills = true,  -- arena kills add to Total Kills (titles)
	CountMonthlyKills = false,
	QuestsCount = false,     -- arena fights do not progress main-game quests
}

-- Arena gold. Casual pays CasualMultiplier of everything; friend duels pay FriendlyMultiplier.
Config.Rewards = {
	KillGold = 70,
	KillGoldVIP = 150,
	WinGold = 200,
	LossGold = 50,           -- only for finishing the match (not leaving / AFK)
	CasualMultiplier = 0.5,
	FriendlyMultiplier = 0,
	MinDamageForGold = 100,  -- deal less than this and the match pays nothing
	IdleVictimSeconds = 10,  -- killing someone idle this long pays no kill gold
	SameOpponentsPerHour = 3, -- after this many paid matches vs the same opponents in an hour, no gold
	MinFightSecondsForWinGold = 30,
	DailyCap = 3000,         -- arena gold per UTC day
}

-- Display-only tiers, lowest first. Matchmaking always uses the number.
Config.Tiers = {
	{ Name = "Bronze", Min = -math.huge },
	{ Name = "Silver", Min = 900 },
	{ Name = "Gold", Min = 1100 },
	{ Name = "Platinum", Min = 1300 },
	{ Name = "Diamond", Min = 1500 },
	{ Name = "Champion", Min = 1700 },
}

function Config.GetTier(rating: number): string
	local name = Config.Tiers[1].Name
	for _, tier in Config.Tiers do
		if rating >= tier.Min then
			name = tier.Name
		end
	end
	return name
end

-- Country code (LocalizationService) -> matchmaking region.
-- Country-level data cannot tell US East from US West; that needs ping measurement later.
local REGIONS = {
	NA = { "US", "CA", "MX", "PR", "GT", "HN", "SV", "NI", "CR", "PA", "DO", "JM", "CU", "BS", "TT", "BZ", "HT" },
	SA = { "BR", "AR", "CL", "CO", "PE", "VE", "EC", "BO", "PY", "UY", "GY", "SR" },
	EU = {
		"GB", "IE", "FR", "DE", "NL", "BE", "LU", "ES", "PT", "IT", "CH", "AT", "DK", "NO", "SE", "FI", "IS",
		"PL", "CZ", "SK", "HU", "RO", "BG", "GR", "HR", "SI", "RS", "BA", "ME", "MK", "AL", "EE", "LV", "LT",
		"UA", "BY", "MD", "RU", "TR", "CY", "MT", "GE", "AM", "AZ",
		-- Middle East and Africa usually land on European servers
		"SA", "AE", "QA", "KW", "BH", "OM", "IL", "JO", "LB", "EG", "MA", "DZ", "TN", "ZA", "NG", "KE", "GH",
	},
	ASIA = {
		"JP", "KR", "CN", "TW", "HK", "MO", "SG", "MY", "TH", "VN", "PH", "ID", "IN", "PK", "BD", "LK", "NP",
		"KH", "MM", "LA", "MN", "KZ", "UZ",
	},
	OCE = { "AU", "NZ", "FJ", "PG" },
}

Config.RegionByCountry = {}
for region, countries in REGIONS do
	for _, code in countries do
		Config.RegionByCountry[code] = region
	end
end

-- Regions the matchmaker may widen into after waiting (used once the matchmaker exists).
Config.RegionNeighbors = {
	NA = { "SA" },
	SA = { "NA" },
	EU = {},
	ASIA = { "OCE" },
	OCE = { "ASIA" },
}

function Config.GetRegion(countryCode: string?): string
	return Config.RegionByCountry[countryCode or ""] or "ANY"
end

return Config
