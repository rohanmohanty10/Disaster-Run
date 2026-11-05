  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local u4 = Knit.GetService("EventCandyService");
local _ = game.Players.LocalPlayer;
local u5 = Dialogue.new();

local function GetStep(u6, u7) -- Line: 17
    return function(p8) -- Line: 18
        -- upvalues: u6 (copy), u7 (copy)
        return u6 == u7;
    end;
end;

local function ResetDialogue() -- Line: 22
    -- upvalues: u5 (copy)
    u5:Destroy();
end;

u5:SetCheckStep(function() -- Line: 26
    -- upvalues: u3 (copy), u5 (copy)
    local v9 = u3:GetCurrentStep("A Cold and Sweet Adventure"):expect();

    if v9 == 1 then
        u5:SetStarterText("Ho-ho-ho! Merry Christmas! Wait.. It isn\'t Christmas anymore.. Right.. My home got taken away from me...");

        return v9;
    end;

    if v9 == 2 then
        u5:SetStarterText("Hey.. Did you take care of those Hooligans like I asked you to?");

        return v9;
    end;

    if v9 == 4 then
        u5:SetStarterText("Do you have the fragment of the sword I asked you to go get?");
    end;

    return v9;
end);
u5:SetTitle("Santa Claus");
u5:SetStarterText("Ho-ho-ho! Merry Christmas! Wait.. It isn\'t Christmas anymore.. Right.. My home got taken away from me...");

function u5.Setup(p10) -- Line: 42
    -- upvalues: u5 (copy), u3 (copy), u2 (copy), u4 (copy), ResetDialogue (copy)
    u5:AddCallback("OnDestroy", function(p11) -- Line: 43
        table.clear(p11._Responses);
    end);
    local u12 = u3:GetCurrentStep("A Cold and Sweet Adventure"):expect() or 1;
    local u13 = 1;

    u5:AddResponse("Oh. That\'s awful to hear.. How can I be of help to you?", function() -- Line: 49
        -- upvalues: u5 (ref)
        u5:SetText("I don\'t know... I\'m stuck here in this random place here... Well.. to be honest.. I\'ve lost my Christmas Spirit.. My sleigh was wrecked by thugs, A big.. creature took my candy cane sword away.. Wait.. Do you think you can help me?");

        return "Continue";
    end):SetStep(1):LinkResponse("Uhhh sure, that depends..", function() -- Line: 53
        -- upvalues: u2 (ref), u5 (ref)
        u2:CheckDialogue("A Cold and Sweet Adventure"):expect();
        u5:SetText("Okay, here\'s the deal. If you can get back on those hooligans I crashed landed near at the Port, I\'ll see you fit to fighting this creature.");

        return "ClearResponses";
    end).GetStep = function(p14) -- Line: 18
        -- upvalues: u12 (copy), u13 (copy)
        return u12 == u13;
    end;

    local u15 = 2;

    u5:AddResponse("Yes I have taken care of those Hooligans liked you asked me to.", function() -- Line: 61
        -- upvalues: u5 (ref)
        u5:SetText("Doesn\'t seem like it.. My christmas spirit hasn\'t been rejuvenated all that much.. Don\'t lie to me please.. Return back once you have.");

        return "ClearResponses";
    end).GetStep = function(p16) -- Line: 18
        -- upvalues: u12 (copy), u15 (copy)
        return u12 == u15;
    end;

    local u17 = 3;

    u5:AddResponse("Yes I have taken care of those Hooligans liked you asked me to.", function() -- Line: 68
        -- upvalues: u5 (ref)
        u5:SetText("You\'re right.. I\'m feeling a lot more jolly at this moment. We\'re getting there.");

        return "Continue";
    end):SetStep(3):LinkResponse("Anything else?", function() -- Line: 72
        -- upvalues: u5 (ref), u2 (ref)
        u5:SetText("I see you fit for this final task. Go and defeat Grimpus. He\'s located at the Ice Fortress. Once you do, return back to me. He should drop an item that you can return to me that I can use to make my sword whole again.");
        u2:CheckDialogue("A Cold and Sweet Adventure"):expect();

        return "Continue";
    end):SetStep(3):LinkResponse("How do I get there?", function() -- Line: 77
        -- upvalues: u5 (ref)
        u5:SetText("Speak to Bawx. He\'s in the main area under the huge christmas tree.");

        return "ClearResponses";
    end).GetStep = function(p18) -- Line: 18
        -- upvalues: u12 (copy), u17 (copy)
        return u12 == u17;
    end;

    local u19 = 4;

    u5:AddResponse("Yes here it is.", function() -- Line: 84
        -- upvalues: u2 (ref), u5 (ref)
        local v20 = u2:CheckDialogue("A Cold and Sweet Adventure"):expect();

        if not v20 then
            u5:SetText("It doesn\'t seem like you do.. Otherwise it would\'ve already floated out and merged with it. Come back when you really do.");

            return "ClearResponses";
        end;

        if v20 == "ClearSpace" then
            u5:SetText("(YOU HAVE NO ABILITY INVENTORY SPACE, PLEASE CLEAR A SPACE BEFOREHAND)");

            return "ClearResponses";
        end;

        u5:SetText("Perfect! It clicked together and good as new. You know what.. You deserve it. Take it and use it with great honor. You\'ve saved Christmas!");

        return "ClearResponses";
    end).GetStep = function(p21) -- Line: 18
        -- upvalues: u12 (copy), u19 (copy)
        return u12 == u19;
    end;

    local u22 = nil;
    u22 = u5:AddResponse("I want to exchange my candy", function() -- Line: 104
        -- upvalues: u4 (ref), u5 (ref), u22 (ref), ResetDialogue (ref)
        local v23 = u4:ExchangeCandy():expect() or 0;
        u5:SetText(v23 > 0 and `I can give you <Color=255,85,255>{v23}uE<Color=/> for your candy.` or "You have nothing to exchange.");

        if #u22:GetLinkedResponses() == 0 then
            u22:LinkResponse("Alright!", function() -- Line: 113
                -- upvalues: u5 (ref), u4 (ref)
                u5:SetText("There you go.");
                u4:ExchangeCandy(true):expect();

                return "ClearResponses";
            end);
            u22:LinkResponse("Nevermind", ResetDialogue);
        end;

        return v23 > 0 and "Continue" or "ClearResponses";
    end);

    function u22.GetStep() -- Line: 125
        return true;
    end;
end;

return u5;