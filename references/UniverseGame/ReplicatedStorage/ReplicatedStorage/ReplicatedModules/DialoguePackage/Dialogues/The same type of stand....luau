  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();

local function ResetDialogue() -- Line: 13
    -- upvalues: u4 (copy)
    u4:Destroy();
end;

u4:SetCheckStep(function() -- Line: 17
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetText("Have you watched Date A Live???");

        return v5;
    end;

    if v5 == 3 then
        u4:SetText("Well done on completing those objectives, you have now attained Star Platinum: The World. [YOU NEED TO EQUIP STAR PLATINUM FIRST]");
    end;

    return v5;
end);
u4:SetTitle("Jotaro Kujo");

function u4.Setup(p6) -- Line: 29
    -- upvalues: u4 (copy), u2 (copy), ResetDialogue (copy)
    u4:AddCallback("OnDestroy", function(p7) -- Line: 30
        table.clear(p7._Responses);
    end);

    if game.Players.LocalPlayer.Data.Ability.Value ~= 2 then
        u4:SetText("You do not possess my ability. Talk to me when you are ready to evolve it.");

        return;
    end;

    u4:SetStarterText("Hey, I\'m Jotaro Kujo, a stand user. If you have a stand like mine, I can train you to evolve it.");
    local v8 = u4:AddResponse("Ok", function() -- Line: 40
        -- upvalues: u4 (ref)
        u4:SetText("I\'ll need my old hat as payment, to evolve Star Platinum you\'ll need to train it\'s strength, I\'ve given you a list of tasks to help raise it\'s power.");

        return "Continue";
    end);
    v8:LinkResponse("Alright, thanks.", function() -- Line: 45
        -- upvalues: u2 (ref), u4 (ref)
        if not u2:CheckDialogue(script.Name):expect() then
            u4:SetText("It seems you are missing [Mysterious Hat], come back when you\'ve obtained it");

            return "Continue";
        end;

        u4:Destroy();
    end):LinkResponse("Hmm. Okay.", ResetDialogue);
    v8:LinkResponse("I\'ve changed my mind, goodbye.", ResetDialogue);
    u4:AddResponse("Sorry, goodbye.", ResetDialogue);
    u4:AddResponse("Alright, thanks.", function() -- Line: 58
        -- upvalues: u2 (ref), u4 (ref)
        u2:CheckDialogue(script.Name):expect();
        u4:Destroy();
    end):SetStep(3);
end;

return u4;