  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local _ = game.Players.LocalPlayer;
local u4 = Dialogue.new();

local function GetStep(u5, u6) -- Line: 16
    return function(p7) -- Line: 17
        -- upvalues: u5 (copy), u6 (copy)
        return u5 == u6;
    end;
end;

u4:SetCheckStep(function() -- Line: 22
    -- upvalues: u3 (copy)
    return u3:GetCurrentStep("Straw Hat\'s Destiny"):expect();
end);
u4:SetTitle("Shanks");
u4:SetStarterText("Unless you got no business with me, what can I do for you?");

function u4.Setup(p8) -- Line: 30
    -- upvalues: u4 (copy), u3 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p9) -- Line: 31
        table.clear(p9._Responses);
    end);
    local u10 = u3:GetCurrentStep("Straw Hat\'s Destiny"):expect() or 1;
    local u11 = 1;

    u4:AddResponse("What\'s in that chest you got next to you?", function() -- Line: 38
        -- upvalues: u4 (ref)
        u4:SetText("Not that it\'s much of your concern honestly, but I\'ll say it has something that has the capability to provide you some form of power.");

        return "Continue";
    end):SetStep(1):LinkResponse("What kinds of power does it provide?", function() -- Line: 41
        -- upvalues: u4 (ref)
        u4:SetText("The power comes from a Devil Fruit. More specifically, from the <Color=Lilac><AnimateStyle=Wiggle><AnimateStepFrequency=1><AnimateStyleTime=2>Gomu Gomu No Mi<AnimateStyle=/><AnimateStepFrequency=/><AnimateStyleTime=/><Color=/><TextScale=/> Devil Fruit.");

        return "Continue";
    end):SetStep(1):LinkResponse("I see. Is there anyway I can get it from you?", function() -- Line: 44
        -- upvalues: u4 (ref)
        u4:SetText("No you can not just take the fruit. If you eat this fruit, you may gain powers but you lose your ability to swim. Also, I do not believe you are trustworthy of this fruit.");

        return "Continue";
    end):SetStep(1):LinkResponse("Come on! There\'s gotta be a way that you give me that fruit.", function() -- Line: 48
        -- upvalues: u4 (ref)
        u4:SetText("Persistent aren\'t you? I\'ll tell you what. I\'m here in Orange Town mostly because someone I used to be friends and crewmates with, Buggy, currently stations his crew here. He has built a lot of resentment towards me for a while now. Tell you what, help me by taking out 20 of his pirates around here and we cut a deal you hear me?");

        return "Continue";
    end):SetStep(1):LinkResponse("Yeah sure! I\'ll be back in no time trust me.", function() -- Line: 51
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Don\'t worry, I don\'t have anywhere to be right now.");
        u2:CheckDialogue("Straw Hat\'s Destiny"):expect();

        return "ClearResponses";
    end).GetStep = function(p12) -- Line: 17
        -- upvalues: u10 (copy), u11 (copy)
        return u10 == u11;
    end;

    local u13 = 2;

    u4:AddResponse("I\'ve defeated the 20 pirates that you asked me to.", function() -- Line: 59
        -- upvalues: u4 (ref)
        u4:SetText("I still see a lot around here. Maybe you\'re not so serious after all. Come back to me when you\'ve ACTUALLY done what I asked you to do.");

        return "ClearResponses";
    end).GetStep = function(p14) -- Line: 17
        -- upvalues: u10 (copy), u13 (copy)
        return u10 == u13;
    end;

    local u15 = 3;

    u4:AddResponse("I\'ve defeated the 20 pirates that you asked me to.", function() -- Line: 65
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Great, great. However, you have seem to have aggravated Buggy. I heard him yelling at his men to scatter around and find out who\'s shortening his crew size. I\'ll tell you what, I was going to have you do more but if you can defeat Buggy, I see you fit of acquiring this fruit. Return back to me once you have done that.");
        u2:CheckDialogue("Straw Hat\'s Destiny"):expect();

        return "ClearResponses";
    end).GetStep = function(p16) -- Line: 17
        -- upvalues: u10 (copy), u15 (copy)
        return u10 == u15;
    end;

    local u17 = 4;

    u4:AddResponse("I\'ve defeated Buggy.", function() -- Line: 73
        -- upvalues: u4 (ref)
        u4:SetText("Doesn\'t seem like it. His bounty still exists meaning nobody has defeated him at all. Don\'t lie to me and come back when you actually defeat him.");

        return "ClearResponses";
    end).GetStep = function(p18) -- Line: 17
        -- upvalues: u10 (copy), u17 (copy)
        return u10 == u17;
    end;

    local u19 = 5;

    u4:AddResponse("I\'ve defeated Buggy.", function() -- Line: 80
        -- upvalues: u2 (ref), u4 (ref)
        local v20 = u2:CheckDialogue("Straw Hat\'s Destiny"):expect();

        if v20 then
            if v20 == "ClearSpace" then
                u4:SetText("As much as I\'d be willing to give you this fruit, it seems I can\'t. Clear out a spot in your ITEMS INVENTORY so I can give it to you.");
            else
                u4:SetText("You surprise me a lot. I sent you into that battle assuming you wouldn\'t come back. Seems you are stronger than I thought. A deals a deal, take the fruit and remember what I told you about it.");
            end;
        end;

        return "ClearResponses";
    end).GetStep = function(p21) -- Line: 17
        -- upvalues: u10 (copy), u19 (copy)
        return u10 == u19;
    end;
end;

return u4;