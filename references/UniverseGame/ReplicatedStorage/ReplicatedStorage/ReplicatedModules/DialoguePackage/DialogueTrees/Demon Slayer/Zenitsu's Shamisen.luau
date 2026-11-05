  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("HakiService");
Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return {
    Title = "Zenitsu\'s Shamisen",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: LocalPlayer (copy)
        return LocalPlayer:GetAttribute("Accuracy") and "result" or "start";
    end,

    Nodes = {
        result = {
            Unskippable = true,
            Mutable = true,
            Text = "",

            Transformer = function(p2, p3) -- Line: 27, Name: Transformer
                -- upvalues: LocalPlayer (copy)
                local v4 = LocalPlayer:GetAttribute("Accuracy");

                if v4 >= 95 then
                    p3.Text = `You completed the song at {v4}% accuracy!`;
                    task.delay(3, p2.Destroy, p2);
                end;
            end
        },
        start = {
            Mutable = true,
            Text = "You feel a compulsion to play a song.",
            Options = {
                {
                    Response = "Jam.",

                    Callback = function(p5, p6) -- Line: 44, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckRequirement("Zenitsu\'s Shamisen"):expect();
                    end
                },
                {
                    Response = "Ignore it",
                    Next = nil
                }
            },

            Transformer = function(p7, p8) -- Line: 55, Name: Transformer
            end
        }
    }
};