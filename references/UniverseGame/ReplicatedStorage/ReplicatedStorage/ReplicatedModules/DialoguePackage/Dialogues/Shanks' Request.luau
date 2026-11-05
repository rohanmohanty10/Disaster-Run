  

 

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

u2:SetTitle("Shanks");
u2:SetCheckStep(function(p8, p9) -- Line: 26
    -- upvalues: u4 (copy), u2 (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();

    if v10 == 2 then
        u2:SetText("H?");

        return v10;
    end;

    if v10 == 3 then
        u2:SetText("Awesome. Take this slime energy and use it on standless. This will grant you the same abilities that Cid used to fight you. I expect good things from you, so long!");
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

    u4:GetCurrentStep(script.Name):expect();
    u2:SetText("Hey can you kill Cid? I will give you a really good reward if you manage to slay him.");
    u2:AddResponse("Yeah.", function() -- Line: 50
        -- upvalues: u2 (ref)
        u2:SetText("Ok, make sure to get the cursed gemstone from Nitron if you don\'t already have it, you\'ll need it to summon Cid.");

        return "Continue";
    end):SetStep(1):LinkResponse("Gotcha.", function() -- Line: 53
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Alright, good luck.");

        return "ClearResponses";
    end);
    u2:AddResponse("Nah, I\'m good.", function() -- Line: 59
        -- upvalues: u2 (ref)
        u2:SetText("Lol ok");

        return "ClearResponses";
    end):SetStep(1);
    u2:AddResponse("Thanks.", function() -- Line: 64
        -- upvalues: u3 (ref)
        u3:CheckDialogue(script.Name):expect();

        return "ClearResponses";
    end):SetStep(3);
end;

return u2;