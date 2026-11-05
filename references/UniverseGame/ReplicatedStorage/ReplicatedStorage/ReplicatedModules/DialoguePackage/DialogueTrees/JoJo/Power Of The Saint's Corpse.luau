  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Funny Valentine",

    Start = function() -- Line: 8, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Text = "Is there something you need?",
            Options = {
                {
                    Response = "I\'m interested in becoming your apprentice... \n⚠ PRICE: 500,000 UCOINS ⚠",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p3, p4, p5) -- Line: 23, Name: Callback
                        -- upvalues: u1 (copy)
                        local v6 = u1:CheckDialogue(script.Name):expect();

                        if v6 == true then
                            p4.Next = {
                                Text = "I see how it is. Let\'s start our deal. Find and use these corpse parts and come back to me for a final task.",
                                Options = { {
                                        Response = "Thanks I\'ll be back",
                                        Next = nil
                                    } }
                            };

                            return;
                        end;

                        if type(v6) == "number" then
                            p4.Next = {
                                Text = string.format("My time is money. Get the cash before we can even consider talking! [%s more uCoins]", v6),
                                Options = { {
                                        Response = "Okay",
                                        Next = "step_1"
                                    } }
                            };
                        end;
                    end
                },
                {
                    Response = "No, sorry for bothering you",
                    Next = nil
                }
            }
        },
        step_2 = {
            Text = "Only come back to me once you\'ve completed what I demand of you, my new subordinate."
        },
        step_3 = {
            Text = "You\'re pretty good at this, there\'s only one final task left:\n The criminal, Diavolo, is out on the loose, and carrying the saint\'s skull. Kill him and use the skull."
        },
        step_4 = {
            Text = "Seems you made quick work of Diavolo, \nNow, let me show you how to use this corpse...",
            Options = {
                {
                    Response = "I will accept the power of the corpse.\n [Gives Saint\'s Corpse] (Use on D4C)",
                    Next = nil,

                    Callback = function(p7, p8, p9) -- Line: 65, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                    end
                }
            }
        }
    }
};