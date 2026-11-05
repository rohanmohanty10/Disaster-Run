  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Satoru Gojo",

    Start = function() -- Line: 8, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Text = "Another student seeking the power of infinity? Most can\'t handle it. The limitless isn\'t just a technique - it\'s a state of mind. Think you\'re up for it?",
            Options = {
                {
                    Response = "I won\'t back down. I need this power, Gojo-sensei!",
                    Next = {
                        Text = "That look in your eyes... Maybe you\'re not just another boring student after all.",
                        Options = {
                            {
                                Response = "I\'m prepared for whatever training you have planned.",

                                Callback = function(p3, p4) -- Line: 27, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Then let\'s begin. First, show me how you handle curses. Numbers mean nothing before infinity."
                                }
                            }
                        }
                    }
                },
                {
                    Response = "I can\'t do it. I give up.",
                    Next = {
                        Text = "At least you\'re honest with yourself. The limitless technique is not fit for the WEAK."
                    }
                }
            }
        },
        step_2 = {
            Text = "Come back when you\'ve dealt with those curses. Show me you understand what infinity truly means."
        },
        step_3 = {
            Text = "Come back when you\'re ready to face your next trial.",
            Options = {
                {
                    Response = "I\'ve learned that true power goes beyond numbers.",

                    Callback = function(p5, p6) -- Line: 53, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                    end,

                    Next = {
                        Text = "Now you\'re getting it. Your next trial awaits - prove yourself against real opponents."
                    }
                }
            }
        },
        step_4 = {
            Text = "Still here? The Jujutsu Sorcerers await. Don\'t keep me waiting."
        }
    }
};