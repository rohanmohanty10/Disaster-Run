  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local LocalPlayer = game.Players.LocalPlayer;
local u4 = Dialogue.new();

local function GetStep(u5, u6) -- Line: 16
    return function(p7) -- Line: 17
        -- upvalues: u5 (copy), u6 (copy)
        return u5 == u6;
    end;
end;

u4:SetTitle("William Zeppeli");
u4:SetCheckStep(function() -- Line: 24
    -- upvalues: u3 (copy), u4 (copy)
    local v8 = u3:GetCurrentStep("Jonathan\'s Informant"):expect();

    if v8 == 2 or v8 == 3 then
        u4:SetText("Have you taken care of the Hooligans at the Port like I\'ve asked you to?");

        return v8;
    end;

    if v8 == 4 then
        u4:SetText("Do you have the space to hold this letter of referral?");
    end;

    return v8;
end);

function u4.Setup(p9) -- Line: 34
    -- upvalues: u4 (copy), LocalPlayer (copy), u3 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p10) -- Line: 35
        table.clear(p10._Responses);
    end);
    local Value = LocalPlayer.Data.Ability.Value;

    if Value ~= 22 and (Value ~= 1300 and Value ~= 19) then
        u4:SetText("You don\'t seem like no hamon user. Get away from here.");

        return;
    end;

    local u11 = u3:GetCurrentStep("Jonathan\'s Informant"):expect() or 1;
    u4:SetText("You seem like a fellow Hamon user. Are you a Hamon user?");
    local u12 = 1;

    u4:AddResponse("Yes, I just got done training my Base Hamon. I learned it from the Hamon Trainer.", function() -- Line: 45
        -- upvalues: u4 (ref)
        u4:SetText("What brings you here to me then?");

        return "Continue";
    end):LinkResponse("I wanna further learn my Hamon. Do you by chance know if I\'m able to learn anymore styles from anyone else? Like you?", function() -- Line: 48
        -- upvalues: u4 (ref)
        u4:SetText("Hmmm.. I follow Base Hamon training too. I don\'t have much uniqueness in my style worth learning but... Got it. I know a guy. Name\'s Jonathan.");

        return "Continue";
    end):LinkResponse("Jonathan? Oh yeah sure how can I get to him?", function() -- Line: 51
        -- upvalues: u4 (ref)
        u4:SetText("Well, the problem is not getting to him. It\'s you. I need you to prove it\'s worth getting to him.");

        return "Continue";
    end):LinkResponse("How do you expect for me to do that then?", function() -- Line: 54
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Defeat 10 Hooligans at the port for me. Come talk to me when you\'re done.");
        u2:CheckDialogue("Jonathan\'s Informant"):expect();

        return "ClearResponses";
    end).GetStep = function(p13) -- Line: 17
        -- upvalues: u11 (copy), u12 (copy)
        return u11 == u12;
    end;

    local u14 = 1;

    u4:AddResponse("Nah, I\'m not a fellow Hamon user.", function() -- Line: 62
        -- upvalues: u4 (ref)
        u4:SetText("You sure? You seem like one. Whatever, probably a waste of my time anyway.");

        return "ClearResponses";
    end).GetStep = function(p15) -- Line: 17
        -- upvalues: u11 (copy), u14 (copy)
        return u11 == u14;
    end;

    local u16 = 2;

    u4:AddResponse("Yes I\'ve taken care of them.", function() -- Line: 68
        -- upvalues: u4 (ref)
        u4:SetText("Liar.. I know you haven\'t taken care of them. You don\'t even look beat up at all. Come to me when you have.");

        return "ClearResponses";
    end).GetStep = function(p17) -- Line: 17
        -- upvalues: u11 (copy), u16 (copy)
        return u11 == u16;
    end;

    local v18 = u4:AddResponse("Yes I\'ve taken care of them.", function() -- Line: 74
        -- upvalues: u4 (ref)
        u4:SetText("Very well. Now I just need a payment. Consider this a payment of service. I\'ll need 375,000 UCoins.");

        return "Continue";
    end);
    v18:LinkResponse("Okay, I have the money here.", function() -- Line: 78
        -- upvalues: u2 (ref), u4 (ref), LocalPlayer (ref)
        if u2:CheckDialogue("Jonathan\'s Informant"):expect() then
            u4:SetText("Very well! I\'m going to give you some time to make sure you have a free slot in your inventory before attempting to hand it over to you first.");

            return "ClearResponses";
        end;

        u4:SetText(string.format("Is this all? I need more. You need [%s more uCoins]", 375000 - LocalPlayer.Data.UCoins.Value));

        return "ClearResponses";
    end);
    local u19 = 3;

    function v18.GetStep(p20) -- Line: 17
        -- upvalues: u11 (copy), u19 (copy)
        return u11 == u19;
    end;

    local u21 = 4;

    u4:AddResponse("Yes I do.", function() -- Line: 90
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Jonathan\'s Informant"):expect() then
            u4:SetText("Very well! Take this letter and go look for Jonathan. He\'ll teach you his style.");
        else
            u4:SetText("I need you to clear up your inventory. Please go clear your inventory first before attempting to take this letter.");
        end;

        return "ClearResponses";
    end).GetStep = function(p22) -- Line: 17
        -- upvalues: u11 (copy), u21 (copy)
        return u11 == u21;
    end;
end;

return u4;