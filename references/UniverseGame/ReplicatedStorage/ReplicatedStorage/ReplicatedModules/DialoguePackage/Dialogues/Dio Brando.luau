  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();

local function GetStep(u5, u6) -- Line: 13
    return function(p7) -- Line: 14
        -- upvalues: u5 (copy), u6 (copy)
        return u5 == u6;
    end;
end;

u4:SetTitle("Dio Brando");
u4:SetStarterText("If you have no reason to be speaking with me, I\'d suggest you walk away.");
u4:SetCheckStep(function() -- Line: 22
    -- upvalues: u3 (copy), u4 (copy)
    local v8 = u3:GetCurrentStep("Road To Immortality"):expect();

    if v8 == 2 then
        u4:SetText("Did you find the mask I asked you to find?");

        return v8;
    end;

    if v8 == 3 then
        u4:SetText("Do you have the vial of blood that I asked you to get?");

        return v8;
    end;

    if v8 == 4 then
        u4:SetText("Are you ready to pour the blood on the mask? There\'s no going back. \nMAKE SURE YOU HAVE DO NOT HAVE AN ABILITY EQUIPPED THAT YOU WANT.");
    end;

    return v8;
end);

function u4.Setup(p9) -- Line: 34
    -- upvalues: u4 (copy), u3 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p10) -- Line: 35
        table.clear(p10._Responses);
    end);
    local u11 = u3:GetCurrentStep("Road To Immortality"):expect() or 1;
    local u12 = 1;

    u4:AddResponse("Well, I was just curious to who you were but alright..", function() -- Line: 41
        -- upvalues: u4 (ref)
        u4:SetText("Interested in someone like me? We don\'t even know each other..?");

        return "Continue";
    end):LinkResponse("Well.. Random dude standing around here like nothing is going on.. Say, you look a bit pale. You a Vampire?", function() -- Line: 44
        -- upvalues: u4 (ref)
        u4:SetText("People like you who have lucky guesses really gets on my nerves.. Sure, I\'m a Vampire. What\'s it to you?");

        return "Continue";
    end):LinkResponse("Sweet, I\'m a little interested in learning the ways of how I can obtain powers like you.", function() -- Line: 47
        -- upvalues: u4 (ref)
        u4:SetText("Kid, even I struggled to accept it at first. I don\'t do teaching. However... you\'d make a good henchma- actually. Let\'s do it. You need to prove it to me first that you\'re capable of these things.");

        return "Continue";
    end):LinkResponse("Great! What shall I do then?", function() -- Line: 50
        -- upvalues: u4 (ref)
        u4:SetText("Find me my vampire mask. It should look very distinctive and you can not miss it. Has a rock/concrete texture on it.");

        return "Continue";
    end):LinkResponse("Is that all?", function() -- Line: 53
        -- upvalues: u4 (ref)
        u4:SetText("......");

        return "Continue";
    end):LinkResponse("I\'m guessing that\'s a ye-", function() -- Line: 56
        -- upvalues: u2 (ref), u4 (ref)
        u2:CheckDialogue("Road To Immortality"):expect();
        u4:SetText("MORON!! GET TO IT BEFORE I CHANGE MY MIND.");

        return "ClearResponses";
    end).GetStep = function(p13) -- Line: 14
        -- upvalues: u11 (copy), u12 (copy)
        return u11 == u12;
    end;

    local u14 = 1;

    u4:AddResponse("Damn alright.. Sorry for the bother then.", function() -- Line: 64
        -- upvalues: u4 (ref)
        u4:SetText("Scram.");

        return "ClearResponses";
    end).GetStep = function(p15) -- Line: 14
        -- upvalues: u11 (copy), u14 (copy)
        return u11 == u14;
    end;

    local v17 = u4:AddResponse("Yeah, I\'ve found the mask you described.", function() -- Line: 70
        -- upvalues: u2 (ref), u4 (ref)
        local v16 = u2:CheckRequirement("ItemCountCheck", "ITEM_73"):expect();

        if typeof(v16) ~= "number" or v16 <= 0 then
            u4:SetText("You aren\'t lying to me are you? Oh? You don\'t have it? Well I guess you wouldn\'t mind if I just took your blood right? Find me it for real and don\'t come back till you do.");

            return "ClearResponses";
        end;

        u2:CheckDialogue("Road To Immortality"):expect();
        u4:SetText("You\'re more persistent than I thought. Well. Great job then. Next I need you to uhhh... Locate some blood. I had a guy scavenge some vials of blood that I had forced him to collect from people, but let\'s say he never returned and they\'ve been scattered somewhere around the area since. If you can find one, bring it to me and we can continue.");

        return "Continue";
    end);
    v17:LinkResponse("Okay.. got it.", function() -- Line: 83
        -- upvalues: u4 (ref)
        u4:SetText("Don\'t come back until you have found this vial of blood for me.");

        return "ClearResponses";
    end);
    local u18 = 2;

    function v17.GetStep(p19) -- Line: 14
        -- upvalues: u11 (copy), u18 (copy)
        return u11 == u18;
    end;

    local v21 = u4:AddResponse("Yeah, I have it right here.", function() -- Line: 89
        -- upvalues: u2 (ref), u4 (ref)
        local v20 = u2:CheckRequirement("ItemCountCheck", "ITEM_74"):expect();

        if typeof(v20) == "number" and v20 > 0 then
            u4:SetText("Fantastic. We\'re almost there. Now, you will need to pour this blood ontop of the mask again and put it on immediately.");

            return "Continue";
        end;

        u4:SetText("Hmmm... LIAR! I can smell blood stronger than anyone else around here can. I knew if there blood around here, EVEN IF IT\'S SEALED. Come back to me when you\'ve really found it.");

        return "ClearResponses";
    end);
    v21:LinkResponse("Okay, so I just pour the blood on the mask right?", function() -- Line: 102
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Road To Immortality"):expect() == "ClearSpace" then
            u4:SetText("CLEAR AN INVENTORY ITEM SLOT FIRST, THEN SPEAK TO DIO BRANDO AGAIN.");
        else
            u4:SetText("Yes. Equip the Blood & Vial mask item and left click. You will be able to obtain the item from there on.");
        end;

        return "ClearResponses";
    end);
    local u22 = 3;

    function v21.GetStep(p23) -- Line: 14
        -- upvalues: u11 (copy), u22 (copy)
        return u11 == u22;
    end;
end;

return u4;