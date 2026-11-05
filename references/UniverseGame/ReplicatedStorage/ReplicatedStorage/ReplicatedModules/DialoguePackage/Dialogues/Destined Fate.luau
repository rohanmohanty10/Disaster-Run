  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Dialogue.new();
local u3 = Knit.GetService("DialogueService");
local u4 = Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

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

u2:SetTitle("me am nub (alter ego)");
u2:SetCheckStep(function(p8, p9) -- Line: 27
    -- upvalues: u4 (copy), u2 (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();

    if v10 == 2 then
        u2:SetText("Have you completed my initial tasks~?");

        return v10;
    end;

    if v10 == 3 then
        u2:SetText("Arigato~! I will give you this fruit, eat this & it will grant you some very special abilities, chao!.");
    end;

    return v10;
end);

function u2.Setup(p11, p12, p13) -- Line: 37
    -- upvalues: u2 (copy), LocalPlayer (copy), u3 (copy)
    u2:AddCallback("OnDestroy", function(p14) -- Line: 38
        table.clear(p14._Responses);
    end);

    if p12 and p13 then
        return "ClearResponses";
    end;

    if LocalPlayer.Data.Ability.Value ~= 90000 then
        u2:SetText("Hoi- uh.... ew..- what is that ability 😭😭😭, please come back when you have mighty gomu gomu no mi fruit, till then, sayonara~!");

        return "ClearResponses";
    end;

    if LocalPlayer.Data.Ability:GetAttribute("AscensionRank") < 10 then
        u2:SetText("Hoi~! Oh! You don\'t seem ready yet! Come back when you\'re Ascension 10.");

        return "ClearResponses";
    end;

    u2:SetText("Hoi~! You seem like a pretty strong person, mind helping me with these objectives?");
    u2:AddResponse("Yeah sure.", function() -- Line: 61
        -- upvalues: u2 (ref)
        u2:SetText("Arigato! Let me know once you\'re ready!~");

        return "Continue";
    end):SetStep(1):LinkResponse("I am ready.", function() -- Line: 64
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Alright, good luck~!");

        return "ClearResponses";
    end);
    u2:AddResponse("Nah, I\'m good.", function() -- Line: 70
        -- upvalues: u2 (ref)
        u2:SetText(":(");

        return "ClearResponses";
    end):SetStep(1);
    u2:AddResponse("Thanks.", function() -- Line: 75
        -- upvalues: u3 (ref)
        u3:CheckDialogue(script.Name):expect();

        return "ClearResponses";
    end):SetStep(3);
end;

return u2;