  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Title = "Gyro Zeppeli (Q: Spinning Nails)",

    Start = function() -- Line: 9, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Hey, can you help me out? I need help killing these thugs, please help!",
            Options = {
                {
                    Response = "What\'s in it for me?",
                    Next = {
                        Text = "I\'ll show you how to use some form of spin energy and utilize it.",
                        Options = {
                            {
                                Response = "Oh, for sure then!",

                                Callback = function(p3, p4, p5) -- Line: 29, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                    p4.Next = {
                                        Text = "Alright, good luck."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                },
                {
                    Response = "I\'m good.",
                    Next = {
                        Text = "Maybe next time."
                    }
                }
            }
        },
        step_2 = {
            Text = "Have you slain the thugs?"
        },
        step_3 = {
            Mutable = true,
            Text = "Awesome, you now have spin energy inside of you. If you want to make valuable use off of it, I\'d suggest playing around with Saint\'s Ribs if you manage to find them.",
            Options = {
                {
                    Response = "Thank you.",

                    Callback = function(p6, p7, p8) -- Line: 57, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                        p7.Next = nil;
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};