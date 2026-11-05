  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.GetLevelRecommendation);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = Knit.GetService("AdventureService");
local u5 = Dialogue.new();
u5:SetTitle("The Quest Dealer");
u5:SetStarterText("Hey.");

local function CheckIfMaterialCostsIsComplete() -- Line: 19
    local QuestLines = game.Players.LocalPlayer:FindFirstChild("QuestLines");

    if QuestLines then
        local v6 = QuestLines:FindFirstChild("Material Costs");
        local v7 = v6 and v6:FindFirstChild("Material Costs");

        if v7 then
            local v8 = false;

            for _, child in v7:GetChildren() do
                if child.Value == child:GetAttribute("MaxValue") then
                    v8 = true;
                end;
            end;

            if v8 then
                return true;
            end;
        end;
    end;
end;

function u5.Setup(p9) -- Line: 42
    -- upvalues: u5 (copy), u4 (copy), u3 (copy), CheckIfMaterialCostsIsComplete (copy), u2 (copy)
    u5:AddCallback("OnDestroy", function(p10) -- Line: 43
        table.clear(p10._Responses);
    end);
    local v11 = u4:GetQuests():expect();
    local v12 = u4:GetAdventureNames():expect();
    local v13 = 0;

    for _, _ in v11 do
        v13 = v13 + 1;
    end;

    if v13 == 0 then
        u5:SetText("Sorry, but I don\'t have any adventures for you right now.");

        return;
    end;

    local v14 = {
        MaterialQuests = false,
        SpecialGrade = false
    };
    local v15 = false;

    for i, _ in v12 do
        if u3:GetQuestlineInfo(i):expect() ~= nil then
            v15 = true;

            if i == "Material_Costs_Adventure" then
                v14.MaterialQuests = CheckIfMaterialCostsIsComplete();
            end;

            break;
        end;
    end;

    local v16 = u4:AttemptClaim():expect();
    print("claimed", v16);

    if v16 then
        u5:SetText("Good work.");

        return true;
    end;

    if v14.MaterialQuests then
        u5:AddResponse("Ok", function() -- Line: 89
            -- upvalues: u2 (ref)
            u2:TalkedToTheQuestBoard("The Quest Dealer");

            return "Continue";
        end);
        u5:SetText("I\'ll be taking those materials, then. Good work.");

        return;
    end;

    warn("adventure is in progress? : ", v15);

    if v15 then
        u5:SetText("Please finish the current adventure you embarked on before taking more.");

        return;
    end;

    u5:SetText("My clients have given me a few jobs, take your pick.");

    for i, v in v11 do
        local u17 = v[2];
        u5:AddResponse(v[1], function() -- Line: 110
            -- upvalues: u2 (ref), i (copy), u5 (ref), u17 (copy)
            if not u2:CheckRequirement("AdventureCondition", i, 1) then
                u5:SetText("This adventure is currently occupied by someone else.");

                return "ClearResponses";
            end;

            u2:CheckDialogue(i):expect();
            u5:SetText(u17);

            return "ClearResponses";
        end);
    end;
end;

return u5;