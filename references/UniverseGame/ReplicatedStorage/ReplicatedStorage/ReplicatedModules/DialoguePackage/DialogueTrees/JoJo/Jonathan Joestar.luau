  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local LocalPlayer = game.Players.LocalPlayer;

return {
    Title = "Jonathan Joestar",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: LocalPlayer (copy), u2 (copy)
        if LocalPlayer.Data.Ability.Value ~= 22 then
            return "not_allowed";
        end;

        local v3 = u2:GetCurrentStep("Learning Jonathan\'s Style"):expect() or 1;
        local v4 = tostring(v3);

        return (v4 == "6" or v4 == "7") and "step_finale" or `step_{v4}`;
    end,

    Nodes = {
        not_allowed = {
            Text = "Sorry, I can\'t help you right now. I\'m in the middle of an emergency.",
            Options = {}
        },
        step_1 = {
            Mutable = true,
            Text = "Hey! You\'re a hamon user aren\'t ya? What brings you to me?",
            Options = {
                {
                    Response = "I was referred here by a guy called William Zeppeli.",
                    Next = {
                        Text = "Oh now were you? He gives an item you\'re supposed to give to me if so. Do you have it?",
                        Options = {
                            {
                                Response = "Yes, I have it right there.",
                                Next = {
                                    Callback = function() -- Line: 47, Name: Callback
                                        -- upvalues: LocalPlayer (copy)
                                        local Inventory = LocalPlayer:FindFirstChild("Inventory");
                                        local v5 = false;

                                        if Inventory then
                                            for _, child in pairs(Inventory:GetChildren()) do
                                                if child.Name == "LetterOfReferral" then
                                                    child:Destroy();
                                                    v5 = true;
                                                    break;
                                                end;
                                            end;
                                        end;

                                        return v5 and {
                                            Text = "Very well. I need your help then. I need to make sure you\'re willing to be committed to this. I have a, well... Used to consider him my brother. He\'s obtained the power of a vampire and has his own minions running around now. They\'re zombies, literally. Defeat 15 of them to prove you are capable of utilizing your Base Hamon techniques."
                                        } or {
                                            Text = "No you do not. I do not see it in your inventory. Come back to me when you have it. Talk to a man named William Zeppeli."
                                        };
                                    end
                                }
                            }
                        }
                    }
                },
                {
                    Response = "Sorry, didn\'t mean to strike conversation.",
                    Next = {
                        Text = "Who just goes up to someone random to talk to them just to walk away? Ok then."
                    }
                }
            }
        },
        step_2 = {
            Text = "Did you take care of Dio\'s Zombie henchmen like I asked you to?",
            Options = { {
                    Response = "Yes I took care of the zombies like you asked me to.",
                    Next = {
                        Text = "Have you? I don\'t think so. Last time I went back to check, seems like a couple were left. Come back to me once you\'re serious about taking them all out."
                    }
                } }
        },
        step_3 = {
            Mutable = true,
            Text = "Did you take care of Dio\'s Zombie henchmen like I asked you to?",
            Options = {
                {
                    Response = "Yes I took care of the zombies like you asked me to.",
                    Next = {
                        Text = "Sweet. Alright then. I\'m not too sure what else I can have you prove as for I had to learn this quick myself too. You know what. I want you to help me fight Dio Brando.",
                        Options = {
                            {
                                Response = "Oh? Just fight the vampire? That\'s it? If it\'s tag team we can for sure take him down.",
                                Next = {
                                    Callback = function() -- Line: 107, Name: Callback
                                        -- upvalues: u1 (copy)
                                        u1:CheckDialogue("Learning Jonathan\'s Style"):expect();

                                        return {
                                            Text = "Well, here\'s the thing. I want you to do it yourself. If you can not beat someone like him, you can\'t really keep up with my style. In order to prove yourself first, you need to fight me using your Base Hamon techniques. Come talk to me once you\'re ready to fight me."
                                        };
                                    end
                                }
                            }
                        }
                    }
                }
            }
        },
        step_4 = {
            Mutable = true,
            Text = "Are you ready to battle me? Keep in mind that this will determine if you will be able to beat me or not.",
            Options = {
                {
                    Response = "Yes I\'m ready to battle you.",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 129, Name: Callback
                            -- upvalues: u1 (copy)
                            return u1:CheckDialogue("Learning Jonathan\'s Style"):expect() and {
                                Text = "Take this summon signal. When you\'re ready, head to the arena and summon me there. When you\'ve beaten me, return back and chat with me. Good luck."
                            } or {
                                Text = "Seems like you have to either clear an inventory slot or you\'re equipped with the signal already. Double check first, then determine what to do after."
                            };
                        end
                    }
                },
                {
                    Response = "No, I need some more time to think about it.",
                    Next = {
                        Text = "Sounds good then. No pressure, but don\'t wait too long. Not sure how much longer he plans to wait before he attempts havoc."
                    }
                }
            }
        },
        step_5 = {
            Mutable = true,
            Text = "...",
            Options = {
                {
                    Response = "...",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 160, Name: Callback
                            -- upvalues: u1 (copy)
                            local v6 = u1:CheckDialogue("Learning Jonathan\'s Style"):expect();

                            return v6 and (v6 == "ClearSpace" and {
                                Text = "You were a lot better than I thought. Although, to proceed on I need you to clear an inventory slot in your items. Please do so then talk to me again."
                            } or {
                                Text = "You were a lot better than I thought. Almost a warrior. Alright. We can move on then. For your final task, I\'ll need you to fight Dio Brando. Find Hecate, and you\'ll be given a contract to finish off Dio once and for all. Don\'t come back until you\'ve beaten him."
                            }) or {
                                Text = "Seems like you haven\'t beaten me yet. I\'ll give you another signal if you\'ve lost your current one. Please return to me once you have beaten me."
                            };
                        end
                    }
                }
            }
        },
        step_finale = {
            Mutable = true,
            Text = "Did you defeat him? Did you finally put an end to Dio Brando?",
            Options = {
                {
                    Response = "Yes, I believe I put an end to Dio Brando.",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 191, Name: Callback
                            -- upvalues: u1 (copy)
                            local v7 = u1:CheckDialogue("Learning Jonathan\'s Style"):expect();

                            return v7 and (v7 == "ClearSpace" and {
                                Text = "I need you to clear a slot in your ability inventory before we can proceed any further."
                            } or {
                                Text = "Very well then. A promise is a promise. I will teach you my style. Take it and I\'ll hopefully see you around soon. Thanks for everything."
                            }) or {
                                Text = "I\'ve been told by a friend of mine that he hasn\'t been taken down yet and still spots him runnin\' around wreaking havoc. You should get to him and stop him before you talk to me. Hecate will give you further instructions."
                            };
                        end
                    }
                },
                {
                    Response = "No, I have not defeated him yet.",
                    Next = {
                        Text = "Have you attempted to at least? Come on.. You have to take this guy down before anything else bad happens."
                    }
                }
            }
        }
    }
};