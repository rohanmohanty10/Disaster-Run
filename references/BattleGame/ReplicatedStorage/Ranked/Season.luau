-- Monthly season rules for profile.Data.Ranked (shape defined in the shared Template).
local Config = require(script.Parent.Config)

local Season = {}

local SIZES = { "1v1", "2v2" }

-- Season id is the UTC month, e.g. "2026-11".
function Season.Current(): string
	return os.date("!%Y-%m")
end

local function snapshot(ranked)
	local entry = { Season = ranked.Season }
	for _, size in SIZES do
		entry["Rating" .. size] = ranked["Rating" .. size]
		entry["Peak" .. size] = ranked["Peak" .. size]
		entry["Tier" .. size] = Config.GetTier(ranked["Rating" .. size])
		entry["Played" .. size] = ranked["Played" .. size]
		entry["Wins" .. size] = ranked["Wins" .. size]
	end
	return entry
end

-- Call once when a profile loads. Returns true if the profile moved into a new season.
-- First-ever load just stamps the season; later month changes archive and soft-reset.
function Season.Apply(ranked): boolean
	local current = Season.Current()
	if ranked.Season == current then
		return false
	end

	if ranked.Season ~= "" then
		if ranked.Played1v1 > 0 or ranked.Played2v2 > 0 then
			table.insert(ranked.History, 1, snapshot(ranked))
			while #ranked.History > Config.HistoryLimit do
				table.remove(ranked.History)
			end
		end

		for _, size in SIZES do
			local old = ranked["Rating" .. size]
			local new = math.round(Config.StartRating + (old - Config.StartRating) * Config.SoftResetFactor)
			ranked["Rating" .. size] = new
			ranked["Peak" .. size] = new
			ranked["Played" .. size] = 0
			ranked["Wins" .. size] = 0
		end
	end

	ranked.Season = current
	return true
end

-- Matches played in this size across the current season and every archived one.
function Season.LifetimePlayed(ranked, size: string): number
	local total = ranked["Played" .. size] or 0
	for _, entry in ranked.History or {} do
		total += entry["Played" .. size] or 0
	end
	return total
end

return Season
