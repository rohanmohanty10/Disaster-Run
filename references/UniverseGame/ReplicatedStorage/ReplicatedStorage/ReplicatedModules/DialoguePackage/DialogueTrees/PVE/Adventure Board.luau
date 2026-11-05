  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.GetLevelRecommendation);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local u3 = Knit.GetService("AdventureService");

local function CheckIfMaterialCostsIsComplete() -- Line: 13
    local QuestLines = game.Players.LocalPlayer:FindFirstChild("QuestLines");

    if QuestLines then
        local v4 = QuestLines:FindFirstChild("Material Costs");
        local v5 = v4 and v4:FindFirstChild("Material Costs");

        if v5 then
            local v6 = false;

            for _, child in v5:GetChildren() do
                if child.Value == child:GetAttribute("MaxValue") then
                    v6 = true;
                end;
            end;

            if v6 then
                return true;
            end;
        end;
    end;
end;

local u7 = {
    Response = "Nevermind.",
    Next = nil
};

return {
    Start = "start",
    Title = "The Quest Dealer",
    Nodes = {
        start = {
            Mutable = true,
            Text = "Hey.",
            Options = {
                {
                    Response = "You got anything for me?",

                    Callback = function(p8, p9) -- Line: 52, Name: Callback
                        -- upvalues: u3 (copy)
                        local v10 = 0;

                        for _, _ in u3:GetQuests():expect() do
                            v10 = v10 + 1;
                        end;

                        p9.Next = v10 <= 0 and "no_adventures" or "adventures";
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                u7
            }
        },
        adventures = {
            Mutable = true,
            Text = "",

            Transformer = function(p11, p12) -- Line: 71, Name: Transformer
                -- upvalues: u3 (copy), u2 (copy), CheckIfMaterialCostsIsComplete (copy), u1 (copy), u7 (copy), Dialogue (copy)
                local v13 = u3:GetQuests():expect();
                local v14 = {
                    MaterialQuests = false,
                    SpecialGrade = false
                };
                local v15 = false;

                for i, _ in u3:GetAdventureNames():expect() do
                    if u2:GetQuestlineInfo(i):expect() ~= nil then
                        v15 = true;

                        if i == "Material_Costs_Adventure" then
                            v14.MaterialQuests = CheckIfMaterialCostsIsComplete();
                        end;

                        break;
                    end;
                end;

                warn("adventure is in progress? : ", v15);

                if v15 then
                    p12.Text = "Please finish the current adventure you embarked on before taking more.";

                    return true;
                end;

                p12.Text = "My clients have given me a few jobs, take your pick.";

                for i, v in v13 do
                    local u16 = v[2];
                    table.insert(p12.Options, 1, {
                        Response = v[1],

                        Callback = function(p17, p18) -- Line: 110, Name: Callback
                            -- upvalues: u1 (ref), i (copy), u7 (ref), u16 (copy)
                            if not u1:CheckRequirement("AdventureCondition", i, 1) then
                                p18.Next = {
                                    Text = "This adventure is currently occupied by someone else.",
                                    Options = { u7 }
                                };

                                return true;
                            end;

                            u1:CheckDialogue(i):expect();
                            p18.Next = {
                                Text = u16,
                                Options = { {
                                        Response = "Thanks",
                                        Next = nil
                                    } }
                            };
                        end,

                        Next = Dialogue.PLACEHOLDER
                    });
                end;
            end,

            Options = { u7 }
        },
        no_adventures = {
            Text = "Sorry, but I don\'t have any adventures for you right now.",
            Options = { {
                    Response = "Okay then.",
                    Next = nil
                } }
        }
    }
};