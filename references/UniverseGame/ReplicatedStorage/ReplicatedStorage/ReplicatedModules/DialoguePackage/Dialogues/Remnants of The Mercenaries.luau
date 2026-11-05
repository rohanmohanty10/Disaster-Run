  

 

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
        u4:SetText("Once you have all items in your inventory & have taken out The Spy, come back to me.");

        return v5;
    end;

    if v5 == 3 then
        u4:SetText("You\'ve done well, Soldier. Let me put somethin\' together for ya real quick..");
    end;

    return v5;
end);
u4:SetTitle("skaidev");
u4:SetStarterText("YOU! You look like a proper hitman, do you take hires?");
local v6 = u4:AddResponse("Depends", function() -- Line: 26
    -- upvalues: u4 (copy)
    u4:SetText("That bloody Spy has taken my weaponry, I\'ll hire you to take him out and retrieve whats rightfully mine!");

    return "Continue";
end);
u4:AddResponse("No", function() -- Line: 31
    -- upvalues: u4 (copy)
    u4:Destroy();
end);
v6:LinkResponse("What\'s the pay?", function() -- Line: 35
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:SetText("I\'ll see when that happens, now scram! Find me my weaponry pronto. [Make sure to have Inventory Space in Abilities upon completion]");

    return "ClearResponses";
end);
v6:LinkResponse("Not my cup of tea", function() -- Line: 41
    -- upvalues: u4 (copy)
    u4:Destroy();
end);
u4:AddResponse("Okay", function() -- Line: 45
    -- upvalues: u2 (copy), u4 (copy)
    local v7, v8 = u2:CheckDialogue(script.Name):expect();

    if v7 == "SPYALIVE" then
        u4:SetText("That spy is still alive and runnin\' around with my weaponry! What are you doing?");
    elseif v7 == "NOITEM" then
        u4:SetText((`That spy may be eliminated, but you do not hold all of the weaponry he took from my hands!\n[MISSING ITEMS: {table.concat(v8, ", ")}]`));
    elseif v7 == "INVFULL" then
        u4:SetText("You\'ve done well, Soldier, though it seems you have enough on your plate. Come back to me when you\'re not carrying other weaponry around.\n[REMOVE SOMETHING FROM YOUR ABILITY INVENTORY TO CONTINUE]");
    else
        u4:SetText("You\'ve done well, Soldier. Let me put somethin\' together for ya real quick..");
    end;

    return v7 == true and "Continue" or "ClearResponses";
end):SetStep(2):LinkResponse("Pleasure doing business", function() -- Line: 59
    -- upvalues: u4 (copy)
    u4:Destroy();
end);
u4:AddResponse("Pleasure doing business", function() -- Line: 63
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:Destroy();
end):SetStep(3);

return u4;