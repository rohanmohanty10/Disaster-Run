  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
Knit.GetService("AdventureService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return {
    Title = "Umbra",

    Start = function() -- Line: 14, Name: GetStart
        -- upvalues: u3 (copy)
        local v4 = u3:GetCurrentStep(script.Name):expect();

        return v4 == 2 and "step_tasks" or (v4 == 3 and "step_duel" or (v4 == 4 and "step_finale" or "step_init"));
    end,

    Nodes = {
        step_init = {
            Text = "Is there something you need?",
            Options = {
                {
                    Response = "I heard you knew a lot about sword styles. I wish to learn them! <font color=\"#ff2\">(Requires 100,000 UCoins)</font>",
                    Next = {
                        Mutable = true,

                        Transformer = function(p5, p6) -- Line: 39, Name: Transformer
                            -- upvalues: u2 (copy), LocalPlayer (copy)
                            if u2:CheckDialogue(script.Name, "Yone"):expect() then
                                p6.Text = "It seems you\'ve come prepared for this. Complete these tasks and return to me.";

                                return;
                            end;

                            p6.Text = string.format("This isn\'t free bud, you\'re gonna need <Color=#ff2>%s<Color=/> more UCoins", 100000 - LocalPlayer.Data.UCoins.Value);
                        end
                    }
                }
            }
        },
        step_tasks = {
            Text = "Talk to me again when you have completed my tasks.",
            Options = { {
                    Response = "Thanks, I\'ll be back."
                } }
        },
        step_duel = {
            Text = "It seems you have potential... Very well, let us duel to see your growth, though you should bring teammates as I\'m quite strong."
        },
        step_finale = {
            Text = "Hahaha, that was very fun, but more importantly you\'ve proven your worth! That being said, if you hold either an <Color=#fff>azakana mask<Color=/> or an <Color=#fff>ancient sword<Color=/>, perhaps I could teach you those techniques.",
            Options = {
                {
                    Response = "I wish to be Unforgiven (Yasuo)",
                    Mutable = true,

                    Callback = function(p7, p8) -- Line: 68, Name: Callback
                        -- upvalues: u2 (copy)
                        if u2:CheckDialogue(script.Name, "Yasuo"):expect() == "InventoryFull" then
                            p8.Next = {
                                Text = "Your ability inventory is full. Come back to me when you have a free inventory slot."
                            };

                            return;
                        end;

                        p8.Next = {
                            Text = "You do not have an <Color=#fff>Ancient Sword<Color=/> in your backpack."
                        };
                    end
                },
                {
                    Response = "I wish to be Unforgotten (Yone)",
                    Mutable = true,

                    Callback = function(p9, p10) -- Line: 84, Name: Callback
                        -- upvalues: u2 (copy)
                        if u2:CheckDialogue(script.Name, "Yone"):expect() == "InventoryFull" then
                            p10.Next = {
                                Text = "Your ability inventory is full. Come back to me when you have a free inventory slot."
                            };

                            return;
                        end;

                        p10.Next = {
                            Text = "You do not have an <Color=#fff>Azakana Mask<Color=/> in your backpack."
                        };
                    end
                }
            }
        }
    }
};