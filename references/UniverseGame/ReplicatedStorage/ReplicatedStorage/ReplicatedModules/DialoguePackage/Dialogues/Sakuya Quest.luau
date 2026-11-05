  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetCheckStep(function() -- Line: 13
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetCurrentStep(script.Name):expect();

    if v5 == 2 then
        u4:SetText("🤡🤡🤡🤡🤡🤡🤡🤡🤡🤡🤡🤡🤡");
    end;

    return v5;
end);
u4:SetTitle("Sakuya Fumo");
u4:SetStarterText("Do you want to get strong enough to be able to manipulate time as you want?");
u4:AddResponse("YES", function() -- Line: 24
    -- upvalues: u2 (copy), u4 (copy)
    u2:CheckDialogue(script.Name):expect();
    u4:Destroy();
end);

return u4;