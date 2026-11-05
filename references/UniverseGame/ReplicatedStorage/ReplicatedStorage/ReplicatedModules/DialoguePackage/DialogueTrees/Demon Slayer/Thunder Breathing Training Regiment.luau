  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("HakiService");
local u2 = Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return {
    Title = "Zenitsu",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: LocalPlayer (copy), u2 (copy)
        if LocalPlayer:GetAttribute("ThunderclapTrial") and typeof(LocalPlayer:GetAttribute("ThunderclapTrial")) == "number" then
            return "trial_" .. (LocalPlayer:GetAttribute("ThunderclapTrial") or 0);
        end;

        return LocalPlayer:GetAttribute("Accuracy") and "result" or `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        trial_0 = {
            Unskippable = true,
            Mutable = true,
            Text = "",

            Transformer = function(p3, p4) -- Line: 32, Name: Transformer
                local v5 = { "You have failed. Prepare better next time.", "You stumbled. Learn from it, or be left behind again.", "Failure is not the end but it is a warning. Refocus." };
                p4.Text = v5[math.random(1, #v5)];
                task.delay(5, p3.Destroy, p3);
            end
        },
        trial_1 = {
            Unskippable = true,
            Mutable = true,
            Text = "Remember your training. First, heighten your awareness. Precisely evaluate your surroundings and determine the threat.",

            Transformer = function(p6, p7) -- Line: 49, Name: Transformer
                task.delay(5, p6.Destroy, p6);
            end
        },
        trial_2 = {
            Unskippable = true,
            Mutable = true,
            Text = "Excellent. Now, take stance.",

            Transformer = function(p8, p9) -- Line: 58, Name: Transformer
                task.delay(2, p8.Destroy, p8);
            end
        },
        trial_3 = {
            Unskippable = true,
            Mutable = true,
            Text = "Perfect. Now, take concentrate on your breathing.",

            Transformer = function(p10, p11) -- Line: 67, Name: Transformer
                task.delay(2, p10.Destroy, p10);
            end
        },
        trial_4 = {
            Unskippable = true,
            Mutable = true,
            Text = "Very good. Feel the surge of thunder coursing through your veins.",

            Transformer = function(p12, p13) -- Line: 76, Name: Transformer
                task.delay(2, p12.Destroy, p12);
            end
        },
        trial_5 = {
            Unskippable = true,
            Mutable = true,
            Text = "Direct your power.",

            Transformer = function(p14, p15) -- Line: 85, Name: Transformer
                task.delay(2, p14.Destroy, p14);
            end
        },
        trial_7 = {
            Unskippable = true,
            Mutable = true,
            Text = "Nice gang.",

            Transformer = function(p16, p17) -- Line: 104, Name: Transformer
                task.delay(2, p16.Destroy, p16);
            end
        },
        result = {
            Unskippable = true,
            Mutable = true,
            Text = "",

            Transformer = function(p18, p19) -- Line: 114, Name: Transformer
                -- upvalues: LocalPlayer (copy)
                local v20 = LocalPlayer:GetAttribute("Accuracy");

                if v20 >= 95 then
                    p19.Text = `You played beugifully at {v20}% accuracy. I will teach you Thunder Breathing.`;
                    task.delay(3, p18.Destroy, p18);

                    return;
                end;

                local v21 = { "You have failed.", "Too many mistakes.", "How can you become a demon slayer if you can\'t complete simple tasks?", "Failure is not the end but it is a warning. Refocus.", "You must improve." };
                p19.Text = `{v21[math.random(1, #v21)]} Your accuracy was {v20}%. I require at least 95% accuracy.`;
                task.delay(5, p18.Destroy, p18);
            end
        },
        step_1 = {
            Mutable = true,
            Text = "Hmph?",

            Transformer = function(p22, p23) -- Line: 139, Name: Transformer
                -- upvalues: u1 (copy)
                local v24 = u1:CheckDialogue(script.Name):expect();

                if v24 == "Trainee" then
                    p23.Options = { {
                            Response = "[POSSESS THE SLAYER TRAINEE ABILITY]",
                            Next = {
                                Text = "I have no need in talking to you. [POSSESS THE SLAYER TRAINEE ABILITY BY COMPLETING ...]"
                            }
                        } };
                end;

                if v24 == "Guitar" then
                    p23.Options = { {
                            Response = "Teach me the ways of Thunder Breathing.",
                            Next = {
                                Mutable = true,
                                Text = "I don\'t take on any fresh slayer trainee. First... you must impress me.",
                                Options = { {
                                        Response = "Impress you? How?",
                                        Next = {
                                            Text = "Play me a song with my shamisen. [OBTAIN ZENITSU\'S SHAMISEN ITEM]"
                                        }
                                    } }
                            }
                        } };
                end;

                if typeof(v24) == "boolean" and v24 == true then
                    p23.Text = "Impress me.";
                    task.delay(2.3, p22.Destroy, p22);
                end;
            end
        },
        step_2 = {
            Mutable = true,
            Text = "Before we begin, I have many debts to pay. Your first task is to earn the money required to pay my dues.",
            Options = {
                {
                    Response = "Very well.",

                    Callback = function(p25, p26) -- Line: 186, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                    end,

                    Next = {
                        Text = "Obtain for me 2m uCoins and 100k uShards."
                    }
                }
            }
        },
        step_3 = {
            Mutable = true,
            Text = "Gather the money to pay off my debts before we begin."
        },
        step_4 = {
            Mutable = true,
            Text = "I appreciate the money. Now we will begin your training. Thunder Breathing\'s attack forms are variations of its 1st form called \"Thunderclap and Flash\". If you wish to master Thunder Breathing, you must learn and perfect the 1st form.",
            Options = {
                {
                    Response = "How can I learn this technique?",

                    Callback = function(p27, p28) -- Line: 207, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                    end,

                    Next = {
                        Text = "It\'s all in your precision, awareness, and agility. First, you must train your legs to."
                    }
                }
            }
        }
    }
};