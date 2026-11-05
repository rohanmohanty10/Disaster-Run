  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return {
    Title = "Homare Nishitani",

    Start = function() -- Line: 12, Name: GetStart
        -- upvalues: LocalPlayer (copy), u2 (copy)
        if LocalPlayer.Data.Ability.Value == 1501 then
            return LocalPlayer.Data.Ability:GetAttribute("AscensionRank") < 1 and "not_allowed_mastery" or "stepB_" .. (u2:GetCurrentStep("Nishitani\'s Training"):expect() or 1);
        end;

        return "stepA_" .. (u2:GetCurrentStep("A Gilded Cage"):expect() or 1);
    end,

    Nodes = {
        not_allowed_mastery = {
            Text = "Seems ya\' haven\'t really improved since you learned. Come back to me when you\'re stronger like me. (ASCENSION 1 OR ABOVE REQUIRED)",
            Options = nil
        },
        stepA_1 = {
            Mutable = true,
            Text = "Who are you? I don\'t think I know you. Now, scram outta here!",
            Options = {
                {
                    Response = "I know you don\'t know me but I recognize your demeanor and I\'d like to further understand it.",
                    Next = {
                        Text = "Whatcha talking about my demeanor for? You trying to start something?",
                        Options = {
                            {
                                Response = "Well, I am. I\'m here to learn from you.",

                                Callback = function(p3, p4, p5) -- Line: 49, Name: Callback
                                    -- upvalues: u1 (copy)
                                    if u1:CheckDialogue("A Gilded Cage"):expect() then
                                        p4.Next = {
                                            Text = "Oh? You think you can just waltz up in here and try to learn something? You want to learn a thing? Go fetch my dagger. I lost it in a previous battle. You can do that, maybe I\'ll consider it.",
                                            Options = { {
                                                    Response = "Ok. I will go ahead and do that then.",
                                                    Next = nil
                                                } }
                                        };

                                        return;
                                    end;

                                    p4.Next = {
                                        Text = "Oh? You think you can just waltz up in here and try to learn something? You don\'t even look as good as one of my guys! Scram, and if you want to truly learn something, you\'d think twice before coming back. (YOU NEED STANDLESS TO PROGRESS)",
                                        Options = nil
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
            Text = "Have you fetched me my dagger as I asked?",
            Options = {
                {
                    Response = "I got your dagger here.",

                    Callback = function(p6, p7, p8) -- Line: 86, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("A Gilded Cage"):expect() then
                            p7.Next = {
                                Text = "Sweet. You actually did what I told you to do. You may as well not be so bad after all.",
                                Options = {
                                    {
                                        Response = "Sooo. What about teaching me that demeanor of yours?",
                                        Next = {
                                            Text = "Ohhh right. Well, I think you\'re not fit for it much. That is, unless you can prove it to me that you can unleash that by DEFEATING 15 players.",
                                            Options = {
                                                {
                                                    Response = "Players? Yeah. I think I can do that.",

                                                    Callback = function() -- Line: 99, Name: Callback
                                                        -- upvalues: u1 (ref)
                                                        u1:CheckDialogue("A Gilded Cage"):expect();
                                                    end,

                                                    Next = {
                                                        Text = "I\'ll be waitin\' on ya\' to see if you do it!",
                                                        Options = nil
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            };

                            return;
                        end;

                        p7.Next = {
                            Text = "I think ya\' lying. That dagger got a strong aura to it that I can feel. When you\'re serious, come back with it."
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        },
        stepA_3 = {
            Mutable = true,
            Text = "Have you defeated those 15 players like I\'ve asked you to?",
            Options = { {
                    Response = "Yes. I have defeated all 15 players.",
                    Next = {
                        Text = "You\'re lying to me and I know it! I knew you weren\'t capable of doing this. If you ever do complete this, maybe I\'ll give you a chance when you come back.",
                        Options = nil
                    }
                } }
        },
        stepA_4 = {
            Mutable = true,
            Text = "Have you defeated those 15 players like I\'ve asked you to?",
            Options = {
                {
                    Response = "Yes. I have defeated all 15 players.",
                    Next = {
                        Text = "Heh. I believe you. I see that blood all over ya\'. Proves to me there is something in you. Tell you what. I still need you to defeat more things for me. Take out some local thugs and hooligans, then we can proceed onward.",
                        Options = {
                            {
                                Response = "You want me to defeat MORE people? Really that far?",

                                Callback = function() -- Line: 149, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("A Gilded Cage"):expect();
                                end,

                                Next = {
                                    Text = "Hey, I\'m the teacher here ya\' hear!? Listen what I say!",
                                    Options = nil
                                }
                            }
                        }
                    }
                }
            }
        },
        stepA_5 = {
            Mutable = true,
            Text = "Have you taken care of the local thugs and hooligans?",
            Options = { {
                    Response = "Yes. I have defeated all of them.",
                    Next = {
                        Text = "You lying to me now? I ain\'t see this place clear at all. If you chicken out now, ya won\'t be able to get another chance.",
                        Options = nil
                    }
                } }
        },
        stepA_6 = {
            Mutable = true,
            Text = "Have you taken care of the local thugs and hooligans?",
            Options = {
                {
                    Response = "Yes. I have defeated all of them.",
                    Next = {
                        Text = "Just like that, you\'ve basically cleared out the competition for me. I hope you learned a thing or two from me, now scram.",
                        Options = {
                            {
                                Response = "Just like that? You\'re not even going to go on with this?",
                                Next = {
                                    Text = "Whaddya expect from me? I\'m just a Yakuza after all pal, nothing I can do for you.",
                                    Options = {
                                        {
                                            Response = "That\'s quite scummy of you. Y\'know what. Let\'s settle this out with a fight.",

                                            Callback = function(p9, p10) -- Line: 195, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue("A Gilded Cage"):expect();
                                            end,

                                            Next = {
                                                Text = "Waste of my time aren\'t ya. Well. I\'m willing to put up the fight. You got guts pal. Speak to me again later once you\'re ready to fight.",
                                                Options = nil
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
        stepA_7 = {
            Mutable = true,
            Text = "Are ya\' ready to fight me?",
            Options = {
                {
                    Response = "Yes, I am ready to fight you.",

                    Callback = function(p11, p12) -- Line: 220, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("A Gilded Cage"):expect() then
                            p12.Next = nil;
                            local Model = p11.Metadata.Model;

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
        stepA_8 = {
            Mutable = true,
            Text = "Ya either haven\'t attempted to challenge me or haven\'t defeated me yet. Return to me once you do.",
            Options = {
                {
                    Response = "I need to respawn the boss.",
                    Next = nil,

                    Callback = function(p13, p14) -- Line: 255, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("A Gilded Cage"):expect() then
                            local Model = p13.Metadata.Model;

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
        stepA_9 = {
            Mutable = true,
            Text = "You put up.. a great fight.. Not bad.. Not bad at all.. Y\'know I think that about wraps it up for me. Take, this dagger you got for me. It ain\'t even mine. Belonged to another person like you.",
            Options = {
                {
                    Response = "What\'s this dagger going to do for me..?",
                    Next = {
                        Text = "Well.. That last guy I told ya\' about, had somethin\' in him. I got him to crack his shell like me. Twas\' crazier than I was but. You get the drill.",
                        Options = {
                            {
                                Response = "Oh, okay. I\'ll take this dagger then.",

                                Callback = function(p15, p16) -- Line: 291, Name: Callback
                                    -- upvalues: u1 (copy)
                                    if u1:CheckDialogue("A Gilded Cage"):expect() then
                                        p16.Next = nil;

                                        return;
                                    end;

                                    p16.Next = {
                                        Text = "Ya\' don\'t have enough space in your inventory to hold this dagger. Make some room and speak to me again.",
                                        Options = nil
                                    };
                                end
                            },
                            {
                                Response = "Nah I\'m good.",
                                Next = nil
                            }
                        }
                    }
                }
            }
        },
        stepB_1 = {
            Mutable = true,
            Text = "Ahhhh. You\'re back. Well not like I can scurry you outta\' here, whatcha\' want?",

            Transformer = function(p17, p18) -- Line: 318, Name: Transformer
                -- upvalues: u1 (copy)
                local v19 = game:GetService("Players").LocalPlayer.Character:GetAttribute("MasteryRank") or 0;
                local v20 = { {
                        Rank = 0,
                        Name = "Hannya Dance"
                    }, {
                        Rank = 1,
                        Name = "Triple Rush Attack Finisher"
                    }, {
                        Rank = 2,
                        Name = "Mad Dog Maul"
                    }, {
                        Rank = 3,
                        Name = "Loose Dog"
                    } };

                if v19 > 3 then
                    p18.Text = "Ya\' already learned everything I got to teach. Ain\'t nothing left for me to show ya\'. Now scram and put those skills to use!";
                    p18.Options = { {
                            Response = "Understood.",
                            Next = nil
                        } };

                    return p18;
                end;

                local v21 = {};

                for _, v in v20 do
                    if v19 == v.Rank then
                        local v25 = {
                            Response = `I want to learn {v.Name}. (MASTERY RANK {v.Rank})`,

                            Callback = function(p22, p23, p24) -- Line: 347, Name: Callback
                                -- upvalues: u1 (ref), v (copy)
                                p23.Next = u1:CheckDialogue("Nishitani\'s Training", v.Rank):expect() and {
                                    Text = `Ya' wanna learn {v.Name}? Okay. I need ya' to take care of 5 players around here. Do that and we can discuss more.`,
                                    Options = { {
                                            Response = "5 players to defeat? Okay got it. Will do.",
                                            Next = {
                                                Text = "Yea. Don\'t come back till\' ya taken care of them. Otherwise, we can\'t proceed onward.",
                                                Options = nil
                                            }
                                        } }
                                } or {
                                    Text = "Ya\' ain\'t strong enough for this yet. Try something your league.",
                                    Options = nil
                                };
                            end
                        };
                        table.insert(v21, v25);
                        break;
                    end;
                end;

                table.insert(v21, {
                    Response = "Nevermind.",
                    Next = nil
                });
                p18.Options = v21;

                return p18;
            end,

            Options = {}
        },
        stepB_2 = {
            Mutable = true,
            Text = "Did ya\' take care of 5 players around here like I asked ya\' to?",
            Options = { {
                    Response = "Yes I have.",
                    Next = {
                        Text = "You lyin\' to me now? Bein\' a wimp gets you nowhere. Do as I say first then come back.",
                        Options = nil
                    }
                }, {
                    Response = "No, not yet.",
                    Next = {
                        Text = "Hmph. Okay, come back to me once you have.",
                        Options = nil
                    }
                } }
        },
        stepB_3 = {
            Mutable = true,
            Text = "Did ya\' take care of 5 players around here like I asked ya\' to?",
            Options = {
                {
                    Response = "Yes I have.",
                    Next = {
                        Text = "Well, now we fight once again. I\'ll be using the speciality move, allowing you to see how it is performed. Got it? Come back to me when you\'re ready",
                        Options = {
                            {
                                Response = "Okay, got it.",

                                Callback = function(p26) -- Line: 420, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Nishitani\'s Training"):expect();
                                end
                            },
                            {
                                Response = "Actually, I need more time.",
                                Next = nil
                            }
                        }
                    }
                }
            }
        },
        stepB_4 = {
            Mutable = true,
            Text = "Are ya\' ready to fight me?",
            Options = {
                {
                    Response = "Yes, I am ready to fight you.",

                    Callback = function(p27, p28) -- Line: 441, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Nishitani\'s Training"):expect() then
                            p28.Next = nil;
                            local Model = p27.Metadata.Model;

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
        stepB_5 = {
            Mutable = true,
            Text = "Either ya\' haven\'t beaten me or even attempted to fight me. Come back when you\'ve beaten me.",
            Options = {
                {
                    Response = "I need to respawn the boss.",
                    Next = nil,

                    Callback = function(p29, p30) -- Line: 476, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Nishitani\'s Training"):expect() then
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
                }
            }
        },
        stepB_6 = {
            Mutable = true,
            Text = "Ya\' beat me fair and square. Like said, a deal\'s a deal.",
            Options = {
                {
                    Response = "Great. I\'ll be looking forward to training more.",

                    Callback = function(p31) -- Line: 507, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Nishitani\'s Training"):expect();
                    end
                }
            }
        }
    }
};