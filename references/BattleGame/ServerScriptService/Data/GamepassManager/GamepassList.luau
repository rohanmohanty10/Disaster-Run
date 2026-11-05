--[[
		Store gamepass names, productIds, and award functions

]]


local Info = require(game:GetService("ReplicatedStorage").Info)

local GamepassList = {}

-- Pass name -> ID (as a string, the same form as the Template.Gamepasses keys), from ReplicatedStorage.Info.Passes
GamepassList.Names = {}
for name, id in Info.Passes do
	GamepassList.Names[name] = tostring(id)
end

function GamepassList.GetGamepassId(name: string)
	return GamepassList.Names[name]
end

-- Award function for gamepasses (called once when bought)
GamepassList.Functions = {
	
	-- VIP 
	[GamepassList.Names.VIP] = function(player: Player)
		print("VIP Gamepass Awarded!")
		
	end,
	
	-- MoreEmotes
	[GamepassList.Names.MoreEmotes] = function(player: Players)
		print("More Emotes Awarded!")
	end,
	
	-- Second Page
	[GamepassList.Names.SecondPage] = function(player: Players)
		print("Second Page awared!")
	end,

	-- Early Access (NewCombatSystem checks it when picking a character marked isEA)
	[GamepassList.Names.EarlyAccess] = function(player: Player)
		print("Early Access Awarded!")
	end,
	
}


return GamepassList
