  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Ghost Rider",

    Start = function() -- Line: 8, Name: GetStart
        -- upvalues: u2 (copy)
        u2:GetCurrentStep(script.Name):expect();

        return "start";
    end,

    Nodes = {
        start = {
            Mutable = true,
            Text = "Man... I should\'ve been called Daredevil. It really doesn\'t make sense... This dude... he has the abilities of a bat, but hes called Daredevil? Total non-sense, right? What do you say?",
            Options = {
                {
                    Response = "So true man. Anyways, cool bike you got there.",
                    Next = {
                        Mutable = true,
                        Text = "I TOTALLY AGREE! Hey, would you like to take a drive? I can\'t lie... it is pretty FIRE!",
                        Options = {
                            {
                                Response = "HELL yeah! Got it? Hell... yeah...",

                                Callback = function(p3, p4) -- Line: 29, Name: Callback
                                    -- upvalues: u1 (copy)
                                    if u1:CheckDialogue(script.Name):expect() then
                                        p4.Next = {
                                            Text = "Alright, here are some objectives.. to make sure u can HANDLE THE HEAT!"
                                        };

                                        return;
                                    end;

                                    p4.Next = {
                                        Text = "You already have my ride."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            },
                            {
                                Response = "You creep me out bro",
                                Next = {
                                    Text = "..."
                                }
                            }
                        }
                    }
                }
            }
        },
        step_2 = {
            Text = "You haven\'t completed my tasks."
        }
    }
};