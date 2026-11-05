  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Dying Soul Reaper",

    Start = function() -- Line: 8, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Arrghh..... I\'m bleeding out! Listen, you must finish the job & kill the hollow destroying the city, they are all over, please, help me, I\'m ready to give you my reiatsu energy so you can do this!",
            Options = {
                {
                    Response = "Oh my god, you really are, listen, I\'ll do it.",
                    Next = {
                        Text = "Take my powers, I don\'t know if you\'re strong enough for it, but in this moment, you are the only one who can do this. Remember, if you kill the hollow, you\'ll keep the powers, but don\'t die to it, for the consequences are uncertain and unwanted..",
                        Options = {
                            {
                                Response = "I won\'t disappoint you.",

                                Callback = function(p3, p4) -- Line: 28, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Good luck.. I put my faith in you."
                                }
                            }
                        }
                    }
                },
                {
                    Response = "I\'m sorry, I don\'t think I have the strength to.",
                    Next = {
                        Text = "ARRGHHHH."
                    }
                }
            }
        },
        step_2 = {
            Text = "..."
        }
    }
};