local ProductManager = {}

-- Services
local MarketPlaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")


-- References
local DataManager = require(ServerScriptService.Data.DataManager)

local ProductFunctions = require(script.Products)
local ProductList = require(script.ProductList)

local MAX_CACHE_SIZE = 100

local giftCooldowns = {}

-- Clean up on player leave
Players.PlayerRemoving:Connect(function(player)
	giftCooldowns[player] = nil
end)

MarketPlaceService.PromptProductPurchaseFinished:Connect(function(userId, productId, wasPurchased)
	local player = Players:GetPlayerByUserId(userId)
	--print("[GIFT] PromptFinished", player and player.Name or userId, productId, wasPurchased)
	if wasPurchased then return end
	if not player then return end

	local profile = DataManager.Profiles[player]
	if profile then
		profile.Data.OutgoingGifts[tostring(productId)] = nil
	end
end)


function ProductManager.GiftPurchaseRequested(player: Player, targetUserId: number, productName: string)
	--print("[GIFT] requested", player.Name, "->", targetUserId, productName)
	
	-- Rate limit
	if giftCooldowns[player] and tick() - giftCooldowns[player] < 5 then
		warn("Gift request rate limited for:", player.Name)
		return
	end
	giftCooldowns[player] = tick() -- set before the web calls below yield, so spammed requests can't all get through
	
	if typeof(targetUserId) ~= "number"
		or targetUserId <= 0
		or targetUserId ~= math.floor(targetUserId) then
		return
	end
	if typeof(productName) ~= "string" or #productName == 0 then return end

	local ok = pcall(function()
		Players:GetNameFromUserIdAsync(targetUserId)
	end)
	if not ok then
		warn("Invalid targetUserId:", targetUserId)
		return
	end
	
	-- Prevent self-gifting
	if targetUserId == player.UserId then
		warn("Player tried to gift themselves:", player.Name)
		return
	end

	local productId = ProductList.GetProductId(productName)
	productId = tonumber(productId)
	if not productId then
		warn("Invalid productName:", productName)
		return
	end

	if ProductFunctions[tostring(productId)] == nil then
		warn("No product function for ProductID:", productId, "| Player:", player.Name)
		return
	end

	local profile = DataManager.Profiles[player]
	if not profile then return end
	
	
	local passId = ProductList.GiftPassMap[productName]
	if passId then
		local target = Players:GetPlayerByUserId(targetUserId)
		if target then
			local targetProfile = DataManager.Profiles[target]
			if targetProfile and targetProfile.Data.Gamepasses[passId]
				and targetProfile.Data.Gamepasses[passId].owned then
				-- fire whatever "they already own this" remote you use
				local message = "Player already owns gamepass" 

				Remotes.Comunicator.Set:FireClient(player, "SendNotification", { Title = "GIFTING"; Text = message; Time = 5; })
				return
			end
		else
			-- Not in this server. Roblox ownership only covers passes they bought, so also read their
			-- saved profile (read-only) to catch passes they were gifted. Saved data can lag a live
			-- session by one autosave, which is fine for this check.
			local alreadyOwns = false

			local store = DataManager.PlayerStore
			if store then
				local okView, view = pcall(store.GetAsync, store, "Player_" .. targetUserId)
				local gamepasses = okView and view and view.Data and view.Data.Gamepasses
				if gamepasses and gamepasses[passId] and gamepasses[passId].owned then
					alreadyOwns = true
				end
			end

			if not alreadyOwns then
				local ok, owns = pcall(function()
					return MarketPlaceService:UserOwnsGamePassAsync(targetUserId, tonumber(passId))
				end)
				alreadyOwns = ok and owns == true
			end

			if alreadyOwns then
				Remotes.Comunicator.Set:FireClient(player, "SendNotification",
					{ Title = "GIFTING", Text = "Player already owns this gamepass.", Time = 5 })
				return 
			end
		end
	end
	
	profile.Data.OutgoingGifts[tostring(productId)] = {
		targetUserId = targetUserId,
		productName = productName,
		productId = productId,
		timestamp = os.time()
	}
	--print("[GIFT] prompting", productId)
	MarketPlaceService:PromptProductPurchase(player, tonumber(productId))
end


function ProductManager.ProductPurchaseRequested(player:Player, productName)
	-- Gift products must go through GiftPurchaseRequested so a recipient is recorded first.
	-- Bought here, the receipt has no recipient and the Robux would be spent on nothing.
	if ProductList.GiftPassMap[productName] or ProductList.GiftItemMap[productName] then
		warn("Gift product requested as a normal purchase:", productName, "| Player:", player.Name)
		return
	end

	local productId = ProductList.GetProductId(productName)
	-- Sanity Check on productID
	if ProductFunctions[tostring(productId)] == nil then
		warn("No product function for ProductID:",  productId, "| Player:", player.Name, player.UserId)
		return
	end
	
	-- Prompt Purchase 
	MarketPlaceService:PromptProductPurchase(player, productId) --The actual prompt which roblox sends out for players to buy a certain product. It needs the player and the productId.
end

-- Waits until PurchaseId has been stored in the Profile before confirming ProductPurchaseDecision. To ensure that if they were kicked or something before the item was given, it will yield and try to give it next session.
local function CheckPurchaseAsync(profile: typeof(PlayerStore:StartSessionAsync()), purchaseId, grantProductFunction) :Enum.ProductPurchaseDecision
	
	-- Check if profile is active.
	if profile:IsActive() then
		
		-- Get cache of previous purchaseIds
		local purchaseIdCache = profile.Data.PurchaseIdCache
		if purchaseIdCache == nil then
			purchaseIdCache = {}
			profile.Data.PurchaseIdCache = purchaseIdCache
		end
		
		-- Grant product if not previously logged
		if table.find(purchaseIdCache, purchaseId) == nil then
			
			-- Grant product
			local success, result = pcall(grantProductFunction) -- grantProductFunction is an parameter which recieves an function. So no need to add ().
				
			-- if pcall fails.
			if success == false then
				warn("Failed to grant product:", profile.Key, purchaseId, result)
				return Enum.ProductPurchaseDecision.NotProcessedYet
			end
			
			-- if pcall succeded (log purchaseId to cache):
			
			-- Remove outdated purchaseIds
			while #purchaseIdCache >= MAX_CACHE_SIZE do
				table.remove(purchaseIdCache, 1)
			end
			
			table.insert(purchaseIdCache, purchaseId)
			
		end
		
		-- At this point, product has been confirmed and granted
		-- Verify that the product has been logged in the Data Store. We do this with the lastsaved function.
		local function isPurchaseSaved() :boolean
			local savedCache = profile.LastSavedData.PurchaseIdCache --Similar to .Data, but instead we are seeing the last saved session and seeing if it is there
			return if savedCache ~= nil then table.find(savedCache, purchaseId) ~= nil else false
		end
		
		-- Initial purchaseId saved check:
		if isPurchaseSaved() == true then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		end
		
		-- Periodically check if the purchaseId is saved UNTIL it is, OR the profile session ends.
		while profile:IsActive() == true do
			
			-- Get a copy of current LastSavedData
			local lastSavedDataCopy = profile.LastSavedData
			
			-- Manually save the profile 
			profile:Save()
			
			-- Wait until the profile has been saved
			if profile.LastSavedData == lastSavedDataCopy then -- Since if they are the same, it will wait until it is saved. 
				profile.OnAfterSave:Wait()
			end
			
			-- Check if purchaseId has been saved
			if isPurchaseSaved() == true then
				return Enum.ProductPurchaseDecision.PurchaseGranted
			end
			
			-- Wait a period of time and then try again
			if profile:IsActive() == true then
				task.wait(10) -- This will continually run and will make sure it will run. 
			end
			
		end
		
	end
	
	-- Fall back to return NotProcessedYet
	return Enum.ProductPurchaseDecision.NotProcessedYet
	
end

-- MarketPlaceService callback to verify product has been granted.
local function ProcessReceipt(receiptInfo)
	--print("[GIFT] ProcessReceipt fired", receiptInfo.ProductId, "for", receiptInfo.PlayerId)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	
	-- Make sure that the player is still in the game
	if player ~= nil then
		local profile = DataManager.Profiles[player]
		
		-- Wait for profile to exist
		while profile == nil and player.Parent == Players do -- So if they are still in the game and their profile exists, do this.
			task.wait()
			profile = DataManager.Profiles[player]
		end
		
		-- Make sure profile exists. This won't work if they leave the game immediately.
		if profile ~= nil then
			
			-- Sanity Check on productID
			if ProductFunctions[tostring(receiptInfo.ProductId)] == nil then
				warn("No product function for ProductID:",  receiptInfo.ProductId, "| Player:", player.Name, player.UserId)
				return Enum.ProductPurchaseDecision.NotProcessedYet
			end
			
			-- Grant product and return result
			local productPurchaseDecision = CheckPurchaseAsync(
				profile,
				receiptInfo.PurchaseId,
				function()
					ProductFunctions[tostring(receiptInfo.ProductId)](receiptInfo, player, profile)
				end
			)
			
			return productPurchaseDecision
			
		end
		
	end
	
	return Enum.ProductPurchaseDecision.NotProcessedYet
	
end



-- Connects ProcessReceipt CallBack
MarketPlaceService.ProcessReceipt = ProcessReceipt


ReplicatedStorage.Remotes.DevProducts.RequestDevProduct.OnServerEvent:Connect(function(player, productName)
	ProductManager.ProductPurchaseRequested(player, productName) 
end)

ReplicatedStorage.Remotes.DevProducts.RequestGiftingProduct.OnServerEvent:Connect(function(player, targetUserId, productName)
	ProductManager.GiftPurchaseRequested(player, targetUserId, productName)
end)

-- Gift delivery is handled by the profile MessageHandler in DataInit (sent via DataManager.queueGift).

return ProductManager
