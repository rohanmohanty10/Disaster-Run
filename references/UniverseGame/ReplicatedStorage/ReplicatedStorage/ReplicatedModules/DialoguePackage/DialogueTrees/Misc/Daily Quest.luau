  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("ShopService");

return {
    Title = "Akira_Blade",

    Start = function() -- Line: 8, Name: GetStart
        return "step_1";
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Here for the daily quest?",

            Transformer = function(p2, p3) -- Line: 19, Name: Transformer
                -- upvalues: u1 (copy)
                p3.Options = {
                    {
                        Response = "Yes my good sir",
                        Next = nil,

                        Callback = function(p4, p5) -- Line: 23, Name: Callback
                            -- upvalues: u1 (ref)
                            u1:ShowDailyQuests();
                        end
                    }
                };
            end,

            Options = {}
        }
    }
};