  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Dialogue.new();

local function ResetDialogue() -- Line: 14
    -- upvalues: u4 (copy)
    u4:Destroy();
end;

u4:SetTitle("Hecate");
u4:SetStarterText("What is it that you need...?");
u4:SetCheckStep(function() -- Line: 21
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = u3:GetQuestlineInfo("Slayer_Quest"):expect();
    warn(v5);
    local v6 = not v5 and 1 or v5.Step;
    local v7 = not v5 and {} or v5.Metadata;
    local v8 = v7.Slayers and (v7.Slayers[v7.Slayer] or {}) or {};

    if v6 == 2 then
        u4:SetText((`Did you slay {v8.Slayer} yet? Hint: You might want to defeat some {v8.FodderNPC}`));
    end;

    return v6;
end);

local function toHMS(p9) -- Line: 35
    return string.format("%02i:%02i", p9 / 60 % 60, p9 % 60);
end;

local u10 = nil;
u10 = u4:AddResponse("Do you know of any contracts that I may undertake?", function() -- Line: 40
    -- upvalues: u10 (ref), u3 (copy), u2 (copy), u4 (copy), ResetDialogue (copy)
    u10:ClearLinkedResponses();

    for i, v in u3:GetQuestlineInfo("Slayer_Quest"):expect().Metadata.Slayers do
        if v.Level <= game.Players.LocalPlayer.Data.Ability:GetAttribute("AbilityLevel") then
            u10:LinkResponse(`[CONTRACT] {v.Slayer} (Level {v.Level}+)`, function() -- Line: 51
                -- upvalues: u2 (ref), i (copy), u4 (ref)
                local v11 = u2:CheckDialogue("Slayer_Quest", i):expect();

                if not v11 then
                    u4:SetText("Sorry but your ability level is not high enough for this contract");

                    return;
                end;

                if typeof(v11) ~= "number" then
                    u4:SetText("I\'ve updated your contracts.");

                    return "ClearResponses";
                end;

                u4:SetText((`You have to wait {string.format("%02i:%02i", v11 / 60 % 60, v11 % 60)} minutes to retake this contract ({i})`));
            end).GetLevelRequirement = function(p12) -- Line: 64, Name: GetLevelRequirement
                -- upvalues: v (copy)
                return v.Level;
            end;
        end;
    end;

    table.sort(u10:GetLinkedResponses(), function(p13, p14) -- Line: 70
        return p14:GetLevelRequirement() > p13:GetLevelRequirement();
    end);

    if #u10:GetLinkedResponses() > 0 then
        u4:SetText("I have been made aware of the following SLAYER contracts that you may undertake.");
        u10:LinkResponse("Nevermind", ResetDialogue);

        return "Continue";
    end;

    u4:SetText("You are too underleveled to take on any SLAYER contracts [LVL 25 MINIMUM REQUIRED]");
end);
u4:AddResponse("Nevermind, it was nothing.", ResetDialogue);

return u4;