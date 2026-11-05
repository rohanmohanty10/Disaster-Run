  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetCheckStep(function() -- Line: 13
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetText("We have to keep searching! They have to be around here somewhere. Come back to me when you have all of my belongings in your Backpack (Hotbar)");

        return v5;
    end;

    if v5 == 3 then
        u4:SetText("Thank you so much! To compensate for your troubles I\'ll give you [Brickbattle]");
    end;

    return v5;
end);
u4:SetTitle("Builderman");
u4:SetStarterText("Hello! I could use some assistance.");
local v6 = u4:AddResponse("What happened?", function() -- Line: 26
    -- upvalues: u4 (copy)
    u4:SetText("During my travel here, I\'ve lost some of my belongings. Would you mind helping me find them?");

    return "Continue";
end);
u4:AddResponse("Goodbye", function() -- Line: 31
    -- upvalues: u4 (copy)
    u4:Destroy();
end);
v6:LinkResponse("Sure!", function() -- Line: 35
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:SetText("Thanks");

    return "ClearResponses";
end);
v6:LinkResponse("Goodbye", function() -- Line: 41
    -- upvalues: u4 (copy)
    u4:Destroy();
end);
u4:AddResponse("Okay", function() -- Line: 45
    -- upvalues: u2 (copy), u4 (copy)
    if u2:CheckDialogue(script.Name):expect() then
        u4:SetText("Thank you so much! To compensate for your troubles I\'ll give you [Brickbattle]");

        return "Continue";
    end;

    u4:Destroy();
end):SetStep(2):LinkResponse("Thank you!", function() -- Line: 54
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:Destroy();
end);
u4:AddResponse("Thank you!", function() -- Line: 59
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:Destroy();
end):SetStep(3);

return u4;