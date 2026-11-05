  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("ShopService");
Knit.GetService("QuestLineService");

return {
    Start = "start",
    Title = "Big Hoss",
    Nodes = {
        start = {
            Mutable = true,
            Text = "I\'m in dire need of a McChicken. I can let you take on my Shadow, however I\'ll be needing a [Monochromatic Orb] and [5.000.000] UCoins to cover those costs.",
            Options = {
                {
                    Response = "Sure",

                    Callback = function(p2, p3, p4) -- Line: 19, Name: Callback
                        -- upvalues: u1 (copy)
                        local v5 = u1:CheckRequirement("ItemCountCheck", "ITEM_530"):expect();

                        if typeof(v5) == "number" and v5 > 0 then
                            local v6 = u1:CheckDialogue(script.Name):expect();

                            if v6 == true then
                                p3.Next = nil;

                                return;
                            end;

                            if typeof(v6) == "number" then
                                p3.Next = {
                                    Text = string.format("You poor as hell, get back when you have gathered another [%s] UCoins", (tostring(v6)))
                                };

                                return;
                            end;

                            if v6 == false then
                                p3.Next = {
                                    Text = "Hey man, I can\'t hear you from over there."
                                };
                            end;
                        else
                            p3.Next = {
                                Text = "It seems you\'re missing the item I need. Get it pronto, I really need that McChicken."
                            };
                        end;
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                {
                    Response = "No",
                    Next = nil
                }
            }
        }
    }
};