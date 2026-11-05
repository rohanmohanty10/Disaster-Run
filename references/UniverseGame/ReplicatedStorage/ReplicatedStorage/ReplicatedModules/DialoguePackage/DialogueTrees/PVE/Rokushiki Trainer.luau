  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("ShopService");

return {
    Start = "start_node",
    Title = "Rokushiki Trainer",
    Nodes = {
        start_node = {
            Text = "Would you like to learn the Rokushiki fighting style? (costs 500k UShards)",
            Mutable = true,
            Options = {
                {
                    Response = "YES",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p2, p3, p4) -- Line: 19, Name: Callback
                        -- upvalues: u1 (copy)
                        local v5 = u1:CheckDialogue(script.Name):expect();

                        if v5 == true then
                            p3.Next = {
                                Text = "There you go! Use that manual and you should be okay.",
                                Options = { {
                                        Response = "Thank you",
                                        Next = nil
                                    } }
                            };

                            return;
                        end;

                        p3.Next = {
                            Text = string.format("You need [%s] UShards", v5),
                            Options = { {
                                    Response = "Okay",
                                    Next = "start_node"
                                } }
                        };
                    end
                },
                {
                    Response = "No",
                    Next = nil
                }
            }
        }
    }
};