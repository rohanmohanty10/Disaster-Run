  

 

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

u4:SetTitle("Monkey D. Luffy");
u4:SetStarterText("I\'m Monkey D. Luffy, and I\'m going to be the King of the Pirates!");
u4:SetCheckStep(function() -- Line: 25
    -- upvalues: u3 (copy)
    return u3:GetCurrentStep("Gomu\'s Second Gear"):expect();
end);

function u4.Setup(p8) -- Line: 30
    -- upvalues: u4 (copy), u3 (copy), LocalPlayer (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p9) -- Line: 31
        table.clear(p9._Responses);
    end);
    local u10 = u3:GetCurrentStep("Gomu\'s Second Gear"):expect() or 1;

    if LocalPlayer.Data.Ability.Value ~= 90000 then
        u4:SetText("EQUIP GOMU TO TALK TO LUFFY");

        return "ClearResponses";
    end;

    local u11 = 1;

    u4:AddResponse("Hey, you\'re the guy who possesses further power in Gomu?", function() -- Line: 42
        -- upvalues: u4 (ref)
        u4:SetText("!! Who\'s asking !! I know nothing about no Gomu! Uhhh.. Wait you\'re not a marine right?");

        return "Continue";
    end):SetStep(1):LinkResponse("No, I\'t a marine, I also have acquired Gomu powers too like you. I want to learn new techniques and I\'m wondering if you can help me.", function() -- Line: 46
        -- upvalues: u4 (ref)
        u4:SetText("H-huh? You have the same powers as me? Nah. That can\'t be! It\'s cool but hmmm.. You actually sort of look like me. Ya feel strong!?");

        return "Continue";
    end):SetStep(1):LinkResponse("Yeah. I got these from a fruit I earned from a guy\'s chest.", function() -- Line: 49
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Gomu\'s Second Gear"):expect() then
            u4:SetText("Ooooohhhh.. Sounds familiar. Anyways ya wanna learn how to be strong like me!? Alright! For your first task bring me a uhhhh..... hmmmm... ummmmm.. Meat on a Bone! Yeah! I\'m starving!");

            return "Continue";
        end;

        u4:SetText("Ooooohhhh.. Sounds familiar. Anyways ya wanna learn how to be strong like me!? You don\'t look strong honestly. Get buff like me and we\'ll talk Haha! (REACH ASCENSION 2 WITH GOMU)");

        return "ClearResponses";
    end):SetStep(1):LinkResponse("Seriously? Meat on a Bone?", function() -- Line: 58
        -- upvalues: u4 (ref)
        u4:SetText("Hey! You\'re learning from the best here! I\'m going to make you stronger! I\'m just hungry.");

        return "ClearResponses";
    end).GetStep = function(p12) -- Line: 17
        -- upvalues: u10 (copy), u11 (copy)
        return u10 == u11;
    end;

    local u13 = 2;

    u4:AddResponse("I got you your Meat on a Bone.", function() -- Line: 65
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Gomu\'s Second Gear"):expect() then
            u4:SetText("Haha! I KNEW I could count you! This look so good. I\'ve been starving all day!");

            return "Continue";
        end;

        u4:SetText("Dude. I have a strong sense of smell.");

        return "ClearResponses";
    end):SetStep(2):LinkResponse("Hey.. How about teaching me you know?", function() -- Line: 74
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("O-oh. Sorry! I\'ve just been so hungry today. I just really love meat. Anyways uh. You up to fight!? Do me a favor and help me take care of some of those pirates in Orange Town! I\'m tired from eating all this food you know.");
        u2:CheckDialogue("Gomu\'s Second Gear"):expect();

        return "Continue";
    end):SetStep(2):LinkResponse("Seriously? Pirates again?", function() -- Line: 80
        -- upvalues: u4 (ref)
        u4:SetText("Hey, hey! You signed up for it. I\'m just teaching ya\' the basics here.");

        return "Continue";
    end).GetStep = function(p14) -- Line: 17
        -- upvalues: u10 (copy), u13 (copy)
        return u10 == u13;
    end;

    local u15 = 3;

    u4:AddResponse("I got you your Meat on a Bone.", function() -- Line: 87
        -- upvalues: u4 (ref)
        u4:SetText("Haha! I KNEW I could count you! This look so good. I\'ve been starving all day!");

        return "Continue";
    end):SetStep(3):LinkResponse("Hey.. How about teaching me you know?", function() -- Line: 90
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("O-oh. Sorry! I\'ve just been so hungry today. I just really love meat. Anyways uh. You up to fight!? Do me a favor and help me take care of some of those pirates in Orange Town! I\'m tired from eating all this food you know.");
        u2:CheckDialogue("Gomu\'s Second Gear"):expect();

        return "Continue";
    end):SetStep(3):LinkResponse("Seriously? Pirates again?", function() -- Line: 96
        -- upvalues: u4 (ref)
        u4:SetText("Hey, hey! You signed up for it. I\'m just teaching ya\' the basics here.");

        return "Continue";
    end).GetStep = function(p16) -- Line: 17
        -- upvalues: u10 (copy), u15 (copy)
        return u10 == u15;
    end;

    local u17 = 4;

    u4:AddResponse("I have beaten those pirates up like you told me to.", function() -- Line: 103
        -- upvalues: u4 (ref)
        u4:SetText("You know I can sense some liars but you are a different type... You still look just as weak when I saw you.. Come back when you\'ve actually done it!");

        return "ClearResponses";
    end).GetStep = function(p18) -- Line: 17
        -- upvalues: u10 (copy), u17 (copy)
        return u10 == u17;
    end;

    local u19 = 5;

    u4:AddResponse("I have beaten those pirates up like you told me to.", function() -- Line: 109
        -- upvalues: u4 (ref)
        u4:SetText("Alright! I can tell you\'re growing in power just like me! Uhhh.. For the next task let me think... O- yeah. Okay, you should... Go beat up this Buggy guy! Yeah! I don\'t like him!");

        return "Continue";
    end):SetStep(5):LinkResponse("You gonna help me at least?", function() -- Line: 113
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Who me? Naw the teacher stays back and slacks while you take care of him! I have faith in you don\'t worry!");
        u2:CheckDialogue("Gomu\'s Second Gear"):expect();

        return "Continue";
    end).GetStep = function(p20) -- Line: 17
        -- upvalues: u10 (copy), u19 (copy)
        return u10 == u19;
    end;

    local u21 = 6;

    u4:AddResponse("I have taken care of Buggy like you requested me to.", function() -- Line: 122
        -- upvalues: u4 (ref)
        u4:SetText("Huhhhh? I see his bounty though... You lying to me!?");

        return "ClearResponses";
    end).GetStep = function(p22) -- Line: 17
        -- upvalues: u10 (copy), u21 (copy)
        return u10 == u21;
    end;

    local u23 = 7;

    u4:AddResponse("I have taken care of Buggy like you requested me to.", function() -- Line: 128
        -- upvalues: u4 (ref)
        u4:SetText("Oooohh! His bounty is gone! Another step for me becoming King of the Pirates! Haha!");

        return "Continue";
    end):SetStep(7):LinkResponse("Uhhhh... I\'m still here though...", function() -- Line: 131
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("You again? Oh I mean hey! Ok ok! Uhhhh... uhh.... Fight this Law guy! Yeah! He\'s been bothering me a lot.");
        u2:CheckDialogue("Gomu\'s Second Gear"):expect();

        return "Continue";
    end):SetStep(7):LinkResponse("Bro what.", function() -- Line: 137
        -- upvalues: u4 (ref)
        u4:SetText("Do this and I might just actually teach you everything I know! (he\'s really helping me get to the top...)");

        return "ClearResponses";
    end).GetStep = function(p24) -- Line: 17
        -- upvalues: u10 (copy), u23 (copy)
        return u10 == u23;
    end;

    local u25 = 8;

    u4:AddResponse("I\'ve defeated Law.. Can we move on now?", function() -- Line: 143
        -- upvalues: u4 (ref)
        u4:SetText("HIS BOUNTY IS STILL THERE! YOU HAVEN\'T EVEN INCHED TOWARDS HIM!?");

        return "ClearResponses";
    end).GetStep = function(p26) -- Line: 17
        -- upvalues: u10 (copy), u25 (copy)
        return u10 == u25;
    end;

    local u27 = 9;

    u4:AddResponse("I\'ve defeated Law.. Can we move on now?", function() -- Line: 149
        -- upvalues: u4 (ref)
        u4:SetText("Aha! You did beat him! His bounty is gone! Amazing! Fantastic! Ok ok! For the grand prize! You get to fight me!");

        return "Continue";
    end):SetStep(9):LinkResponse("FIGHT YOU? Dude! I barely know less than half of what you probably do!", function() -- Line: 152
        -- upvalues: u4 (ref)
        u4:SetText("Yeah.. But you\'re growing in your strength. You\'re getting too strong so I need to also stop you. Tell you what though.. You beat me and I\'ll still teach you anyways!");

        return "Continue";
    end):SetStep(9):LinkResponse("You got a deal here.", function() -- Line: 155
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Hahahahaha! I look forward to it!");
        u2:CheckDialogue("Gomu\'s Second Gear"):expect();

        return "ClearResponses";
    end).GetStep = function(p28) -- Line: 17
        -- upvalues: u10 (copy), u27 (copy)
        return u10 == u27;
    end;
end;

return u4;