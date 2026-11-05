--!strict
-- Player save data on ProfileStore (session-locked, auto-saved, GDPR-tagged).
-- Every change goes through DataService.Changed(player) so the client gets a fresh snapshot.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ProfileStore = require(ServerScriptService.ServerPackages.ProfileStore)
local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local Rarities = require(ReplicatedStorage.Shared.Data.Rarities)
local GachaConfig = require(ReplicatedStorage.Shared.Config.GachaConfig)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local Requests = require(script.Parent.Requests)

-- Bump the store name only to wipe everyone's data (e.g. before launch).
local STORE_NAME = "PlayerData_v1"
local LOAD_TIMEOUT = 30

export type RoleData = {
	Spins: number,
	LuckySpins: number,
	Slots: { string }, -- kit id per slot, "" = empty (always GachaConfig.MaxSlots long)
	Locked: { boolean },
	MaxSlots: number, -- slots the player owns (BaseSlots..MaxSlots)
	Selected: number, -- selected / equipped slot
	VaultEquipped: string, -- kit id equipped from the vault, "" = using the selected slot
	Vault: { string }, -- Mythical / Secret kits, kept forever
	Pity: { Normal: number, LuckyMythical: number, LuckySecret: number },
	BoostedKit: string, -- kit picked in the odds list for 2x weight, "" = none
	AdBoost: number, -- boosted normal spins left
	TotalSpins: number,
}

export type PlayerData = {
	Cash: number,
	Gems: number,
	DivineShards: number,
	God: RoleData,
	Runner: RoleData,
	Stats: {
		MatchesPlayed: number,
		MatchWins: number,
		RoundsSurvived: number,
		Kills: number,
		DamageDealt: number,
		MVPs: number,
	},
	PurchaseIdCache: { string },
}

local function roleTemplate(role: Kits.Role): RoleData
	local slots = table.create(GachaConfig.MaxSlots, "")
	slots[1] = Kits.Defaults[role]
	return {
		Spins = GachaConfig.StarterSpins,
		LuckySpins = 0,
		Slots = slots,
		Locked = table.create(GachaConfig.MaxSlots, false),
		MaxSlots = GachaConfig.BaseSlots,
		Selected = 1,
		VaultEquipped = "",
		Vault = {},
		Pity = { Normal = 0, LuckyMythical = 0, LuckySecret = 0 },
		BoostedKit = "",
		AdBoost = 0,
		TotalSpins = 0,
	}
end

local TEMPLATE: PlayerData = {
	Cash = 0,
	Gems = 0,
	DivineShards = 0,
	God = roleTemplate("God"),
	Runner = roleTemplate("Runner"),
	Stats = {
		MatchesPlayed = 0,
		MatchWins = 0,
		RoundsSurvived = 0,
		Kills = 0,
		DamageDealt = 0,
		MVPs = 0,
	},
	PurchaseIdCache = {},
}

local store = ProfileStore.New(STORE_NAME, TEMPLATE)
local profiles: { [Player]: any } = {}
local pendingReplication: { [Player]: boolean } = {}

local DataService = {}

DataService.Loaded = Signal.new() -- (player, data)

-- Repairs data that no longer matches the kit catalog or slot rules (renamed kits, edited saves).
local function sanitizeRole(role: Kits.Role, data: RoleData)
	data.MaxSlots = math.clamp(math.floor(tonumber(data.MaxSlots) or GachaConfig.BaseSlots), GachaConfig.BaseSlots, GachaConfig.MaxSlots)
	for i = 1, GachaConfig.MaxSlots do
		local kitId = data.Slots[i]
		local kit = if type(kitId) == "string" then Kits.Get(role, kitId) else nil
		-- Vault rarities never live in slots.
		if kitId ~= "" and (kit == nil or Rarities.Vaulted[kit.Rarity]) then
			data.Slots[i] = ""
		end
		if type(data.Locked[i]) ~= "boolean" then
			data.Locked[i] = false
		end
	end
	local vault = {}
	for _, kitId in data.Vault do
		if Kits.Get(role, kitId) and not table.find(vault, kitId) then
			table.insert(vault, kitId)
		end
	end
	data.Vault = vault
	if data.VaultEquipped ~= "" and not table.find(vault, data.VaultEquipped) then
		data.VaultEquipped = ""
	end
	if data.BoostedKit ~= "" and not Kits.Get(role, data.BoostedKit) then
		data.BoostedKit = ""
	end
	local selected = math.floor(tonumber(data.Selected) or 1)
	if selected < 1 or selected > data.MaxSlots then
		selected = 1
	end
	data.Selected = selected
	-- Never leave a player with nothing at all.
	if data.Slots[1] == "" and data.VaultEquipped == "" and #vault == 0 then
		local anyKit = false
		for i = 1, data.MaxSlots do
			if data.Slots[i] ~= "" then
				anyKit = true
				break
			end
		end
		if not anyKit then
			data.Slots[1] = Kits.Defaults[role]
		end
	end
end

-- What the client is allowed to see (everything except purchase bookkeeping).
local function snapshot(data: PlayerData): { [string]: any }
	local copy = table.clone(data) :: any
	copy.PurchaseIdCache = nil
	return copy
end

local function replicate(player: Player)
	pendingReplication[player] = nil
	local profile = profiles[player]
	if profile and player.Parent == Players then
		Remotes.Event("DataUpdated"):FireClient(player, snapshot(profile.Data))
	end
end

local function onPlayerAdded(player: Player)
	local profile = store:StartSessionAsync(`Player_{player.UserId}`, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	if profile == nil then
		-- Only happens when the server is shutting down or DataStores are down.
		player:Kick("Your data couldn't be loaded. Please rejoin.")
		return
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile()

	profile.OnSessionEnd:Connect(function()
		profiles[player] = nil
		player:Kick("Your data session ended (you may have joined another server). Please rejoin.")
	end)

	if player.Parent ~= Players then
		profile:EndSession()
		return
	end

	local data = profile.Data :: PlayerData
	sanitizeRole("God", data.God)
	sanitizeRole("Runner", data.Runner)

	profiles[player] = profile
	DataService.Loaded:Fire(player, data)
	replicate(player)
end

-- Data for a loaded player, or nil.
function DataService.Get(player: Player): PlayerData?
	local profile = profiles[player]
	return if profile then profile.Data :: PlayerData else nil
end

-- Waits (up to LOAD_TIMEOUT) for a player's data.
function DataService.WaitFor(player: Player): PlayerData?
	local started = os.clock()
	while profiles[player] == nil and player.Parent == Players and os.clock() - started < LOAD_TIMEOUT do
		task.wait()
	end
	return DataService.Get(player)
end

function DataService.GetProfile(player: Player): any
	return profiles[player]
end

-- Call after changing a player's data. Batches changes made in the same frame into one update.
function DataService.Changed(player: Player)
	if pendingReplication[player] then
		return
	end
	pendingReplication[player] = true
	task.defer(replicate, player)
end

function DataService.Init()
	Requests.Register("GetData", function(player)
		local data = DataService.WaitFor(player)
		if not data then
			return Requests.Fail("NotLoaded")
		end
		return { Ok = true, Data = snapshot(data) }
	end)
end

function DataService.Start()
	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(function(player)
		pendingReplication[player] = nil
		local profile = profiles[player]
		if profile then
			profile:EndSession()
		end
	end)
end

return DataService
