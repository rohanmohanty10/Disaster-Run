  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Title = "Gyro Zeppeli (Q: Golden Rectangle Nails)",

    Start = function() -- Line: 9, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "I see you\'ve progressed the visualization of your spin technique further. Would you like to progress further?",
            Options = {
                {
                    Response = "Yeah sure",
                    Next = {
                        Text = "Alright, you will need to utilize your nail gliding technique & slay some enemies again. Check your quests section for more details.",
                        Options = {
                            {
                                Response = "Okay, I got it.",

                                Callback = function(p3, p4, p5) -- Line: 29, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                    p4.Next = {
                                        Text = "Good luck!"
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                },
                {
                    Response = "Nah, not right now.",
                    Next = {
                        Text = "Alright, I got you."
                    }
                }
            }
        },
        step_2 = {
            Text = "Have you completed the first part of the process?"
        },
        step_3 = {
            Mutable = true,
            Text = "Awesome, now I need you to amass & claim bounty. This might be a difficult task but I need to make sure you\'re worthy enough to take this to the next level.",
            Options = {
                {
                    Response = "I got it.",

                    Callback = function(p6, p7, p8) -- Line: 57, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                        p7.Next = {
                            Text = "Good luck!"
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        },
        step_4 = {
            Text = "You done yet?"
        },
        step_5 = {
            Mutable = true,
            Text = "Awesome, use these saint\'s arms on that and you\'ll reach the next level. Make sure to use it while you\'re in this session otherwise it won\'t work later. Also, once you get ACT2, I\'d recommend reaching ASC2 and try to use Dark Determination as much as you can, it should leave an effect.",
            Options = {
                {
                    Response = "Alright, thank you so much.",

                    Callback = function(p9, p10, p11) -- Line: 76, Name: Callback
                        -- upvalues: u1 (copy)
                        p10.Next = {
                            Text = "See you soon."
                        };
                        u1:CheckDialogue(script.Name):expect();
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};