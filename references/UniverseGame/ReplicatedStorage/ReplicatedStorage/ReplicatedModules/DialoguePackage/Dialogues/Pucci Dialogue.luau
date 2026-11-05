  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u3 = Knit.GetService("InventoryService");
local u4 = Dialogue.new();
u4:SetTitle("Pucci");
u4:SetStarterText("What do you want?");
u4:AddResponse("Give me standless", function() -- Line: 17
    -- upvalues: u4 (copy), u3 (copy)
    u4:SetText("Alright.");
    u3:GiveMeStandless();

    return "ClearResponses";
end);
u4:AddResponse("TWOH Quest", function() -- Line: 23
    -- upvalues: u2 (copy), u4 (copy)
    if u2:CheckDialogue("TWOH Quest"):expect() then
        u4:SetText("Good Luck");
    else
        u4:SetText("You already have the quest");
    end;

    return "ClearResponses";
end);
u4:AddResponse("C-Moon Quest", function() -- Line: 33
    -- upvalues: u2 (copy), u4 (copy)
    if u2:CheckDialogue("C-Moon Quest"):expect() then
        u4:SetText("Good Luck");
    else
        u4:SetText("You already have the quest");
    end;

    return "ClearResponses";
end);
u4:AddResponse("MIH Quest", function() -- Line: 43
    -- upvalues: u2 (copy), u4 (copy)
    if u2:CheckDialogue("MIH Quest"):expect() then
        u4:SetText("Good Luck");
    else
        u4:SetText("You already have the quest");
    end;

    return "ClearResponses";
end);

return u4;