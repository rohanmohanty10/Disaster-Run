  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Dialogue.new();
local u3 = Knit.GetService("DialogueService");
local u4 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local _ = game:GetService("Players").LocalPlayer;

local function ResetDialogue() -- Line: 12
    -- upvalues: u2 (copy)
    u2:Destroy();
end;

local function GetStep(u5, u6) -- Line: 16
    return function(p7) -- Line: 17
        -- upvalues: u6 (copy), u5 (copy)
        return typeof(u6) == "table" and table.find(u6, u5) or u5 == u6;
    end;
end;

u2:SetTitle("Satoru Gojo");
u2:SetCheckStep(function(p8, p9) -- Line: 23
    -- upvalues: u4 (copy), u2 (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();

    if v10 == 2 then
        u2:SetText("Come back when you\'ve dealt with those curses. Show me you understand what infinity truly means.");

        return v10;
    end;

    if v10 == 3 then
        u2:SetText("Come back when you\'re ready to face your next trial.");

        return v10;
    end;

    if v10 == 4 then
        u2:SetText("Still here? The Jujutsu Sorcerers await. Don\'t keep me waiting.");
    end;

    return v10;
end);

function u2.Setup(p11, p12, p13) -- Line: 35
    -- upvalues: u2 (copy), u4 (copy), u3 (copy)
    u2:AddCallback("OnDestroy", function(p14) -- Line: 36
        table.clear(p14._Responses);
    end);

    if p12 and p13 then
        return "ClearResponses";
    end;

    if not u4:GetCurrentStep(script.Name):expect() then
        u2:SetText("Come back when you\'re actually worth my time.");

        return "ClearResponses";
    end;

    u2:SetText("Another student seeking the power of infinity? Most can\'t handle it. The limitless isn\'t just a technique - it\'s a state of mind. Think you\'re up for it?");
    u2:AddResponse("I won\'t back down. I need this power, Gojo-sensei!", function() -- Line: 52
        -- upvalues: u2 (ref)
        u2:SetText("That look in your eyes... Maybe you\'re not just another boring student after all.");

        return "Continue";
    end):SetStep(1):LinkResponse("I\'m prepared for whatever training you have planned.", function() -- Line: 55
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Then let\'s begin. First, show me how you handle curses. Numbers mean nothing before infinity.");

        return "ClearResponses";
    end);
    u2:AddResponse("I can\'t do it. I give up.", function() -- Line: 61
        -- upvalues: u2 (ref)
        u2:SetText("At least you\'re honest with yourself. The limitless technique is not fit for the WEAK.");

        return "ClearResponses";
    end):SetStep(1);
    u2:AddResponse("I\'ve learned that true power goes beyond numbers.", function() -- Line: 66
        -- upvalues: u2 (ref), u3 (ref)
        u2:SetText("Now you\'re getting it. Your next trial awaits - prove yourself against real opponents.");
        u3:CheckDialogue(script.Name):expect();

        return "ClearResponses";
    end):SetStep(3);
end;

return u2;