  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Dialogue.new();
local u3 = Knit.GetService("DialogueService");
Knit.GetService("HakiService");
local u4 = Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;

local function ResetDialogue() -- Line: 15
    -- upvalues: u2 (copy)
    u2:Destroy();
end;

local function GetStep(u5, u6) -- Line: 19
    return function(p7) -- Line: 20
        -- upvalues: u6 (copy), u5 (copy)
        return typeof(u6) == "table" and table.find(u6, u5) or u5 == u6;
    end;
end;

u2:SetTitle("Murimasu");
u2:SetCheckStep(function(p8, p9) -- Line: 27
    -- upvalues: u4 (copy), u2 (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();

    if v10 == 2 then
        u2:SetText("Have you done my task?");

        return v10;
    end;

    if v10 == 3 then
        u2:SetText("Awesome, I grant you the abilities of a mysterious haki, \'Kenbunshoku\'. You aren\'t as strong yet, but I recommend that you progress further & you\'ll be just as strong as me. I recommend trying to obtain & consume haki shards & the manual for Kenbunshoku, you might be lucky and stumble upon either of these items, I recommend you see Rayleigh if you wanna know more about these abilities. Anyways, my job is done, I wish you the very best.");
    end;

    return v10;
end);

function u2.Setup(p11, p12, p13) -- Line: 37
    -- upvalues: u2 (copy), u4 (copy), u3 (copy)
    u2:AddCallback("OnDestroy", function(p14) -- Line: 38
        table.clear(p14._Responses);
    end);

    if p12 and p13 then
        return "ClearResponses";
    end;

    if not u4:GetCurrentStep(script.Name):expect() then
        u2:SetText("Hi");

        return "ClearResponses";
    end;

    u2:SetText("Yo, wanna help me out? I\'ll give you this cool technique that my master taught me!");
    u2:AddResponse("Yeah.", function() -- Line: 55
        -- upvalues: u2 (ref)
        u2:SetText("Awesome! Finish these tasks & come back to me once you\'re done.");

        return "Continue";
    end):SetStep(1):LinkResponse("Gotcha.", function() -- Line: 58
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Good luck!");

        return "ClearResponses";
    end);
    u2:AddResponse("Nah, I\'m good.", function() -- Line: 64
        -- upvalues: u2 (ref)
        u2:SetText("Whatever you say buddy.");

        return "ClearResponses";
    end):SetStep(1);
    u2:AddResponse("Thanks.", function() -- Line: 69
        -- upvalues: u3 (ref)
        u3:CheckDialogue(script.Name):expect();

        return "ClearResponses";
    end):SetStep(3);
end;

return u2;