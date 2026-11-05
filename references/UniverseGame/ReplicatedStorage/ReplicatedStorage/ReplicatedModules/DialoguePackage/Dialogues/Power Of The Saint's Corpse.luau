  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();

local function ResetDialogue() -- Line: 13
    -- upvalues: u4 (copy)
    u4:Destroy();
end;

u4:SetCheckStep(function() -- Line: 17
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetText("Only come back to me once you\'ve completed what I demand of you, my new subordinate.");

        return v5;
    end;

    if v5 == 3 then
        u4:SetText("You\'re pretty good at this, there\'s only one final task left:\n The criminal, Diavolo, is out on the loose, and carrying the saint\'s skull. Kill him and use the skull.");

        return v5;
    end;

    if v5 == 4 then
        u4:SetText("Seems you made quick work of Diavolo, \nNow, let me show you how to use this corpse...");
    end;

    return v5;
end);
u4:SetTitle("Funny Valentine");
u4:SetStarterText("Is there something you need?");
u4:AddResponse("I\'m interested in becoming your apprentice... \n⚠ PRICE: 500,000 UCOINS ⚠", function() -- Line: 32
    -- upvalues: u2 (copy), u4 (copy)
    local v6 = u2:CheckDialogue(script.Name):expect();

    if v6 == true then
        u4:SetText("I see how it is. Let\'s start our deal. Find and use these corpse parts and come back to me for a final task.");

        return "Continue";
    end;

    if type(v6) == "number" then
        u4:SetText(string.format("My time is money. Get the cash before we can even consider talking! [%s more uCoins]", v6));
    end;

    return "ClearResponses";
end):LinkResponse("Thanks I\'ll be back", ResetDialogue);
u4:AddResponse("No, sorry for bothering you", ResetDialogue);
u4:AddResponse("I will accept the power of the corpse.\n [Gives Saint\'s Corpse] (Use on D4C)", function() -- Line: 45
    -- upvalues: u2 (copy), u4 (copy)
    local v7 = u2:CheckDialogue(script.Name):expect();
    print(v7);
    u4:Destroy();
end):SetStep(4);

return u4;