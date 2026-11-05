  

 

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
        u4:SetText("Talk to me again when you have completed my tasks");

        return v5;
    end;

    if v5 == 3 then
        u4:SetText("It seems you have potential, very well let\'s duel to see your growth,\nthough you should bring teammates as I\'m quite strong");

        return v5;
    end;

    if v5 == 4 then
        u4:SetText("Hahaha, that was very fun, \nI\'ll teach you one of them if you have the item");
    end;

    return v5;
end);
u4:SetTitle("Umbra");
u4:SetStarterText("Is there something you need?");
u4:AddResponse("I heard you knew alot about sword styles, I wish to learn them", function(p6) -- Line: 28
    -- upvalues: u2 (copy), u4 (copy)
    if u2:CheckDialogue(script.Name):expect() then
        u4:SetText("It seems you\'ve come prepared for this, complete these tasks and return to me");

        return "ClearResponses";
    end;

    u4:SetText(string.format("This isn\'t free bud, you\'re gonna need [%s more uCoins]", 100000 - p6.Data.UCoins.Value));
end);
u4:AddResponse("No, sorry for bothering you", function() -- Line: 38
    -- upvalues: u4 (copy)
    u4:Destroy();
end);
u4:AddResponse("Thanks I\'ll be back", function() -- Line: 42
    -- upvalues: u4 (copy)
    u4:Destroy();
end):SetStep(2);
u4:AddResponse("I wish to be Unforgiven (YASUO)", function() -- Line: 46
    -- upvalues: u2 (copy), u4 (copy)
    local v7 = u2:CheckDialogue(script.Name, "Yasuo"):expect();

    if v7 == "InventoryFull" then
        u4:SetText("Your ability inventory is full. Come back to me when you have a free inventory slot.");

        return;
    end;

    if v7 then
        u4:Destroy();

        return;
    end;

    u4:SetText("You don\'t have [Ancient Sword] in your backpack");
end):SetStep(4);
u4:AddResponse("I wish to be Unforgotten (YONE)", function() -- Line: 56
    -- upvalues: u2 (copy), u4 (copy)
    local v8 = u2:CheckDialogue(script.Name, "Yone"):expect();

    if v8 == "InventoryFull" then
        u4:SetText("Your ability inventory is full. Come back to me when you have a free inventory slot.");

        return;
    end;

    if v8 then
        u4:Destroy();

        return;
    end;

    u4:SetText("You don\'t have [Azakana Mask] in your backpack");
end):SetStep(4);

return u4;