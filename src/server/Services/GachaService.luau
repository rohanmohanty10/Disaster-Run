--!strict
-- Server-authoritative spins for both vaults (GAME_PLAN.md Section 3).
-- The client only asks to spin; the server charges, rolls, applies pity and decides where the kit goes.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local Rarities = require(ReplicatedStorage.Shared.Data.Rarities)
local GachaConfig = require(ReplicatedStorage.Shared.Config.GachaConfig)
local Roller = require(ReplicatedStorage.Shared.Gacha.Roller)
local Banners = require(ReplicatedStorage.Shared.Gacha.Banners)

local Requests = require(script.Parent.Requests)
local DataService = require(script.Parent.DataService)
local InventoryService = require(script.Parent.InventoryService)
local QuestService = require(script.Parent.QuestService)

local GachaService = {}

local rng = Random.new()
local lastSpin: { [Player]: number } = {}

export type SpinResult = {
	Ok: boolean,
	Kit: string,
	Rarity: string,
	Table: string, -- odds table used ("Normal", "NormalPity", "Lucky", ...)
	Vaulted: boolean, -- went to the Permanent Vault
	Duplicate: boolean,
	RefundLuckySpins: number,
	RefundCash: number,
	Shards: number,
	PaidWithCash: boolean,
}

-- Charges for a spin. Returns (ok, paidWithCash, failReason, failMessage).
local function charge(data: any, roleData: any, spinType: Roller.SpinType): (boolean, boolean, string?, string?)
	if spinType == "Lucky" then
		if roleData.LuckySpins <= 0 then
			return false, false, "NoLuckySpins", "You don't have any Lucky Spins!"
		end
		roleData.LuckySpins -= 1
		return true, false, nil, nil
	end
	if roleData.Spins > 0 then
		roleData.Spins -= 1
		return true, false, nil, nil
	end
	if data.Cash >= GachaConfig.CashSpinCost then
		data.Cash -= GachaConfig.CashSpinCost
		return true, true, nil, nil
	end
	return false, false, "NoSpins", "You don't have any spins or enough Cash!"
end

-- Puts a rolled kit where it belongs and works out duplicate compensation.
local function place(data: any, roleData: any, spinType: Roller.SpinType, kitId: string, rarity: string, result: SpinResult)
	local shards = GachaConfig.Duplicate.Shards[rarity] or 0
	if Rarities.Vaulted[rarity] then
		result.Vaulted = true
		if table.find(roleData.Vault, kitId) then
			result.Duplicate = true
			if spinType == "Lucky" then
				result.RefundLuckySpins = GachaConfig.Duplicate.LuckySpinRefund
				roleData.LuckySpins += result.RefundLuckySpins
			else
				result.RefundCash = rng:NextInteger(GachaConfig.Duplicate.CashRefundMin, GachaConfig.Duplicate.CashRefundMax)
				data.Cash += result.RefundCash
			end
		else
			table.insert(roleData.Vault, kitId)
			-- A brand-new vault kit is equipped straight away (the slot underneath is untouched).
			roleData.VaultEquipped = kitId
		end
	else
		if table.find(roleData.Slots, kitId) then
			result.Duplicate = true
		end
		roleData.Slots[roleData.Selected] = kitId
	end
	if result.Duplicate and shards > 0 then
		result.Shards = shards
		data.DivineShards += shards
	end
end

function GachaService.Spin(player: Player, role: any, spinType: any): Requests.Result
	if not Kits.IsRole(role) then
		return Requests.Fail("BadRole")
	end
	if spinType ~= "Normal" and spinType ~= "Lucky" then
		return Requests.Fail("BadSpinType")
	end
	if InventoryService.IsLocked(player) then
		return Requests.Fail("InRound", "You can't spin during a round!")
	end
	local now = os.clock()
	if lastSpin[player] and now - lastSpin[player] < GachaConfig.SpinCooldown then
		return Requests.Fail("Busy")
	end
	local data = DataService.Get(player)
	if not data then
		return Requests.Fail("NotLoaded", "Your data is still loading!")
	end
	local roleData = (data :: any)[role]
	if roleData.VaultEquipped ~= "" then
		return Requests.Fail("VaultEquipped", "Equip a slot to spin! Vault kits can't be spun away.")
	end
	if roleData.Locked[roleData.Selected] then
		return Requests.Fail("Locked", "This slot is locked!")
	end

	local paid, paidWithCash, reason, message = charge(data, roleData, spinType)
	if not paid then
		return Requests.Fail(reason :: string, message)
	end
	lastSpin[player] = now

	local tableName = Roller.TableFor(roleData, spinType)
	local boosted = if roleData.BoostedKit ~= "" then roleData.BoostedKit else nil
	local now = os.time()
	local kitId, rarity = Roller.Roll(role, tableName, boosted, rng, now)
	-- During an event banner, the Lucky Secret pity guarantees the featured Secret (GAME_PLAN 3C).
	local featured = if tableName == "LuckySecretPity" then Banners.FeaturedSecret(role, now) else nil
	if featured then
		kitId, rarity = featured, "Secret"
	end
	Roller.UpdatePity(roleData, spinType, tableName, rarity)
	roleData.TotalSpins += 1

	local result: SpinResult = {
		Ok = true,
		Kit = kitId,
		Rarity = rarity,
		Table = tableName,
		Vaulted = false,
		Duplicate = false,
		RefundLuckySpins = 0,
		RefundCash = 0,
		Shards = 0,
		PaidWithCash = paidWithCash,
	}
	place(data, roleData, spinType, kitId, rarity, result)

	InventoryService.Refresh(player)
	DataService.Changed(player)
	QuestService.Increment(player, "Spins", 1)
	-- Purchases already force a save; spins of Mythical+ are worth one too.
	if Rarities.AtLeast(rarity, "Mythical") then
		local profile = DataService.GetProfile(player)
		if profile then
			profile:Save()
		end
	end
	return result :: any
end

-- For purchases, rewards and admin tools.
function GachaService.GrantSpins(player: Player, role: Kits.Role, spinType: Roller.SpinType, amount: number): boolean
	local data = DataService.Get(player)
	if not data then
		return false
	end
	local roleData = (data :: any)[role]
	if spinType == "Lucky" then
		roleData.LuckySpins += amount
	else
		roleData.Spins += amount
	end
	DataService.Changed(player)
	return true
end

-- Grants boosted normal spins (ad / daily boost). Hooked up once rewarded ads are set up.
function GachaService.GrantAdBoost(player: Player, role: Kits.Role, spins: number?): boolean
	local data = DataService.Get(player)
	if not data then
		return false
	end
	local roleData = (data :: any)[role]
	roleData.AdBoost += spins or GachaConfig.AdBoostSpins
	DataService.Changed(player)
	return true
end

function GachaService.Init()
	Requests.Register("Spin", GachaService.Spin)
end

function GachaService.Start()
	game:GetService("Players").PlayerRemoving:Connect(function(player)
		lastSpin[player] = nil
	end)
end

return GachaService
