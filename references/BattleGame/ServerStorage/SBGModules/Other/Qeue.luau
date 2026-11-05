local module = {}
module.SoloQeueTable = {}
module.DuoQeueTable = {}


function module:AddPlayerToQeue(Player: Player)
	module.SoloQeueTable[Player] = Player
end

function module:RemovePlayerFromQeue(Player: Player)
	module.SoloQeueTable[Player] = nil
end


function module:AddDuoToQeue(Player1: Player, Player2: Player)
	module.DuoQeueTable[Player1] = { ['Main'] = Player1, ['Teammate'] = Player2 }
	
	return module.DuoQeueTable[Player1]
end

function module:RemoveDuoFromQeue(Player1: Player)
	module.DuoQeueTable[Player1] = nil
end


return module