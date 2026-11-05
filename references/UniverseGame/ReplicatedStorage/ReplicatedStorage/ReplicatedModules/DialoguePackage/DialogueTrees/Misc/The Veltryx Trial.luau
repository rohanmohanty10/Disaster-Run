  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local u3 = Knit.GetService("TitleService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function ExitChoice() -- Line: 20
    return {
        Response = "Goodbye.",
        Next = nil
    };
end;

local function QuestCheck() -- Line: 27
    -- upvalues: Dialogue (copy)
    return {
        Mutable = true,
        Text = "Complete my task if you want to be on your way to becoming the Veltryx.",
        Options = {
            {
                Response = "I will my master.",
                Next = Dialogue.PLACEHOLDER
            }
        }
    };
end;

return {
    Title = "Acceleron",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: LocalPlayer (copy), u2 (copy)
        local v4 = LocalPlayer:GetAttribute("TheTrials");

        if v4 then
            return "trial_" .. v4;
        end;

        return `step_{u2:GetCurrentStep("The Veltryx Trial"):expect() or 1}`;
    end,

    Nodes = {
        trial_0 = {
            Unskippable = true,
            Mutable = true,
            Text = "",

            Transformer = function(p5, p6) -- Line: 51, Name: Transformer
                local v7 = { "You have failed. Prepare better next time.", "The Medium does not favor the unready. Return when your will is sharper.", "You stumbled. Learn from it, or be left behind again.", "Failure is not the end but it is a warning. Refocus.", "You were too slow... or too careless. Either way, you must improve." };
                p6.Text = v7[math.random(1, #v7)];
                task.delay(5, p5.Destroy, p5);
            end
        },
        trial_1 = {
            Unskippable = true,
            Mutable = true,
            Text = "Welcome to The Trials. This is the staging chamber. Prepare yourself and enter the Trials when you\'re ready.",

            Transformer = function(p8, p9) -- Line: 74, Name: Transformer
                task.delay(8, p8.Destroy, p8);
            end
        },
        trial_2 = {
            Unskippable = true,
            Mutable = true,
            Text = "Greetings, %s. You stand within the Crucible of Momentum. Defeat each opponent within the time limit without rests or second chances. The Trials begin now.",

            Transformer = function(p10, p11) -- Line: 83, Name: Transformer
                -- upvalues: LocalPlayer (copy)
                p11.Text = string.format(p11.Text, LocalPlayer.Name);
                task.delay(6, p10.Destroy, p10);
            end
        },
        trial_3 = {
            Unskippable = true,
            Mutable = true,
            Text = "First up! The wielder of the Ope-Ope No Mi, the Surgeon of Death.",

            Transformer = function(p12, p13) -- Line: 93, Name: Transformer
                task.delay(5, p12.Destroy, p12);
            end
        },
        trial_4 = {
            Unskippable = true,
            Mutable = true,
            Text = "You defeated Law.. but are you a match for Minos Prime!?!",

            Transformer = function(p14, p15) -- Line: 102, Name: Transformer
                task.delay(4, p14.Destroy, p14);
            end
        },
        trial_5 = {
            Unskippable = true,
            Mutable = true,
            Text = "For your final and hardest battle yet, defeat The Denizen of Hell, a master in the arts of the Oni.",

            Transformer = function(p16, p17) -- Line: 111, Name: Transformer
                task.delay(5, p16.Destroy, p16);
            end
        },
        trial_6 = {
            Unskippable = true,
            Mutable = true,
            Text = "Congrats twin you beat the trials",

            Transformer = function(p18, p19) -- Line: 120, Name: Transformer
                task.delay(5, p18.Destroy, p18);
            end
        },
        step_1 = {
            Mutable = true,
            Text = "",

            Transformer = function(p20, p21) -- Line: 132, Name: Transformer
                -- upvalues: u3 (copy), u1 (copy), Dialogue (copy)
                if (u3:GetOwnedTitles():expect() or {}).TITLE_144 then
                    p21.Text = "Deceleron??? Is that you? How did you get past the Gates of Shaffod!?!";
                    p21.Options = {
                        {
                            Response = "Uhh… I walked in through the door. What’s a Decceleron??",
                            Next = {
                                Title = "???",
                                Text = "Wait…huh? You’re not Decceleron?? I apologize. My senses are all impaired. Did you activate the Ancient Statues of Kason then…",
                                Options = {
                                    {
                                        Response = "Yes… what is all this?",
                                        Next = {
                                            Title = "???",
                                            Text = "Impressive. This is…my hiding place…the Sanctuary of the Accelerated Medium. My name is Acceleron and I\'m eons old. I have been the seer and guardian watchdog of the Accelerated Medium since the Genesis of the New Universe. I balance the Medium’s power to protect this universe from total demise; I am the embodiment of acceleration.",
                                            Options = {
                                                {
                                                    Response = "What is the Accelerated Medium?",
                                                    Next = {
                                                        Text = "It’s a layer of dimensional reality that manipulates spacetime, granting speedsters their powers. Its where I draw energy from. Maintaining complete balance of the Medium is absolutely imperative for the safety of all.",
                                                        Options = {
                                                            {
                                                                Response = "Why are you all beat up? You look like you’re about to die.",
                                                                Next = {
                                                                    Text = "I was nearly exterminated by my evil twin brother: Decceleron. That is why I am hiding. Decceleron is the embodiment of Decceleration: the antithesis of all that is good within this universe and all the negative cosmic energy of the Medium.",
                                                                    Options = {
                                                                        {
                                                                            Response = "Interesting….I’m compelled to help. Tell me, is there anything I can do to assist you?",
                                                                            Next = {
                                                                                Text = "Well…I suppose you did get past the Gates… and I am in need of a Veltryx",
                                                                                Options = {
                                                                                    {
                                                                                        Response = "A what??",
                                                                                        Next = {
                                                                                            Text = "A Veltryx. The Veltryx is the bearer of velocity. A warrior chosen to serve as the Medium’s conduit. A mortal being imbued with divine speed to act as my apprentice and, one day, successor. But the previous Veltryx… he was lost in the recent battle against Decceleron. He gave everything.",
                                                                                            Options = {
                                                                                                {
                                                                                                    Response = "What happened to him?",
                                                                                                    Next = {
                                                                                                        Text = "He died saving the Old Universe from temporal collapse. Decceleron corrupted a Nexus Point, and the Veltryx ran faster than time itself to restore the flow and create this new map… but his atoms unraveled in the process. Brave but foolish.",
                                                                                                        Options = {
                                                                                                            {
                                                                                                                Response = "…Why me though?",
                                                                                                                Next = {
                                                                                                                    Text = "The Medium chose you. Only those in perfect resonance with its pulse can awaken the Statues of Kason. And you did. Whether you like it or not… you are bound to it now. I will train you to become the next Veltryx.",
                                                                                                                    Options = {
                                                                                                                        {
                                                                                                                            Response = "What should I do?",

                                                                                                                            Callback = function(p22, p23) -- Line: 194, Name: Callback
                                                                                                                                -- upvalues: u1 (ref)
                                                                                                                                u1:CheckDialogue("The Veltryx Trial"):expect();
                                                                                                                                p23.Next = {
                                                                                                                                    Text = "Speed without focus is chaos. Scattered in the sanctuary are chrono-wasps —speed creatures that teleport erratically. Catch 3 of them and come back when you have done so."
                                                                                                                                };
                                                                                                                            end,

                                                                                                                            Next = Dialogue.PLACEHOLDER
                                                                                                                        },
                                                                                                                        {
                                                                                                                            Response = "Goodbye.",
                                                                                                                            Next = nil
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            },
                                                                                                            {
                                                                                                                Response = "Goodbye.",
                                                                                                                Next = nil
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                },
                                                                                                {
                                                                                                    Response = "Goodbye.",
                                                                                                    Next = nil
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    },
                                                                                    {
                                                                                        Response = "Goodbye.",
                                                                                        Next = nil
                                                                                    }
                                                                                }
                                                                            }
                                                                        },
                                                                        {
                                                                            Response = "Goodbye.",
                                                                            Next = nil
                                                                        }
                                                                    }
                                                                }
                                                            },
                                                            {
                                                                Response = "Goodbye.",
                                                                Next = nil
                                                            }
                                                        }
                                                    }
                                                },
                                                {
                                                    Response = "Goodbye.",
                                                    Next = nil
                                                }
                                            }
                                        }
                                    },
                                    {
                                        Response = "Goodbye.",
                                        Next = nil
                                    }
                                }
                            }
                        },
                        {
                            Response = "Goodbye.",
                            Next = nil
                        }
                    };
                else
                    p21.Text = "[POSSESS THE KEY OF KASON TITLE]";
                    p21.Options = { {
                            Response = "[POSSESS THE KEY OF KASON TITLE]",
                            Next = {
                                Text = "[POSSESS THE KEY OF KASON TITLE]"
                            }
                        } };
                end;

                p21.Title = "???";
            end
        },
        step_2 = QuestCheck(),
        step_3 = {
            Mutable = true,
            Text = "Have you captured the chrono wasps yet?",
            Options = {
                {
                    Response = "Yes I have, what was the point in that?",
                    Next = {
                        Text = "It was to train your temporal aptitude. The chrono wasps exude temporal energy. Entering relatively close proximity with the chrono wasps will facilitate the awakening of your temporal aptitude. Although you may not be able to sense it, I can tell that you’ve successfully tuned your temperance.",
                        Options = {
                            {
                                Response = "What should I do next?",
                                Next = {
                                    Text = "Now I want to test your capabilities to fight in accelerated conditions.",
                                    Options = {
                                        {
                                            Response = "You want me to fight something!?!?",
                                            Next = {
                                                Text = "Not something. Three somethings. And its not just fights they are speedrun trials. You must defeat each boss one after the other in quick success without dying. Each in under two minutes. No breaks. No mercy. Return to me when you are ready.",
                                                Options = {
                                                    {
                                                        Response = "Alright.",

                                                        Callback = function(p24, p25) -- Line: 265, Name: Callback
                                                            -- upvalues: u1 (copy)
                                                            u1:CheckDialogue("The Veltryx Trial"):expect();
                                                        end,

                                                        Next = Dialogue.PLACEHOLDER
                                                    },
                                                    {
                                                        Response = "Goodbye.",
                                                        Next = nil
                                                    }
                                                }
                                            }
                                        },
                                        {
                                            Response = "Goodbye.",
                                            Next = nil
                                        }
                                    }
                                }
                            },
                            {
                                Response = "Goodbye.",
                                Next = nil
                            }
                        }
                    }
                },
                {
                    Response = "Goodbye.",
                    Next = nil
                }
            }
        },
        step_4 = {
            Mutable = true,
            Text = "Are you ready to enter the arena and begin the Trials?",
            Options = {
                {
                    Response = "Yes. I am prepared.",

                    Callback = function(p26, p27) -- Line: 292, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("The Veltryx Trial"):expect();
                    end
                },
                {
                    Response = "Not yet.",
                    Next = Dialogue.PLACEHOLDER
                }
            }
        },
        step_5 = {
            Mutable = true,
            Text = "...You did it. You beat them all. Good. The path of the Veltryx is never without pressure. The Medium only blesses those who surmount the Trials in time.",
            Options = {
                {
                    Response = "What now?? Am I the Veltryx yet?",
                    Next = {
                        Text = "Not yet. The title is not given so easily. Your next task will be one of inner strength. The Accelerated Medium is powerful but volatile. If you lose focus it will twist into its darker reflection. It absolutely necessary that you do not draw from negative power of the Accelerated Medium and tap into the powers of Deceleration.",
                        Options = {
                            {
                                Response = "What can I do?",
                                Next = {
                                    Text = "For your next task you must go face to face with those who have already fallen. Wielders of the Decelerated Medium. They are known as the Speed-Eaters",
                                    Options = {
                                        {
                                            Response = "What are they like?",

                                            Callback = function(p28, p29) -- Line: 319, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue("The Veltryx Trial"):expect();
                                                p29.Next = {
                                                    Text = "Well…they remember how it felt to be fast. You must go head to head and defeat them and prove your inner strength by resisting their temptation to turn you over to the corrupted flow. I will guide you to them."
                                                };
                                            end,

                                            Next = Dialogue.PLACEHOLDER
                                        },
                                        {
                                            Response = "Goodbye.",
                                            Next = nil
                                        }
                                    }
                                }
                            },
                            {
                                Response = "Goodbye.",
                                Next = nil
                            }
                        }
                    }
                },
                {
                    Response = "Goodbye.",
                    Next = nil
                }
            }
        },
        step_6 = QuestCheck(),
        step_7 = {
            Mutable = true,
            Text = "Have you defeated the Speed Eaters?",
            Options = {
                {
                    Response = "Yes I have",
                    Next = {
                        Text = "Very well..then you’ve seen firsthand what happens to those who let fear and darkness take root. I was beginning to be-",
                        Options = {
                            {
                                Response = "...",
                                Next = {
                                    Title = "???",
                                    Text = "Ah.. there you are, brother",
                                    Unskippable = true,
                                    TitleColor = Color3.fromRGB(218, 0, 0),
                                    Options = {
                                        {
                                            Response = "...",

                                            Callback = function(u30, p31) -- Line: 360, Name: Callback
                                                -- upvalues: ReplicatedStorage (copy), PathShortcuts (copy)
                                                local v32 = u30.Trove:Clone(ReplicatedStorage["Client Assets"].Decceleron);
                                                v32.Parent = workspace.Effects;
                                                u30.Model = v32;
                                                u30.Trove:Add(function() -- Line: 365
                                                    -- upvalues: u30 (copy)
                                                    u30.Model = nil;
                                                end);
                                                require(PathShortcuts.ReplicatedModules.EffectsHandler).CallEffect("Decceleron NPC", {
                                                    Model = v32,
                                                    Acceleron = u30.Metadata.Model
                                                });
                                            end,

                                            Next = {
                                                Title = "???",
                                                Text = "I felt the presence of the Speed Eaters vanish. And that scent…your apprentice. I see you’ve begun your little replacement game again.",
                                                Unskippable = true,
                                                TitleColor = Color3.fromRGB(218, 0, 0),
                                                Options = {
                                                    {
                                                        Response = "...",

                                                        Callback = function(p33, p34) -- Line: 383, Name: Callback
                                                            p33.Model:SetAttribute("Stage", "FirstTurn");
                                                        end,

                                                        Next = {
                                                            Text = "Run! Its Decceleron!!",
                                                            Unskippable = true,
                                                            Options = {
                                                                {
                                                                    Response = "What??",

                                                                    Callback = function(p35, p36) -- Line: 392, Name: Callback
                                                                        p35.Model:SetAttribute("Stage", "Attack");
                                                                    end,

                                                                    Next = {
                                                                        Title = "Decceleron",
                                                                        Text = "No! I will end you here once and for all Acceleron!",
                                                                        Unskippable = true,
                                                                        TitleColor = Color3.fromRGB(218, 0, 0),
                                                                        Options = {
                                                                            {
                                                                                Response = "Acceleron!!!",

                                                                                Callback = function(p37, p38) -- Line: 403, Name: Callback
                                                                                    -- upvalues: u1 (copy)
                                                                                    u1:CheckDialogue("The Veltryx Trial"):expect();
                                                                                    p38.Next = {
                                                                                        Text = "Listen to me… do not fret… I can’t chase him… but you can… you trained for this. I’ll grant you some of my speed. It won\'t be enough to beat him… but enough to reach him. The rest… you must find within yourself... (TALK TO QUEST GIVER TO INITIATE CHASE)",
                                                                                        Unskippable = true
                                                                                    };
                                                                                    p37.Model:SetAttribute("Stage", "Runaway");
                                                                                end,

                                                                                Next = Dialogue.PLACEHOLDER
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                {
                    Response = "Goodbye.",
                    Next = nil
                }
            }
        },
        step_8 = {
            Mutable = true,
            Text = "Go after Decceleron! Dont let him get away!",
            Options = {
                {
                    Response = "Im ready. Lend me your speed.",

                    Callback = function(p39, p40) -- Line: 439, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("The Veltryx Trial"):expect();
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        },
        step_9 = {
            Mutable = true,
            Text = "%s ... Are you okay? Did you reach Decceleron?",

            Transformer = function(p41, p42) -- Line: 449, Name: Transformer
                -- upvalues: LocalPlayer (copy)
                p42.Text = string.format(p42.Text, LocalPlayer.Name);
            end,

            Options = {
                {
                    Response = "Acceleron...its over. Hes gone. I beat him.",
                    Next = {
                        Text = "I can feel it. The Medium breaths easier again for the first time in eons. You really did it.",
                        Options = {
                            {
                                Response = "But you dont look good.",
                                Next = {
                                    Text = "Don’t worry about me..I’ll be restored to my full vitality soon. Besides this was never about me. This was your crucible. Your trial. I sense that Deceleron will be back..... and I’ll need a Veltryx at my side for when the time comes.",
                                    Options = {
                                        {
                                            Response = "...",
                                            Next = {
                                                Unskippable = true,
                                                Text = "Do you accept your place at my side as the Veltryx? Mortal guardian of the Medium? (ACCEPTING WILL OVERRIDE YOUR CURRENT ABILITY)",
                                                Options = {
                                                    {
                                                        Response = "Yes I do.",
                                                        Next = {
                                                            Unskippable = true,
                                                            Text = "(ARE YOU SURE YOU WANT TO OVERRIDE YOUR CURRENT ABILITY?)",
                                                            Options = {
                                                                {
                                                                    Response = "Yes",

                                                                    Callback = function(p43, p44) -- Line: 478, Name: Callback
                                                                        -- upvalues: u1 (copy)
                                                                        u1:CheckDialogue("The Veltryx Trial"):expect();
                                                                    end,

                                                                    Next = Dialogue.PLACEHOLDER
                                                                }
                                                            }
                                                        }
                                                    },
                                                    {
                                                        Response = "Goodbye.",
                                                        Next = nil
                                                    }
                                                }
                                            }
                                        },
                                        {
                                            Response = "Goodbye.",
                                            Next = nil
                                        }
                                    }
                                }
                            },
                            {
                                Response = "Goodbye.",
                                Next = nil
                            }
                        }
                    }
                },
                {
                    Response = "Goodbye.",
                    Next = nil
                }
            }
        }
    }
};