  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Bur",

    Start = function() -- Line: 8, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Hey can you kill Cid? I will give you a really good reward if you manage to slay him.",
            Options = {
                {
                    Response = "Yeah.",
                    Next = {
                        Mutable = true,
                        Text = "Ok, make sure to get the cursed gemstone from Nitron if you don\'t already have it, you\'ll need it to summon Cid.",
                        Options = {
                            {
                                Response = "Gotcha.",

                                Callback = function() -- Line: 29, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Alright, good luck."
                                }
                            }
                        }
                    }
                },
                {
                    Response = "Nah, I\'m good.",
                    Next = {
                        Text = "Lol ok"
                    }
                }
            }
        },
        step_2 = {
            Text = "Have you slain shadow??"
        },
        step_3 = {
            Mutable = true,
            Text = "Awesome. Take this slime energy and use it on standless. This will grant you the same abilities that Cid used to fight you. I expect good things from you, so long!",
            Options = {
                {
                    Response = "Thanks.",
                    Next = nil,

                    Callback = function() -- Line: 56, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                    end
                }
            }
        }
    }
};