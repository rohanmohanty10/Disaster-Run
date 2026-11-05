  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("InventoryService");
local v3 = {
    Response = "You seem crazy.. Nevermind..",
    Next = "reject"
};

return {
    Title = "Hamon Trainer",

    Start = function() -- Line: 12, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("The Way To Hamon"):expect() or 1}`;
    end,

    Nodes = {
        reject = {
            Text = "Bit weird comin\' from someone like you."
        },
        step_1 = {
            Text = "Hey, you seem like the guy I\'ve been hearing about. Something about potential... towards being a fighter and a user of my technique.",
            Options = {
                {
                    Response = "Who me? I appreciate it but-",
                    Next = {
                        Text = "Anyways, let\'s get to the point here. I can teach you how to use <Color=Yellow>Hamon<Color=/>. You can progess with it by specific breathing techniques you maintain the more you begin to use said so technique.",
                        Options = {
                            {
                                Response = "Hamon....? Alright. Well how can I further proceed to learn this technique?",
                                Next = {
                                    Text = "Well, I can\'t give out free handouts. You\'ll need to prove you\'re capable of learning such a technique. I need you to help me rid the area of Hooligans. There\'s been a lot more lately around the Port lately. Take down at least 15 of them and don\'t come back till you do.",
                                    Options = {
                                        {
                                            Response = "Alright got it.",
                                            Next = {
                                                Text = "Don\'t forget. You don\'t defeat those 15 hooligans, I can not further help you."
                                            },

                                            Callback = function(p4) -- Line: 49, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue("The Way To Hamon"):expect();
                                            end
                                        },
                                        v3
                                    }
                                }
                            },
                            v3
                        }
                    }
                },
                v3
            }
        },
        step_2 = {
            Text = "Did you take care of those Hooligans at the port like I\'ve asked you to do?",
            Options = { {
                    Response = "Yeah, I\'ve taken care of them.",
                    Next = {
                        Text = "Don\'t lie to me. I have eyes around the area. Come to me when you\'ve really taken care of them."
                    }
                } }
        },
        step_3 = {
            Text = "Did you take care of those Hooligans at the port like I\'ve asked you to do?",
            Options = {
                {
                    Response = "Yeah, I\'ve taken care of them.",
                    Next = {
                        Text = "Very well. It\'s still not enough for me. Those port hooligans seem like deadbeats. The thugs around town though, they possess special abilities. Beat 20 of em\', then I\'ll really know you\'re the real deal."
                    },

                    Callback = function(p5) -- Line: 88, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("The Way To Hamon"):expect();
                    end
                }
            }
        },
        step_4 = {
            Text = "Did you take care of those Thugs around town like I\'ve asked you to do?",
            Options = {
                {
                    Response = "Yeah, I\'ve taken care of them.",
                    Next = {
                        Text = "Very well. It\'s still not enough for me. Those port hooligans seem like deadbeats. The thugs around town though, they possess special abilities. Beat 20 of em\', then I\'ll really know you\'re the real deal."
                    },

                    Callback = function(p6) -- Line: 103, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("The Way To Hamon"):expect();
                    end
                }
            }
        },
        step_5 = {
            Text = "Did you take care of those Thugs around town like I\'ve asked you to do?",
            Options = {
                {
                    Response = "Yeah, I\'ve taken care of them.",
                    Next = {
                        Text = "Wow. You\'re actually more persistent than I thought. Okay, for your final task I need you to find me a uhhh. uhhh... a frog! I\'ll demonstrate a hamon technique.",
                        Options = {
                            {
                                Response = "A frog..? Really?",
                                Next = {
                                    Text = "Well to myself, I don\'t think I sound like I\'m joking. I can not proceed forward if you don\'t bring me that frog."
                                },

                                Callback = function(p7) -- Line: 123, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("The Way To Hamon"):expect();
                                end
                            }
                        }
                    }
                }
            }
        },
        step_6 = {
            Mutable = true,
            Text = "Have you found me a frog yet?",
            Options = {
                {
                    Response = "Yes, I have the frog here for you.",

                    Callback = function(p8, p9) -- Line: 139, Name: Callback
                        -- upvalues: u1 (copy)
                        local v10 = u1:CheckRequirement("ItemCountCheck", "ITEM_60"):expect();

                        if typeof(v10) == "number" and v10 > 0 then
                            p9.Next = "step_6_1";
                            u1:CheckDialogue("The Way To Hamon"):expect();
                        end;
                    end,

                    Next = {
                        Text = "Oh you have it right? Let me see it. Oh? You don\'t have it? Yeah. Come back to me when you\'re serious about this and have it."
                    }
                }
            }
        },
        step_6_1 = {
            Text = "Very well. I will now demonstrate to you the technique. Are you ready for it?",
            Options = { {
                    Response = "Yeah, I\'m watching",
                    Next = {
                        Text = "yea i dont feel like describing allat so just picture the jojo scene where zeppeli hit the frog through rock yea",
                        Options = { {
                                Response = "Woah.. How\'d you do that?",
                                Next = {
                                    Text = "Breathing technique. That\'s all it is. Instead of punching the frog directly, I imbued my hamon through it and the shockwave traveled to the bottom of the frog.",
                                    Options = { {
                                            Response = "What do I do now?",
                                            Next = {
                                                Text = "Well. I\'ll hold onto this frog. It has imbued energy into it now. I\'ll give this frog to you next time you come to me ready."
                                            }
                                        } }
                                }
                            } }
                    }
                } }
        },
        step_7 = {
            Text = "Do you think you have what it takes for the final step?",
            Options = {
                {
                    Response = "Yes, I believe I do.",

                    Callback = function(p11, p12) -- Line: 186, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("The Way To Hamon"):expect();
                    end,

                    Next = {
                        Text = "Okay. Here you go. When you\'re ready to fight me, head to the arena and signal me there. I\'ll appear and won\'t hold back. Good luck."
                    }
                }
            }
        }
    }
};