-- ServerScriptService > Systems > CodeService   (Script, server)
--
-- Codes, redeemed from the box at the bottom of the Store's Items tab. The codes and what they
-- give are in the Codes module under this script (server only, so players can't read them).
-- Each player can redeem a code once (profile.Data.RedeemedCodes). Gold and spins are given
-- straight away; items go into PendingItems and a seagull brings them (ShopService).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local DataManager = require(ServerScriptService.Data.DataManager)
local ItemConfig = require(ReplicatedStorage.Modules:WaitForChild("ItemConfig"))
local Codes = require(script.Codes)

local ShopRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Shop")
local Redeem = ShopRemotes:FindFirstChild("RedeemCode") or Instance.new("RemoteFunction")
Redeem.Name = "RedeemCode"
Redeem.Parent = ShopRemotes

local COOLDOWN = 2 -- seconds between tries, so codes can't be guessed quickly
local LastTry: { [Player]: number } = {}

-- the codes by their upper-case name, so "release" and "RELEASE" are the same code
local ByName = {}
for Name, Code in Codes do
	ByName[string.upper(Name)] = Code
end

-- "2026-12-31" -> the end of that day (UTC); nil if there's no date
local function ExpiresAt(Date: string?): number?
	if type(Date) ~= "string" then
		return nil
	end
	local Ok, Time = pcall(DateTime.fromIsoDate, Date)
	return if Ok and Time then Time.UnixTimestamp + 86399 else nil
end

local function Describe(Code): string
	local Parts = {}
	if (Code.Gold or 0) > 0 then
		table.insert(Parts, `{Code.Gold} Gold`)
	end
	if (Code.Spins or 0) > 0 then
		table.insert(Parts, `{Code.Spins} Emote Spin{Code.Spins > 1 and "s" or ""}`)
	end
	for _, ItemId in Code.Items or {} do
		local Item = ItemConfig.Get(ItemId)
		table.insert(Parts, if Item and Item.Name then Item.Name else ItemId)
	end
	return table.concat(Parts, ", ")
end

Redeem.OnServerInvoke = function(Player: Player, Text: any)
	if type(Text) ~= "string" or #Text > 40 then
		return false, "That code isn't valid."
	end
	local Now = os.clock()
	if Now - (LastTry[Player] or -math.huge) < COOLDOWN then
		return false, "Slow down a little."
	end
	LastTry[Player] = Now

	local Name = string.upper((Text:gsub("%s", "")))
	local Code = ByName[Name]
	if not Code then
		return false, "That code doesn't exist."
	end
	local Expires = ExpiresAt(Code.Expires)
	if Expires and os.time() > Expires then
		return false, "That code has expired."
	end
	local Profile = DataManager.Profiles[Player]
	if not Profile or (Profile.IsActive and not Profile:IsActive()) then
		return false, "Your data is still loading."
	end
	Profile.Data.RedeemedCodes = Profile.Data.RedeemedCodes or {}
	if Profile.Data.RedeemedCodes[Name] then
		return false, "You already redeemed that code."
	end

	-- mark it first, so a second request can't redeem it twice
	Profile.Data.RedeemedCodes[Name] = os.time()
	if (Code.Gold or 0) > 0 then
		DataManager.addGold(Player, Code.Gold)
	end
	if (Code.Spins or 0) > 0 then
		DataManager.addEmoteSpins(Player, Code.Spins)
	end
	if Code.Items and #Code.Items > 0 then
		DataManager.addPendingItems(Player, Code.Items)
	end
	return true, `Redeemed! You got {Describe(Code)}.`
end

Players.PlayerRemoving:Connect(function(Player)
	LastTry[Player] = nil
end)
