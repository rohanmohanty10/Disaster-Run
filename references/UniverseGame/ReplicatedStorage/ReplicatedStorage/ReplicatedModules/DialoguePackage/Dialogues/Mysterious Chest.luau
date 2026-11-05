  

 

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

u2:SetTitle("Distinguished Wolf");
u2:SetCheckStep(function(p8, p9) -- Line: 26
    -- upvalues: u4 (copy), u2 (copy)
    local v10 = u4:GetCurrentStep(script.Name):expect();

    if v10 == 2 then
        u2:SetText("Have you found the key yet?");

        return v10;
    end;

    if v10 ~= 3 then
        if v10 == 4 then
            u2:SetText("Did you do the requests yet?");

            return v10;
        end;

        if v10 == 5 then
            u2:SetText("I\'ve discovered more and found out that you must have got an orb. Use it and it will tell you what to do....");
        end;

        return v10;
    end;

    if not (p8 and p9) then
        u2:SetText("I just opened the chest, it turns out that it has a scroll inside of it. It asks me to do these requests, but I am physically unable to do so, you mind doing them for me?~");

        return v10;
    end;

    local _ = p9 - p8;
    u2:SetText("Thank you for finding the key!");

    return "ClearResponses";
end);

function u2.Setup(p11, p12, p13) -- Line: 48
    -- upvalues: u2 (copy), u3 (copy)
    u2:AddCallback("OnDestroy", function(p14) -- Line: 49
        table.clear(p14._Responses);
    end);

    if p12 and p13 then
        return "ClearResponses";
    end;

    u2:SetText("Help me find the key for this chest behind me");
    u2:AddResponse("What?", function() -- Line: 59
        -- upvalues: u2 (ref)
        u2:SetText("I found this chest & I\'ve been carrying it for a bit, please help me find the key for it so I can see what\'s inside it.");

        return "Continue";
    end):SetStep(1):LinkResponse("Okay, sure.", function() -- Line: 62
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Thank you so much!");

        return "ClearResponses";
    end);
    u2:AddResponse("No lol", function() -- Line: 68
        -- upvalues: u2 (ref)
        u2:SetText("Bruh");

        return "ClearResponses";
    end):SetStep(1);
    u2:AddResponse("Sure.", function() -- Line: 73
        -- upvalues: u3 (ref), u2 (ref)
        u3:CheckDialogue(script.Name):expect();
        u2:SetText("Thank you so much!");

        return "ClearResponses";
    end):SetStep(3);
    u2:AddResponse("I gotcha.", function() -- Line: 79
        -- upvalues: u2 (ref), u3 (ref)
        u2:SetText("I wish you well, stay safe!");
        u3:CheckDialogue(script.Name):expect();

        return "ClearResponses";
    end):SetStep(5);
end;

return u2;