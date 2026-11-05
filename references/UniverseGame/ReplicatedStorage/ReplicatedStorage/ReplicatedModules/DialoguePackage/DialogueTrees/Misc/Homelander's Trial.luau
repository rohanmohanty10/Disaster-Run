  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("TitleService");
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
        Text = "Complete my task if you want to be on your way to joining the Seven.",
        Options = {
            {
                Response = "I will.",
                Next = Dialogue.PLACEHOLDER
            }
        }
    };
end;

local function GuideToDance() -- Line: 40
    -- upvalues: LocalPlayer (copy)
    local u3 = workspace:FindFirstChild("NPCS") and workspace.NPCS:FindFirstChild("Homelander");

    if u3 then
        u3 = u3:FindFirstChild("Dance");
    end;

    if u3 then
        u3 = u3:FindFirstChild("Trigger");
    end;

    if not u3 then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    if Character:FindFirstChild("DanceWaypoint") then
        return;
    end;

    local u4 = script.SanjiWaypoint:Clone();
    u4.Name = "DanceWaypoint";
    u4.Parent = Character;
    task.spawn(function() -- Line: 59
        -- upvalues: u3 (copy), Character (copy), u4 (copy)
        while true do
            task.wait();

            if not (u3 and (u3.Parent and (Character and Character.Parent))) then
                break;
            end;

            local Position = u3.Position;
            local Magnitude = (Position - Character.Position).Magnitude;

            if Magnitude < 50 then
                u4.Transparency = 1 - math.max(0, (Magnitude - 15) / 50);
            else
                u4.Transparency = 0;
            end;

            u4.CFrame = CFrame.new(Character.Position, Position) * CFrame.new(0, 0, -10) * CFrame.Angles(0, 1.5707963267948966, 0);

            if not u4:IsDescendantOf(game) then
                break;
            end;
        end;

        if u4 and u4.Parent then
            u4:Destroy();
        end;
    end);
end;

return {
    Title = "Homelander",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: LocalPlayer (copy), u2 (copy)
        local v5 = LocalPlayer:GetAttribute("TheTrials");

        if v5 then
            return "trial_" .. v5;
        end;

        return `step_{u2:GetCurrentStep("Homelander\'s Trial"):expect() or 1}`;
    end,

    Nodes = {
        trial_0 = {
            Unskippable = true,
            Mutable = true,
            Text = "",

            Transformer = function(p6, p7) -- Line: 92, Name: Transformer
                local v8 = { "You have failed. Prepare better next time.", "The Seven does not favor the unready. Return when your will is sharper.", "You stumbled. Learn from it.", "Failure is not the end. Refocus.", "You were too slow... or too careless. Either way, you must improve." };
                p7.Text = v8[math.random(1, #v8)];
                task.delay(5, p6.Destroy, p6);
            end
        },
        trial_1 = {
            Unskippable = true,
            Mutable = true,
            Text = "Welcome to The Trials. This is the staging chamber. Prepare yourself and enter the Trials when you\'re ready.",

            Transformer = function(p9, p10) -- Line: 115, Name: Transformer
                task.delay(8, p9.Destroy, p9);
            end
        },
        trial_2 = {
            Unskippable = true,
            Mutable = true,
            Text = "Hello, %s. Defeat each opponent within the time limit without rests or second chances. The Trials begin now.",

            Transformer = function(p11, p12) -- Line: 124, Name: Transformer
                -- upvalues: LocalPlayer (copy)
                p12.Text = string.format(p12.Text, LocalPlayer.Name);
                task.delay(6, p11.Destroy, p11);
            end
        },
        trial_3 = {
            Unskippable = true,
            Mutable = true,
            Text = "First up! The wielder of the Ope-Ope No Mi, the Surgeon of Death.",

            Transformer = function(p13, p14) -- Line: 134, Name: Transformer
                task.delay(5, p13.Destroy, p13);
            end
        },
        trial_4 = {
            Unskippable = true,
            Mutable = true,
            Text = "You defeated Law.. but are you a match for Minos Prime!?!",

            Transformer = function(p15, p16) -- Line: 143, Name: Transformer
                task.delay(4, p15.Destroy, p15);
            end
        },
        trial_5 = {
            Unskippable = true,
            Mutable = true,
            Text = "For your final and hardest battle yet, defeat The Denizen of Hell, a master in the arts of the Oni.",

            Transformer = function(p17, p18) -- Line: 152, Name: Transformer
                task.delay(5, p17.Destroy, p17);
            end
        },
        trial_6 = {
            Unskippable = true,
            Mutable = true,
            Text = "Congrats twin you beat the trials",

            Transformer = function(p19, p20) -- Line: 161, Name: Transformer
                task.delay(5, p19.Destroy, p19);
            end
        },
        step_1 = {
            Mutable = true,
            Text = "Who are you son",
            Options = {
                {
                    Response = "Uhh… you looked menacing. Could you make me powerful?",
                    Next = {
                        Text = "We are missing a member of the Seven... Fine. First you have to prove yourself. ",
                        Options = {
                            {
                                Response = "What do I have to do?",

                                Callback = function(p21, p22) -- Line: 181, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Homelander\'s Trial"):expect();
                                end,

                                Next = {
                                    Text = "First, get rid of the prisoners and pirates. I suspect they are Starlighters over there. Pesky starlights. I hate the memes they make about me.",
                                    Options = { {
                                            Response = "Goodbye.",
                                            Next = nil
                                        } }
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
        step_2 = QuestCheck(),
        step_3 = {
            Mutable = true,
            Text = "Have you killed the Starlighters?",
            Options = {
                {
                    Response = "Yes I have. Why couldn\'t you have done that?",
                    Next = {
                        Text = "Because I am the Homelander. My reputation matters, which brings me to your next task: Create a successful social media post. Half of being apart of the Seven is the powers, the other half is how well you can connect with the people.",
                        Options = {
                            {
                                Response = "How?",

                                Callback = function(p23, p24) -- Line: 212, Name: Callback
                                    -- upvalues: GuideToDance (copy), u1 (copy)
                                    GuideToDance();
                                    u1:CheckDialogue("Homelander\'s Trial"):expect();
                                end,

                                Next = {
                                    Text = "Go by the green screen and record a dance. If you can reach 10m likes I will consider your position.",
                                    Options = { {
                                            Response = "Goodbye.",
                                            Next = nil
                                        } }
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
        step_4 = QuestCheck(),
        step_5 = {
            Mutable = true,
            Text = "Congratulations, you continue to impress me.",
            Options = {
                {
                    Response = "What now?",

                    Callback = function(p25, p26) -- Line: 239, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Homelander\'s Trial"):expect();
                    end,

                    Next = {
                        Text = "Now it is time to test your endurance and strength. If you can complete the Trials then you are one step closer to obtaining the V, the object that will grant you powers.",
                        Options = { {
                                Response = "Goodbye.",
                                Next = nil
                            } }
                    }
                },
                {
                    Response = "Goodbye.",
                    Next = nil
                }
            }
        },
        step_6 = {
            Mutable = true,
            Text = "Are you ready to enter the arena and begin the Trials?",
            Options = {
                {
                    Response = "Yes. I am prepared.",

                    Callback = function(p27, p28) -- Line: 259, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Homelander\'s Trial"):expect();
                    end
                },
                {
                    Response = "Not yet.",
                    Next = Dialogue.PLACEHOLDER
                }
            }
        },
        step_7 = {
            Mutable = true,
            Text = "...You did it. You beat them all. Good. The path of towards the Seven is never without pressure.",
            Options = {
                {
                    Response = "What now?? I\'m capable of handling the V now right-",
                    Next = {
                        Title = "Kur",
                        Text = "HAHA WAAZZZAUP HOMELANDER! AWOOOOO",
                        Unskippable = true,
                        TitleColor = Color3.fromRGB(218, 0, 0),
                        Options = {
                            {
                                Response = "...",

                                Callback = function(u29, p30) -- Line: 284, Name: Callback
                                    -- upvalues: ReplicatedStorage (copy), PathShortcuts (copy)
                                    local v31 = u29.Trove:Clone(ReplicatedStorage["Client Assets"].KurUGrain);
                                    v31.Parent = workspace.Effects;
                                    u29.Model = v31;
                                    u29.Trove:Add(function() -- Line: 289
                                        -- upvalues: u29 (copy)
                                        u29.Model = nil;
                                    end);
                                    require(PathShortcuts.ReplicatedModules.EffectsHandler).CallEffect("Decceleron NPC", {
                                        Model = v31,
                                        Acceleron = u29.Metadata.Model
                                    });
                                end,

                                Next = {
                                    Title = "Kur",
                                    Text = "MISS ME? AWOOOOO",
                                    Unskippable = true,
                                    TitleColor = Color3.fromRGB(218, 0, 0),
                                    Options = {
                                        {
                                            Response = "Who are you??",

                                            Callback = function(p32, p33) -- Line: 307, Name: Callback
                                                p32.Model:SetAttribute("Stage", "FirstTurn");
                                            end,

                                            Next = {
                                                Text = "Kur!!!! The Seven has been chasing you for years for not finishing goku!!",
                                                Unskippable = true,
                                                Options = {
                                                    {
                                                        Response = "😱😱😱",

                                                        Callback = function(p34, p35) -- Line: 316, Name: Callback
                                                            p34.Model:SetAttribute("Stage", "Attack");
                                                        end,

                                                        Next = {
                                                            Title = "Kur",
                                                            Text = "CYA LATER AWOOOOO",
                                                            Unskippable = true,
                                                            TitleColor = Color3.fromRGB(218, 0, 0),
                                                            Options = {
                                                                {
                                                                    Response = "What do I do??",

                                                                    Callback = function(p36, p37) -- Line: 327, Name: Callback
                                                                        -- upvalues: u1 (copy)
                                                                        u1:CheckDialogue("Homelander\'s Trial"):expect();
                                                                        p37.Next = {
                                                                            Text = "Listen to me… do not fret… I won\'t be able to fully catch up to him... but you can ... you trained for this. I’ll grant you some Temp V to temporarily give you speed powers to chase him. I\'ll be right behind you. (TALK TO QUEST GIVER TO INITIATE CHASE)",
                                                                            Unskippable = true
                                                                        };
                                                                        p36.Model:SetAttribute("Stage", "Runaway");
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
                },
                {
                    Response = "Goodbye.",
                    Next = nil
                }
            }
        },
        step_8 = {
            Mutable = true,
            Text = "Dont let that Starlighter Kur get away!",
            Options = {
                {
                    Response = "ILL GO AS FAST A SPEEDING TRAIN!!",

                    Callback = function(p38, p39) -- Line: 360, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Homelander\'s Trial"):expect();
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        },
        step_9 = {
            Mutable = true,
            Text = "%s ... good work son. You were as fast as a train. We\'ve been trying to catch that Starlighter for ages.",

            Transformer = function(p40, p41) -- Line: 370, Name: Transformer
                -- upvalues: LocalPlayer (copy)
                p41.Text = string.format(p41.Text, LocalPlayer.Name);
            end,

            Options = {
                {
                    Response = "So... now that I\'ve dealt with that affair and proved I can handle Temp V can I have the real compound?",
                    Next = {
                        Text = "Nah son. Now you have to prove that you can beat me.",
                        Options = {
                            {
                                Response = "Fine lets do it.",

                                Callback = function(p42, p43) -- Line: 382, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Homelander\'s Trial"):expect();
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
        },
        step_10 = {
            Mutable = true,
            Text = "Enough talk. Show me what you\'ve got.",
            Options = { {
                    Response = "Goodbye.",
                    Next = nil
                } }
        }
    }
};