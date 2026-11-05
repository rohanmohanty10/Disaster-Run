--!strict
-- Robux developer products: spin packs and extra slots (ids in GachaConfig.Products).
-- Uses ProfileStore's PurchaseId cache pattern: the receipt is only granted once the
-- purchase is confirmed saved, so a server crash can't eat (or duplicate) a purchase.

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GachaConfig = require(ReplicatedStorage.Shared.Config.GachaConfig)

local DataService = require(script.Parent.DataService)
local InventoryService = require(script.Parent.InventoryService)
local Requests = require(script.Parent.Requests)

local PURCHASE_ID_CACHE_SIZE = 100

type Grant = (player: Player, data: any) -> ()

local MonetizationService = {}

local productGrants: { [number]: Grant } = {}

local function addProduct(productId: number, grant: Grant)
	if productId == 0 then
		return -- not created on the dashboard yet
	end
	assert(productGrants[productId] == nil, `Product {productId} is configured twice in GachaConfig`)
	productGrants[productId] = grant
end

local function buildProducts()
	for role, packs in GachaConfig.Products.Spins do
		for spinType, list in packs :: any do
			for _, pack in list do
				addProduct(pack.ProductId, function(player, data)
					local field = if spinType == "Lucky" then "LuckySpins" else "Spins"
					data[role][field] += pack.Amount
					Requests.Notify(player, `+{pack.Amount} {if spinType == "Lucky" then "Lucky " else ""}Spins!`, Color3.fromRGB(120, 255, 140))
				end)
			end
		end
	end
	for role, slots in GachaConfig.Products.Slots do
		for index, productId in slots :: any do
			addProduct(productId, function(player, data)
				local roleData = data[role]
				roleData.MaxSlots = math.clamp(math.max(roleData.MaxSlots, index), GachaConfig.BaseSlots, GachaConfig.MaxSlots)
				Requests.Notify(player, `Slot {index} unlocked!`, Color3.fromRGB(120, 255, 140))
			end)
		end
	end
end

local function purchaseIdCheckAsync(profile: any, purchaseId: string, grant: () -> ()): Enum.ProductPurchaseDecision
	if not profile:IsActive() then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local cache = profile.Data.PurchaseIdCache
	if table.find(cache, purchaseId) == nil then
		local ok, err = pcall(grant)
		if not ok then
			warn(`[Monetization] Failed to grant purchase {purchaseId}: {err}`)
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
		while #cache >= PURCHASE_ID_CACHE_SIZE do
			table.remove(cache, 1)
		end
		table.insert(cache, purchaseId)
	end

	local function isSaved(): boolean
		local saved = profile.LastSavedData and profile.LastSavedData.PurchaseIdCache
		return saved ~= nil and table.find(saved, purchaseId) ~= nil
	end

	if isSaved() then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
	while profile:IsActive() do
		local lastSaved = profile.LastSavedData
		profile:Save()
		if profile.LastSavedData == lastSaved then
			profile.OnAfterSave:Wait()
		end
		if isSaved() then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		if profile:IsActive() then
			task.wait(10)
		end
	end
	return Enum.ProductPurchaseDecision.NotProcessedYet
end

local function processReceipt(receipt: any): Enum.ProductPurchaseDecision
	local player = Players:GetPlayerByUserId(receipt.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	local grant = productGrants[receipt.ProductId]
	if not grant then
		warn(`[Monetization] No grant for product {receipt.ProductId}`)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	DataService.WaitFor(player)
	local profile = DataService.GetProfile(player)
	if not profile then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	local decision = purchaseIdCheckAsync(profile, receipt.PurchaseId, function()
		grant(player, profile.Data)
	end)
	if player.Parent == Players then
		InventoryService.Refresh(player)
		DataService.Changed(player)
	end
	return decision
end

function MonetizationService.Init()
	buildProducts()
end

function MonetizationService.Start()
	-- Only one script in the whole game may set this.
	MarketplaceService.ProcessReceipt = processReceipt
end

return MonetizationService
