  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u2 = Dialogue.new();
u2:SetTitle("Gamemodes");
u2:SetStarterText("Wanna go to the gamemodes place?");
u2:AddResponse("Yes", function(p3) -- Line: 16
    -- upvalues: u2 (copy), PathShortcuts (copy)
    u2:SetStarterText("Alright.");
    game:GetService("TeleportService"):Teleport(PathShortcuts.LinkedPlaces[game.GameId].GameModeLobby, game.Players.LocalPlayer);
    u2:Destroy();

    return "ClearResponses";
end);

return u2;