-- ServerScriptService > Systems > ServerBrowserService   (Script)
--
-- The public and private server lists behind the Servers menu (StarterPlayerScripts >
-- ServerBrowserClient), like Heroes Battlegrounds':
--   Public   every live public server: players, a short key (e.g. GD1682), and where it is
--   Private  servers players create for free (Roblox reserved servers), listed by name and owner,
--            joined from the list or with their key
-- Each server keeps its own entry in a MemoryStore sorted map up to date (a heartbeat), so a
-- server that closes drops off the list by itself when its entry expires.
-- "Where it is": the server looks up its own address (ipinfo / ip-api), checked against its
-- players' pings; see "Where the server is" below.
-- Remotes: ReplicatedStorage.Remotes.Servers (List / Join / Create). Main game only, not the
-- Ranked Lobby or Arena. Teleports and creating private servers don't work in Studio.

local Players = game:GetService("Players")
local MemoryStoreService = game:GetService("MemoryStoreService")
local TeleportService = game:GetService("TeleportService")
local LocalizationService = game:GetService("LocalizationService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlaceRole = require(ReplicatedStorage:WaitForChild("Ranked"):WaitForChild("PlaceRole"))
if not PlaceRole.IsMain() then
	return
end

local HEARTBEAT = 20 -- seconds between this server's list updates
local EXPIRY = 75 -- an entry that hasn't been updated for this long (server gone) leaves the list
local PRIVATE_IDLE_EXPIRY = 30 * 60 -- an empty private server stays listed this long
local PRIVATE_KEY_EXPIRY = 30 * 24 * 60 * 60 -- a private server's key keeps working this long
local LIST_LIMIT = 100
local CACHE_TIME = 5 -- seconds a fetched list is reused before asking MemoryStore again
local NAME_MIN, NAME_MAX = 3, 20
local KEY_LETTERS = "ABCDEFGHJKLMNPQRSTUVWXYZ" -- no I or O, so keys aren't misread

local PublicMap = MemoryStoreService:GetSortedMap("ServerBrowser_Public")
local PrivateMap = MemoryStoreService:GetSortedMap("ServerBrowser_Private")
local Keys = MemoryStoreService:GetHashMap("ServerBrowser_Keys") -- key -> { Kind, Id, ReserveCode? }
local Reserved = MemoryStoreService:GetHashMap("ServerBrowser_Reserved") -- PrivateServerId -> its info
local Owners = MemoryStoreService:GetHashMap("ServerBrowser_Owners") -- UserId -> their private server's key

local function Make(ClassName: string, Name: string, Parent: Instance): any
	local Object = Parent:FindFirstChild(Name) or Instance.new(ClassName)
	Object.Name = Name
	Object.Parent = Parent
	return Object
end
local Folder = Make("Folder", "Servers", ReplicatedStorage:WaitForChild("Remotes"))
local ListRemote = Make("RemoteFunction", "List", Folder)
local JoinRemote = Make("RemoteFunction", "Join", Folder)
local CreateRemote = Make("RemoteFunction", "Create", Folder)

local Rng = Random.new()

------------------------------------------------------------------------
-- Keys
------------------------------------------------------------------------
local function RandomKey(): string
	local A, B = Rng:NextInteger(1, #KEY_LETTERS), Rng:NextInteger(1, #KEY_LETTERS)
	return KEY_LETTERS:sub(A, A) .. KEY_LETTERS:sub(B, B) .. string.format("%04d", Rng:NextInteger(0, 9999))
end

local function NewKey(): string?
	for _ = 1, 5 do
		local Key = RandomKey()
		local Ok, Taken = pcall(Keys.GetAsync, Keys, Key)
		if Ok and Taken == nil then
			return Key
		end
	end
	return nil
end

------------------------------------------------------------------------
-- This server
------------------------------------------------------------------------
local IsPaidPrivate = game.PrivateServerOwnerId ~= 0 -- a Roblox private server: not listed
local IsReserved = game.PrivateServerId ~= "" and not IsPaidPrivate

local MyKind: string? = nil -- "Public" / "Private" once known
local MyMap: MemoryStoreSortedMap? = nil
local MyId, MyKey, MyName, MyOwner = "", "", "", ""
local MyKeyValue: any = nil
local MyKeyExpiry = EXPIRY
local StartedAt = os.time()

-- Where the server is. With Game Settings > Security > Allow HTTP Requests on, the server asks
-- ipinfo and ip-api where its address is (both answers are printed to the server log, F9 > Server).
-- Those databases sometimes place Roblox's addresses in the wrong country (a US server showing as
-- Poland), so the answer is checked against the players: someone with a low ping can't be on
-- another continent. If a nearby player's continent doesn't match, the lookup is ignored and the
-- server shows the country most of its low-ping players are from (no region). With no lookup at
-- all, it's the country most of its players are from.
local LOCATION_LOOKUPS = {
	{ Name = "ipinfo", Url = "https://ipinfo.io/json" },
	{ Name = "ip-api", Url = "http://ip-api.com/json/" },
}
local CLOSE_PING = 0.05 -- seconds; a player this close is on the same continent as the server

-- Country code -> continent, to compare a lookup with players' countries. A code that isn't
-- listed just can't be checked (the lookup is trusted).
local CONTINENTS = {}
for Continent, Codes in {
	NA = "US CA MX GT BZ SV HN NI CR PA CU DO HT JM PR BS BB TT AG DM GD KN LC VC BM AW CW KY TC VG VI GL",
	SA = "AR BO BR CL CO EC GY PE PY SR UY VE GF",
	EU = "AD AL AT BA BE BG BY CH CY CZ DE DK EE ES FI FO FR GB GG GI GR HR HU IE IM IS IT JE LI LT LU LV MC MD ME MK MT NL NO PL PT RO RS RU SE SI SK SM UA VA XK",
	AS = "AE AF AM AZ BD BH BN BT CN GE HK ID IL IN IQ IR JO JP KG KH KR KW KZ LA LB LK MM MN MO MV MY NP OM PH PK PS QA SA SG SY TH TJ TL TM TR TW UZ VN YE",
	OC = "AU NZ FJ PG NC PF WS TO VU SB GU",
	AF = "DZ AO BJ BW BF BI CM CV CF TD KM CD CG CI DJ EG GQ ER SZ ET GA GM GH GN GW KE LS LR LY MG MW ML MR MU MA MZ NA NE NG RW ST SN SC SL SO ZA SS SD TZ TG TN UG ZM ZW RE",
} do
	for Code in Codes:gmatch("%u%u") do
		CONTINENTS[Code] = Continent
	end
end

-- Roblox's own server addresses, by datacenter. Geolocation sites often put these in the wrong
-- place (ip-api said Warsaw for a US server), so a server whose address is listed here uses this
-- instead of the site's guess. From the DevForum list "[Roblox Server Region] A list of Roblox IP
-- ranges and its location" (July 2024); add new blocks here if a server shows up unlisted.
-- Roblox moves blocks between datacenters over time (128.116.2 was Warsaw in 2022), which is
-- also why the geolocation sites are wrong; the players' ping check below still catches a
-- stale entry.
local ROBLOX_DATACENTERS = {
	["128.116.115"] = { "Washington", "US" }, -- Seattle
	["128.116.116"] = { "California", "US" }, ["128.116.1"] = { "California", "US" }, ["128.116.63"] = { "California", "US" }, -- Los Angeles
	["128.116.117"] = { "California", "US" }, ["209.206.42"] = { "California", "US" }, ["209.206.43"] = { "California", "US" }, -- San Jose
	["128.116.95"] = { "Texas", "US" }, -- Dallas
	["128.116.101"] = { "Illinois", "US" }, ["128.116.48"] = { "Illinois", "US" }, -- Chicago
	["128.116.22"] = { "Georgia", "US" }, ["128.116.99"] = { "Georgia", "US" }, -- Atlanta
	["128.116.2"] = { "Georgia", "US" }, -- Atlanta (not in the 2024 list; IPinfo's Atlanta probe pings it in 0.4 ms, Nov 2026)
	["128.116.45"] = { "Florida", "US" }, ["128.116.127"] = { "Florida", "US" }, -- Miami
	["128.116.102"] = { "Virginia", "US" }, ["128.116.53"] = { "Virginia", "US" }, -- Ashburn
	["128.116.32"] = { "New York", "US" },
	["128.116.33"] = { "London", "GB" }, ["128.116.119"] = { "London", "GB" },
	["128.116.21"] = { "Amsterdam", "NL" },
	["128.116.4"] = { "Paris", "FR" }, ["128.116.122"] = { "Paris", "FR" },
	["128.116.5"] = { "Frankfurt", "DE" }, ["128.116.44"] = { "Frankfurt", "DE" }, ["128.116.123"] = { "Frankfurt", "DE" },
	["128.116.31"] = { "Warsaw", "PL" }, ["128.116.124"] = { "Warsaw", "PL" },
	["128.116.104"] = { "Mumbai", "IN" },
	["128.116.55"] = { "Tokyo", "JP" }, ["128.116.120"] = { "Tokyo", "JP" },
	["128.116.50"] = { "Singapore", "SG" }, ["128.116.97"] = { "Singapore", "SG" },
	["128.116.51"] = { "Sydney", "AU" },
	["128.116.30"] = { "Hong Kong", "HK" }, ["128.116.118"] = { "Hong Kong", "HK" },
}

type Lookup = { Name: string, Region: string?, Country: string? }
local Lookups: { Lookup } = {} -- in LOCATION_LOOKUPS order, only the ones that answered
local Publish -- defined below
task.spawn(function()
	if not HttpService.HttpEnabled then
		return
	end
	for _, Source in LOCATION_LOOKUPS do
		local Ok, Body = pcall(HttpService.GetAsync, HttpService, Source.Url)
		local Decoded, Data = false, nil
		if Ok then
			Decoded, Data = pcall(HttpService.JSONDecode, HttpService, Body)
		end
		if Decoded and type(Data) == "table" then
			-- ipinfo: region ("Georgia") / country ("US"); ip-api: regionName ("Georgia", its
			-- region is just "GA") / countryCode
			local Region = Data.regionName or Data.region
			local Country = Data.countryCode or Data.country
			local Found: Lookup = {
				Name = Source.Name,
				Region = if type(Region) == "string" and Region ~= "" then Region else nil,
				Country = if type(Country) == "string" and #Country == 2 then Country else nil,
			}
			-- the address's first three numbers ("128.116.22") pick the datacenter, if it's listed
			local Ip = Data.ip or Data.query
			local Block = if type(Ip) == "string" then Ip:match("^(%d+%.%d+%.%d+)%.%d+$") else nil
			local Datacenter = Block and ROBLOX_DATACENTERS[Block]
			if Datacenter then
				Found.Region, Found.Country = Datacenter[1], Datacenter[2]
				Found.Name ..= " (datacenter list)"
			end
			print(("[ServerBrowser] %s says: %s, %s (city %s, org %s, ip %s)"):format(Source.Name, tostring(Region), tostring(Country), tostring(Data.city), tostring(Data.org or Data.isp), tostring(Ip)))
			if Datacenter then
				print(("[ServerBrowser] %s is a %s, %s datacenter address"):format(tostring(Ip), Datacenter[1], Datacenter[2]))
			end
			if Found.Region or Found.Country then
				table.insert(Lookups, Found)
			end
		else
			warn("[ServerBrowser] " .. Source.Name .. " lookup failed")
		end
	end
	if #Lookups > 0 and Publish then
		Publish()
	end
end)

local Countries: { [Player]: string } = {}
local function LookUpCountry(Player: Player)
	local Ok, Country = pcall(LocalizationService.GetCountryRegionForPlayerAsync, LocalizationService, Player)
	if Ok and type(Country) == "string" then
		Countries[Player] = Country
	end
end

-- the most common country in List; a tie goes to the one more common in TieBreak
local function MostCommon(List: { string }, TieBreak: { string }?): string?
	local Counts, Extra = {}, {}
	for _, Country in List do
		Counts[Country] = (Counts[Country] or 0) + 1
	end
	for _, Country in TieBreak or {} do
		Extra[Country] = (Extra[Country] or 0) + 1
	end
	local Best, BestCount, BestExtra = nil, 0, 0
	for Country, Count in Counts do
		local More = Extra[Country] or 0
		if Count > BestCount or (Count == BestCount and More > BestExtra) then
			Best, BestCount, BestExtra = Country, Count, More
		end
	end
	return Best
end

-- This server's country and region, worked out fresh each time it's published (pings change)
local function ServerLocation(): (string?, string?)
	local All, Close, CloseContinents = {}, {}, {}
	for Player, Country in Countries do
		table.insert(All, Country)
		local Ok, Ping = pcall(Player.GetNetworkPing, Player)
		local Continent = CONTINENTS[Country]
		if Ok and type(Ping) == "number" and Ping > 0 and Ping <= CLOSE_PING then
			table.insert(Close, Country)
			if Continent then
				CloseContinents[Continent] = true
			end
		end
	end
	local function Believable(Found: Lookup): boolean
		local Continent = if Found.Country then CONTINENTS[Found.Country] else nil
		return next(CloseContinents) == nil or Continent == nil or CloseContinents[Continent] == true
	end
	-- the first lookup the players don't contradict
	for _, Found in Lookups do
		if Believable(Found) then
			return Found.Country or MostCommon(All), Found.Region
		end
	end
	if #Close > 0 then
		return MostCommon(Close, All), nil
	end
	return MostCommon(All), nil
end

local function Entry()
	local Country, Region = ServerLocation()
	return {
		Id = MyId,
		Key = MyKey,
		Name = MyName,
		Owner = MyOwner,
		Players = #Players:GetPlayers(),
		Max = Players.MaxPlayers,
		Country = Country,
		Region = Region,
		Started = StartedAt,
	}
end

Publish = function()
	-- for the label at the top right (ServerBrowserClient): where this server is, and its key
	local Country, Region = ServerLocation()
	workspace:SetAttribute("ServerCountry", Country)
	workspace:SetAttribute("ServerRegion", Region)
	if not MyMap then
		return
	end
	local Value = Entry()
	local Ok, Err = pcall(MyMap.SetAsync, MyMap, MyId, Value, EXPIRY, Value.Players)
	if not Ok then
		warn("[ServerBrowser] couldn't update this server's entry:", Err)
	end
	pcall(Keys.SetAsync, Keys, MyKey, MyKeyValue, MyKeyExpiry)
end

task.spawn(function()
	if IsReserved then
		-- one of ours if ServerBrowserService.Create made it (the Arena's reserved servers are a
		-- different place, and this script doesn't run there)
		local Info = nil
		for _ = 1, 3 do
			local Ok, Result = pcall(Reserved.GetAsync, Reserved, game.PrivateServerId)
			if Ok then
				Info = Result
				break
			end
			task.wait(2)
		end
		if type(Info) ~= "table" then
			return
		end
		MyKind, MyMap = "Private", PrivateMap
		MyId, MyKey, MyName, MyOwner = Info.Key, Info.Key, Info.Name, Info.OwnerName
		MyKeyValue = { Kind = "Private", Id = Info.Key, ReserveCode = Info.ReserveCode }
		MyKeyExpiry = PRIVATE_KEY_EXPIRY
	elseif not IsPaidPrivate then
		MyKind, MyMap = "Public", PublicMap
		MyId = if game.JobId ~= "" then game.JobId else "Studio"
		MyKey = NewKey() or RandomKey()
		MyKeyValue = { Kind = "Public", Id = MyId }
	end
	if MyKind then
		workspace:SetAttribute("ServerKey", MyKey)
	end
	while true do
		Publish()
		task.wait(HEARTBEAT)
	end
end)

-- player counts change: update soon, but not once per player when many join at once
local Pending = false
local function Soon()
	if Pending then
		return
	end
	Pending = true
	task.delay(3, function()
		Pending = false
		Publish()
	end)
end
Players.PlayerAdded:Connect(function(Player)
	LookUpCountry(Player)
	Soon()
end)
for _, Player in Players:GetPlayers() do
	task.spawn(LookUpCountry, Player)
end
Players.PlayerRemoving:Connect(function(Player)
	Countries[Player] = nil
	Soon()
end)

game:BindToClose(function()
	if MyKind == "Public" then
		pcall(PublicMap.RemoveAsync, PublicMap, MyId)
		pcall(Keys.RemoveAsync, Keys, MyKey)
	elseif MyKind == "Private" then
		-- still listed (empty) for a while, so its owner and friends can find it again
		local Value = Entry()
		Value.Players = 0
		pcall(PrivateMap.SetAsync, PrivateMap, MyId, Value, PRIVATE_IDLE_EXPIRY, 0)
	end
end)

------------------------------------------------------------------------
-- Lists
------------------------------------------------------------------------
local Cache: { [string]: { At: number, List: { any } } } = {}
local function GetList(Kind: string): { any }
	local Cached = Cache[Kind]
	if Cached and os.clock() - Cached.At < CACHE_TIME then
		return Cached.List
	end
	local Map = if Kind == "Public" then PublicMap else PrivateMap
	local List = {}
	local Ok, Items = pcall(Map.GetRangeAsync, Map, Enum.SortDirection.Descending, LIST_LIMIT)
	if Ok then
		for _, Item in Items do
			if type(Item.value) == "table" then
				table.insert(List, Item.value)
			end
		end
	else
		warn("[ServerBrowser] couldn't read the server list:", Items)
		if Cached then
			return Cached.List
		end
	end
	Cache[Kind] = { At = os.clock(), List = List }
	return List
end

local LastRequest: { [Player]: number } = {}
local function Allow(Player: Player, Gap: number): boolean
	local Now = os.clock()
	if LastRequest[Player] and Now - LastRequest[Player] < Gap then
		return false
	end
	LastRequest[Player] = Now
	return true
end
Players.PlayerRemoving:Connect(function(Player)
	LastRequest[Player] = nil
end)

ListRemote.OnServerInvoke = function(_, Kind)
	if Kind ~= "Public" and Kind ~= "Private" then
		return nil
	end
	return {
		Servers = GetList(Kind),
		Current = if MyKind == Kind then Entry() else nil,
		CurrentKind = MyKind,
	}
end

------------------------------------------------------------------------
-- Joining
------------------------------------------------------------------------
local function Teleport(Player: Player, Options: TeleportOptions?): (boolean, string?)
	if RunService:IsStudio() then
		return false, "Joining other servers only works in the published game."
	end
	local Ok, Err = pcall(TeleportService.TeleportAsync, TeleportService, game.PlaceId, { Player }, Options)
	if not Ok then
		warn("[ServerBrowser] teleport failed:", Err)
		return false, "Couldn't join that server. It may be full or closed."
	end
	return true, nil
end

local function JoinPublic(Player: Player, Id: string): (boolean, string?)
	if Id == MyId then
		return false, "You're already in this server."
	end
	local Options = Instance.new("TeleportOptions")
	Options.ServerInstanceId = Id
	return Teleport(Player, Options)
end

local function JoinKey(Player: Player, Key: string): (boolean, string?)
	Key = string.upper(Key):gsub("%s", "")
	if Key == MyKey then
		return false, "You're already in this server."
	end
	local Ok, Value = pcall(Keys.GetAsync, Keys, Key)
	if not Ok then
		return false, "Couldn't look up that key. Try again."
	elseif type(Value) ~= "table" then
		return false, "No server has that key."
	end
	if Value.Kind == "Public" then
		return JoinPublic(Player, Value.Id)
	end
	local Options = Instance.new("TeleportOptions")
	Options.ReservedServerAccessCode = Value.ReserveCode
	return Teleport(Player, Options)
end

JoinRemote.OnServerInvoke = function(Player, Kind, Value)
	if not Allow(Player, 1.5) then
		return false, "Slow down a little."
	end
	if Kind == "Quick" then
		-- the fullest public server that still has room, or a fresh one
		local Best = nil
		for _, Server in GetList("Public") do
			if Server.Id ~= MyId and Server.Players < Server.Max and (not Best or Server.Players > Best.Players) then
				Best = Server
			end
		end
		if Best then
			return JoinPublic(Player, Best.Id)
		end
		return Teleport(Player, nil)
	elseif Kind == "Public" and type(Value) == "string" then
		return JoinPublic(Player, Value)
	elseif (Kind == "Private" or Kind == "Key") and type(Value) == "string" and #Value <= 12 then
		return JoinKey(Player, Value)
	end
	return false, "That server isn't valid."
end

------------------------------------------------------------------------
-- Creating a private server (one per player; making a new one replaces the old)
------------------------------------------------------------------------
CreateRemote.OnServerInvoke = function(Player, Name)
	if not Allow(Player, 3) then
		return false, "Slow down a little."
	end
	if type(Name) ~= "string" then
		return false, "Give your server a name."
	end
	Name = Name:gsub("^%s+", ""):gsub("%s+$", "")
	if #Name < NAME_MIN or #Name > NAME_MAX then
		return false, `Names are {NAME_MIN} to {NAME_MAX} characters.`
	end
	if RunService:IsStudio() then
		return false, "Private servers can only be created in the published game."
	end
	local Filtered, Ok = nil, nil
	Ok, Filtered = pcall(function()
		return TextService:FilterStringAsync(Name, Player.UserId):GetNonChatStringForBroadcastAsync()
	end)
	if not Ok then
		return false, "Couldn't check that name. Try again."
	elseif Filtered:find("#") then
		return false, "That name isn't allowed."
	end

	local Reserve, Code, PrivateServerId = nil, nil, nil
	Reserve, Code, PrivateServerId = pcall(TeleportService.ReserveServer, TeleportService, game.PlaceId)
	local Key = Reserve and NewKey()
	if not Key then
		return false, "Couldn't create a server. Try again."
	end
	local Info = { Key = Key, Name = Filtered, OwnerId = Player.UserId, OwnerName = Player.Name, ReserveCode = Code }
	local Saved = pcall(Reserved.SetAsync, Reserved, PrivateServerId, Info, PRIVATE_KEY_EXPIRY)
		and pcall(Keys.SetAsync, Keys, Key, { Kind = "Private", Id = Key, ReserveCode = Code }, PRIVATE_KEY_EXPIRY)
	if not Saved then
		return false, "Couldn't create a server. Try again."
	end
	pcall(PrivateMap.SetAsync, PrivateMap, Key, {
		Id = Key,
		Key = Key,
		Name = Filtered,
		Owner = Player.Name,
		Players = 0,
		Max = Players.MaxPlayers,
		Started = os.time(),
	}, PRIVATE_IDLE_EXPIRY, 0)

	local OwnerKey = tostring(Player.UserId)
	local HadOld, OldKey = pcall(Owners.GetAsync, Owners, OwnerKey)
	if HadOld and type(OldKey) == "string" and OldKey ~= Key then
		pcall(Keys.RemoveAsync, Keys, OldKey)
		pcall(PrivateMap.RemoveAsync, PrivateMap, OldKey)
	end
	pcall(Owners.SetAsync, Owners, OwnerKey, Key, PRIVATE_KEY_EXPIRY)
	Cache.Private = nil
	return true, { Key = Key, Name = Filtered }
end
