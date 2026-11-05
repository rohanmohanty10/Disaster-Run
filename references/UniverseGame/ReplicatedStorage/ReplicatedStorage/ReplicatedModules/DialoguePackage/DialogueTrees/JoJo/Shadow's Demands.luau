  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Him",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: u2 (copy)
        return "step_" .. (u2:GetCurrentStep(script.Name):expect() or 1);
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "...",

            Transformer = function(p3, p4) -- Line: 23, Name: Transformer
                -- upvalues: Players (copy), u1 (copy)
                if Players.LocalPlayer.Data.Ability.Value == 10019 then
                    p4.Text = "Hmph. You have quite the unique ability - but it has yet reached its potential. Turn to the path of the \'Shadows\', only then will you achieve greater heights.";
                    p4.Options = {
                        {
                            Response = "Alright.",
                            Next = "end",

                            Callback = function() -- Line: 32, Name: Callback
                                -- upvalues: u1 (ref)
                                u1:CheckDialogue(script.Name):expect();
                            end
                        },
                        {
                            Response = "No",
                            Next = {
                                Text = "Get out of my sight.",
                                Options = {}
                            }
                        }
                    };

                    return;
                end;

                p4.Text = "Get out of here.";
                p4.Options = {};
            end,

            Options = {}
        },
        step_2 = {
            Text = "EGOIST - BANG!!!",
            Options = {
                {
                    Response = "...",

                    Callback = function(p5) -- Line: 59, Name: Callback
                        p5:Destroy();
                    end
                }
            }
        },
        ["end"] = {
            Text = "...",
            Options = {}
        }
    }
};