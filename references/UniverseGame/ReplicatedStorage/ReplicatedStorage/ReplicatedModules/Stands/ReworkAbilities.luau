  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);

return not table.find(PathShortcuts.TestPlaces, game.PlaceId) and {} or require(script.Parent);