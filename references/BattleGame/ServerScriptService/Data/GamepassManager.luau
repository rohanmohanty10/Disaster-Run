--[[
	Manage buying gamepasses and syncing data
	
]]

local GamepassManager = {}

-- Services
local ServerScriptServices = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

-- References
local DataManager = require(ServerScriptServices.Data.DataManager)
local GamepassList = require(script.GamepassList)

-- Prompts a gamepass purchase with the pass' name
function GamepassManager:PromptPurchase(player: Player, name: string)
	local profile = DataManager.Profiles[player]
	if not profile then return end
	
	local passId: string = GamepassList.GetGamepassId(name)
	if passId == nil then return end
	
	--Checks if the player owns pass from profile (gifted gamepasses)
	local hasPass = profile.Data.Gamepasses[passId].owned
	print(player.Name, "requests gamepass "..name, "| owned:", hasPass)
	
	-- Checks marketplace for ownership & update if the player buys from actual website
	if hasPass == false then
		local success, message = pcall(function()
			hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, tonumber(passId)) --passId is a string, so we need it to be a number.
		end)
		
		if not success then
			warn("Error while checking if player owns gamepass:", message)
			return
		end
		
		if hasPass == false then
			--Prompt gamepass purchase. Since we know they don't own it from the website or were gifted it. 
			MarketplaceService:PromptGamePassPurchase(player, tonumber(passId))
		elseif hasPass == true then
			-- Re sync all gamepass data if theyy bought it on marketplace and don't have it anywhere else.
			GamepassManager:UpdateOwnershipData(player)
		end
	end
end

-- Award gamepass if purchase is successful
function GamepassManager:OnPromptPurchaseFinished(player, gamepassId, wasPurchased)
	if not wasPurchased then return end
	local passId = tostring(gamepassId)
	if not GamepassList.Functions[passId] then return end

	task.spawn(function()
		-- The "not owned" result from PromptPurchase is cached ~10 s, so retry.
		for _, waitTime in {0, 12, 30} do
			task.wait(waitTime)
			local profile = DataManager.Profiles[player]
			if not profile then return end
			if profile.Data.Gamepasses[passId].owned then return end

			local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, tonumber(passId))
			if ok and owns then
				DataManager.grantGamepass(player, passId)
				GamepassList.Functions[passId](player)
				profile.Data.Gamepasses[passId].awarded = true
				ReplicatedStorage.Remotes.Gamepasses.GamepassPurchased:FireClient(player, passId)
				return
			end
		end
		warn("Purchase not confirmed by Roblox:", player.Name, passId)
	end)
end


-- Checks and updates if a player owns each gamepass
function GamepassManager:UpdateOwnershipData(player: Player)
	local profile = DataManager.Profiles[player]
	if not profile then return end
	
	-- Loop through all gamepasses
	for passId: String, awardFunction in GamepassList.Functions do
		local hasPass = profile.Data.Gamepasses[passId].owned
		
		if hasPass == false then
			-- Checks marketplace service to see if player owns pass
			local success, message = pcall(function()
				hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, tonumber(passId)) --passId is a string, so we need it to be a number.
			end)

			if not success then
				warn("Error while checking if player owns gamepass:", message)
				continue
			end
			
			if hasPass == true then
				-- grantGamepass also sets HasVIP, so perks apply now instead of after a rejoin
				DataManager.grantGamepass(player, passId)
				
				awardFunction(player)
				profile.Data.Gamepasses[passId].awarded = true
				ReplicatedStorage.Remotes.Gamepasses.GamepassPurchased:FireClient(player, passId) -- refresh owned-state UI
			end
			
		end
	end
	
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(...)
	GamepassManager:OnPromptPurchaseFinished(...)
end)

ReplicatedStorage.Remotes.Gamepasses.RequestGamepass.OnServerEvent:Connect(function(player, name)
	GamepassManager:PromptPurchase(player, name)
end)

ReplicatedStorage.Remotes.Comunicator.GetGamepasses.OnServerInvoke = function(player, gamepassName)
	local profile = DataManager.Profiles[player]
	if not profile then return end
	
	local passId: string = GamepassList.GetGamepassId(gamepassName)
	if passId == nil then return end

	local pass = profile.Data.Gamepasses[passId]
	return pass ~= nil and pass.owned == true
end

return GamepassManager