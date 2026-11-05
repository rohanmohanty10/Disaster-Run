local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager = require(game:GetService("ServerScriptService").Data.DataManager)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local ProductList = require(script.Parent.ProductList)
local Info = require(ReplicatedStorage.Info)

-- receipt handlers are keyed by product ID; the IDs come from ReplicatedStorage.Info by name
local function id(name: string): string
	local productId = ProductList.Names[name]
	assert(productId, "Products: no ID in ReplicatedStorage.Info for " .. name)
	return productId
end

type ReceiptInfo = {
	PurchaseId: string,
	PlayerId: number,
	ProductId: number,
	PlaceIdWherePurchased: number,
	CurrencySpent: number,
	CurrencyType: Enum.CurrencyType,
	ProductPurchaseChannel: Enum.ProductPurchaseChannel,
}

local function handleGift(receiptInfo, player, profile)
	print("[GIFT] handleGift fired", receiptInfo.ProductId)
	local key = tostring(receiptInfo.ProductId)
	local gift = profile.Data.OutgoingGifts[key]
	if not gift then
		-- Paid, but no recipient was recorded. Returning marks the receipt granted with nothing delivered.
		warn("No OutgoingGifts entry for " .. player.Name .. " (Product: " .. key .. "). Receipt granted with nothing delivered.")
		return
	end

	local passId = ProductList.GiftPassMap[gift.productName]
	if not passId then error("Invalid productName: " .. tostring(gift.productName)) end

	-- One path for every case (same server, other server, offline, never joined).
	-- If this fails the receipt errors and Roblox retries it; a repeat message is harmless
	-- because the receiver's handler skips passes they already own.
	if not DataManager.queueGift(gift.targetUserId, passId, player.Name) then
		error("queueGift failed for " .. tostring(gift.targetUserId))
	end

	profile.Data.OutgoingGifts[key] = nil

	Remotes.Comunicator.Set:FireClient(player, "SendNotification", {
		Title = "GIFTING",
		Text  = "Gift sent!",
		Time  = 5,
	})
end

-- Items bought with Robux are saved in PendingItems; ShopService has a seagull bring them once
-- the player is alive, so nothing is lost if they're dead or loading when the receipt comes in.
local function awardItem(receiptInfo, player, itemId)
	if not DataManager.addPendingItems(player, { itemId }) then error("addPendingItems failed") end
	DataManager.addTotalRobuxSpent(player, receiptInfo.CurrencySpent)
end

-- Item gifts reach the receiver the same way as pass gifts (a ProfileStore message), and land in
-- their PendingItems.
local function handleItemGift(receiptInfo, player, profile)
	local key = tostring(receiptInfo.ProductId)
	local gift = profile.Data.OutgoingGifts[key]
	if not gift then
		warn("No OutgoingGifts entry for " .. player.Name .. " (Product: " .. key .. "). Receipt granted with nothing delivered.")
		return
	end

	local itemId = ProductList.GiftItemMap[gift.productName]
	if not itemId then error("Invalid item gift: " .. tostring(gift.productName)) end

	if not DataManager.queueItemGift(gift.targetUserId, itemId, player.Name) then
		error("queueItemGift failed for " .. tostring(gift.targetUserId))
	end

	profile.Data.OutgoingGifts[key] = nil
	DataManager.addTotalRobuxSpentOnGifts(player, receiptInfo.CurrencySpent)
	DataManager.addTotalRobuxSpent(player, receiptInfo.CurrencySpent)

	Remotes.Comunicator.Set:FireClient(player, "SendNotification", {
		Title = "GIFTING",
		Text  = "Gift sent!",
		Time  = 5,
	})
end

local function awardGold(player, amount)
	if not DataManager.addGold(player, amount) then error("addGold failed") end
	Remotes.Comunicator.Set:FireClient(player, "BoughtGold", amount)
end

local function awardDonation(receiptInfo, player)
	if not DataManager.addDonation(player, receiptInfo.CurrencySpent) then error("addDonation failed") end
	DataManager.addTotalRobuxSpent(player, receiptInfo.CurrencySpent)
end


local Handlers = {
	-- MoreEmoteGift
	[id("MoreEmoteGift")] = function(receiptInfo, player, profile)
		handleGift(receiptInfo, player, profile)
		DataManager.addTotalRobuxSpentOnGifts(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- SecondPageGift
	[id("SecondPageGift")] = function(receiptInfo, player, profile)
		handleGift(receiptInfo, player, profile)
		DataManager.addTotalRobuxSpentOnGifts(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- VIP
	[id("VipGift")] = function(receiptInfo, player, profile)
		handleGift(receiptInfo, player, profile)
		DataManager.addTotalRobuxSpentOnGifts(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- SpinEmote 1x, 25 Robux (JJS's Random Emote price)
	[id("Random Emote")] = function(receiptInfo: ReceiptInfo, player, profile)
		DataManager.addEmoteSpins(player, 1)
		DataManager.addTotalRobuxSpentOnEmotes(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- SpinEmote 5x, 125 Robux
	[id("Random Emote x5")] = function(receiptInfo, player, profile)
		DataManager.addEmoteSpins(player, 5)
		DataManager.addTotalRobuxSpentOnEmotes(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- SpinEmote 10x, 250 Robux
	[id("Random Emote x10")] = function(receiptInfo, player, profile)
		DataManager.addEmoteSpins(player, 10)
		DataManager.addTotalRobuxSpentOnEmotes(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	
	
	
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------------
	-- GOLD PURCHASES
	
	-- Gold packs follow JJS's rate (wiki): $1 = 14 Gold (a kill is $5 there, 70 Gold here) and
	-- 1 Robux = $10, so 1 Robux = 140 Gold. The keys
	-- ("500 Gold" ...) are the packs' old names in Info.Products; the amounts below are what they give.

	-- 5,600 Gold, 40 Robux
	[id("500 Gold")] = function(receiptInfo, player, profile)
		awardGold(player, 5600)
		DataManager.addTotalRobuxSpentOnGold(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- 14,560 Gold, 104 Robux
	[id("1500 Gold")] = function(receiptInfo, player, profile)
		awardGold(player, 14560)
		DataManager.addTotalRobuxSpentOnGold(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- 26,880 Gold, 192 Robux
	[id("3000 Gold")] = function(receiptInfo, player, profile)
		awardGold(player, 26880)
		DataManager.addTotalRobuxSpentOnGold(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- 44,800 Gold, 320 Robux
	[id("5000 Gold")] = function(receiptInfo, player, profile)
		awardGold(player, 44800)
		DataManager.addTotalRobuxSpentOnGold(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- 89,600 Gold, 640 Robux
	[id("12000 Gold")] = function(receiptInfo, player, profile)
		awardGold(player, 89600)
		DataManager.addTotalRobuxSpentOnGold(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,

	-- 201,600 Gold, 1440 Robux
	[id("30000 Gold")] = function(receiptInfo, player, profile)
		awardGold(player, 201600)
		DataManager.addTotalRobuxSpentOnGold(player, receiptInfo.CurrencySpent)
		DataManager.addTotalRobuxSpent(player,         receiptInfo.CurrencySpent)
	end,
	
	
	


	-----------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ITEM PURCHASES
	
	-- Sniper
	[id("Sniper")] = function(receiptInfo, player, profile)
		awardItem(receiptInfo, player, "Sniper")
	end,

	-- Cola Bomb
	[id("Cola Bomb")] = function(receiptInfo, player, profile)
		awardItem(receiptInfo, player, "ColaBomb")
	end,

	-- Marine Supply Crate (the item is rolled when it's delivered)
	[id("Marine Supply Crate")] = function(receiptInfo, player, profile)
		awardItem(receiptInfo, player, "SupplyCrate")
	end,

	-- SniperGift
	[id("SniperGift")] = function(receiptInfo, player, profile)
		handleItemGift(receiptInfo, player, profile)
	end,

	-- ColaBombGift
	[id("ColaBombGift")] = function(receiptInfo, player, profile)
		handleItemGift(receiptInfo, player, profile)
	end,

	-- SupplyCrateGift
	[id("SupplyCrateGift")] = function(receiptInfo, player, profile)
		handleItemGift(receiptInfo, player, profile)
	end,
	
	
	
	
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------------
	-- DONATIONS: added below, one per entry in Info.Donations
}

for _, productId in Info.Donations do
	Handlers[tostring(productId)] = function(receiptInfo, player, profile)
		awardDonation(receiptInfo, player)
	end
end

return Handlers