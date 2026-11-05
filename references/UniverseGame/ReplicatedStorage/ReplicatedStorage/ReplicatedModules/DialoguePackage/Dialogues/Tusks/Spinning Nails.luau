  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Dialogue.new();
local u3 = Knit.GetService("DialogueService");
local u4 = Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;

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

u2:SetTitle("Gyro Zeppeli (Q: Spinning Nails)");
u2:SetCheckStep(function(p8, p9) -- Line: 26
    -- upvalues: u4 (copy), u2 (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();

    if v10 == 2 then
        u2:SetText("Have you slain the thugs?");

        return v10;
    end;

    if v10 == 3 then
        u2:SetText("Awesome, you now have spin energy inside of you. If you want to make valuable use off of it, I\'d suggest playing around with Saint\'s Ribs if you manage to find them.");
    end;

    return v10;
end);

function u2.Setup(p11, p12, p13) -- Line: 36
    -- upvalues: u2 (copy), u4 (copy), u3 (copy)
    u2:AddCallback("OnDestroy", function(p14) -- Line: 37
        table.clear(p14._Responses);
    end);

    if p12 and p13 then
        return "ClearResponses";
    end;

    if not u4:GetCurrentStep(script.Name):expect() then
        u2:SetText(".");

        return "ClearResponses";
    end;

    u2:SetText("Hey, can you help me out? I need help killing these thugs, please help!");
    u2:AddResponse("What\'s in it for me?", function() -- Line: 54
        -- upvalues: u2 (ref)
        u2:SetText("I\'ll show you how to use some form of spin energy and utilize it.");

        return "Continue";
    end):SetStep(1):LinkResponse("Oh, for sure then!", function() -- Line: 57
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Alright, good luck.");

        return "ClearResponses";
    end);
    u2:AddResponse("I\'m good.", function() -- Line: 63
        -- upvalues: u2 (ref)
        u2:SetText("Maybe next time.");

        return "ClearResponses";
    end):SetStep(1);
    u2:AddResponse("Thank you.", function() -- Line: 68
        -- upvalues: u3 (ref)
        u3:CheckDialogue(script.Name):expect();

        return "ClearResponses";
    end):SetStep(3);
end;

return u2;