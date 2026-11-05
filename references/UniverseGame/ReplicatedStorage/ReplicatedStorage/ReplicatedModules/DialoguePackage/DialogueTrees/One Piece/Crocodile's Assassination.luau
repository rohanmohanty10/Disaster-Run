  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("DialogueService");

return {
    Start = "start",
    Title = "Sanji, the Prince",
    Nodes = {
        start = {
            Mutable = true,
            Text = "",

            Options = function() -- Line: 14, Name: Options
                -- upvalues: u1 (copy)
                return u1:CheckDialogue(script.Name):expect() and {
                    {
                        Response = "I haven\'t, believe me.",
                        Next = {
                            Mutable = true,
                            Text = "Good, because I have really valuable intel I have to tell you. Crocodile, or as you know him, Mr 0, is the current lead of the Kingdom of Alabasta. He seeks to destabilize and conquer it for his own gain on finding the ancient weapon \"Pluton\", forged during the Void Century. We must take him down as no man should be able to possess such a weapon. Are you with me on this?",
                            Options = { {
                                    Response = "I am with you. Lets do it.",
                                    Next = {
                                        Text = "Thats the spirit! Lets get rid of him and maybe I\'ll cook you something up later. He\'s up just ahead"
                                    }
                                } }
                        },

                        Callback = function() -- Line: 41, Name: Callback
                            local Character = game.Players.LocalPlayer.Character;

                            if Character then
                                Character = Character:FindFirstChild("SanjiWaypoint", true);
                            end;

                            if Character then
                                Character:Destroy();
                            end;
                        end
                    }
                } or { {
                        Response = "[POSSESS THE BAROQUE WORKS CONTRACTOR TITLE]",
                        Next = {
                            Text = "I have no need in talking to you. [POSSESS THE BAROQUE WORKS CONTRACTOR TITLE]"
                        }
                    } };
            end
        }
    }
};