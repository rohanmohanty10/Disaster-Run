  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "Shanks",

    Start = function() -- Line: 8, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("Shank\'s Gryphon"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Unless you got no business with me, what can I do for you?",
            Options = {
                {
                    Response = "I see you wield a sword, what techniques do you know?",
                    Next = {
                        Mutable = true,
                        Text = "Ah my sword. Well, I call it Gryphon. But I\'ve had it for a while now. What bothers you to know?",
                        Options = {
                            {
                                Response = "I have a sword ability myself too. However, I\'ve been looking to further my techniques and I\'m wondering if you can teach me?",
                                Next = {
                                    Mutable = true,
                                    Text = "Okay, but if you have a sword ability you will HAVE TO USE IT for every single task I provide to you. Use the following listed: Yone, Yasuo, Shadow, Dawn, Umbra, Anubis and Candy Cutlass. Any other ability will NOT work.",
                                    Options = {
                                        {
                                            Response = "Sounds good, I think I\'m ready to learn new techniques.",
                                            Next = {
                                                Mutable = true,
                                                Text = "For your first task, I need you to help me out around here. Slay 20 Pirates around here and I\'ll see if you\'re fit enough to learn my technique. This will also allow you to practice with your current sword.",
                                                Options = {
                                                    {
                                                        Response = "Gotcha. I\'ll be back soon!",
                                                        Next = {
                                                            Text = "Alright, we\'ll see hopefully.",
                                                            Options = {}
                                                        },

                                                        Callback = function() -- Line: 45, Name: Callback
                                                            -- upvalues: u1 (copy)
                                                            u1:CheckDialogue("Shank\'s Gryphon"):expect();
                                                        end
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
        step_2 = {
            Text = "I\'ve defeated the pirates like you told me to.",
            Options = { {
                    Response = "Continue",
                    Next = {
                        Text = "Hmm.. It still looks like there isn\'t lesser of them since we spoke. When you clear it up more, come speak to me then.",
                        Options = {}
                    }
                } }
        },
        step_3 = {
            Mutable = true,
            Text = "I\'ve defeated the pirates like you told me to.",
            Options = {
                {
                    Response = "Continue",
                    Next = {
                        Mutable = true,
                        Text = "It seems as it has cleared enough around here. Great job. Now, for your next task... Well, it\'s more of a personal request but can you bring me some West Blue Juice? Been craving it for a while now.",
                        Options = {
                            {
                                Response = "Uhhh yeah sure... West Blue Juice",
                                Next = {
                                    Text = "Great. I expect to see you back here with it. Don\'t come back till then.",
                                    Options = {}
                                },

                                Callback = function() -- Line: 88, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Shank\'s Gryphon"):expect();
                                end
                            }
                        }
                    }
                }
            }
        },
        step_4 = {
            Text = "I\'ve brought you your West Blue Juice.",
            Options = {
                {
                    Response = "Continue",

                    Next = function() -- Line: 102, Name: Next
                        -- upvalues: u1 (copy)
                        return u1:CheckDialogue("Shank\'s Gryphon"):expect() and {
                            Text = "Perfect, now I\'ve heard that my old crewmate and best friend, Buggy is in Orange Town with his crew. He has some resent built towards me but I don\'t got the time to sort it out with a fool like him. Tell you what, you go over there and defeat him and we\'ll talk further.",
                            Options = {}
                        } or {
                            Text = "Well? You gonna hand it to me? Oh, you\'re just wasting my time. Like I\'ve said, till you get it, do not come back.",
                            Options = {}
                        };
                    end
                }
            }
        },
        step_5 = {
            Text = "I\'ve defeated Buggy.",
            Options = { {
                    Response = "Continue",
                    Next = {
                        Text = "Doesn\'t seem like it. His bounty still exists meaning nobody has defeated him at all. Don\'t lie to me and come back when you actually defeat him.",
                        Options = {}
                    }
                } }
        },
        step_6 = {
            Mutable = true,
            Text = "I\'ve defeated Buggy.",
            Options = {
                {
                    Response = "Continue",
                    Next = {
                        Mutable = true,
                        Text = "His bounty has seem to have vanished along with him. Hmph, you are a lot better than I anticipated. Tell you what. I want you to fight me. If you fight me and beat me using one of the sword abilities I previously mentioned, I\'ll reward ya\' with a custom made manual book for you. Will teach you all the techniques I know. Do you agree?",
                        Options = {
                            {
                                Response = "Yes, I do agree to those conditions.",
                                Next = {
                                    Text = "Okay. I look forward to it. Let\'s see how you can perform against me.",
                                    Options = {}
                                },

                                Callback = function() -- Line: 147, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Shank\'s Gryphon"):expect();
                                end
                            }
                        }
                    }
                }
            }
        },
        step_7 = {
            Text = "...",
            Options = { {
                    Response = "Continue",
                    Next = {
                        Text = "(YOU HAVE NOT BEAT SHANKS YET, RETURN ONCE YOU HAVE SLAIN SHANKS)",
                        Options = {}
                    }
                } }
        },
        step_8 = {
            Text = "...",
            Options = {
                {
                    Response = "Continue",

                    Next = function() -- Line: 173, Name: Next
                        -- upvalues: u1 (copy)
                        return u1:CheckDialogue("Shank\'s Gryphon"):expect() == "ClearSpace" and {
                            Text = "As much as I\'d be willing to give you this manual, it seems I can\'t. Clear out a spot in your ITEMS INVENTORY so I can give it to you.",
                            Options = {}
                        } or {
                            Text = "I\'ve underestimated you by a lot. Surprised you didn\'t kill me after everything I put you through. You\'ve earned it. Take this manual. Use it on yourself. (BEWARE THAT IT REPLACES YOUR CURRENT ABILITY)",
                            Options = {}
                        };
                    end
                }
            }
        }
    }
};