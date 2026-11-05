--!strict
-- The rotating Divine Shard shop (GAME_PLAN.md Section 3D). Offers come from the shared
-- ShardShop module, so the server and every client agree on them without networking.
--
-- Request: "ShopBuy"(role, kitId). A bought kit goes to the vault (Mythical) or the first empty
-- slot; if every slot is full it replaces the selected slot, unless that slot is locked.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local Rarities = require(ReplicatedStorage.Shared.Data.Rarities)
local ShardShop = require(ReplicatedStorage.Shared.Gacha.ShardShop)

local Requests = require(script.Parent.Requests)
local DataService = require(script.Parent.DataService)
local InventoryService = require(script.Parent.InventoryService)

local ShopService = {}

local function buy(player: Player, role: any, kitId: any): Requests.Result
	if not Kits.IsRole(role) or type(kitId) ~= "string" then
		return Requests.Fail("BadRequest")
	end
	if InventoryService.IsLocked(player) then
		return Requests.Fail("InRound", "You can't shop during a match!")
	end
	local data = DataService.Get(player)
	if not data then
		return Requests.Fail("NotLoaded", "Your data is still loading!")
	end
	local offers = ShardShop.Offers(role, ShardShop.Rotation(os.time()))
	if not table.find(offers, kitId) then
		return Requests.Fail("NotOffered", "That kit isn't in the shop anymore.")
	end
	local price = ShardShop.Price(role, kitId)
	local kit = Kits.Get(role, kitId)
	if not price or not kit then
		return Requests.Fail("NotOffered")
	end
	local roleData = (data :: any)[role]
	if ShardShop.Owns(roleData, kitId) then
		return Requests.Fail("Owned", "You already own this kit!")
	end
	if data.DivineShards < price then
		return Requests.Fail("NoShards", `You need {price} Divine Shards!`)
	end

	local where: string
	if Rarities.Vaulted[kit.Rarity] then
		table.insert(roleData.Vault, kitId)
		roleData.VaultEquipped = kitId
		where = "Vault"
	else
		local slot: number? = nil
		for i = 1, roleData.MaxSlots do
			if roleData.Slots[i] == "" then
				slot = i
				break
			end
		end
		if not slot then
			if roleData.VaultEquipped == "" and not roleData.Locked[roleData.Selected] then
				slot = roleData.Selected
			else
				return Requests.Fail("NoSlot", "Every slot is full: select an unlocked slot to replace first.")
			end
		end
		roleData.Slots[slot :: number] = kitId
		where = `Slot {slot}`
	end
	data.DivineShards -= price
	InventoryService.Refresh(player)
	DataService.Changed(player)
	local profile = DataService.GetProfile(player)
	if profile then
		profile:Save()
	end
	return { Ok = true, Kit = kitId, Where = where }
end

function ShopService.Init()
	Requests.Register("ShopBuy", buy)
end

function ShopService.Start() end

return ShopService
