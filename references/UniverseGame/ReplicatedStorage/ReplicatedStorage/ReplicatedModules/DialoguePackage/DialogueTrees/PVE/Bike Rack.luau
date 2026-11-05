  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("ShopService");

return {
    Start = "start_node",
    Title = "Bike Rack",
    Nodes = {
        start_node = {
            Text = "Would you like to take a bike from the rack? (costs 3500 UCoins)",
            Mutable = true,
            Options = {
                {
                    Response = "YES",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p3, p4, p5) -- Line: 19, Name: Callback
                        -- upvalues: u1 (copy), u2 (copy)
                        local v6 = u1:CheckDialogue(script.Name):expect();

                        if v6 ~= true then
                            p4.Next = {
                                Text = string.format("You need [%s] UCoins", v6),
                                Options = { {
                                        Response = "Okay",
                                        Next = "start_node"
                                    } }
                            };

                            return;
                        end;

                        u2:BuyBike();
                        p4.Next = nil;
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