  

 

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

u4:SetTitle("Joseph Joestar");
u4:SetCheckStep(function() -- Line: 24
    -- upvalues: u3 (copy), u4 (copy)
    local v8 = u3:GetCurrentStep("Learning Joseph\'s Style"):expect();

    if v8 == 2 or v8 == 3 then
        u4:SetText("Did you take care of those Hooligans like I asked you to?");

        return v8;
    end;

    if v8 == 4 then
        u4:SetText("Did ya get me those clackers I asked from you?");

        return v8;
    end;

    if v8 == 5 then
        u4:SetText("Where\'s the Aja Stone? Do you have it on you?");

        return v8;
    end;

    if v8 == 6 then
        u4:SetText("Whats up buddy? I said I\'d be in touch when I needed your help.");

        return v8;
    end;

    if v8 == 7 then
        u4:SetText("...");
    end;

    return v8;
end);

function u4.Setup(p9) -- Line: 40
    -- upvalues: u4 (copy), LocalPlayer (copy), u3 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p10) -- Line: 41
        table.clear(p10._Responses);
    end);

    if LocalPlayer.Data.Ability.Value ~= 22 then
        u4:SetText("I can just tell by looking at you you\'re not supposed to be talking with me. Get out of here.");

        return;
    end;

    local u11 = u3:GetCurrentStep("Learning Joseph\'s Style"):expect() or 1;
    u4:SetText("Hey stranger, you\'re gonna tell me your a hamon user right?");
    local u12 = 1;

    u4:AddResponse("I was referred here by a guy called Speedwagon.", function() -- Line: 51
        -- upvalues: u4 (ref)
        u4:SetText("Oh now were you? He gives an item you\'re supposed to give to me if so. Do you have it?");

        return "Continue";
    end):LinkResponse("Yes, I have it right there.", function() -- Line: 54
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Learning Joseph\'s Style"):expect() then
            u4:SetText("Very well. I need your help then. I need to make sure you\'re willing to be committed to this. On my way back from a diner, I encountered some hooligans at the port. It was about 15 of em\'. Defeat 15 of them then return to me once you have.");
        else
            u4:SetText("No you do not. I do not see it in your inventory. Come back to me when you have it. Talk to a man named Speedwagon.");
        end;

        return "ClearResponses";
    end).GetStep = function(p13) -- Line: 17
        -- upvalues: u11 (copy), u12 (copy)
        return u11 == u12;
    end;

    local u14 = 1;

    u4:AddResponse("Sorry, didn\'t mean to strke conversation.", function() -- Line: 65
        -- upvalues: u4 (ref)
        u4:SetText("Who just goes up to someone random to talk to them just to walk away? Ok then.");

        return "ClearResponses";
    end).GetStep = function(p15) -- Line: 17
        -- upvalues: u11 (copy), u14 (copy)
        return u11 == u14;
    end;

    local u16 = 2;

    u4:AddResponse("Yes I took care of the hooligans like you asked me to.", function() -- Line: 71
        -- upvalues: u4 (ref)
        u4:SetText("Have you? I don\'t think so. Last time I went back to check, seems like a couple were left. Come back to me once you\'re serious about taking them all out.");

        return "ClearResponses";
    end).GetStep = function(p17) -- Line: 17
        -- upvalues: u11 (copy), u16 (copy)
        return u11 == u16;
    end;

    local v18 = u4:AddResponse("Yes I took care of the hooligans like you asked me to.", function() -- Line: 77
        -- upvalues: u4 (ref)
        u4:SetText("Sweet!!! Ok, I need some help. I\'m battling these weird pillar dudes. They\'ve been there for many years and they\'ve seem to be awakened. Bring me some clackers would ya? They\'re usually spawned around the map.");

        return "Continue";
    end);
    v18:LinkResponse("Just some clackers? Alright then.", function() -- Line: 81
        -- upvalues: u4 (ref), u2 (ref)
        u4:SetText("Yep. And don\'t return until you\'ve found them. I\'ll be watching you.");
        u2:CheckDialogue("Learning Joseph\'s Style"):expect();

        return "ClearResponses";
    end);
    local u19 = 3;

    function v18.GetStep(p20) -- Line: 17
        -- upvalues: u11 (copy), u19 (copy)
        return u11 == u19;
    end;

    local u21 = 4;

    u4:AddResponse("Yes I got them right here.", function() -- Line: 88
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Learning Joseph\'s Style"):expect() then
            u4:SetText("Sweet! I need this weird aja stone thing. I think you can also find it somewhere around here. It spawns around, here. Bring that too me too yeah?");
        else
            u4:SetText("Wow. What a liar you are aren\'t you? Bring me those clackers. I seriously need them. Otherwise, don\'t bother returning to me.");
        end;

        return "ClearResponses";
    end).GetStep = function(p22) -- Line: 17
        -- upvalues: u11 (copy), u21 (copy)
        return u11 == u21;
    end;

    local u23 = 5;

    u4:AddResponse("Yes, I have the aja stone right here.", function() -- Line: 99
        -- upvalues: u2 (ref), u4 (ref)
        if u2:CheckDialogue("Learning Joseph\'s Style"):expect() then
            u4:SetText("Sweet, this all I\'ll need your help with.. Thanks, I\'ll keep in touch! \nHINT: TO CONTINUE, TALK TO JOSEPH WHEN YOU FIND CAESAR\'S HEADBAND.");
        else
            u4:SetText("Lying to me? I though you were noble? Bring me that AJA STONE next time you talk to me.");
        end;

        return "ClearResponses";
    end).GetStep = function(p24) -- Line: 17
        -- upvalues: u11 (copy), u23 (copy)
        return u11 == u23;
    end;

    local u25 = 6;

    u4:AddResponse("I found this weird headband lying around the area.", function() -- Line: 110
        -- upvalues: u2 (ref), u4 (ref)
        local v26 = u2:CheckDialogue("Learning Joseph\'s Style"):expect();

        if v26 then
            if v26 == "ClearSpace" then
                u4:SetText("CLEAR AN INVENTORY ITEM SLOT FIRST, THEN SPEAK TO JOSEPH AGAIN.");
            else
                u4:SetText("....This is... Caesar\'s headband... WHERE DID YOU FIND? YOU KILLED HIM DIDN\'T YA? ALRIGHT THEN. I SEE HOW IT IS. TAKE THIS SIGNAL AND FIGHT ME. I\'LL MAKE YOU PAY FOR WHAT YOU DID TO CAESAR.");
            end;
        else
            u4:SetText("??? What headband? You\'re not showing me anything? Look, just come back when I ask you to come back.");
        end;

        return "ClearResponses";
    end).GetStep = function(p27) -- Line: 17
        -- upvalues: u11 (copy), u25 (copy)
        return u11 == u25;
    end;

    local u28 = 7;

    u4:AddResponse("...", function() -- Line: 125
        -- upvalues: u2 (ref), u4 (ref)
        local v29 = u2:CheckDialogue("Learning Joseph\'s Style"):expect();

        if v29 then
            if v29 == "ClearSpace" then
                u4:SetText("CLEAR AN ABILITY SLOT FIRST, THEN SPEAK TO JOSEPH AGAIN.");
            else
                u4:SetText("So... You didn\'t kill Caesar. That\'s my fault.. I\'ll have to make it up to you.. I\'ll give you my style techniques here.. Take it..");
            end;
        else
            u4:SetText("YOU HAVEN\'T FOUGHT ME YET? IF YOU LOST YOUR SIGNAL I\'LL REPLACE IT. OTHERWISE, FIGHT ME FIRST THEN RETURN BACK.");
        end;

        return "ClearResponses";
    end).GetStep = function(p30) -- Line: 17
        -- upvalues: u11 (copy), u28 (copy)
        return u11 == u28;
    end;
end;

return u4;