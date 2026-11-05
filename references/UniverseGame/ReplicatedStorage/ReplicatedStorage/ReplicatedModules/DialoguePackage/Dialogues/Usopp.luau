  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
Knit.GetService("AdventureService");
local u4 = Dialogue.new();
local u5 = false;

function u4.Setup(p6) -- Line: 16
    -- upvalues: u3 (copy), u5 (ref), u4 (copy), u2 (copy)
    if not u3:GetQuestlineInfo("Save_The_Village_Adventure"):expect() then
        if u5 then
            u4:SetText("Thank you for saving our village! You\'re welcome here any time!");
        else
            u4:SetText("Oh, uhh... Hey! Welcome to Syrup Village!");
        end;

        return true;
    end;

    local v7, v8 = u2:CheckDialogue("Save_The_Village_Adventure"):expect();

    if v7 then
        if v8 == 2 then
            u4:SetText("Help us! Save us! Our village, Syrup Village, is being attacked by Kuro!");

            return true;
        end;

        if v8 == 3 then
            u5 = true;
            u4:SetText("Thank you... Please, take my rewards!");

            return true;
        end;
    elseif v8 == 2 then
        u4:SetText("What are you doing? Please save us, I beg of you! Don\'t let him ruin our village!");

        return true;
    end;
end;

return u4;