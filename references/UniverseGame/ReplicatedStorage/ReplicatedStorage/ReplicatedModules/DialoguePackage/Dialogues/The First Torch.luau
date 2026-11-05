  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();
u4:SetTitle("The First Torch");
u4:SetStarterText("It seems that you are capable enough to reach this place, passerby. The torches speak with your soul, it senses that your soul thrives for more power. Help the torches, and it shall help you.");
local u5 = nil;
u5 = u4:AddResponse("Okay.", function(p6) -- Line: 18
    -- upvalues: u4 (copy), u2 (copy), u3 (copy), u5 (ref)
    u4:SetText("Goodluck, passerby.");
    u4:Destroy();
    u2:TalkedToTheGuide("The First Torch");

    if not u3:GetQuestlineInfo("TheFirstTorch_Quest"):expect() then
        u5:ClearLinkedResponses();
    end;
end);
u4:AddResponse("No.", function(p7) -- Line: 29
    -- upvalues: u4 (copy)
    u4:SetText("Then you shall pay, goodbye.");
    u4:Destroy();

    if p7.Character and p7.Character:FindFirstChildOfClass("Humanoid") then
        p7.Character:FindFirstChildOfClass("Humanoid").Health = 0;
        p7.Character:FindFirstChildOfClass("Humanoid").MaxHealth = 0;
    end;
end);

return u4;