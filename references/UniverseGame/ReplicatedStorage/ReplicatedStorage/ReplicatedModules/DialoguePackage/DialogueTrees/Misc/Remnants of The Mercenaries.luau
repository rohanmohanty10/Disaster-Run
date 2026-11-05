  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "skaidev",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "YOU! You look like a proper hitman, do you take hires?",
            Options = {
                {
                    Response = "Depends",
                    Next = {
                        Text = "That bloody Spy has taken my weaponry, I\'ll hire you to take him out and retrieve whats rightfully mine!",
                        Options = {
                            {
                                Response = "What\'s the pay?",
                                Next = {
                                    Text = "I\'ll see when that happens, now scram! Find me my weaponry pronto. [Make sure to have Inventory Space in Abilities upon completion]"
                                },

                                Callback = function(p3) -- Line: 34, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                end
                            },
                            {
                                Response = "Not my cup of tea",
                                Next = "reject"
                            }
                        }
                    }
                },
                {
                    Response = "No",
                    Next = "reject"
                }
            }
        },
        step_2 = {
            Mutable = true,
            Text = "Once you have all items in your inventory & have taken out The Spy, come back to me.",
            Options = {
                {
                    Response = "Okay",

                    Callback = function(p4, p5) -- Line: 58, Name: Callback
                        -- upvalues: u1 (copy)
                        local v6, v7 = u1:CheckDialogue(script.Name):expect();

                        if v6 == "SPYALIVE" then
                            p5.Next = {
                                Text = "That spy is still alive and runnin\' around with my weaponry! What are you doing?"
                            };

                            return;
                        end;

                        if v6 == "NOITEM" then
                            p5.Next = {
                                Text = `That spy may be eliminated, but you do not hold all of the weaponry he took from my hands!\n[MISSING ITEMS: {table.concat(v7, ", ")}]`
                            };

                            return;
                        end;

                        if v6 == "INVFULL" then
                            p5.Next = {
                                Text = "You\'ve done well, Soldier, though it seems you have enough on your plate. Come back to me when you\'re not carrying other weaponry around.\n[REMOVE SOMETHING FROM YOUR ABILITY INVENTORY TO CONTINUE]"
                            };

                            return;
                        end;

                        p5.Next = {
                            Text = "You\'ve done well, Soldier. Let me put somethin\' together for ya real quick..",
                            Options = { {
                                    Response = "Pleasure doing business",
                                    Next = "reject"
                                } }
                        };
                    end
                }
            }
        },
        step_3 = {
            Mutable = true,
            Text = "You\'ve done well, Soldier. Let me put somethin\' together for ya real quick..",
            Options = {
                {
                    Response = "Pleasure doing business",
                    Next = "reject",

                    Callback = function(p8) -- Line: 94, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                    end
                }
            }
        },
        reject = {
            Text = "Suit yourself then."
        }
    }
};