  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return {
    Title = "Sotaro Komaki",

    Start = function() -- Line: 13, Name: GetStart
        -- upvalues: LocalPlayer (copy), u2 (copy)
        local Value = LocalPlayer.Data.Ability.Value;

        if Value == 1500 then
            return LocalPlayer.Data.Ability:GetAttribute("AscensionRank") < 1 and "not_allowed_mastery" or "stepB_" .. (u2:GetCurrentStep("Komaki\'s Training"):expect() or 1);
        end;

        return Value ~= 1 and "not_allowed" or "stepA_" .. (u2:GetCurrentStep("Awakening The Dragon"):expect() or 1);
    end,

    Nodes = {
        not_allowed = {
            Text = "I don\'t see much potential in you. Search for the right person as I believe you are mistaken.",
            Options = nil
        },
        not_allowed_mastery = {
            Text = "It seems you haven\'t honed your abilities more since you\'ve learned some of the things I\'ve taught you. Return to me once you\'ve improved. (ASCENSION 1 OR ABOVE REQUIRED)",
            Options = nil
        },
        stepA_1 = {
            Mutable = true,
            Text = "Hello there, I don\'t think your one of my pupils. Unless you\'ve come to me for further desire.",
            Options = {
                {
                    Response = "I\'m not but, I hear you have great techniques to advance what I know.",
                    Next = {
                        Text = "Indeed I do. But, who\'s asking? I only train the best.",
                        Options = {
                            {
                                Response = "Well, I am. I\'m here to learn from you.",

                                Callback = function(p3, p4, p5) -- Line: 54, Name: Callback
                                    -- upvalues: u1 (copy)
                                    if not u1:CheckDialogue("Awakening The Dragon"):expect() then
                                        p4.Next = {
                                            Text = "I don\'t sense much potential coming from you. When you figure it out, return to me.",
                                            Options = nil
                                        };

                                        return;
                                    end;

                                    for _, descendant in workspace.Map["Revelation Points"]:GetDescendants() do
                                        if descendant:IsA("BasePart") and descendant:GetAttribute("Revelation") then
                                            descendant.Transparency = 0.5;
                                        end;

                                        if descendant:IsA("ProximityPrompt") then
                                            descendant.Enabled = true;
                                        end;
                                    end;

                                    p4.Next = {
                                        Text = "Okay, I can see the potential coming from you. Though, you\'re quite lacking. I want you to go around the area and consider some possible techniques and remeber your previous ones too.",
                                        Options = { {
                                                Response = "Sooo. Some revelations? Got it. Not sure how that\'ll help me.",
                                                Next = {
                                                    Text = "Trust me. You\'ll see it yourself once you find it.",
                                                    Options = nil
                                                }
                                            } }
                                    };
                                end
                            },
                            {
                                Response = "You know what, nevermind actually.",
                                Next = nil
                            }
                        }
                    }
                }
            }
        },
        stepA_2 = {
            Mutable = true,
            Text = "Have you finished reminding yourself of what you\'re capable of my potential pupil?",
            Options = {
                {
                    Response = "Yes, I believe so.",
                    Next = {
                        Text = "Hmm.. Seems you\'re not telling me the truth.",
                        Options = nil
                    }
                },
                {
                    Response = "I need to reactivate the prompts.",
                    Next = nil,

                    Callback = function() -- Line: 111, Name: Callback
                        for _, descendant in workspace.Map["Revelation Points"]:GetDescendants() do
                            if descendant:IsA("BasePart") and descendant:GetAttribute("Revelation") then
                                descendant.Transparency = 0.5;
                            end;

                            if descendant:IsA("ProximityPrompt") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end
                }
            }
        },
        stepA_3 = {
            Mutable = true,
            Text = "Have you finished reminding yourself of what you\'re capable of my potential pupil?",
            Options = {
                {
                    Response = "Yes, I believe so.",
                    Next = {
                        Text = "Hm. Good. You\'ve look more wise, hah. With some newly-found knowledge and remembrance of your techniques, I request you defeat my other pupils. They have similar knowledge to you. Defeating them will grant you scrolls that you MUST return to me.",
                        Options = {
                            {
                                Response = "Pupils? Where can I find them at?",

                                Callback = function(p6, p7, p8) -- Line: 144, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Awakening The Dragon"):expect();
                                end,

                                Next = {
                                    Text = "You can find them around this section of the island. They\'ll be waiting around here.",
                                    Options = nil
                                }
                            }
                        }
                    }
                }
            }
        },
        stepA_4 = {
            Mutable = true,
            Text = "Do you have the scrolls to turn in?",
            Options = {
                {
                    Response = "Yes, I believe so.",

                    Callback = function(p9, p10) -- Line: 166, Name: Callback
                        -- upvalues: u1 (copy)
                        local v11 = u1:CheckDialogue("Awakening The Dragon"):expect();

                        if not v11 then
                            p10.Next = {
                                Text = "You seem to have nothing to turn into me. Please return back once you do, it is a necessity.",
                                Options = nil
                            };

                            return;
                        end;

                        if v11 == "More" then
                            p10.Next = {
                                Text = "It seems you don\'t have all the scrolls to turn in. Please come back once you have the remaining scrolls.",
                                Options = nil
                            };

                            return;
                        end;

                        p10.Next = {
                            Text = "Very well, I\'ll now request you fight me with these newly-found knowledge. Defeat me and we\'ll proceed onward from there. Speak to me again once you\'re ready.",
                            Options = nil
                        };
                    end
                }
            }
        },
        stepA_5 = {
            Mutable = true,
            Text = "Pupil, are you ready to challenge me to prove your readiness?",
            Options = {
                {
                    Response = "Yes, I am ready to fight you.",

                    Callback = function(p12, p13) -- Line: 198, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Awakening The Dragon"):expect() then
                            p13.Next = nil;
                            local Model = p12.Metadata.Model;

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("ProximityPrompt") then
                                    descendant.Enabled = false;
                                end;
                            end;

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("BasePart") or descendant:IsA("MeshPart") and descendant.Name ~= "HumanoidRootPart" or descendant:IsA("Decal") then
                                    descendant.Transparency = 1;
                                end;
                            end;
                        end;
                    end
                },
                {
                    Response = "No, I need some more time.",
                    Next = nil
                }
            }
        },
        stepA_6 = {
            Mutable = true,
            Text = "You either haven\'t attempted to challenge me or haven\'t defeated me yet. Return to me once you do.",
            Options = {
                {
                    Response = "I need to respawn the boss.",
                    Next = nil,

                    Callback = function(p14, p15) -- Line: 233, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Awakening The Dragon"):expect() then
                            local Model = p14.Metadata.Model;

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("ProximityPrompt") then
                                    descendant.Enabled = false;
                                end;
                            end;

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("BasePart") or descendant:IsA("MeshPart") and descendant.Name ~= "HumanoidRootPart" or descendant:IsA("Decal") then
                                    descendant.Transparency = 1;
                                end;
                            end;
                        end;
                    end
                }
            }
        },
        stepA_7 = {
            Mutable = true,
            Text = "You\'ve done very well. Seems like you didn\'t have a rough time defeating me. Well now, take this scroll. It\'ll teach you new skillsets. I trust you will use this wisely.",
            Options = {
                {
                    Response = "Okay, I will do so then.",

                    Callback = function(p16, p17) -- Line: 264, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Awakening The Dragon"):expect() then
                            p17.Next = nil;

                            return;
                        end;

                        p17.Next = {
                            Text = "It seems you don\'t have enough capacity to hold this scroll. Clear out some space in your inventory and then speak to me again.",
                            Options = nil
                        };
                    end
                },
                {
                    Response = "Nah I\'m good.",
                    Next = nil
                }
            }
        },
        stepB_1 = {
            Mutable = true,
            Text = "Welcome back my pupil. Are you ready to keep on advancing your techniques and strength?",

            Transformer = function(p18, p19) -- Line: 288, Name: Transformer
                -- upvalues: u1 (copy)
                local v20 = game:GetService("Players").LocalPlayer.Character:GetAttribute("MasteryRank") or 0;
                local v21 = { {
                        Rank = 0,
                        Name = "Essence of Sumo Slap"
                    }, {
                        Rank = 1,
                        Name = "Triple Rush Attack Finisher"
                    }, {
                        Rank = 2,
                        Name = "Dragon of Dojima \'88"
                    }, {
                        Rank = 3,
                        Name = "Tiger Drop"
                    } };

                if v20 > 3 then
                    p19.Text = "You\'ve outdone yourself my pupil. There\'s nothing left for me to teach you.";
                    p19.Options = { {
                            Response = "Understood.",
                            Next = nil
                        } };

                    return p19;
                end;

                local v22 = {};

                for _, v in v21 do
                    if v20 == v.Rank then
                        local v26 = {
                            Response = `I want to learn {v.Name}. (MASTERY RANK {v.Rank})`,

                            Callback = function(p23, p24, p25) -- Line: 317, Name: Callback
                                -- upvalues: u1 (ref), v (copy)
                                p24.Next = u1:CheckDialogue("Komaki\'s Training", v.Rank):expect() and {
                                    Text = `Hmm. So you want to learn {v.Name}? I need you to locate Scroll of {v.Name} first. Bring it to me once you've found it.`,
                                    Options = { {
                                            Response = "Okay, got it.",
                                            Next = {
                                                Text = "Remember, you can\'t get better without understanding what the technique is first.",
                                                Options = nil
                                            }
                                        } }
                                } or {
                                    Text = "You\'re not ready for this yet. Try something more you\'re more capable of doing first.",
                                    Options = nil
                                };
                            end
                        };
                        table.insert(v22, v26);
                        break;
                    end;
                end;

                table.insert(v22, {
                    Response = "Nevermind.",
                    Next = nil
                });
                p19.Options = v22;

                return p19;
            end,

            Options = {}
        },
        stepB_2 = {
            Mutable = true,
            Text = "Do you have the scroll that I requested you bring to me?",
            Options = {
                {
                    Response = "Yes I have it here.",

                    Callback = function(p27, p28) -- Line: 361, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Komaki\'s Training"):expect() then
                            p28.Next = {
                                Text = "Great. I will request that you duel me now. I will utilize this skill as you fight me, which will allow you to observe its functionality. Return to me once you\'re ready.",
                                Options = nil
                            };

                            return;
                        end;

                        p28.Next = {
                            Text = "Hmph. Seems you are lying to me! Remember pupil, you\'re attempting to advance your skillset, not waste our times. Please turn in the scroll to me before. (IF YOU HAVE IT, ENSURE IT\'S IN YOUR INVENTORY.)",
                            Options = nil
                        };
                    end
                }
            }
        },
        stepB_3 = {
            Mutable = true,
            Text = "Hello there. Are you ready to challenge me?",
            Options = {
                {
                    Response = "Yes, I am ready to fight you.",

                    Callback = function(p29, p30) -- Line: 386, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Komaki\'s Training"):expect() then
                            p30.Next = nil;
                            local Model = p29.Metadata.Model;

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("ProximityPrompt") then
                                    descendant.Enabled = false;
                                end;
                            end;

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("BasePart") or descendant:IsA("MeshPart") and descendant.Name ~= "HumanoidRootPart" or descendant:IsA("Decal") then
                                    descendant.Transparency = 1;
                                end;
                            end;
                        end;
                    end
                },
                {
                    Response = "No, I need some more time.",
                    Next = nil
                }
            }
        },
        stepB_4 = {
            Mutable = true,
            Text = "You either haven\'t attempted to challenge me or haven\'t defeated me yet. Return to me once you do.",
            Options = {
                {
                    Response = "I need to respawn the boss.",
                    Next = nil,

                    Callback = function(p31, p32) -- Line: 421, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Komaki\'s Training"):expect() then
                            local Model = p31.Metadata.Model;

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("ProximityPrompt") then
                                    descendant.Enabled = false;
                                end;
                            end;

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("BasePart") or descendant:IsA("MeshPart") and descendant.Name ~= "HumanoidRootPart" or descendant:IsA("Decal") then
                                    descendant.Transparency = 1;
                                end;
                            end;
                        end;
                    end
                }
            }
        },
        stepB_5 = {
            Mutable = true,
            Text = "You did good my pupil. Now that you\'ve completed your training, you are now ready to instill this technique into your skillset. Return to me once you\'re ready to do more.",
            Options = {
                {
                    Response = "Great. I\'ll be looking forward to training more.",

                    Callback = function(p33) -- Line: 452, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Komaki\'s Training"):expect();
                    end
                }
            }
        }
    }
};