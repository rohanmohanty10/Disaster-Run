  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("DialogueService");

return {
    Start = "start",
    Title = "Dio",
    Nodes = {
        start = {
            Mutable = true,
            Text = "what do you want?...",
            Options = {
                {
                    Response = "I wish to become the stars (SOL Quest)",

                    Callback = function(p2, p3) -- Line: 17, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Sol Quest"):expect() then
                            p3.Next = {
                                Text = "There, now get out of my sight"
                            };

                            return;
                        end;

                        p3.Next = {
                            Text = "You already have the quest"
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                {
                    Response = "I wish to become the eclipse (NOCTURNUS Quest)",

                    Callback = function(p4, p5) -- Line: 29, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Nocturnus Quest"):expect() then
                            p5.Next = {
                                Text = "There, now get out of my sight"
                            };

                            return;
                        end;

                        p5.Next = {
                            Text = "You already have the quest"
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};