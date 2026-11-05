--!strict
-- Slots, locks, vault equips and the "one kit equipped per role" rule.
-- Equipped kit = the vault kit if one is equipped, otherwise the kit in the selected slot.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Kits = require(ReplicatedStorage.Shared.Data.Kits)

local Requests = require(script.Parent.Requests)
local DataService = require(script.Parent.DataService)

local InventoryService = {}

-- Players can't swap kits mid-round. RoundService sets this attribute.
function InventoryService.IsLocked(player: Player): boolean
	return player:GetAttribute("InRound") == true
end

-- The kit a player uses for a role right now.
function InventoryService.GetEquipped(player: Player, role: Kits.Role): string
	local data = DataService.Get(player)
	if not data then
		return Kits.Defaults[role]
	end
	local roleData = data[role]
	if roleData.VaultEquipped ~= "" then
		return roleData.VaultEquipped
	end
	local kitId = roleData.Slots[roleData.Selected]
	if kitId == nil or kitId == "" then
		return Kits.Defaults[role]
	end
	return kitId
end

-- Mirrors equipped kits to attributes so any script (server or client) can read them cheaply.
function InventoryService.Refresh(player: Player)
	for _, role in Kits.Roles do
		player:SetAttribute(`Equipped{role}Kit`, InventoryService.GetEquipped(player, role))
	end
end

local function validSlot(roleData: any, index: any): number?
	if type(index) ~= "number" or index ~= index or index % 1 ~= 0 then
		return nil
	end
	if index < 1 or index > roleData.MaxSlots then
		return nil
	end
	return index
end

local function changed(player: Player)
	InventoryService.Refresh(player)
	DataService.Changed(player)
end

function InventoryService.Init()
	Requests.Register("EquipSlot", function(player, role, index)
		if not Kits.IsRole(role) then
			return Requests.Fail("BadRole")
		end
		if InventoryService.IsLocked(player) then
			return Requests.Fail("InRound", "You can't change kits during a round!")
		end
		local data = DataService.Get(player)
		if not data then
			return Requests.Fail("NotLoaded")
		end
		local roleData = data[role]
		local slot = validSlot(roleData, index)
		if not slot then
			return Requests.Fail("BadSlot")
		end
		roleData.Selected = slot
		roleData.VaultEquipped = ""
		changed(player)
		return { Ok = true }
	end)

	Requests.Register("EquipVault", function(player, role, kitId)
		if not Kits.IsRole(role) or type(kitId) ~= "string" then
			return Requests.Fail("BadRequest")
		end
		if InventoryService.IsLocked(player) then
			return Requests.Fail("InRound", "You can't change kits during a round!")
		end
		local data = DataService.Get(player)
		if not data then
			return Requests.Fail("NotLoaded")
		end
		local roleData = data[role]
		if not table.find(roleData.Vault, kitId) then
			return Requests.Fail("NotOwned")
		end
		roleData.VaultEquipped = kitId
		changed(player)
		return { Ok = true }
	end)

	Requests.Register("SetLocked", function(player, role, index, locked)
		if not Kits.IsRole(role) or type(locked) ~= "boolean" then
			return Requests.Fail("BadRequest")
		end
		local data = DataService.Get(player)
		if not data then
			return Requests.Fail("NotLoaded")
		end
		local roleData = data[role]
		local slot = validSlot(roleData, index)
		if not slot then
			return Requests.Fail("BadSlot")
		end
		roleData.Locked[slot] = locked
		DataService.Changed(player)
		return { Ok = true }
	end)

	Requests.Register("SetBoostedKit", function(player, role, kitId)
		if not Kits.IsRole(role) or type(kitId) ~= "string" then
			return Requests.Fail("BadRequest")
		end
		if kitId ~= "" and not Kits.Get(role, kitId) then
			return Requests.Fail("BadKit")
		end
		local data = DataService.Get(player)
		if not data then
			return Requests.Fail("NotLoaded")
		end
		data[role].BoostedKit = kitId
		DataService.Changed(player)
		return { Ok = true }
	end)
end

function InventoryService.Start()
	DataService.Loaded:Connect(function(player)
		InventoryService.Refresh(player)
	end)
	-- Players who loaded before this connected.
	for _, player in Players:GetPlayers() do
		if DataService.Get(player) then
			InventoryService.Refresh(player)
		end
	end
end

return InventoryService
