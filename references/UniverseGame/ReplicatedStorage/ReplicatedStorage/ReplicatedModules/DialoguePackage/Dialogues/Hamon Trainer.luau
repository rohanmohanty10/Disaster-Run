  

 

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

u4:SetTitle("Hamon Trainer");
u4:SetStarterText("Hey, you seem like the guy I\'ve been hearing about. Something about potential... towards being a fighter and a user of my technique.");
u4:SetCheckStep(function() -- Line: 22
    -- upvalues: u3 (copy), u4 (copy)
    local v8 = u3:GetCurrentStep("The Way To Hamon"):expect();

    if v8 == 2 or v8 == 3 then
        u4:SetText("Did you take care of those Hooligans at the port like I\'ve asked you to do?");

        return v8;
    end;

    if v8 == 4 or v8 == 5 then
        u4:SetText("Did you take care of those Thugs around town like I\'ve asked you to do?");

        return v8;
    end;

    if v8 == 6 then
        u4:SetText("Have you found me a frog yet?");

        return v8;
    end;

    if v8 == 7 then
        u4:SetText("Do you think you have what it takes for the final step?");
    end;

    return v8;
end);

function u4.Setup(p9) -- Line: 36
    -- upvalues: u4 (copy), u3 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p10) -- Line: 37
        table.clear(p10._Responses);
    end);
    local u11 = u3:GetCurrentStep("The Way To Hamon"):expect() or 1;
    local u12 = 1;

    u4:AddResponse("Who me? I appreciate it but-", function() -- Line: 43
        -- upvalues: u4 (ref)
        u4:SetText("Anyways, let\'s get to the point here. I can teach you how to use <Color=Yellow>Hamon<Color=/>. You can progess with it by specific breathing techniques you maintain the more you begin to use said so technique.");

        return "Continue";
    end):LinkResponse("Hamon....? Alright. Well how can I further proceed to learn this technique?", function() -- Line: 46
        -- upvalues: u4 (ref)
        u4:SetText("Well, I can\'t give out free handouts. You\'ll need to prove you\'re capable of learning such a technique. I need you to help me rid the area of Hooligans. There\'s been a lot more lately around the Port lately. Take down at least 15 of them and don\'t come back till you do.");

        return "Continue";
    end):LinkResponse("Alright got it.", function() -- Line: 49
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Don\'t forget. You don\'t defeat those 15 hooligans, I can not further help you.");
        u2:CheckDialogue("The Way To Hamon"):expect();

        return "ClearResponses";
    end).GetStep = function(p13) -- Line: 14
        -- upvalues: u11 (copy), u12 (copy)
        return u11 == u12;
    end;

    local u14 = 1;

    u4:AddResponse("You seem crazy.. Nevermind..", function() -- Line: 57
        -- upvalues: u4 (ref)
        u4:SetText("Bit weird comin\' from someone like you.");

        return "ClearResponses";
    end).GetStep = function(p15) -- Line: 14
        -- upvalues: u11 (copy), u14 (copy)
        return u11 == u14;
    end;

    local u16 = 2;

    u4:AddResponse("Yeah, I\'ve taken care of them.", function() -- Line: 63
        -- upvalues: u4 (ref)
        u4:SetText("Don\'t lie to me. I have eyes around the area. Come to me when you\'ve really taken care of them.");

        return "ClearResponses";
    end).GetStep = function(p17) -- Line: 14
        -- upvalues: u11 (copy), u16 (copy)
        return u11 == u16;
    end;

    local u18 = 3;

    u4:AddResponse("Yeah, I\'ve taken care of them.", function() -- Line: 69
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Very well. It\'s still not enough for me. Those port hooligans seem like deadbeats. The thugs around town though, they possess special abilities. Beat 20 of em\', then I\'ll really know you\'re the real deal.");
        u2:CheckDialogue("The Way To Hamon"):expect();

        return "ClearResponses";
    end).GetStep = function(p19) -- Line: 14
        -- upvalues: u11 (copy), u18 (copy)
        return u11 == u18;
    end;

    local u20 = 4;

    u4:AddResponse("Yeah, I\'ve taken care of them.", function() -- Line: 77
        -- upvalues: u4 (ref)
        u4:SetText("Don\'t lie to me. I have eyes around the area. Come to me when you\'ve really taken care of them.");

        return "ClearResponses";
    end).GetStep = function(p21) -- Line: 14
        -- upvalues: u11 (copy), u20 (copy)
        return u11 == u20;
    end;

    local v22 = u4:AddResponse("Yeah, I\'ve taken care of them.", function() -- Line: 83
        -- upvalues: u4 (ref)
        u4:SetText("Wow. You\'re actually more persistent than I thought. Okay, for your final task I need you to find me a uhhh. uhhh... a frog! I\'ll demonstrate a hamon technique.");

        return "Continue";
    end);
    v22:LinkResponse("A frog..? Really?", function() -- Line: 87
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Well to myself, I don\'t think I sound like I\'m joking. I can not proceed forward if you don\'t bring me that frog.");
        u2:CheckDialogue("The Way To Hamon"):expect();

        return "ClearResponses";
    end);
    local u23 = 5;

    function v22.GetStep(p24) -- Line: 14
        -- upvalues: u11 (copy), u23 (copy)
        return u11 == u23;
    end;

    local v26 = u4:AddResponse("Yes, I have the frog here for you.", function() -- Line: 95
        -- upvalues: u2 (ref), u4 (ref)
        local v25 = u2:CheckRequirement("ItemCountCheck", "ITEM_60"):expect();

        if typeof(v25) ~= "number" or v25 <= 0 then
            u4:SetText("Oh you have it right? Let me see it. Oh? You don\'t have it? Yeah. Come back to me when you\'re serious about this and have it.");

            return "ClearResponses";
        end;

        u4:SetText("Very well. I will now demonstrate to you the technique. Are you ready for it?");
        u2:CheckDialogue("The Way To Hamon"):expect();

        return "Continue";
    end);
    v26:LinkResponse("Yeah, I\'m watching", function() -- Line: 108
        -- upvalues: u4 (ref)
        u4:SetText("yea i dont feel like describing allat so just picture the jojo scene where zeppeli hit the frog through rock yea");

        return "Continue";
    end):LinkResponse("Woah.. How\'d you do that?", function() -- Line: 111
        -- upvalues: u4 (ref)
        u4:SetText("Breathing technique. That\'s all it is. Instead of punching the frog directly, I imbued my hamon through it and the shockwave traveled to the bottom of the frog.");

        return "Continue";
    end):LinkResponse("What do I do now?", function() -- Line: 114
        -- upvalues: u4 (ref)
        u4:SetText("Well. I\'ll hold onto this frog. It has imbued energy into it now. I\'ll give this frog to you next time you come to me ready.");

        return "ClearResponses";
    end);
    local u27 = 6;

    function v26.GetStep(p28) -- Line: 14
        -- upvalues: u11 (copy), u27 (copy)
        return u11 == u27;
    end;

    local u29 = 7;

    u4:AddResponse("Yes, I have the frog here for you.", function() -- Line: 120
        -- upvalues: u2 (ref), u4 (ref)
        u2:CheckDialogue("The Way To Hamon"):expect();
        u4:SetText("Okay. Here you go. When you\'re ready to fight me, head to the arena and signal me there. I\'ll appear and won\'t hold back. Good luck.");

        return "ClearResponses";
    end).GetStep = function(p30) -- Line: 14
        -- upvalues: u11 (copy), u29 (copy)
        return u11 == u29;
    end;
end;

return u4;