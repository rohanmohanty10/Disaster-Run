  

 

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

u2:SetTitle("BobBallin");
u2:SetCheckStep(function(p8, p9) -- Line: 27
    -- upvalues: u4 (copy), u2 (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();

    if v10 == 2 then
        u2:SetText("I still dont see the sigma in you");

        return v10;
    end;

    if v10 == 3 then
        u2:SetText("welcome to the sigma society");
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
        u2:SetText("I be like the joker 🃏 🤡 😈 Society be hating 🏙️ 😠 ❌ But I js wanna be evil 🔥 🗣️ 📏");

        return "ClearResponses";
    end;

    u2:SetText("I be like the joker 🃏 🤡 😈 Society be hating 🏙️ 😠 ❌ But I js wanna be evil 🔥 🗣️ 📏");
    u2:AddResponse("I\'m here for haoshoku haki", function() -- Line: 55
        -- upvalues: u2 (ref)
        u2:SetText("Perhaps... we can arrage something");

        return "Continue";
    end):SetStep(1):LinkResponse("gulps..", function() -- Line: 58
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Get to working then.. The quest wont complete itself");

        return "ClearResponses";
    end);
    u2:AddResponse("I\'m out of here.", function() -- Line: 64
        -- upvalues: u2 (ref)
        u2:SetText("not sigma");

        return "ClearResponses";
    end):SetStep(1);
    u2:AddResponse("*gulps*", function() -- Line: 69
        -- upvalues: u3 (ref)
        u3:CheckDialogue(script.Name):expect();

        return "ClearResponses";
    end):SetStep(3);
end;

return u2;