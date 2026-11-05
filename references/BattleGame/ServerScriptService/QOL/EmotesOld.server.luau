-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Modules
local DataManager = require(ServerScriptService.Data.DataManager)
local AnimationService = require(ServerStorage.SBGModules.AnimationService)
local SoundsModule = require(ServerStorage.SBGModules.SoundsModule)
local EmotesModule = require(ServerStorage.SBGModules.Emotes)

local Trove = require(ReplicatedStorage.Modules.Trove)

-- Folders & Remotes
local EmotesFolder = ReplicatedStorage.Assets.Animations.Emotes
local Sounds = ReplicatedStorage.Assets.Sounds
local Remotes = ReplicatedStorage.Remotes
local EmotesRemotes = Remotes.Emotes
local ComunicatorComms = Remotes.Comunicator
local ComSet = ComunicatorComms.Set

-- Helper Function
local function GetEmoteAnim(emoteName)
	for _, descendant in EmotesFolder:GetDescendants() do
		if descendant:IsA("Animation") and descendant.Name == emoteName then
			return descendant
		end
	end
	return nil
end

-- /// REMOTE INVOCATIONS (Moved from DataManager) ///
EmotesRemotes.GetOwnedEmotes.OnServerInvoke = function(player)
	return DataManager.getOwnedEmotes(player)
end

EmotesRemotes.GetEquippedEmotes.OnServerInvoke = function(player)
	local profile = DataManager.Profiles[player]
	if not profile then return {}, {} end

	local page1, page2 = {}, {}
	for key, emoteName in profile.Data.Emotes.EquippedEmotes do
		local pageNum, slot = string.match(key, "^(%d+)_(%d+)$")
		if pageNum == "1" then page1[slot] = emoteName
		elseif pageNum == "2" then page2[slot] = emoteName end
	end
	return page1, page2
end

EmotesRemotes.ChangeEmotes.OnServerInvoke = function(player, params)
	return DataManager.changeEmoteSlot(player, params.EmoteName, params.Slot, params.Page)
end

EmotesRemotes.BuyEmote.OnServerInvoke = function(player)
	local cost = 1000  -- server decides the price; client can't spoof it

	local result, emote = DataManager.buyEmoteSpin(player, cost)

	if result == "Bought" then
		ComSet:FireClient(player, "SendNotification", { Title = "MARKET", Text = "Unlocked emote: " .. tostring(emote) .. "!", Time = 5 })
	elseif result == "NotEnough" then
		ComSet:FireClient(player, "SendNotification", { Title = "MARKET", Text = "Not enough Beli. (Need " .. cost .. ")", Time = 5 })
	elseif result == "OwnAll" then
		ComSet:FireClient(player, "SendNotification", { Title = "MARKET", Text = "You already own every emote!", Time = 5 })
	end

	return result
end


-- /// REMOTE EVENTS (Moved from DataInit) ///

EmotesRemotes.Set.OnServerEvent:Connect(function(player, action, AnimationName)
	if action == "PlayEmote" then
		local Character = player.Character
		if not Character or Character:HasTag("Stunned") or not Character:FindFirstChild("HumanoidRootPart") then return end

		local Anim = GetEmoteAnim(AnimationName)
		if not Anim then return end
		
		AnimationService:stopAll(Character)
		
		if EmotesModule[AnimationName] then
			EmotesModule[AnimationName](player, Anim)
		else
			--print("Going into emote else branch")

			local Track = AnimationService:getAnimationTrack(Character, Anim)
			AnimationService:playAnimation(Character, Anim)

			Character:SetAttribute('DefaultRunSpeed', Anim:GetAttribute('WalkSpeed') or 0)
			Character:SetAttribute('DefaultWalkSpeed', Anim:GetAttribute('WalkSpeed') or 0)
			Character:SetAttribute('DefaultJumpPower', Anim:GetAttribute('JumpPower') or 0)

			if Anim:HasTag('NAR') then Character:AddTag("CantRotate") end

			local EmoteSound = Sounds.Emotes:FindFirstChild(Anim.Name)
			if EmoteSound then
				EmoteSound = SoundsModule:PlaySound(EmoteSound, Character.PrimaryPart)
			end

			local c
			c = Track.Stopped:Connect(function()
				if trove then trove:Destroy() end
				c:Disconnect()

				if not Character:HasTag("Stunned") then
					Character:SetAttribute('DefaultRunSpeed', 25)
					Character:SetAttribute('DefaultWalkSpeed', 16)
					Character:SetAttribute('DefaultJumpPower', 50)
				end
				Character:RemoveTag("CantRotate")
				if EmoteSound then EmoteSound:Destroy() end
			end)
		end

	elseif action == "StopEmote" then
		local Character = player.Character
		if Character and Character:FindFirstChild("Emoting") then
			AnimationService:stopAll(Character, 0)
		end
	end
end)