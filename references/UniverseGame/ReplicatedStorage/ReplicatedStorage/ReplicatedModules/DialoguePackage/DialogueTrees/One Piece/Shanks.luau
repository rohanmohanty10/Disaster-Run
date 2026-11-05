  

 

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
        return `step_{u2:GetCurrentStep("Straw Hat\'s Destiny"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Unless you got no business with me, what can I do for you?",
            Options = {
                {
                    Response = "What\'s in that chest you got next to you?",
                    Next = {
                        Mutable = true,
                        Text = "Not that it\'s much of your concern honestly, but I\'ll say it has something that has the capability to provide you some form of power.",
                        Options = {
                            {
                                Response = "What kinds of power does it provide?",
                                Next = {
                                    Mutable = true,
                                    Text = "The power comes from a Devil Fruit. More specifically, from the <Color=Lilac><AnimateStyle=Wiggle><AnimateStepFrequency=1><AnimateStyleTime=2>Gomu Gomu No Mi<AnimateStyle=/><AnimateStepFrequency=/><AnimateStyleTime=/><Color=/><TextScale=/> Devil Fruit.",
                                    Options = {
                                        {
                                            Response = "I see. Is there anyway I can get it from you?",
                                            Next = {
                                                Mutable = true,
                                                Text = "No you can not just take the fruit. If you eat this fruit, you may gain powers but you lose your ability to swim. Also, I do not believe you are trustworthy of this fruit.",
                                                Options = {
                                                    {
                                                        Response = "Come on! There\'s gotta be a way that you give me that fruit.",
                                                        Next = {
                                                            Mutable = true,
                                                            Text = "Persistent aren\'t you? I\'ll tell you what. I\'m here in Orange Town mostly because someone I used to be friends and crewmates with, Buggy, currently stations his crew here. He has built a lot of resentment towards me for a while now. Tell you what, help me by taking out 20 of his pirates around here and we cut a deal you hear me?",
                                                            Options = {
                                                                {
                                                                    Response = "Yeah sure! I\'ll be back in no time trust me.",
                                                                    Next = {
                                                                        Text = "Don\'t worry, I don\'t have anywhere to be right now.",
                                                                        Options = {}
                                                                    },

                                                                    Callback = function() -- Line: 51, Name: Callback
                                                                        -- upvalues: u1 (copy)
                                                                        u1:CheckDialogue("Straw Hat\'s Destiny"):expect();
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
                    }
                }
            }
        },
        step_2 = {
            Text = "Have you defeated the 20 pirates that I asked you to.",
            Options = { {
                    Response = "Yes",
                    Next = {
                        Text = "I still see a lot around here. Maybe you\'re not so serious after all. Come back to me when you\'ve ACTUALLY done what I asked you to do.",
                        Options = {}
                    }
                } }
        },
        step_3 = {
            Mutable = true,
            Text = "Have you defeated the 20 pirates that I asked you to.",
            Options = {
                {
                    Response = "Yes",
                    Next = {
                        Text = "Great, great. However, you have seem to have aggravated Buggy. I heard him yelling at his men to scatter around and find out who\'s shortening his crew size. I\'ll tell you what, I was going to have you do more but if you can defeat Buggy, I see you fit of acquiring this fruit. Return back to me once you have done that.",
                        Options = {
                            {
                                Response = "Alright.",

                                Callback = function() -- Line: 94, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Straw Hat\'s Destiny"):expect();
                                end
                            }
                        }
                    }
                }
            }
        },
        step_4 = {
            Text = "Have you defeated Buggy.",
            Options = {
                {
                    Response = "Yes",

                    Next = function() -- Line: 109, Name: Next
                        -- upvalues: u1 (copy)
                        return u1:CheckDialogue("Straw Hat\'s Destiny"):expect() and "step_5" or {
                            Text = "Doesn\'t seem like it. His bounty still exists meaning nobody has defeated him at all. Don\'t lie to me and come back when you actually defeat him.",
                            Options = {}
                        };
                    end
                }
            }
        },
        step_5 = {
            Mutable = true,
            Text = "Have you defeated Buggy.",
            Options = {
                {
                    Response = "Yes",

                    Next = function() -- Line: 130, Name: Next
                        -- upvalues: u1 (copy)
                        return u1:CheckDialogue("Straw Hat\'s Destiny"):expect() == "ClearSpace" and {
                            Text = "As much as I\'d be willing to give you this fruit, it seems I can\'t. Clear out a spot in your ITEMS INVENTORY so I can give it to you.",
                            Options = {}
                        } or {
                            Text = "You surprise me a lot. I sent you into that battle assuming you wouldn\'t come back. Seems you are stronger than I thought. A deals a deal, take the fruit and remember what I told you about it.",
                            Options = {}
                        };
                    end
                }
            }
        }
    }
};