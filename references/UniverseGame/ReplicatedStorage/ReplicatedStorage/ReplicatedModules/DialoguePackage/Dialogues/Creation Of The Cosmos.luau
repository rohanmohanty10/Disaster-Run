  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u3 = Dialogue.new();
u3:SetTitle("Dio");
u3:SetStarterText("what do you want?...");
u3:AddResponse("I wish to become the stars (SOL Quest)", function() -- Line: 16
    -- upvalues: u2 (copy), u3 (copy)
    if u2:CheckDialogue("Sol Quest"):expect() then
        u3:SetText("There, now get out of my sight");
    else
        u3:SetText("You already have the quest");
    end;

    return "ClearResponses";
end);
u3:AddResponse("I wish to become the eclipse (NOCTURNUS Quest)", function() -- Line: 26
    -- upvalues: u2 (copy), u3 (copy)
    if u2:CheckDialogue("Nocturnus Quest"):expect() then
        u3:SetText("There, now get out of my sight");
    else
        u3:SetText("You already have the quest");
    end;

    return "ClearResponses";
end);

return u3;