  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Jotaro Kujo",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: u2 (copy)
        return "step_" .. (u2:GetCurrentStep(script.Name):expect() or 1);
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "",

            Transformer = function(p3, p4) -- Line: 23, Name: Transformer
                -- upvalues: Players (copy), u1 (copy)
                if Players.LocalPlayer.Data.Ability.Value == 2 then
                    p4.Text = "Hey, I\'m Jotaro Kujo, a stand user. If you have a stand like mine, I can train you to evolve it.";
                    p4.Options = {
                        {
                            Response = "Ok",
                            Next = {
                                Text = "I\'ll need my old hat as payment, to evolve Star Platinum you\'ll need to train its strength, I\'ve given you a list of tasks to help raise its power.",
                                Options = {
                                    {
                                        Response = "Alright, thanks.",
                                        Next = "",

                                        Callback = function(p5) -- Line: 37, Name: Callback
                                            -- upvalues: u1 (ref)
                                            if u1:CheckDialogue(script.Name):expect() then
                                                p5:Destroy();

                                                return;
                                            end;

                                            p5:SetCurrentNode({
                                                Text = "It seems you are missing [Mysterious Hat], come back when you\'ve obtained it",
                                                Options = {
                                                    {
                                                        Response = "Hmm. Okay.",
                                                        Next = "",

                                                        Callback = function(p6) -- Line: 45, Name: Callback
                                                            p6:Destroy();
                                                        end
                                                    }
                                                }
                                            });
                                        end
                                    },
                                    {
                                        Response = "I\'ve changed my mind, goodbye.",
                                        Next = "",

                                        Callback = function(p7) -- Line: 60, Name: Callback
                                            p7:Destroy();
                                        end
                                    }
                                }
                            }
                        },
                        {
                            Response = "Sorry, goodbye.",
                            Next = "",

                            Callback = function(p8) -- Line: 70, Name: Callback
                                p8:Destroy();
                            end
                        }
                    };

                    return;
                end;

                p4.Text = "You do not possess my ability. Talk to me when you are ready to evolve it.";
                p4.Options = {};
            end,

            Options = {}
        },
        step_2 = {
            Mutable = true,
            Text = "",

            Transformer = function(p9, p10) -- Line: 87, Name: Transformer
                p10.Text = "Have you watched Date A Live???";
                p10.Options = {};
            end,

            Options = {}
        },
        step_3 = {
            Mutable = true,
            Text = "",

            Transformer = function(p11, p12) -- Line: 97, Name: Transformer
                -- upvalues: u1 (copy)
                p12.Text = "Well done on completing those objectives, you have now attained Star Platinum: The World. [YOU NEED TO EQUIP STAR PLATINUM FIRST]";
                p12.Options = {
                    {
                        Response = "Alright, thanks.",
                        Next = "",

                        Callback = function(p13) -- Line: 102, Name: Callback
                            -- upvalues: u1 (ref)
                            u1:CheckDialogue(script.Name):expect();
                            p13:Destroy();
                        end
                    }
                };
            end,

            Options = {}
        }
    }
};