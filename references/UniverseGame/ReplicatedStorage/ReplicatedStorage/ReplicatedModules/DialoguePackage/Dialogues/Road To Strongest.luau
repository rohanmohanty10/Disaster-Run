  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = game:GetService("ReplicatedStorage")["Client Assets"];
local u3 = Knit.GetService("DialogueService");
local u4 = Knit.GetService("QuestLineService");
local u5 = Dialogue.new();

local function ResetDialogue() -- Line: 15
    -- upvalues: u5 (copy)
    u5:Destroy();
end;

local u6 = nil;

local function ShenronClean() -- Line: 21
    -- upvalues: u6 (ref)
    if not u6 then
        return;
    end;

    u6:Destroy();
    u6 = nil;
end;

u5:SetCheckStep(function() -- Line: 27
    -- upvalues: u4 (copy), u5 (copy), u6 (ref), u2 (copy)
    local v7 = u4:GetCurrentStep(script.Name):expect();

    if v7 == 2 then
        u5:SetText("Come back when you\'ve found all 7");

        return v7;
    end;

    if v7 == 3 then
        u5:SetText("Oh you\'re back, did you complete my request?");

        return v7;
    end;

    if v7 == 4 then
        u5:SetText("Come back when you\'ve completed these tasks");

        return v7;
    end;

    if v7 == 5 then
        u5:SetTitle("Shenron");
        u5:SetText("What do you wish for mortal?");
        local LocalPlayer = game.Players.LocalPlayer;
        u6 = u2.Goku["Shenron GUI"]:Clone();
        u6.Parent = LocalPlayer.PlayerGui;
    end;

    return v7;
end);
u5:SetStarterTitle("Goku");
u5:SetStarterText("Hi there! What can I do for you?");
local v8 = u5:AddResponse("How do I become strong like you?", function() -- Line: 48
    -- upvalues: u5 (copy)
    u5:SetText("If you wish to become strong like me, first you gotta obtain all 7 dragon balls");

    return "Continue";
end);
v8:LinkResponse("Very well I will obtain them", function() -- Line: 52
    -- upvalues: u3 (copy), u5 (copy)
    u3:CheckDialogue(script.Name):expect();
    u5:SetText("Come back when you\'ve gotten all");

    return "ClearResponses";
end);
v8:LinkResponse("Nevermind this is too hard", ResetDialogue);
u5:AddResponse("Here, I\'ve found some of them", function() -- Line: 59
    -- upvalues: u3 (copy), u5 (copy)
    local v9 = u3:CheckDialogue(script.Name):expect();

    if type(v9) == "number" then
        u5:SetText(string.format("You need to find [%s] more dragon balls", v9));

        return "ClearResponses";
    end;

    u5:Destroy();
end):SetStep(2);
u5:AddResponse("Yes", function() -- Line: 68
    -- upvalues: u3 (copy), u5 (copy)
    u3:CheckDialogue(script.Name);
    u5:SetText("Nice work! Now you must complete these tasks");

    return "ClearResponses";
end):SetStep(3);
u5:AddResponse("No", ResetDialogue):SetStep(3);

local function SelectChoice(u10) -- Line: 75
    -- upvalues: u3 (copy), u6 (ref), u5 (copy)
    return function() -- Line: 76
        -- upvalues: u3 (ref), u10 (copy), u6 (ref), u5 (ref)
        local v11 = u3:CheckDialogue(script.Name, u10):expect();

        if u6 then
            u6:Destroy();
            u6 = nil;
        end;

        if v11 ~= true then
            u5:SetText(v11);

            return "ClearResponses";
        end;

        u5:Destroy();
    end;
end;

local u12 = "Wealth";
u5:AddResponse("Wealth", function() -- Line: 76
    -- upvalues: u3 (copy), u12 (copy), u6 (ref), u5 (copy)
    local v13 = u3:CheckDialogue(script.Name, u12):expect();

    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    if v13 ~= true then
        u5:SetText(v13);

        return "ClearResponses";
    end;

    u5:Destroy();
end):SetStep(5);
local u14 = "Ascension";
u5:AddResponse("Ascension", function() -- Line: 76
    -- upvalues: u3 (copy), u14 (copy), u6 (ref), u5 (copy)
    local v15 = u3:CheckDialogue(script.Name, u14):expect();

    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    if v15 ~= true then
        u5:SetText(v15);

        return "ClearResponses";
    end;

    u5:Destroy();
end):SetStep(5);
local u16 = "Corruption";
u5:AddResponse("Corruption", function() -- Line: 76
    -- upvalues: u3 (copy), u16 (copy), u6 (ref), u5 (copy)
    local v17 = u3:CheckDialogue(script.Name, u16):expect();

    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    if v17 ~= true then
        u5:SetText(v17);

        return "ClearResponses";
    end;

    u5:Destroy();
end):SetStep(5);
local u18 = "Primal Power";
u5:AddResponse("Primal Power", function() -- Line: 76
    -- upvalues: u3 (copy), u18 (copy), u6 (ref), u5 (copy)
    local v19 = u3:CheckDialogue(script.Name, u18):expect();

    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    if v19 ~= true then
        u5:SetText(v19);

        return "ClearResponses";
    end;

    u5:Destroy();
end):SetStep(5);
local Destroy = u5.Destroy;

function u5.Destroy(p20) -- Line: 96
    -- upvalues: u6 (ref), Destroy (copy)
    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    Destroy(p20);
end;

return u5;