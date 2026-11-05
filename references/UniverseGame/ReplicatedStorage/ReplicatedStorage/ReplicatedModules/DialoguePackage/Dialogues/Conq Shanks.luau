  

 

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
    return u3:GetCurrentStep("Shank\'s Gryphon"):expect();
end);
u4:SetTitle("Shanks");
u4:SetStarterText("Unless you got no business with me, what can I do for you?");

function u4.Setup(p8) -- Line: 30
    -- upvalues: u4 (copy), u3 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p9) -- Line: 31
        table.clear(p9._Responses);
    end);
    local u10 = u3:GetCurrentStep("Shank\'s Gryphon"):expect() or 1;
    local u11 = 1;

    u4:AddResponse("I see you wield a sword, what techniques do you know?", function() -- Line: 37
        -- upvalues: u4 (ref)
        u4:SetText("Ah my sword. Well, I call it Gryphon. But I\'ve had it for a while now. What bothers you to know?");

        return "Continue";
    end):SetStep(1):LinkResponse("I have a sword ability myself too. However, I\'ve been looking to further my techniques and I\'m wondering if you can teach me?", function() -- Line: 40
        -- upvalues: u4 (ref)
        u4:SetText("Okay, but if you have a sword ability you will HAVE TO USE IT for every single task I provide to you. Use the following listed: Yone, Yasuo, Shadow, Dawn, Umbra, Anubis and Candy Cutlass. Any other ability will NOT work.");

        return "Continue";
    end):SetStep(1):LinkResponse("Sounds good, I think I\'m ready to learn new techniques.", function() -- Line: 43
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("For your first task, I need you to help me out around here. Slay 20 Pirates around here and I\'ll see if you\'re fit enough to learn my technique. This will also allow you to practice with your current sword.");
        u2:CheckDialogue("Shank\'s Gryphon"):expect();

        return "Continue";
    end):SetStep(1):LinkResponse("Gotcha. I\'ll be back soon!", function() -- Line: 47
        -- upvalues: u4 (ref)
        u4:SetText("Alright, we\'ll see hopefully.");

        return "ClearResponses";
    end).GetStep = function(p12) -- Line: 17
        -- upvalues: u10 (copy), u11 (copy)
        return u10 == u11;
    end;

    local u13 = 2;

    u4:AddResponse("I\'ve defeated the pirates like you told me to.", function() -- Line: 53
        -- upvalues: u4 (ref)
        u4:SetText("Hmm.. It still looks like there isn\'t lesser of them since we spoke. When you clear it up more, come speak to me then.");

        return "ClearResponses";
    end).GetStep = function(p14) -- Line: 17
        -- upvalues: u10 (copy), u13 (copy)
        return u10 == u13;
    end;

    local u15 = 3;

    u4:AddResponse("I\'ve defeated the pirates like you told me to.", function() -- Line: 59
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("It seems as it has cleared enough around here. Great job. Now, for your next task... Well, it\'s more of a personal request but can you bring me some West Blue Juice? Been craving it for a while now.");
        u2:CheckDialogue("Shank\'s Gryphon"):expect();

        return "Continue";
    end):SetStep(3):LinkResponse("Uhhh yeah sure... West Blue Juice", function() -- Line: 63
        -- upvalues: u4 (ref)
        u4:SetText("Great. I expect to see you back here with it. Don\'t come back till then.");

        return "ClearResponses";
    end).GetStep = function(p16) -- Line: 17
        -- upvalues: u10 (copy), u15 (copy)
        return u10 == u15;
    end;

    local u17 = 4;

    u4:AddResponse("I\'ve brought you your West Blue Juice.", function() -- Line: 69
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Shank\'s Gryphon"):expect() then
            u4:SetText("Perfect, now I\'ve heard that my old crewmate and best friend, Buggy is in Orange Town with his crew. He has some resent built towards me but I don\'t got the time to sort it out with a fool like him. Tell you what, you go over there and defeat him and we\'ll talk further.");
            u2:CheckDialogue("Shank\'s Gryphon"):expect();
        else
            u4:SetText("Well? You gonna hand it to me? Oh, you\'re just wasting my time. Like I\'ve said, till you get it, do not come back.");
        end;

        return "ClearResponses";
    end).GetStep = function(p18) -- Line: 17
        -- upvalues: u10 (copy), u17 (copy)
        return u10 == u17;
    end;

    local u19 = 5;

    u4:AddResponse("I\'ve defeated Buggy.", function() -- Line: 81
        -- upvalues: u4 (ref)
        u4:SetText("Doesn\'t seem like it. His bounty still exists meaning nobody has defeated him at all. Don\'t lie to me and come back when you actually defeat him.");

        return "ClearResponses";
    end).GetStep = function(p20) -- Line: 17
        -- upvalues: u10 (copy), u19 (copy)
        return u10 == u19;
    end;

    local u21 = 6;

    u4:AddResponse("I\'ve defeated Buggy.", function() -- Line: 88
        -- upvalues: u4 (ref)
        u4:SetText("His bounty has seem to have vanished along with him. Hmph, you are a lot better than I anticipated. Tell you what. I want you to fight me. If you fight me and beat me using one of the sword abilities I previously mentioned, I\'ll reward ya\' with a custom made manual book for you. Will teach you all the techniques I know. Do you agree?");

        return "Continue";
    end):SetStep(6):LinkResponse("Yes, I do agree to those conditions.", function() -- Line: 91
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Okay. I look forward to it. Let\'s see how you can perform against me.");
        u2:CheckDialogue("Shank\'s Gryphon"):expect();

        return "ClearResponses";
    end).GetStep = function(p22) -- Line: 17
        -- upvalues: u10 (copy), u21 (copy)
        return u10 == u21;
    end;

    local u23 = 7;

    u4:AddResponse("...", function() -- Line: 99
        -- upvalues: u4 (ref)
        u4:SetText("(YOU HAVE NOT BEAT SHANKS YET, RETURN ONCE YOU HAVE SLAIN SHANKS)");

        return "ClearResponses";
    end).GetStep = function(p24) -- Line: 17
        -- upvalues: u10 (copy), u23 (copy)
        return u10 == u23;
    end;

    local u25 = 8;

    u4:AddResponse("...", function() -- Line: 106
        -- upvalues: u2 (ref), u4 (ref)
        local v26 = u2:CheckDialogue("Shank\'s Gryphon"):expect();

        if v26 then
            if v26 == "ClearSpace" then
                u4:SetText("As much as I\'d be willing to give you this manual, it seems I can\'t. Clear out a spot in your ITEMS INVENTORY so I can give it to you.");
            else
                u4:SetText("I\'ve underestimated you by a lot. Surprised you didn\'t kill me after everything I put you through. You\'ve earned it. Take this manual. Use it on yourself. (BEWARE THAT IT REPLACES YOUR CURRENT ABILITY)");
            end;
        end;

        return "ClearResponses";
    end).GetStep = function(p27) -- Line: 17
        -- upvalues: u10 (copy), u25 (copy)
        return u10 == u25;
    end;
end;

return u4;