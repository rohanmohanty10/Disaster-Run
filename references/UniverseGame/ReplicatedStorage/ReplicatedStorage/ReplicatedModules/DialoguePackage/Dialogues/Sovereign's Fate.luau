  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetCheckStep(function() -- Line: 20
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetText("Talk to me again when you have completed my tasks");

        return v5;
    end;

    if v5 == 3 then
        u4:SetText("It seems you have potential to obtain the power. Very well, I will now begin your training arc.\nCollect these items and craft into the <Color=Yellow>Sovereign\'s Chapter<Color=/> before returning to me.\n<Color=Cyan>Demonic Scroll - Obtained by defeating <Color=Red>The Hunter<Color=Cyan>\nFragment of Death - Obtained by defeating <Color=Red>Shadow Assassin<Color=Cyan>\nGodly Doctor\'s Poison - Combine <Color=Yellow>Monochromatic Orb + Kinetic Orb + Corrupted Arrow<Color=Cyan>\nHeavenly Nectar - Obtained through chests\nTales of the Universe - Obtained through chests\nCorrupted Soul - Obtained through chests<Color=/>");

        return v5;
    end;

    if v5 == 4 then
        u4:SetText("Did you craft the <Color=Yellow>Sovereign\'s Chapter<Color=/>?\nRemember you need to collect these items to craft it\n<Color=Cyan>Demonic Scroll - Obtained by defeating <Color=Red>The Hunter<Color=Cyan>\nFragment of Death - Obtained by defeating <Color=Red>Shadow Assassin<Color=Cyan>\nGodly Doctor\'s Poison - Combine <Color=Yellow>Monochromatic Orb + Kinetic Orb + Corrupted Arrow<Color=Cyan>\nHeavenly Nectar - Obtained through chests\nTales of the Universe - Obtained through chests\nCorrupted Soul - Obtained through chests<Color=/>");

        return v5;
    end;

    if v5 == 5 then
        u4:SetText("It seems you have crafted the chapter, all that is left is to challenge <Color=Red>Skibidi Noobie<Color=/> and <Color=Red>The Sovereign<Color=/>. Once you have defeated them be sure to return back to me and I will grant you the final item.");

        return v5;
    end;

    if v5 == 6 then
        u4:SetText("Have you challenged <Color=Red>Skibidi Noobie<Color=/> and <Color=Red>The Sovereign<Color=/>? Once you have defeated them be sure to return back to me and I will grant you the final item.");

        return v5;
    end;

    if v5 == 7 then
        u4:SetText("You really did it...\nTake this item <Color=Yellow>A New Fable<Color=/> and combine it with <Color=Yellow>Sovereign\'s Chapter<Color=/> to create <Color=Yellow>Sovereign\'s Sword.<Color=/>\nOnce that is crafted, use it on <Color=White>Standless<Color=/> to obtain <Color=Pink>Umbra<Color=/>.");
    end;

    return v5;
end);
u4:SetTitle("Umbra");
u4:SetStarterText("Is there something you need?");
u4:AddResponse("Teach me the power of sovereign", function(p6) -- Line: 55
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:SetText("Very well, first defeat some Skibidi Noobie Sect members");

    return "ClearResponses";
end);
u4:AddResponse("No", function() -- Line: 61
    -- upvalues: u4 (copy)
    u4:Destroy();
end);
u4:AddResponse("Understood", function() -- Line: 65
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:SetText("Show me the fruition of your labor");

    return "ClearResponses";
end):SetStep(3);
u4:AddResponse("Understood", function() -- Line: 71
    -- upvalues: u4 (copy)
    u4:SetText("Show me the fruition of your labor");

    return "ClearResponses";
end):SetStep(4);
u4:AddResponse("Understood", function() -- Line: 76
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:SetText("This will be start of your new fable");

    return "ClearResponses";
end):SetStep(5);
u4:AddResponse("Thank you for your teachings", function() -- Line: 82
    -- upvalues: u2 (copy)
    u2:CheckDialogue(script.Name):expect();

    return "ClearResponses";
end):SetStep(7);

return u4;