  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Umbra",

    Start = function() -- Line: 18, Name: GetStart
        -- upvalues: u2 (copy)
        return "step_" .. (u2:GetCurrentStep(script.Name):expect() or 1);
    end,

    Nodes = {
        step_1 = {
            Text = "Is there something you need?",
            Options = {
                {
                    Response = "Teach me the power of sovereign",

                    Callback = function(p3) -- Line: 32, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                    end,

                    Next = {
                        Text = "Very well, first defeat some Skibidi Noobie Sect members",
                        Options = {}
                    }
                },
                {
                    Response = "No",
                    Next = "",

                    Callback = function(p4) -- Line: 42, Name: Callback
                        p4:Destroy();
                    end
                }
            }
        },
        step_2 = {
            Mutable = true,
            Text = "",

            Transformer = function(p5, p6) -- Line: 51, Name: Transformer
                p6.Text = "Talk to me again when you have completed my tasks";
                p6.Options = {};
            end,

            Options = {}
        },
        step_3 = {
            Mutable = true,
            Text = "",

            Transformer = function(p7, p8) -- Line: 60, Name: Transformer
                -- upvalues: u1 (copy)
                p8.Text = "It seems you have potential to obtain the power. Very well, I will now begin your training arc.\nCollect these items and craft into the <Color=Yellow>Sovereign\'s Chapter<Color=/> before returning to me.\n<Color=Cyan>Demonic Scroll - Obtained by defeating <Color=Red>The Hunter<Color=Cyan>\nFragment of Death - Obtained by defeating <Color=Red>Shadow Assassin<Color=Cyan>\nGodly Doctor\'s Poison - Combine <Color=Yellow>Monochromatic Orb + Kinetic Orb + Corrupted Arrow<Color=Cyan>\nHeavenly Nectar - Obtained through chests\nTales of the Universe - Obtained through chests\nCorrupted Soul - Obtained through chests<Color=/>";
                p8.Options = {
                    {
                        Response = "Understood",

                        Callback = function(p9) -- Line: 67, Name: Callback
                            -- upvalues: u1 (ref)
                            u1:CheckDialogue(script.Name):expect();
                        end,

                        Next = {
                            Text = "Show me the fruition of your labor",
                            Options = {}
                        }
                    }
                };
            end,

            Options = {}
        },
        step_4 = {
            Mutable = true,
            Text = "",

            Transformer = function(p10, p11) -- Line: 82, Name: Transformer
                p11.Text = "Did you craft the <Color=Yellow>Sovereign\'s Chapter<Color=/>?\nRemember you need to collect these items to craft it\n<Color=Cyan>Demonic Scroll - Obtained by defeating <Color=Red>The Hunter<Color=Cyan>\nFragment of Death - Obtained by defeating <Color=Red>Shadow Assassin<Color=Cyan>\nGodly Doctor\'s Poison - Combine <Color=Yellow>Monochromatic Orb + Kinetic Orb + Corrupted Arrow<Color=Cyan>\nHeavenly Nectar - Obtained through chests\nTales of the Universe - Obtained through chests\nCorrupted Soul - Obtained through chests<Color=/>";
                p11.Options = { {
                        Response = "Understood",
                        Next = {
                            Text = "Show me the fruition of your labor",
                            Options = {}
                        }
                    } };
            end,

            Options = {}
        },
        step_5 = {
            Mutable = true,
            Text = "",

            Transformer = function(p12, p13) -- Line: 101, Name: Transformer
                -- upvalues: u1 (copy)
                p13.Text = "It seems you have crafted the chapter, all that is left is to challenge <Color=Red>Skibidi Noobie<Color=/> and <Color=Red>The Sovereign<Color=/>. Once you have defeated them be sure to return back to me and I will grant you the final item.";
                p13.Options = {
                    {
                        Response = "Understood",

                        Callback = function(p14) -- Line: 108, Name: Callback
                            -- upvalues: u1 (ref)
                            u1:CheckDialogue(script.Name):expect();
                        end,

                        Next = {
                            Text = "This will be start of your new fable",
                            Options = {}
                        }
                    }
                };
            end,

            Options = {}
        },
        step_6 = {
            Mutable = true,
            Text = "",

            Transformer = function(p15, p16) -- Line: 123, Name: Transformer
                p16.Text = "Have you challenged <Color=Red>Skibidi Noobie<Color=/> and <Color=Red>The Sovereign<Color=/>? Once you have defeated them be sure to return back to me and I will grant you the final item.";
                p16.Options = {};
            end,

            Options = {}
        },
        step_7 = {
            Mutable = true,
            Text = "",

            Transformer = function(p17, p18) -- Line: 133, Name: Transformer
                -- upvalues: u1 (copy)
                p18.Text = "You really did it...\nTake this item <Color=Yellow>A New Fable<Color=/> and combine it with <Color=Yellow>Sovereign\'s Chapter<Color=/> to create <Color=Yellow>Sovereign\'s Sword.<Color=/>\nOnce that is crafted, use it on <Color=White>Standless<Color=/> to obtain <Color=Pink>Umbra<Color=/>.";
                p18.Options = {
                    {
                        Response = "Thank you for your teachings",
                        Next = "",

                        Callback = function(p19) -- Line: 140, Name: Callback
                            -- upvalues: u1 (ref)
                            u1:CheckDialogue(script.Name):expect();
                        end
                    }
                };
            end,

            Options = {}
        }
    }
};