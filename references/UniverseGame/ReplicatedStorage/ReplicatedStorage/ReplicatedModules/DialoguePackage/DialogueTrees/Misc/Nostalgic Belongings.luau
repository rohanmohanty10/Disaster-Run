  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Builderman",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: u2 (copy)
        return "step_" .. (u2:GetCurrentStep(script.Name):expect() or 1);
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Hello! I could use some assistance.",
            Options = {
                {
                    Response = "What happened?",
                    Next = {
                        Text = "During my travel here, I\'ve lost some of my belongings. Would you mind helping me find them?",
                        Options = {
                            {
                                Response = "Sure!",

                                Callback = function(p3, p4) -- Line: 32, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Thanks",
                                    Options = {}
                                }
                            },
                            {
                                Response = "Goodbye",
                                Next = "end"
                            }
                        }
                    }
                },
                {
                    Response = "Goodbye",
                    Next = "end"
                }
            }
        },
        step_2 = {
            Mutable = true,
            Text = "",

            Transformer = function(p5, p6) -- Line: 56, Name: Transformer
                -- upvalues: u1 (copy)
                p6.Text = "We have to keep searching! They have to be around here somewhere. Come back to me when you have all of my belongings in your Backpack (Hotbar)";
                p6.Options = {
                    {
                        Response = "Okay",
                        Next = "",

                        Callback = function(p7, p8) -- Line: 61, Name: Callback
                            -- upvalues: u1 (ref)
                            if u1:CheckDialogue(script.Name):expect() then
                                p8.Next = "step_3";
                            end;
                        end
                    }
                };
            end,

            Options = {}
        },
        step_3 = {
            Text = "Thank you so much! To compensate for your troubles I\'ll give you [Brickbattle]",
            Options = {
                {
                    Response = "Thank you!",
                    Next = "",

                    Callback = function(p9, p10) -- Line: 80, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                    end
                }
            }
        },
        ["end"] = {
            Text = "Goodbye.",
            Options = {}
        }
    }
};