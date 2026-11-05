  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("ShopService");

return {
    Start = "start",
    Title = "Mount Store",
    Nodes = {
        start = {
            Mutable = true,
            Text = "Yo, wanna buy a hoverboard or a bike? Hoverboard costs 250,00 uShards but bike costs 100,00 uShards.",
            Options = {
                {
                    Response = "Yes, let me purchase a hoverboard!",
                    Next = nil,

                    Callback = function() -- Line: 17, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:BuyHoverboard();
                    end
                },
                {
                    Response = "Yes, let me purchase a bike!",
                    Next = nil,

                    Callback = function() -- Line: 24, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:BuyBike();
                    end
                },
                {
                    Response = "I\'m good.",
                    Next = nil
                },
                {
                    Response = "Fix silver chariot buddy",

                    Callback = function() -- Line: 35, Name: Callback
                        local Character = game.Players.LocalPlayer.Character;
                        local v2 = Character and Character:FindFirstChildOfClass("Humanoid");

                        if v2 then
                            v2.Health = 0;
                            v2.MaxHealth = 0;
                        end;
                    end,

                    Next = {
                        Text = "😠"
                    }
                }
            }
        }
    }
};