  

 

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

u4:SetTitle("Jonathan Joestar");
u4:SetCheckStep(function() -- Line: 24
    -- upvalues: u3 (copy), u4 (copy)
    local v8 = u3:GetCurrentStep("Learning Jonathan\'s Style"):expect();

    if v8 == 2 or v8 == 3 then
        u4:SetText("Did you take care of Dio\'s Zombie henchmen like I asked you to?");

        return v8;
    end;

    if v8 == 4 then
        u4:SetText("Are you ready to battle me? Keep in mind that this will determine if you will be able to beat me or not.");

        return v8;
    end;

    if v8 == 5 then
        u4:SetText("...");

        return v8;
    end;

    if v8 == 6 or v8 == 7 then
        u4:SetText("Did you defeat him? Did you finally put an end to Dio Brando?");
    end;

    return v8;
end);

function u4.Setup(p9) -- Line: 38
    -- upvalues: u4 (copy), LocalPlayer (copy), u3 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p10) -- Line: 39
        table.clear(p10._Responses);
    end);

    if LocalPlayer.Data.Ability.Value ~= 22 then
        u4:SetText("Sorry, I can\'t help you right now. I\'m in the middle of an emergency.");

        return;
    end;

    local u11 = u3:GetCurrentStep("Learning Jonathan\'s Style"):expect() or 1;
    u4:SetText("Hey! You\'re a hamon user aren\'t ya? What brings you to me?");
    local u12 = 1;

    u4:AddResponse("I was referred here by a guy called William Zeppeli.", function() -- Line: 49
        -- upvalues: u4 (ref)
        u4:SetText("Oh now were you? He gives an item you\'re supposed to give to me if so. Do you have it?");

        return "Continue";
    end):LinkResponse("Yes, I have it right there.", function() -- Line: 52
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Learning Jonathan\'s Style"):expect() then
            u4:SetText("Very well. I need your help then. I need to make sure you\'re willing to be committed to this. I have a, well... Used to consider him my brother. He\'s obtained the power of a vampire and has his own minions running around now. They\'re zombies, literally. Defeat 15 of them to prove you are capable of utilizing your Base Hamon techniques.");
        else
            u4:SetText("No you do not. I do not see it in your inventory. Come back to me when you have it. Talk to a man named William Zeppeli.");
        end;

        return "ClearResponses";
    end).GetStep = function(p13) -- Line: 17
        -- upvalues: u11 (copy), u12 (copy)
        return u11 == u12;
    end;

    local u14 = 1;

    u4:AddResponse("Sorry, didn\'t mean to strke conversation.", function() -- Line: 63
        -- upvalues: u4 (ref)
        u4:SetText("Who just goes up to someone random to talk to them just to walk away? Ok then.");

        return "ClearResponses";
    end).GetStep = function(p15) -- Line: 17
        -- upvalues: u11 (copy), u14 (copy)
        return u11 == u14;
    end;

    local u16 = 2;

    u4:AddResponse("Yes I took care of the zombies like you asked me to.", function() -- Line: 69
        -- upvalues: u4 (ref)
        u4:SetText("Have you? I don\'t think so. Last time I went back to check, seems like a couple were left. Come back to me once you\'re serious about taking them all out.");

        return "ClearResponses";
    end).GetStep = function(p17) -- Line: 17
        -- upvalues: u11 (copy), u16 (copy)
        return u11 == u16;
    end;

    local v18 = u4:AddResponse("Yes I took care of the zombies like you asked me to.", function() -- Line: 75
        -- upvalues: u4 (ref)
        u4:SetText("Sweet. Alright then. I\'m not too sure what else I can have you prove as for I had to learn this quick myself too. You know what. I want you to help me fight Dio Brando.");

        return "Continue";
    end);
    v18:LinkResponse("Oh? Just fight the vampire? That\'s it? If it\'s tag team we can for sure take him down.", function() -- Line: 79
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Well, here\'s the thing. I want you to do it yourself. If you can not beat someone like him, you can\'t really keep up with my style. In order to prove yourself first, you need to fight me using your Base Hamon techniques. Come talk to me once you\'re ready to fight me.");
        u2:CheckDialogue("Learning Jonathan\'s Style"):expect();

        return "ClearResponses";
    end);
    local u19 = 3;

    function v18.GetStep(p20) -- Line: 17
        -- upvalues: u11 (copy), u19 (copy)
        return u11 == u19;
    end;

    local u21 = 4;

    u4:AddResponse("Yes I\'m ready to battle you.", function() -- Line: 86
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Learning Jonathan\'s Style"):expect() then
            u4:SetText("Take this summon signal. When you\'re ready, head to the arena and summon me there. When you\'ve beaten me, return back and chat with me. Good luck.");
        else
            u4:SetText("Seems like you have to either clear an inventory slot or you\'re equipped with the signal already. Double check first, then determine what to do after.");
        end;

        return "ClearResponses";
    end).GetStep = function(p22) -- Line: 17
        -- upvalues: u11 (copy), u21 (copy)
        return u11 == u21;
    end;

    local u23 = 4;

    u4:AddResponse("No, I need some more time to think about it.", function() -- Line: 97
        -- upvalues: u4 (ref)
        u4:SetText("Sounds good then. No pressure, but don\'t wait too long. Not sure how much longer he plans to wait before he attempts havoc.");

        return "ClearResponses";
    end).GetStep = function(p24) -- Line: 17
        -- upvalues: u11 (copy), u23 (copy)
        return u11 == u23;
    end;

    local u25 = 5;

    u4:AddResponse("...", function() -- Line: 103
        -- upvalues: u2 (ref), u4 (ref)
        local v26 = u2:CheckDialogue("Learning Jonathan\'s Style"):expect();

        if v26 then
            if v26 == "ClearSpace" then
                u4:SetText("You were a lot better than I thought. Although, to proceed on I need you to clear an inventory slot in your items. Please do so then talk to me again.");
            else
                u4:SetText("You were a lot better than I thought. Almost a warrior. Alright. We can move on then. For your final task, I\'ll need you to fight Dio Brando. Find Hecate, and you\'ll be given a contract to finish off Dio once and for all. Don\'t come back until you\'ve beaten him.");
            end;
        else
            u4:SetText("Seems like you haven\'t beaten me yet. I\'ll give you another signal if you\'ve lost your current one. Please return to me once you have beaten me.");
        end;

        return "ClearResponses";
    end).GetStep = function(p27) -- Line: 17
        -- upvalues: u11 (copy), u25 (copy)
        return u11 == u25;
    end;

    for i = 6, 7 do
        u4:AddResponse("Yes, I believe I put an end to Dio Brando.", function() -- Line: 119
            -- upvalues: u2 (ref), u4 (ref)
            local v28 = u2:CheckDialogue("Learning Jonathan\'s Style"):expect();

            if v28 then
                if v28 == "ClearSpace" then
                    u4:SetText("I need you to clear a slot in your ability inventory before we can proceed any further.");
                else
                    u4:SetText("Very well then. A promise is a promise. I will teach you my style. Take it and I\'ll hopefully see you around soon. Thanks for everything.");
                end;
            else
                u4:SetText("I\'ve been told by a friend of mine that he hasn\'t been taken down yet and still spots him runnin\' around wreaking havoc. You should get to him and stop him before you talk to me. Hecate will give you further instructions.");
            end;

            return "ClearResponses";
        end).GetStep = function(p29) -- Line: 17
            -- upvalues: u11 (copy), i (copy)
            return u11 == i;
        end;

        u4:AddResponse("No, I have not defeated him yet.", function() -- Line: 134
            -- upvalues: u4 (ref)
            u4:SetText("Have you attempted to at least? Come on.. You have to take this guy down before anything else bad happens.");

            return "ClearResponses";
        end).GetStep = function(p30) -- Line: 17
            -- upvalues: u11 (copy), i (copy)
            return u11 == i;
        end;
    end;
end;

return u4;