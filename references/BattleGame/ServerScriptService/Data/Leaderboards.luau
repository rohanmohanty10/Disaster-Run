--[[
	Leaderboards (server)

	Scores live on each player's profile: TotalKills, MonthlyKills, TotalRobuxDonated, MonthlyDonated.
	Every SYNC_INTERVAL seconds, changed scores are copied into OrderedDataStores.

	Monthly boards use one store per UTC month ("MonthlyKills_2026_11"), the same month rule as Ranked.
	A new month therefore starts empty on its own - nothing is wiped - and every past month stays
	readable (that is where "October champion" comes from).

	Every REFRESH_INTERVAL seconds the top 100 of each board is read and published as JSON in
	ReplicatedStorage.LeaderboardData.<Board> (StringValues). StarterPlayerScripts.LeaderboardBoards
	draws them. The #1 user of each board is also set as an attribute on that folder
	(e.g. LeaderboardData:GetAttribute("AllTimeTopDonatorsLeader")).
]]

local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserService = game:GetService("UserService")

local DataManager = require(script.Parent.DataManager)

local Leaderboards = {}

local SUFFIX = RunService:IsStudio() and "_Test" or ""
local TOP = 100
local SYNC_INTERVAL = 60
local REFRESH_INTERVAL = 120
local RANK_SETTLE = 15 * 60 -- wait this long after a month ends before saving players' final ranks for it
local DONOR_REFRESH_GAP = 30 -- minimum seconds between the quick donor-board refreshes after donations
local BOARD_NAMES = { "AllTimeKills", "MonthlyKills", "AllTimeTopDonators", "MonthlyTopDonators" }

-- which profile field feeds each board
local FIELD = {
	AllTimeKills = "TotalKills",
	MonthlyKills = "MonthlyKills",
	AllTimeTopDonators = "TotalRobuxDonated",
	MonthlyTopDonators = "MonthlyDonated",
}
local ALL_TIME_STORE = {
	AllTimeKills = "TotalKillsDatastore",
	AllTimeTopDonators = "TotalDonationsDatastore",
}
local MONTHLY_STORE = {
	MonthlyKills = "MonthlyKills_",
	MonthlyTopDonators = "MonthlyDonations_",
}

local stores = {}
local function getStore(name: string): OrderedDataStore
	name ..= SUFFIX
	local store = stores[name]
	if not store then
		store = DataStoreService:GetOrderedDataStore(name)
		stores[name] = store
	end
	return store
end

-- season is "2026-11"
local function storeFor(board: string, season: string): OrderedDataStore
	local allTime = ALL_TIME_STORE[board]
	if allTime then
		return getStore(allTime)
	end
	return getStore(MONTHLY_STORE[board] .. (string.gsub(season, "-", "_")))
end

local function previousSeason(season: string): string
	local y, m = string.match(season, "^(%d+)-(%d+)$")
	local year, month = tonumber(y), tonumber(m) - 1
	if month == 0 then
		year, month = year - 1, 12
	end
	return string.format("%04d-%02d", year, month)
end

local function monthName(season: string): string
	local y, m = string.match(season, "^(%d+)-(%d+)$")
	return DateTime.fromUniversalTime(tonumber(y), tonumber(m), 1):FormatUniversalTime("MMMM", "en-us")
end

-- unix time the month ended (= 00:00 UTC on the 1st of the next month)
local function monthEnd(season: string): number
	local y, m = string.match(season, "^(%d+)-(%d+)$")
	if not y then
		return math.huge
	end
	local year, month = tonumber(y), tonumber(m) + 1
	if month == 13 then
		year, month = year + 1, 1
	end
	return DateTime.fromUniversalTime(year, month, 1).UnixTimestamp
end

-------------------------------------------------------------------- writing scores

local written = {} -- [userId] = { Season = "2026-11", [board] = last value written }
local resolveHistoryRanks, refreshDonorBoardsSoon -- defined with the board readers below

local function write(store: OrderedDataStore, userId: number, value: number): boolean
	local ok, err = pcall(store.SetAsync, store, tostring(userId), value)
	if not ok then
		warn("[Leaderboards] write failed:", err)
	end
	return ok
end

-- Copies a player's changed scores into the stores. Pass leaving = true from PlayerRemoving.
function Leaderboards.FlushPlayer(player: Player, profile, leaving: boolean?)
	profile = profile or DataManager.Profiles[player]
	local userId = player.UserId
	if not profile or not profile.Data or userId <= 0 then
		return -- negative IDs are Studio test players
	end

	DataManager.rollMonthly(player, profile)

	-- months that ended since the last write go to that month's own store
	local archive = DataManager.MonthlyArchive[userId]
	if archive then
		DataManager.MonthlyArchive[userId] = nil
		local failed = {}
		for _, entry in archive do
			local ok = true
			if entry.Kills > 0 then
				ok = write(storeFor("MonthlyKills", entry.Season), userId, entry.Kills) and ok
			end
			if entry.Donated > 0 then
				ok = write(storeFor("MonthlyTopDonators", entry.Season), userId, entry.Donated) and ok
			end
			if not ok then
				table.insert(failed, entry)
			end
		end
		if #failed > 0 then -- retry on the next sync
			local queue = DataManager.MonthlyArchive[userId] or {}
			for _, entry in failed do
				table.insert(queue, entry)
			end
			DataManager.MonthlyArchive[userId] = queue
		end
	end

	-- once every finished month is written, save where the player placed on its final boards
	if not DataManager.MonthlyArchive[userId] then
		resolveHistoryRanks(userId, profile.Data.MonthlyHistory)
	end

	local data = profile.Data
	local season = data.LeaderboardSeason
	local last = written[userId]
	if not last or last.Season ~= season then
		last = { Season = season }
		written[userId] = last
	end
	for board, field in FIELD do
		local value = math.floor(tonumber(data[field]) or 0)
		if value > 0 and last[board] ~= value and write(storeFor(board, season), userId, value) then
			last[board] = value
		end
	end

	if leaving then
		written[userId] = nil
	end
end

-- Call when a profile has loaded, before leaderstats are filled in.
function Leaderboards.OnProfileLoaded(player: Player, profile)
	DataManager.rollMonthly(player, profile)
	local data = profile.Data
	player:SetAttribute("MonthlyKills", data.MonthlyKills or 0)
	player:SetAttribute("TotalDonated", data.TotalRobuxDonated or 0)
	player:SetAttribute("MonthlyDonated", data.MonthlyDonated or 0)

	-- a donation (DataManager.addDonation) shows on the donor boards within ~30s instead of up to 2 min
	player:GetAttributeChangedSignal("TotalDonated"):Connect(function()
		task.spawn(Leaderboards.FlushPlayer, player)
		refreshDonorBoardsSoon()
	end)
end

-------------------------------------------------------------------- reading boards

local folder: Folder
local names = {} -- [userId] = { d = DisplayName, u = Username }
local CHAMPION_REREAD = 1800 -- seconds; re-check last month's #1 in case final scores landed after the first read
local champion = { Season = nil, Data = nil, ReadAt = 0 } -- last month's #1 monthly killer

local function lookUpNames(ids: { number })
	local missing, seen = {}, {}
	for _, id in ids do
		if not names[id] and not seen[id] then
			seen[id] = true
			table.insert(missing, id)
		end
	end
	for i = 1, #missing, 200 do
		local chunk = table.move(missing, i, math.min(i + 199, #missing), 1, {})
		local ok, infos = pcall(UserService.GetUserInfosByUserIdsAsync, UserService, chunk)
		if ok and type(infos) == "table" then
			for _, info in infos do
				names[info.Id] = { d = info.DisplayName, u = info.Username }
			end
		else
			warn("[Leaderboards] name lookup failed:", infos)
		end
	end
end

local function readTop(store: OrderedDataStore, count: number)
	local ok, pages = pcall(store.GetSortedAsync, store, false, count)
	if not ok then
		warn("[Leaderboards] read failed:", pages)
		return nil
	end
	local entries = {}
	for _, item in pages:GetCurrentPage() do
		local id = tonumber(item.key)
		-- skipping bad rows here keeps ranks gap-free: rank = position in this list
		if id and id > 0 and item.value > 0 then
			table.insert(entries, { id = id, v = item.value })
		end
	end
	return entries
end

local function publish(name: string, payload)
	local value = folder:FindFirstChild(name)
	if not value then
		value = Instance.new("StringValue")
		value.Name = name
		value.Parent = folder
	end
	local json = HttpService:JSONEncode(payload)
	if value.Value ~= json then
		value.Value = json
	end
end

-- Reads boards and publishes them. Pass a list of board names to refresh only those.
function Leaderboards.Refresh(only: { string }?)
	local season = DataManager.CurrentSeason()
	local boards, ids = {}, {}
	for _, board in only or BOARD_NAMES do
		local entries = readTop(storeFor(board, season), TOP)
		if entries then
			boards[board] = entries
			for _, e in entries do
				table.insert(ids, e.id)
			end
		end
	end

	if not only and (champion.Season ~= season or os.clock() - champion.ReadAt > CHAMPION_REREAD) then
		local prev = previousSeason(season)
		local top = readTop(storeFor("MonthlyKills", prev), 1)
		if top then
			champion.Season = season
			champion.ReadAt = os.clock()
			champion.Data = top[1] and { id = top[1].id, v = top[1].v, month = monthName(prev) } or false
			if top[1] then
				table.insert(ids, top[1].id)
			end
		end
	end

	lookUpNames(ids)
	local function addName(e)
		local n = names[e.id]
		if n then
			e.d, e.u = n.d, n.u
		end
	end

	for board, entries in boards do
		for _, e in entries do
			addName(e)
		end
		publish(board, entries)
		folder:SetAttribute(board .. "Leader", entries[1] and entries[1].id or 0)
	end

	if not only then
		local champ = champion.Data or nil
		if champ then
			addName(champ)
		end
		publish("Meta", { season = season, champion = champ })
	end
end

-- Final ranks of finished months, read once per server: ["MonthlyKills|2026-10"] = { [userId] = rank }
local finalRanks = {}

local function finalRankOf(board: string, season: string, userId: number): number?
	local key = board .. "|" .. season
	local ranks = finalRanks[key]
	if not ranks then
		local entries = readTop(storeFor(board, season), TOP)
		if not entries then
			return nil -- read failed; try again on the next sync
		end
		ranks = {}
		for i, e in entries do
			ranks[e.id] = i
		end
		finalRanks[key] = ranks
	end
	return ranks[userId] or 0
end

-- Fills KillsRank / DonatedRank on finished months (0 = outside the top 100) once their boards have settled.
resolveHistoryRanks = function(userId: number, history)
	local now = os.time()
	for _, entry in history do
		if (entry.KillsRank == nil or entry.DonatedRank == nil) and now >= monthEnd(entry.Season) + RANK_SETTLE then
			if entry.KillsRank == nil then
				if (entry.Kills or 0) > 0 then
					entry.KillsRank = finalRankOf("MonthlyKills", entry.Season, userId)
				else
					entry.KillsRank = 0
				end
			end
			if entry.DonatedRank == nil then
				if (entry.Donated or 0) > 0 then
					entry.DonatedRank = finalRankOf("MonthlyTopDonators", entry.Season, userId)
				else
					entry.DonatedRank = 0
				end
			end
		end
	end
end

local donorRefreshQueued, lastDonorRefresh = false, 0
refreshDonorBoardsSoon = function()
	if donorRefreshQueued or not folder then
		return
	end
	donorRefreshQueued = true
	-- at least 5s so the donor's own write lands before the read
	task.delay(math.max(5, lastDonorRefresh + DONOR_REFRESH_GAP - os.clock()), function()
		donorRefreshQueued = false
		lastDonorRefresh = os.clock()
		local ok, err = pcall(Leaderboards.Refresh, { "AllTimeTopDonators", "MonthlyTopDonators" })
		if not ok then
			warn("[Leaderboards] donor refresh failed:", err)
		end
	end)
end

function Leaderboards.Start()
	folder = ReplicatedStorage:FindFirstChild("LeaderboardData") or Instance.new("Folder")
	folder.Name = "LeaderboardData"
	folder.Parent = ReplicatedStorage

	task.spawn(function()
		while true do
			for player, profile in DataManager.Profiles do
				task.spawn(Leaderboards.FlushPlayer, player, profile)
			end
			task.wait(SYNC_INTERVAL)
		end
	end)

	task.spawn(function()
		task.wait(5) -- let the first sync land so players see themselves straight away
		while true do
			local ok, err = pcall(Leaderboards.Refresh)
			if not ok then
				warn("[Leaderboards] refresh failed:", err)
			end
			task.wait(REFRESH_INTERVAL)
		end
	end)
end

return Leaderboards
