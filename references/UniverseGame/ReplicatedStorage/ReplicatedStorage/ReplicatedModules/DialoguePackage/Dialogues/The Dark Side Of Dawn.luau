  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetCheckStep(function() -- Line: 13
    -- upvalues: u3 (copy), u4 (copy), u2 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetText("Come back once you\'ve completed my tasks");

        return v5;
    end;

    if v5 ~= 3 then
        if v5 == 4 then
            u4:SetTitle("Dawn Sword");
            u4:SetText("Do you wish to pull out the sword?");
        end;

        return v5;
    end;

    u4:SetText("Good work, I deem you worthy of the power, now scram!");
    u2:CheckDialogue(script.Name);

    return v5;
end);
u4:BindNPC(1, "StucksDucks", {
    ["Dawn Sword"] = "You are not worthy"
});
u4:BindNPC(2, "StucksDucks", {
    ["Dawn Sword"] = "You are not worthy"
});
u4:BindNPC(3, "StucksDucks", {
    ["Dawn Sword"] = "You are not worthy"
});
u4:BindNPC(
    4,
    "Dawn Sword",
    {
        StucksDucks = "Why are you back here? Do you plan on not obtaining the sword?"
    }
);
u4:SetStarterTitle("StucksDucks");
u4:SetStarterText("Hmph, what do you want?");
u4:AddResponse("I\'ve come to obtain Dawn", function() -- Line: 43
    -- upvalues: u2 (copy), u4 (copy)
    if u2:CheckDialogue(script.Name):expect() then
        u4:SetText("Heh, very well I\'ll teach you the ways, complete these 3 tasks and come back to me");
    else
        u4:SetText("I have nothing to teach you, bring the book next time (Book must be in Item Inventory)");
    end;

    return "ClearResponses";
end);
u4:AddResponse("Sorry for bothering you", function() -- Line: 53
    -- upvalues: u4 (copy)
    u4:Destroy();
end);
u4:AddResponse("Yes", function() -- Line: 57
    -- upvalues: u2 (copy)
    u2:CheckDialogue(script.Name);

    return "ClearResponses";
end):SetStep(4);
u4:AddResponse("No", function() -- Line: 62
    -- upvalues: u4 (copy)
    u4:Destroy();
end):SetStep(4);

return u4;