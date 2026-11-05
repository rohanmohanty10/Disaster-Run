  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetCheckStep(function() -- Line: 17
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetText("EGOIST - BANG!!!");
    end;

    return v5;
end);
u4:SetTitle("Him");

function u4.Setup(p6) -- Line: 28
    -- upvalues: u4 (copy), u2 (copy)
    u4:AddCallback("OnDestroy", function(p7) -- Line: 29
        table.clear(p7._Responses);
    end);

    if game.Players.LocalPlayer.Data.Ability.Value ~= 10019 then
        u4:SetText("Get out of here.");

        return;
    end;

    u4:SetStarterText("Hmph. You have quite the unique ability - but it has yet reached its potential. Turn to the path of the \'Shadows\', only then will you achieve greater heights.");
    u4:AddResponse("Alright.", function() -- Line: 39
        -- upvalues: u2 (ref), u4 (ref)
        u2:CheckDialogue(script.Name):expect();
        u4:Destroy();
    end);
    u4:AddResponse("No", function() -- Line: 44
        -- upvalues: u4 (ref)
        u4:SetText("Get out of my sight.");

        return "ClearResponses";
    end);
end;

u4:AddResponse("...", function() -- Line: 13, Name: ResetDialogue
    -- upvalues: u4 (copy)
    u4:Destroy();
end):SetStep(2);

return u4;