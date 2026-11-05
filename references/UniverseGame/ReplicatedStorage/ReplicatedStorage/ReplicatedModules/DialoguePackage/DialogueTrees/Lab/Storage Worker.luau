  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
Core.GetClientService("LabService");
Core.GetLegacyService("QuestLineService");
local u1 = Core.GetLegacyService("DialogueService");

return {
    Title = "Storage Worker",

    Start = function() -- Line: 10, Name: Start
        local v2 = math.random(1, 2);
        local Character = game:GetService("Players").LocalPlayer.Character;

        return Character and Character:GetAttribute("CarryingCrate") and "crate" or `start_{v2}`;
    end,

    Nodes = {
        start_1 = {
            Text = "This is the storage sector. Just don\'t mess with anything. If you ever happen to find some lost equipment, please feel free to return it here.",
            Options = { {
                    Response = "What\'s stored here?",
                    Next = {
                        Text = "Parts, tools, supplies. Some stuff I\'m not even allowed to know about.",
                        Options = { {
                                Response = "Got it.",
                                Next = nil
                            } }
                    }
                }, {
                    Response = "Relax, I\'m not touching anything.",
                    Next = {
                        Text = "Good. We\'ve had enough accidents without extra hands moving things.",
                        Options = { {
                                Response = "Understood.",
                                Next = nil
                            } }
                    }
                } }
        },
        start_2 = {
            Text = "Stacking crates all day isn\'t exciting, but at least nothing explodes back here.",
            Options = { {
                    Response = "That\'s... reassuring.",
                    Next = {
                        Text = "You\'d be surprised how often that\'s not the case around here.",
                        Options = { {
                                Response = "Fair enough.",
                                Next = nil
                            } }
                    }
                }, {
                    Response = "Sounds boring.",
                    Next = {
                        Text = "Honestly, I\'ll take boring over glowing boxes and alarm lights any day.",
                        Options = { {
                                Response = "Can\'t argue with that.",
                                Next = nil
                            } }
                    }
                } }
        },
        crate = {
            Text = "Oh hey, you found some of our equipment!",
            Options = {
                {
                    Response = "I am here to return the equipment.",

                    Callback = function(p3, p4) -- Line: 90, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckRequirement("TurnInCrate"):expect() == true then
                            p4.Next = {
                                Text = "I appreciate your effort. Have this as a reward.",
                                Options = { {
                                        Response = "Thanks.",
                                        Next = nil
                                    } }
                            };
                        end;
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};