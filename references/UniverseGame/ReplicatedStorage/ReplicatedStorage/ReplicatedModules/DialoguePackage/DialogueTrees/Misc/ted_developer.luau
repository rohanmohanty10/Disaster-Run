  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");

return {
    Title = "Gamemodes",

    Start = function() -- Line: 8, Name: GetStart
        return "main";
    end,

    Nodes = {
        main = {
            Text = "Wanna go to the gamemodes place?",
            Options = {
                {
                    Response = "Yes",

                    Callback = function(p1, p2, p3) -- Line: 21, Name: Callback
                        -- upvalues: PathShortcuts (copy)
                        p2.Next = {
                            Text = "Alright.",

                            Callback = function() -- Line: 24, Name: Callback
                                -- upvalues: PathShortcuts (ref)
                                game:GetService("TeleportService"):Teleport(PathShortcuts.LinkedPlaces[game.GameId].GameModeLobby, game.Players.LocalPlayer);
                            end
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};