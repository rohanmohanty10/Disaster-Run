  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local v2 = Dialogue.new();
v2:SetTitle("Ability Banner");
v2:SetStarterText("What can I help you with?");

return v2;