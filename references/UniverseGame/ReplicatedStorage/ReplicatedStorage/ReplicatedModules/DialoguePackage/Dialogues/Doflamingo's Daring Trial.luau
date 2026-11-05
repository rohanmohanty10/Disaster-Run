  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local _ = PathShortcuts.RemotesPath.UIOutput;
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();

local function GetStep(u5, u6) -- Line: 14
    return function(p7) -- Line: 15
        -- upvalues: u6 (copy), u5 (copy)
        return typeof(u6) == "table" and table.find(u6, u5) or u5 == u6;
    end;
end;

local LocalPlayer = game:GetService("Players").LocalPlayer;
u4:SetTitle("Doflamingo, The Joker");
u4:SetCheckStep(function(p8, p9) -- Line: 24
    -- upvalues: u3 (copy), u4 (copy)
    local v10 = u3:GetCurrentStep("Doflamingo\'s Daring Trial"):expect();

    if v10 == 2 then
        u4:SetText("Have you surprassed your swordsmanship potential yet?");

        return v10;
    end;

    if v10 == 3 then
        u4:SetText("The Worst Generation is the World Government\'s priority. Are you worthy of being a part of it?");

        return v10;
    end;

    if v10 == 4 then
        u4:SetText("Are you worthy of possesing the title of \'The Worst Generation\' yet?");

        return v10;
    end;

    if v10 == 5 then
        u4:SetText("I will now need you to gather me some materials that will prove helpful in my ruling of Dressrosa and SLIME research.");

        return v10;
    end;

    if v10 ~= 6 then
        if v10 == 7 then
            u4:SetText("Did I stutter? Return back to me when you have brought the 2.5 Million uCoins and Law\'s Cap.");
        end;

        return v10;
    end;

    if not (p8 and p9) then
        u4:SetText("Have you brought the materials I requested?");

        return v10;
    end;

    local v11 = p9 - p8;
    u4:SetText("Thank you for the corpse part." .. (v11 > 0 and `I still require {v11} more.` or " Thank you for all the corpse parts."));

    return "ClearResponses";
end);

function u4.Setup(p12, p13, p14) -- Line: 49
    -- upvalues: u4 (copy), u3 (copy), LocalPlayer (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p15) -- Line: 50
        table.clear(p15._Responses);
    end);

    if p13 and p14 then
        return "ClearResponses";
    end;

    local u16 = u3:GetCurrentStep("Doflamingo\'s Daring Trial"):expect() or 1;

    if LocalPlayer.Data.Ability:GetAttribute("AbilityLevel") < 200 and u16 == 1 then
        u4:SetText("I possess no need for weaklings. Scram. [NEEDS LEVEL 200 ABILITY EQUIPPED TO START THE QUEST]");

        return "ClearResponses";
    end;

    u4:SetText("Hey. I would say you got the potential. Do you have what it takes to take on the duty of The Surgeon of Death, though?");
    u4:AddResponse("Yes.", function() -- Line: 69
        -- upvalues: u4 (ref)
        u4:SetText("Then I have good news, as I possess the coveted Ope Ope Devil Fruit. If you can prove your worth, I may deem you ready to wield its mythical powers. You will need to go through a tough training, endure numerous dangers, face mighty warriors, and do me a few favors. That sit well with you?");

        return "Continue";
    end):SetStep(1):LinkResponse("I am ready.", function() -- Line: 72
        -- upvalues: u2 (ref), u4 (ref)
        u2:CheckDialogue("Doflamingo\'s Daring Trial"):expect();
        u4:SetText("Glad to hear that. The first step is learning to yield Kikoku. Do you have what it takes to wield the cursed sword? We shall see. Return back to me when you are done.");

        return "ClearResponses";
    end);
    u4:AddResponse("OK I FEEL THREATENED IM LEAVING", function() -- Line: 78
        -- upvalues: u4 (ref)
        u4:SetText("Scram fool.");

        return "ClearResponses";
    end):SetStep(1);
    u4:AddResponse("I am", function() -- Line: 103
        -- upvalues: u2 (ref), u4 (ref)
        u2:CheckDialogue("Doflamingo\'s Daring Trial"):expect();
        u4:SetText("I like your energy. Return back to me when you are done.");

        return "ClearResponses";
    end):SetStep(3);
    local u17 = { 2, 4, 6 };

    u4:AddResponse("Not yet.", function() -- Line: 109
        -- upvalues: u4 (ref)
        u4:SetText("Then what are you idling here for? Go.");

        return "ClearResponses";
    end).GetStep = function(p18) -- Line: 15
        -- upvalues: u17 (copy), u16 (copy)
        return typeof(u17) == "table" and table.find(u17, u16) or u16 == u17;
    end;

    u4:AddResponse("I shall do so.", function() -- Line: 136
        -- upvalues: u2 (ref), u4 (ref)
        u2:CheckDialogue("Doflamingo\'s Daring Trial"):expect();
        u4:SetText("Those resources won\'t collect themselves.");

        return "ClearResponses";
    end):SetStep(5);
    u4:AddResponse("I have.", function() -- Line: 143
        -- upvalues: u4 (ref)
        u4:SetText("Liar, get back to training.");

        return "ClearResponses";
    end):SetStep(6);
    u4:AddResponse("I have the goods right here.", function() -- Line: 159
        -- upvalues: u2 (ref), u4 (ref)
        local v19 = u2:CheckDialogue("Doflamingo\'s Daring Trial"):expect();

        if v19 == true then
            u4:SetText("You have earned this. Take this coveted Ope Ope No Mi Devil Fruit and make good use of it. I believe in you.");
        elseif typeof(v19) == "number" then
            u4:SetText(string.format("Liar, get back to work. You still need [%s more uCoins]", v19));
        else
            u4:SetText("Liar, you still need to bring me Law\'s Cap.");
        end;

        return "ClearResponses";
    end):SetStep(7);
    u4:AddResponse("I will not forget this.", function() -- Line: 173
        -- upvalues: u4 (ref)
        u4:SetText("Sounds good to me.");

        return "ClearResponses";
    end):SetStep(7);
end;

return u4;