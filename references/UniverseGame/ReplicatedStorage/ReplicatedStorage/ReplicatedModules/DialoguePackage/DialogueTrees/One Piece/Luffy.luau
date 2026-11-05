  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Title = "Monkey D. Luffy",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("Gomu\'s Second Gear"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "I\'m Monkey D. Luffy, and I\'m going to be the King of the Pirates!",
            Options = {
                {
                    Response = "Hey, you\'re the guy who possesses further power in Gomu?",
                    Next = {
                        Text = "!! Who\'s asking !! I know nothing about no Gomu! Uhhh.. Wait you\'re not a marine right?",
                        Options = {
                            {
                                Response = "No, I\'m a marine, I also have acquired Gomu powers too like you. I want to learn new techniques and I\'m wondering if you can help me.",
                                Next = {
                                    Text = "H-huh? You have the same powers as me? Nah. That can\'t be! It\'s cool but hmmm.. You actually sort of look like me. Ya feel strong!?",
                                    Options = {
                                        {
                                            Response = "Yeah. I got these from a fruit I earned from a guy\'s chest.",

                                            Callback = function(p3, p4, p5) -- Line: 35, Name: Callback
                                                -- upvalues: u1 (copy)
                                                if u1:CheckDialogue("Gomu\'s Second Gear"):expect() then
                                                    p4.Next = {
                                                        Text = "Ooooohhhh.. Sounds familiar. Anyways ya wanna learn how to be strong like me!? Alright! For your first task bring me a uhhhh..... hmmmm... ummmmm.. Meat on a Bone! Yeah! I\'m starving!",
                                                        Options = { {
                                                                Response = "Seriously? Meat on a Bone?",
                                                                Next = {
                                                                    Text = "Hey! You\'re learning from the best here! I\'m going to make you stronger! I\'m just hungry."
                                                                }
                                                            } }
                                                    };

                                                    return;
                                                end;

                                                p4.Next = {
                                                    Text = "Ooooohhhh.. Sounds familiar. Anyways ya wanna learn how to be strong like me!? You don\'t look strong honestly. Get buff like me and we\'ll talk Haha! (REACH ASCENSION 2 WITH GOMU)"
                                                };
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
        },
        step_2 = {
            Mutable = true,
            Text = "Have you gotten the Meat on a Bone?",
            Options = {
                {
                    Response = "I got you your Meat on a Bone.",

                    Callback = function(p6, p7, p8) -- Line: 71, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Gomu\'s Second Gear"):expect() then
                            p7.Next = {
                                Text = "Haha! I KNEW I could count you! This look so good. I\'ve been starving all day!",
                                Options = {
                                    {
                                        Response = "Hey.. How about teaching me you know?",
                                        Next = {
                                            Text = "O-oh. Sorry! I\'ve just been so hungry today. I just really love meat. Anyways uh. You up to fight!? Do me a favor and help me take care of some of those pirates in Orange Town! I\'m tired from eating all this food you know.",
                                            Options = {
                                                {
                                                    Response = "Seriously? Pirates again?",

                                                    Callback = function() -- Line: 84, Name: Callback
                                                        -- upvalues: u1 (ref)
                                                        u1:CheckDialogue("Gomu\'s Second Gear"):expect();
                                                    end,

                                                    Next = {
                                                        Text = "Hey, hey! You signed up for it. I\'m just teaching ya\' the basics here."
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
                            Text = "Dude. I have a strong sense of smell."
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        },
        step_3 = {
            Mutable = true,
            Text = "Have you gotten the Meat on a Bone?",
            Options = {
                {
                    Response = "I got you your Meat on a Bone.",
                    Next = {
                        Text = "Haha! I KNEW I could count you! This look so good. I\'ve been starving all day!",
                        Options = {
                            {
                                Response = "Hey.. How about teaching me you know?",
                                Next = {
                                    Text = "O-oh. Sorry! I\'ve just been so hungry today. I just really love meat. Anyways uh. You up to fight!? Do me a favor and help me take care of some of those pirates in Orange Town! I\'m tired from eating all this food you know.",
                                    Options = {
                                        {
                                            Response = "Seriously? Pirates again?",

                                            Callback = function() -- Line: 121, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue("Gomu\'s Second Gear"):expect();
                                            end,

                                            Next = {
                                                Text = "Hey, hey! You signed up for it. I\'m just teaching ya\' the basics here."
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
        step_4 = {
            Text = "You know I can sense some liars but you are a different type... You still look just as weak when I saw you.. Come back when you\'ve actually done it!"
        },
        step_5 = {
            Mutable = true,
            Text = "Alright! I can tell you\'re growing in power just like me! Uhhh.. For the next task let me think... O- yeah. Okay, you should... Go beat up this Buggy guy! Yeah! I don\'t like him!",
            Options = {
                {
                    Response = "You gonna help me at least?",

                    Callback = function() -- Line: 146, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Gomu\'s Second Gear"):expect();
                    end,

                    Next = {
                        Text = "Who me? Naw the teacher stays back and slacks while you take care of him! I have faith in you don\'t worry!"
                    }
                }
            }
        },
        step_6 = {
            Text = "Huhhhh? I see his bounty though... You lying to me!?"
        },
        step_7 = {
            Mutable = true,
            Text = "Oooohh! His bounty is gone! Another step for me becoming King of the Pirates! Haha!",
            Options = {
                {
                    Response = "Uhhhh... I\'m still here though...",
                    Next = {
                        Text = "You again? Oh I mean hey! Ok ok! Uhhhh... uhh.... Fight this Law guy! Yeah! He\'s been bothering me a lot.",
                        Options = {
                            {
                                Response = "Bro what.",

                                Callback = function() -- Line: 169, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Gomu\'s Second Gear"):expect();
                                end,

                                Next = {
                                    Text = "Do this and I might just actually teach you everything I know! (he\'s really helping me get to the top...)"
                                }
                            }
                        }
                    }
                }
            }
        },
        step_8 = {
            Text = "HIS BOUNTY IS STILL THERE! YOU HAVEN\'T EVEN INCHED TOWARDS HIM!?"
        },
        step_9 = {
            Mutable = true,
            Text = "Aha! You did beat him! His bounty is gone! Amazing! Fantastic! Ok ok! For the grand prize! You get to fight me!",
            Options = {
                {
                    Response = "FIGHT YOU? Dude! I barely know less than half of what you probably do!",
                    Next = {
                        Text = "Yeah.. But you\'re growing in your strength. You\'re getting too strong so I need to also stop you. Tell you what though.. You beat me and I\'ll still teach you anyways!"
                    }
                },
                {
                    Response = "You got a deal here.",

                    Callback = function(p9, p10, p11) -- Line: 196, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Gomu\'s Second Gear"):expect();
                        p10.Next = {
                            Text = "Hahahahaha! I look forward to it!"
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};