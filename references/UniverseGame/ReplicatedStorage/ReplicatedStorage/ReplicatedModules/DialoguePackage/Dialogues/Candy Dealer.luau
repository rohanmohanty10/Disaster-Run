  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
Knit.GetService("EventCandyService");
local u2 = Dialogue.new();
u2:SetTitle("The Sigma Of Halloween");
u2:SetStarterText("...");
u2:AddResponse("Hi", function() -- Line: 43
    -- upvalues: u2 (copy)
    u2:SetText("...");

    return "ClearResponses";
end);
u2:AddResponse("Nevermind", function() -- Line: 14, Name: ResetDialogue
    -- upvalues: u2 (copy)
    u2:Destroy();
end);

return u2;