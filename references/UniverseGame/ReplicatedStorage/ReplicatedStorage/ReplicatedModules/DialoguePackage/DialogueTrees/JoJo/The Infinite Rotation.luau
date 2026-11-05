  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function AbilityCheck() -- Line: 9
    -- upvalues: LocalPlayer (copy)
    local v3 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v4 = LocalPlayer.Data.Ability:GetAttribute("AbilityLevel");
    local v5;

    if v3 == "Tusk ACT3" or v3 == "Tusk ACT4" then
        v5 = v4 >= 200;
    else
        v5 = false;
    end;

    return v5;
end;

return {
    Title = "Gyro Zeppeli (Q: The Infinite Rotation)",

    Start = function() -- Line: 15, Name: GetStart
        -- upvalues: u2 (copy), LocalPlayer (copy)
        local v6 = u2:GetCurrentStep(script.Name):expect();
        local v7 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
        local v8 = LocalPlayer.Data.Ability:GetAttribute("AbilityLevel");
        local v9;

        if v7 == "Tusk ACT3" or v7 == "Tusk ACT4" then
            v9 = v8 >= 200;
        else
            v9 = false;
        end;

        return v9 and `step_{v6 or 1}` or "no_tusk";
    end,

    Nodes = {
        no_tusk = {
            Text = "You\'re not ready yet. Come back when you\'ve got the power to handle this. [Level 200, and have Tusk Act 3 or 4 equipped]",
            Options = { {
                    Response = "Okay.",
                    Next = nil
                } }
        },
        step_1 = {
            Mutable = true,
            Text = "%s But listen, I need to tell you about two key figures — <Color=158,239,255>Funny Valentine<Color=/> and <Color=255,236,125>Diego Brando<Color=/>. Did you know Valentine executed Diego during the <Color=191,255,107>Steel Ball Run<Color=/>? Strange times, huh? I need your help.",

            Transformer = function(p10, p11) -- Line: 38, Name: Transformer
                -- upvalues: LocalPlayer (copy)
                local v12 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");

                if v12 and v12 == "Tusk ACT4" then
                    p11.Text = string.format(p11.Text, "So, Tusk Act 4. You\'ve really mastered its power.");

                    return;
                end;

                p11.Text = string.format(p11.Text, "So, Tusk Act 3, huh? You\'re really mastering its power.");
            end,

            Options = {
                {
                    Response = "What do you need?",
                    Next = {
                        Text = "I’ve got some unfinished business... group of hooligans has been causing me trouble. I need you to take care of them. Once you\'re done, I\'ll tell you more.",
                        Options = {
                            {
                                Response = "Alright, I\'ll get it done.",

                                Callback = function(p13, p14, p15) -- Line: 54, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                    p14.Next = {
                                        Text = "Appreciated."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            },
                            {
                                Response = "Sorry, I can\'t help right now.",
                                Next = {
                                    Text = "Understood, come back another time."
                                }
                            }
                        }
                    }
                },
                {
                    Response = "Sorry, I can\'t help right now.",
                    Next = {
                        Text = "Understood, come back another time."
                    }
                }
            }
        },
        step_2 = {
            Text = "Did you defeat those hooligans yet? Come back to me when you\'re done."
        },
        step_3 = {
            Mutable = true,
            Text = "Nice work with those idiots. Now, the real reason I called you — <Color=158,239,255>Funny Valentine<Color=/> and <Color=255,236,125>Diego Brando<Color=/>. Valentine executed Diego during the <Color=191,255,107>Steel Ball Run<Color=/>. I need you to investigate him. Something about his movements doesn’t add up. Start where he last dined, a spot nearby where he met with some... shady people. Find clues and report back to me. <Color=Red>Be careful though, they may catch a hold of you.<Color=/>",
            Options = {
                {
                    Response = "Got it, I\'ll see what I can find. [Investigate Albasta]",

                    Callback = function(p16, p17, p18) -- Line: 88, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name, "BeginInvestigation"):expect();
                        p17.Next = {
                            Text = "Good luck."
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                {
                    Response = "Not now.",
                    Next = {
                        Text = "Suit yourself."
                    }
                }
            }
        },
        step_4 = {
            Mutable = true,
            Text = "Keep your eyes open.",

            Transformer = function(p19, p20) -- Line: 107, Name: Transformer
                -- upvalues: u1 (copy), LocalPlayer (copy)
                u1:CheckDialogue(script.Name):expect();

                if LocalPlayer:GetAttribute("InInvestigation") then
                    p20.Text = "Please hurry up with the investigation, you don\'t have much time. [Investigate Albasta]";

                    return;
                end;

                p20.Text = "Keep your eyes open.";
            end,

            Options = { {
                    Response = "Okay.",
                    Next = nil
                } }
        },
        step_5 = {
            Mutable = true,
            Text = "Blood stains, a napkin, a corpse part, and the flag — perfect. This confirms it. Valentine’s been here, and he\'s making his moves. Now listen carefully. To find him outside of his safe spot, you\'ll need to use these clues.",
            Options = {
                {
                    Response = "Tell me more.",
                    Next = {
                        Text = "The flag and the corpse part — use them to track him. Valentine’s not easy to pin down, but these will help. Find him, and you know what to do. Take him out with Tusk Act 3, this way you might find the true potential of your ability.",
                        Options = {
                            {
                                Response = "Will do.",

                                Callback = function(p21, p22, p23) -- Line: 135, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                    p22.Next = {
                                        Text = "Don\'t let your guard down."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            },
                            {
                                Response = "Sorry, I can\'t help right now.",
                                Next = {
                                    Text = "Come back soon."
                                }
                            }
                        }
                    }
                }
            }
        },
        step_6 = {
            Text = "Funny Valentine is still around, make sure you finish him off with your Tusk Act 3."
        },
        step_7 = {
            Mutable = true,
            Text = "You\'ve done a good job. The true potential of the infinite rotation is yours.",
            Options = {
                {
                    Response = "Glad I could be of help.",

                    Callback = function(p24, p25, p26) -- Line: 163, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();
                        p25.Next = {
                            Text = "Good luck on your journey."
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};