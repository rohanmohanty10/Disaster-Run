  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");

return {
    Title = "Killua",

    Start = function() -- Line: 11, Name: GetStart
        return "step_1";
    end,

    Nodes = {
        step_1 = {
            Text = "Assassination is a key aspect that\'s held at high regards within my family. Do you wish to be a successor of such tradition?",
            Options = {
                {
                    Response = "Yes",
                    Next = {
                        Text = "You\'ll have to mentally farm yourself in order to meet the criteria, still think you\'ve got the mental capacity?",
                        Options = {
                            {
                                Response = "Yes",

                                Callback = function(p2, p3) -- Line: 30, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Good luck.",
                                    Options = {}
                                }
                            },
                            {
                                Response = "Nevermind",
                                Next = ""
                            }
                        }
                    }
                },
                {
                    Response = "No",
                    Next = ""
                }
            }
        }
    }
};