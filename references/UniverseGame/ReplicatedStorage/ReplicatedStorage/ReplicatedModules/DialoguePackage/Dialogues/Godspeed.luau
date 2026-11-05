  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u3 = Dialogue.new();

local function ResetDialogue() -- Line: 13
    -- upvalues: u3 (copy)
    u3:Destroy();
end;

u3:SetTitle("Killua");
u3:SetStarterText("Assassination is a key aspect that\'s held at high regards within my family. Do you wish to be a successor of such tradition?");
local v4 = u3:AddResponse("Yes", function() -- Line: 20
    -- upvalues: u3 (copy)
    u3:SetText("You\'ll have to mentally farm yourself in order to meet the criteria, still think you\'ve got the mental capacity?");

    return "Continue";
end);
v4:LinkResponse("Yes", function() -- Line: 25
    -- upvalues: u2 (copy), u3 (copy)
    u2:CheckDialogue(script.Name):expect();
    u3:SetText("Good luck.");

    return "ClearResponses";
end);
v4:LinkResponse("Nevermind", ResetDialogue);
u3:AddResponse("No", ResetDialogue);

return u3;