  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Godot",

    Start = function() -- Line: 8, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Arrghh... Hey there, young man. Can you help me find some scraps?",
            Options = {
                {
                    Response = "Sure, what do you need?",
                    Next = {
                        Text = "I need about 50 metal scraps.. if you find me all, I\'ll give you something special.",
                        Options = {
                            {
                                Response = "Alright.",

                                Callback = function(p3, p4) -- Line: 28, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Thank you....! All of these young men refuse to help me, I can sense special energy from you.."
                                }
                            }
                        }
                    }
                },
                {
                    Response = "No, sorry.",
                    Next = {
                        Text = "It\'s fine, may you propser further, young man..."
                    }
                }
            }
        },
        step_2 = {
            Text = "Keep going, I believe in you!"
        },
        step_3 = {
            Mutable = true,
            Text = "Have you retrieved all 50 as requested?",
            Options = {
                {
                    Response = "I have.",

                    Callback = function(p5, p6) -- Line: 55, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue(script.Name):expect() == true then
                            p6.Next = {
                                Text = "Thank you so much..! Here\'s a sword I made quite a while ago, I call it the \'Dragon Slayer`. You can use it, but it\'s quite heavy, I personally don\'t know how you\'ll be able to sustain it, but honestly you might be able to... you have exceeded my expectations."
                            };

                            return;
                        end;

                        p6.Next = {
                            Text = "I don\'t see them!"
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};