  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Dialogue.new();
local u3 = Knit.GetService("DialogueService");
local u4 = Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function ResetDialogue() -- Line: 14
    -- upvalues: u2 (copy)
    u2:Destroy();
end;

local function GetStep(u5, u6) -- Line: 18
    return function(p7) -- Line: 19
        -- upvalues: u6 (copy), u5 (copy)
        return typeof(u6) == "table" and table.find(u6, u5) or u5 == u6;
    end;
end;

u2:SetTitle("Gyro Zeppeli (Q: Golden Rectangle Nails)");
u2:SetCheckStep(function(p8, p9) -- Line: 26
    -- upvalues: u4 (copy), u2 (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();

    if v10 == 2 then
        u2:SetText("Have you completed the first part of the process?");

        return v10;
    end;

    if v10 == 3 then
        u2:SetText("Awesome, now I need you to amass & claim bounty. This might be a difficult task but I need to make sure you\'re worthy enough to take this to the next level.");

        return v10;
    end;

    if v10 == 4 then
        u2:SetText("You done yet?");

        return v10;
    end;

    if v10 == 5 then
        u2:SetText("Awesome, use these saint\'s arms on that and you\'ll reach the next level. Make sure to use it while you\'re in this session otherwise it won\'t work later. Also, once you get ACT2, I\'d recommend reaching ASC2 and try to use Dark Determination as much as you can, it should leave an effect.");
    end;

    return v10;
end);

function u2.Setup(p11, p12, p13) -- Line: 41
    -- upvalues: u2 (copy), LocalPlayer (copy), u3 (copy)
    u2:AddCallback("OnDestroy", function(p14) -- Line: 42
        table.clear(p14._Responses);
    end);

    if p12 and p13 then
        return "ClearResponses";
    end;

    local v15 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v16 = LocalPlayer.Data.Ability:GetAttribute("AbilityLevel");

    if v15 ~= "Tusk ACT1" or v16 < 200 then
        u2:SetText("I can\'t help you. Come back once you have level 200 on Tusk ACT1.");

        return "ClearResponses";
    end;

    u2:SetText("I see you\'ve progressed the visualization of your spin technique further. Would you like to progress further?");
    u2:AddResponse("Yeah sure", function() -- Line: 60
        -- upvalues: u2 (ref)
        u2:SetText("Alright, you will need to utilize your nail gliding technique & slay some enemies again. Check your quests section for more details.");

        return "Continue";
    end):SetStep(1):LinkResponse("Okay, I got it.", function() -- Line: 63
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Good luck!");

        return "ClearResponses";
    end);
    u2:AddResponse("Nah, not right now.", function() -- Line: 69
        -- upvalues: u2 (ref)
        u2:SetText("Alright, I got you.");

        return "ClearResponses";
    end):SetStep(1);
    u2:AddResponse("I got it.", function() -- Line: 74
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Good luck!");

        return "ClearResponses";
    end):SetStep(3);
    u2:AddResponse("Alright, thank you so much.", function() -- Line: 80
        -- upvalues: u2 (ref), u3 (ref)
        u2:SetText("See you soon.");
        u3:CheckDialogue(script.Name):expect();

        return "ClearResponses";
    end):SetStep(5);
end;

return u2;