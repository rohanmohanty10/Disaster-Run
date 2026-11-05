  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
Knit.GetService("DialogueService");
local u2 = Knit.GetService("ShopService");
Knit.GetService("QuestLineService");
local u3 = Dialogue.new();

local function Proceed(u4) -- Line: 38
    -- upvalues: u3 (copy)
    u3:SetText("Very well.");
    task.delay(1, function() -- Line: 40
        -- upvalues: u3 (ref), u4 (copy)
        u3:Destroy();
        u4();
    end);
end;

u3:SetTitle("UniversalOS Smart Assistant");
u3:SetStarterText("Hello, <Color=Yellow><PlayerName><Color=/>. How may I help?");
u3:AddResponse("I would like to contact \"<font color=\"#000000\">The Shady Person</font>\" about the black market.", function() -- Line: 49
    -- upvalues: u2 (copy), u3 (copy)
    local function u5() -- Line: 50
        -- upvalues: u2 (ref)
        u2:RequestSmartAssistant(1):expect();
    end;

    u3:SetText("Very well.");
    task.delay(1, function() -- Line: 40
        -- upvalues: u3 (ref), u5 (copy)
        u3:Destroy();
        u5();
    end);

    return "ClearResponses";
end);
u3:AddResponse("I would like to contact \"<font color=\"#FF0000\">The Slayer Master</font>\" about slayer contracts.", function() -- Line: 56
    -- upvalues: u2 (copy), u3 (copy)
    local function u6() -- Line: 57
        -- upvalues: u2 (ref)
        u2:RequestSmartAssistant(2):expect();
    end;

    u3:SetText("Very well.");
    task.delay(1, function() -- Line: 40
        -- upvalues: u3 (ref), u6 (copy)
        u3:Destroy();
        u6();
    end);

    return "ClearResponses";
end);
u3:AddResponse("I would like to contact \"<font color=\"#00FF00\">The Master Crafter</font>\" about crafting.", function() -- Line: 63
    -- upvalues: u2 (copy), u3 (copy)
    local function u7() -- Line: 64
        -- upvalues: u2 (ref)
        u2:RequestSmartAssistant(3):expect();
    end;

    u3:SetText("Very well.");
    task.delay(1, function() -- Line: 40
        -- upvalues: u3 (ref), u7 (copy)
        u3:Destroy();
        u7();
    end);

    return "ClearResponses";
end);
u3:AddResponse("I would like to contact \"<font color=\"#0000FF\">The Adventurer</font>\" about the adventure board.", function() -- Line: 70
    -- upvalues: u2 (copy), u3 (copy)
    local function u8() -- Line: 71
        -- upvalues: u2 (ref)
        u2:RequestSmartAssistant(4):expect();
    end;

    u3:SetText("Very well.");
    task.delay(1, function() -- Line: 40
        -- upvalues: u3 (ref), u8 (copy)
        u3:Destroy();
        u8();
    end);

    return "ClearResponses";
end);
u3:AddResponse("I would like to contact \"<font color=\"#A020F0\">The Gacha Addict</font>\" about the ability gacha.", function() -- Line: 77
    -- upvalues: u2 (copy), u3 (copy)
    local function u9() -- Line: 78
        -- upvalues: u2 (ref)
        u2:RequestSmartAssistant(5):expect();
    end;

    u3:SetText("Very well.");
    task.delay(1, function() -- Line: 40
        -- upvalues: u3 (ref), u9 (copy)
        u3:Destroy();
        u9();
    end);

    return "ClearResponses";
end);
u3:AddResponse("I would like to contact \"<font color=\"#00FFFF\">The Haki Master</font>\" about haki customization.", function() -- Line: 84
    -- upvalues: u2 (copy), u3 (copy)
    local function u10() -- Line: 85
        -- upvalues: u2 (ref)
        u2:RequestSmartAssistant(6):expect();
    end;

    u3:SetText("Very well.");
    task.delay(1, function() -- Line: 40
        -- upvalues: u3 (ref), u10 (copy)
        u3:Destroy();
        u10();
    end);

    return "ClearResponses";
end);
u3:AddResponse("I would like to contact \"<font color=\"#ca53e1\">Unusual Merchant</font>\" about unusuals.", function() -- Line: 91
    -- upvalues: u2 (copy), u3 (copy)
    local function u11() -- Line: 92
        -- upvalues: u2 (ref)
        u2:RequestSmartAssistant(7):expect();
    end;

    u3:SetText("Very well.");
    task.delay(1, function() -- Line: 40
        -- upvalues: u3 (ref), u11 (copy)
        u3:Destroy();
        u11();
    end);

    return "ClearResponses";
end);
u3:AddResponse("Nevermind.", function() -- Line: 34, Name: ResetDialogue
    -- upvalues: u3 (copy)
    u3:Destroy();
end);

return u3;