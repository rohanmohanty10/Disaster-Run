local DataManager = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Info = require(ReplicatedStorage.Info)
local VIP_PASS = tostring(Info.Passes.VIP) -- Template.Gamepasses keys are the pass IDs as strings

-- Store profiles from ProfileStore
DataManager.Profiles = {}
DataManager.SessionStart = {}

function DataManager.addGold(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile or type(amount) ~= "number" or amount ~= amount then return false end

	profile.Data.Gold = math.max(0, math.floor(profile.Data.Gold + amount))
	player:SetAttribute("Gold", profile.Data.Gold)

	return true
end

function DataManager.getGold(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end
	
	return profile.Data.Gold or 0
end

function DataManager.addEmoteSpins(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	--if profile.Data.Gamepasses["1637126325"].owned == true then --2x spin earner later?
	--	amount *= 2
	--end
	
	profile.Data.EmoteSpins =  math.max(0, math.floor(profile.Data.EmoteSpins + amount))
	player:SetAttribute("EmoteSpins", profile.Data.EmoteSpins)
end

function DataManager.getEmoteSpins(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.EmoteSpins or 0
end

-- Monthly leaderboard season = the UTC month, same rule as Ranked ("2026-11").
function DataManager.CurrentSeason(): string
	return os.date("!%Y-%m")
end

-- Month totals that ended and still need writing to that month's leaderboard store.
-- [userId] = { { Season, Kills, Donated }, ... } - the Leaderboards module drains this.
DataManager.MonthlyArchive = {}

-- Moves a profile into the current month if it isn't there yet. The finished month is kept in
-- MonthlyHistory and queued for its leaderboard, then MonthlyKills / MonthlyDonated restart at 0.
function DataManager.rollMonthly(player: Player, profile): boolean
	local data = profile.Data
	local season = DataManager.CurrentSeason()
	if data.LeaderboardSeason == season then return false end

	if data.LeaderboardSeason == "" then
		-- profile from before seasons existed: adopt this month and keep its numbers
		data.LeaderboardSeason = season
		return false
	end

	local kills, donated = data.MonthlyKills or 0, data.MonthlyDonated or 0
	if kills > 0 or donated > 0 then
		local entry = { Season = data.LeaderboardSeason, Kills = kills, Donated = donated }
		table.insert(data.MonthlyHistory, 1, entry) -- kept forever; Leaderboards fills in KillsRank / DonatedRank later
		local queue = DataManager.MonthlyArchive[player.UserId] or {}
		table.insert(queue, entry)
		DataManager.MonthlyArchive[player.UserId] = queue
	end

	data.MonthlyKills = 0
	data.MonthlyDonated = 0
	data.LeaderboardSeason = season

	player:SetAttribute("MonthlyKills", 0)
	player:SetAttribute("MonthlyDonated", 0)
	local leaderstats = player:FindFirstChild("leaderstats")
	local killsStat = leaderstats and leaderstats:FindFirstChild("Kills", true)
	if killsStat then
		killsStat.Value = 0
	end
	return true
end

function DataManager.addMonthlyKill(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	DataManager.rollMonthly(player, profile)
	profile.Data.MonthlyKills += amount
	player:SetAttribute("MonthlyKills", profile.Data.MonthlyKills)

	local leaderstats = player:FindFirstChild("leaderstats")
	local killsStat = leaderstats and leaderstats:FindFirstChild("Kills", true)
	if killsStat then
		killsStat.Value = profile.Data.MonthlyKills
	end
end

function DataManager.addTotalKill(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	profile.Data.TotalKills += amount
	player:SetAttribute("TotalKills", profile.Data.TotalKills) -- live value the title menu reads for progress/unlock

	local leaderstats = player:FindFirstChild("leaderstats")
	local totalKillsStat = leaderstats and leaderstats:FindFirstChild("Total Kills", true)
	if totalKillsStat then
		totalKillsStat.Value = profile.Data.TotalKills
	end
	--pcall(function()
	--	TotalKillsDatastore:SetAsync(tostring(player.UserId), profile.Data.TotalKills)
	--end)
end

function DataManager.addDummyKill(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	profile.Data.DummyKills += amount
end

function DataManager.addTime(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	profile.Data.TotalTimeSpent += amount
	--player.leaderstatsOld.TotalTimeSpent.Value = profile.Data.TotalTimeSpent
end

function DataManager.lastCharacter(player: Player, lastCharacter)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	profile.Data.LastCharacter = lastCharacter
end

function DataManager.returnLastCharacter(player: Player) --Should be getLastCharacter instead of returnLastCharacter
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.LastCharacter
end

function DataManager.getOwnedCosmetics(player:Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Cosmetics 
end

function DataManager.getOwnedAccessories(player:Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Cosmetics.OwnedAccessories
end

function DataManager.getOwnedAuras(player:Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Cosmetics.OwnedAuras
end

function DataManager.getOwnedTitles(player:Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Cosmetics.OwnedTitles
end

function DataManager.getEquippedAccessories(player:Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Cosmetics.EquippedAccessories
end

function DataManager.getEquippedAuras(player:Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Cosmetics.EquippedAuras
end

function DataManager.getEquippedTitles(player:Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Cosmetics.EquippedTitle
end

function DataManager.getRemainingCosmetics(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	local owned = profile.Data.Cosmetics.OwnedAccessories
	local Cosmetics = game:GetService("ServerStorage").Assets.Models.Cosmetics

	local remaining = {
		Accessories = {},
		Auras = {},
		Titles = {} -- add this or skip Titles explicitly
	}

	for _, Category in Cosmetics:GetChildren() do
		if Category.Name == "Titles" then continue end -- skip titles
		for _, Cosmetic in Category:GetChildren() do
			if not table.find(owned, Cosmetic.Name) then
				table.insert(remaining[Category.Name], {
					Name = Cosmetic.Name,
					Kills = Cosmetic:GetAttribute("Kills"),
					Image = Cosmetic:GetAttribute("Image") or 17138543887
				})
			end
		end
	end


	return remaining
end

function DataManager.getOwnedEmotes(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Emotes.OwnedEmotes --Remotes a table of ownedEmotes
end

function DataManager.getEquippedEmotes(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Emotes.EquippedEmotes --Remotes a table of ownedEmotes
end

function DataManager.changeEmoteSlot(player, emoteName, slot, page)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	if not table.find(profile.Data.Emotes.OwnedEmotes, emoteName) then return false end

	local pageNum = page == 'Emotes' and "1" or "2"
	local key = pageNum .. "_" .. slot  -- e.g. "1_3"
	profile.Data.Emotes.EquippedEmotes[key] = emoteName

	ReplicatedStorage.Remotes.Emotes.Set:FireClient(player, "SlotUpdated", {
		Slot = slot,  -- e.g. "3"
		Page = page,        -- e.g. "Emotes" or "Emotes2"
		EmoteName = emoteName
	})

	return true
end

-- scaled with the 3,500 Gold spin (they were set against a 1,000 Gold spin)
local DUPE_FALLBACK_GOLD = {
	Common    = 175,
	Rare      = 350,
	Epic      = 600,
	Legendary = 1400,
	Mythic    = 2800,
	Secret    = 5250,
}

local function weightedRarityRoll(rarities)
	local totalWeight = 0
	for _, data in rarities do
		totalWeight += data.Weight
	end

	local roll = math.random() * totalWeight
	local cumulative = 0

	for rarityName, data in rarities do
		cumulative += data.Weight
		if roll <= cumulative then
			return rarityName
		end
	end

	-- Floating point safety net; should be unreachable
	for rarityName in rarities do
		return rarityName
	end
end

-- Emote names in a rarity folder that a spin can give (skips the starter emote).
local function rollablePool(rarityFolder)
	local pool = {}
	if rarityFolder then
		for _, desc in rarityFolder:GetChildren() do
			if desc:IsA("Animation") and desc.Name ~= "Resolute" then
				table.insert(pool, desc.Name)
			end
		end
	end
	return pool
end

local function SpinEmoteFunc(profile)
	local InfoModule = require(ReplicatedStorage.Info) -- adjust path to match your module
	local EmotesFolder = ReplicatedStorage.Assets.Animations.Emotes

	-- Only roll rarities that actually contain emotes. An empty tier (Secret right now) used to
	-- win ~0.1% of rolls and give nothing; it now joins the roll automatically once it has emotes.
	-- Real odds = Weight / sum of Weights of the non-empty tiers (show the same numbers in the odds UI).
	local rollable, pools = {}, {}
	for name, data in InfoModule.EmoteRarities do
		local pool = rollablePool(EmotesFolder:FindFirstChild(name))
		if #pool > 0 and (data.Weight or 0) > 0 then
			rollable[name] = data
			pools[name] = pool
		end
	end

	local rarityName = weightedRarityRoll(rollable)
	if not rarityName then
		warn("[Emotes] No rarity has any emotes to roll")
		return nil, nil, 0, nil
	end

	local pool = pools[rarityName]
	local chosenEmote = pool[math.random(1, #pool)]

	if table.find(profile.Data.Emotes.OwnedEmotes, chosenEmote) == nil then
		table.insert(profile.Data.Emotes.OwnedEmotes, chosenEmote)
		return chosenEmote, rarityName, 0, chosenEmote -- granted
	end

	local goldAwarded = DUPE_FALLBACK_GOLD[rarityName] or 0
	return nil, rarityName, goldAwarded, chosenEmote
end


function DataManager.spinEmote(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return false end

	if DataManager.getEmoteSpins(player) < 1 then
		return false
	end
	
	local newEmote, rarityName, goldAwarded, rolledEmoteName = SpinEmoteFunc(profile)
	if not rarityName then
		return false -- nothing could be rolled; keep the spin
	end

	-- no yield between the roll and the deduct, so this is still atomic
	DataManager.addEmoteSpins(player, -1)
	profile.Data.TotalEmotesSpun += 1

	if goldAwarded > 0 then
		DataManager.addGold(player, goldAwarded)
	end

	return true, newEmote, rarityName, goldAwarded, rolledEmoteName
end

-- Buys one random emote spin for Beli. Server-authoritative, atomic (no yields
-- between the balance check and the deduct, so no race). Returns a result code.
function DataManager.buyEmoteSpin(player: Player, cost: number)
	local profile = DataManager.Profiles[player]
	if not profile then return "Error" end

	if DataManager.getGold(player) < cost then
		return "NotEnough"
	end

	-- SpinEmoteFunc returns nil only when every emote is already owned,
	-- and does NOT insert in that case — so checking it first is safe.
	local newEmote = SpinEmoteFunc(profile)
	if not newEmote then
		return "OwnAll"
	end

	DataManager.addGold(player, -cost)
	ReplicatedStorage.Remotes.Emotes.Set:FireClient(player, "UpdateOwnedEmotes", { OwnedEmotes = profile.Data.Emotes.OwnedEmotes })

	return "Bought", newEmote
end

function DataManager.addTotalRobuxSpentOnEmotes(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end
	
	profile.Data.TotalRobuxSpentOnEmotes += amount
end

function DataManager.getTotalRobuxSpentOnEmotes(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.TotalRobuxSpentOnEmotes or 0
end

function DataManager.addTotalRobuxSpentOnGold(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	profile.Data.TotalRobuxSpentOnGold += amount
end

function DataManager.getTotalRobuxSpentOnGold(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.TotalRobuxSpentOnGold or 0
end

function DataManager.addTotalRobuxSpentOnGifts(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	profile.Data.TotalRobuxSpentOnGifts += amount
end

function DataManager.getTotalRobuxSpentOnGifts(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.TotalRobuxSpentOnGifts or 0
end

function DataManager.addTotalRobuxSpent(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	profile.Data.TotalRobuxSpent += amount
end

function DataManager.getTotalRobuxSpent(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.TotalRobuxSpent or 0
end

-- Donations feed the All-Time and Monthly Top Donators boards (and Robux titles via "TotalDonated").
-- Call from the donate products' receipt handler with receiptInfo.CurrencySpent.
function DataManager.addDonation(player: Player, amount: number): boolean
	local profile = DataManager.Profiles[player]
	if not profile or type(amount) ~= "number" or amount ~= amount or amount <= 0 then return false end
	amount = math.floor(amount)

	DataManager.rollMonthly(player, profile)
	profile.Data.TotalRobuxDonated = (profile.Data.TotalRobuxDonated or 0) + amount
	profile.Data.MonthlyDonated = (profile.Data.MonthlyDonated or 0) + amount

	player:SetAttribute("TotalDonated", profile.Data.TotalRobuxDonated)
	player:SetAttribute("MonthlyDonated", profile.Data.MonthlyDonated)
	return true
end

-- Sends a gift to the receiver's own profile through ProfileStore messages.
-- Works whether they are online here, online in another server, offline, or have never joined:
-- whichever server holds their session applies it (DataInit's MessageHandler), so no save can overwrite it.
-- MessageAsync retries until it succeeds; it only returns false when this server is shutting down.
function DataManager.queueGift(targetUserId: number, passId: string, fromName: string)
	local store = DataManager.PlayerStore
	if not store then
		warn("queueGift: PlayerStore not set")
		return false
	end

	local ok, result = pcall(function()
		return store:MessageAsync("Player_" .. targetUserId, {
			Type = "Gift",
			PassId = passId,
			From = fromName,
		})
	end)

	if not ok then
		warn("queueGift failed:", result)
		return false
	end
	return result == true
end

-- Items bought with Robux or gifted wait in PendingItems (saved) until ShopService can have a
-- seagull deliver them.
function DataManager.addPendingItems(player: Player, itemIds: { string })
	local profile = DataManager.Profiles[player]
	if not profile then return false end
	for _, itemId in itemIds do
		table.insert(profile.Data.PendingItems, itemId)
	end
	return true
end

-- queueGift for an item: lands in the receiver's PendingItems (DataInit's MessageHandler).
function DataManager.queueItemGift(targetUserId: number, itemId: string, fromName: string)
	local store = DataManager.PlayerStore
	if not store then
		warn("queueItemGift: PlayerStore not set")
		return false
	end

	local ok, result = pcall(function()
		return store:MessageAsync("Player_" .. targetUserId, {
			Type = "ItemGift",
			ItemId = itemId,
			From = fromName,
		})
	end)

	if not ok then
		warn("queueItemGift failed:", result)
		return false
	end
	return result == true
end


function DataManager.grantGamepass(player, passId)
	local profile = DataManager.Profiles[player]
	local gp = profile and profile.Data.Gamepasses[passId]
	if not gp then return false end
	gp.owned = true
	if passId == VIP_PASS then player:SetAttribute("HasVIP", true) end
	return true
end








-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- SETTINGS

function DataManager.getSetting(player: Player, settingName: string)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Settings[settingName]
end

-- Set a single setting (validates key exists and type matches)
function DataManager.setSetting(player: Player, settingName: string, value)
	local profile = DataManager.Profiles[player]
	if not profile then return false end

	local current = profile.Data.Settings[settingName]
	if current == nil then
		warn("DataManager.setSetting: unknown setting key:", settingName)
		return false
	end

	if type(value) ~= type(current) then
		warn("DataManager.setSetting: type mismatch for", settingName, "— expected", type(current), "got", type(value))
		return false
	end

	profile.Data.Settings[settingName] = value
	local config = player:FindFirstChild("Configuration")
	if config then
		local setting = config:FindFirstChild(settingName)
		if setting then
			setting.Value = value
		end
	end
	return true
end

-- Get the full settings table (send to client on join)
function DataManager.getSettings(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	return profile.Data.Settings
end

-- Reset one setting to its template default
function DataManager.resetSetting(player: Player, settingName: string)
	local profile = DataManager.Profiles[player]
	if not profile then return false end

	local Template = require(game:GetService("ServerScriptService").Data.Template)
	local default = Template.Settings[settingName]
	if default == nil then
		warn("DataManager.resetSetting: unknown setting key:", settingName)
		return false
	end

	profile.Data.Settings[settingName] = default
	return true
end

-- Reset all settings to template defaults
function DataManager.resetAllSettings(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end

	local Template = require(game:GetService("ServerScriptService").Data.Template)
	for key, default in Template.Settings do
		profile.Data.Settings[key] = default
	end
end

local SetSetting = ReplicatedStorage.Remotes.Settings.Set    -- RemoteEvent
local LoadSettings = ReplicatedStorage.Remotes.Settings.Load -- RemoteEvent

-- Keys the client is allowed to change
local ALLOWED = {
	["Auto Use"]              = true,
	["Character Packages"]    = true,
	["Fast Mode"]             = true,
	["Day Night Cicle"]       = true,
	["Auto Run"]              = true,
	["Awakening Music"]       = true,
	["Emote Music"]           = true,
	["Volume"]                = true,
	["MusicVolume"]           = true,
	["Camera Shake"]          = true,
	["Reduce Camera Shake"]   = true,
	["Camera Follow"]         = true,
	["Destruction Physics"]   = true,
	["Blood"]                 = true,
	["Low Graphics"]          = true,
	["Hide Gold"]             = true,
	["Show Console Controls"] = true,
	["Shiftlock Offset"]      = true,
	["Changelogs"]            = true,
	["Hide Kills"]            = true,
	["Hide FPS"]              = true,
	["Hide Killstreak"]       = true,
	["Hide VIP Join Message"] = true,
	["CustomizeKillSound"]    = true,
	["CustomizeAwakeningOutfit"] = true,
	["CustomizeVIPCape"]      = true,
}

local VIP_ONLY = {
	["Hide Kills"]               = true,
	["Hide Killstreak"]          = true,
	["Hide VIP Join Message"]    = true,
	["CustomizeKillSound"]       = true,
	["CustomizeAwakeningOutfit"] = true,
	["CustomizeVIPCape"]         = true,
}

local PS_ONLY = {}

local ADMIN_ONLY = {}

local lastRequest = {}
local COOLDOWN = 0.3

local function hasVIP(player)
	local profile = DataManager.Profiles[player]
	return profile and profile.Data.Gamepasses[VIP_PASS].owned == true
end

SetSetting.OnServerEvent:Connect(function(player, settingName, value)
	if type(settingName) ~= "string" then return end

	-- Rate limit
	local now = tick()
	if lastRequest[player] and now - lastRequest[player] < COOLDOWN then return end
	lastRequest[player] = now

	-- Whitelist
	if not ALLOWED[settingName] then
		warn(player.Name, "attempted to set unauthorized setting:", settingName)
		return
	end

	-- VIP gate
	if VIP_ONLY[settingName] and not hasVIP(player) then
		warn(player.Name, "attempted VIP-only setting without VIP:", settingName)
		return
	end

	-- Clamp numerics server-side to prevent exploits
	if settingName == "Volume" then
		if type(value) ~= "number" then return end
		value = math.clamp(math.round(value * 10) / 10, 0.1, 1)
	elseif settingName == "MusicVolume" then
		if type(value) ~= "number" then return end
		value = math.clamp(math.round(value * 10) / 10, 0, 2)
	elseif settingName == "Shiftlock Offset" then
		if type(value) ~= "number" then return end
		value = math.clamp(math.round(value * 100) / 100, 0, 5.5)
	end

	DataManager.setSetting(player, settingName, value)
end)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return DataManager
