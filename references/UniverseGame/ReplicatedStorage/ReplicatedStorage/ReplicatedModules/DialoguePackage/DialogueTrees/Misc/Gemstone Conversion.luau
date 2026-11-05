  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Start = "start",
    Title = "Z4",
    Nodes = {
        start = {
            Mutable = true,
            Text = "Yo",
            Options = {
                {
                    Response = "Can I convert this ability to a gemstone?",
                    Next = {
                        Text = "Before you continue, I am going to warn you that you will lose the ability if it\'s applicable, you can back off right now if you wish not to.",
                        Options = {
                            {
                                Response = "Continue, I am going to convert the ability.",

                                Callback = function(p2, p3, p4) -- Line: 24, Name: Callback
                                    -- upvalues: u1 (copy)
                                    if u1:CheckDialogue(script.Name):expect() then
                                        p3.Next = {
                                            Text = "There you go."
                                        };

                                        return;
                                    end;

                                    p3.Next = {
                                        Text = "Your current ability cannot be converted, come back once you have something like Dragon Knight or Locke. I\'d recommend talking to the slayer NPCs for Dragon Knight or finding a Kinetic Orb for Locke. You should also try for something like Dawn or Xeno, I\'d recommend asking some folks around for help as well!"
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                }
            }
        }
    }
};