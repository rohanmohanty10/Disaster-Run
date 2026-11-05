  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local _ = game.Players.LocalPlayer;

return {
    Title = "Dio Brando",
    StarterText = "If you have no reason to be speaking with me, I\'d suggest you walk away.",

    Start = function() -- Line: 10, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("Road To Immortality"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "If you have no reason to be speaking with me, I\'d suggest you walk away.",
            Options = {
                {
                    Response = "Well, I was just curious to who you were but alright..",
                    Next = {
                        Mutable = true,
                        Text = "Interested in someone like me? We don\'t even know each other..?",
                        Options = {
                            {
                                Response = "Well.. Random dude standing around here like nothing is going on.. Say, you look a bit pale. You a Vampire?",
                                Next = {
                                    Mutable = true,
                                    Text = "People like you who have lucky guesses really gets on my nerves.. Sure, I\'m a Vampire. What\'s it to you?",
                                    Options = {
                                        {
                                            Response = "Sweet, I\'m a little interested in learning the ways of how I can obtain powers like you.",
                                            Next = {
                                                Mutable = true,
                                                Text = "Kid, even I struggled to accept it at first. I don\'t do teaching. However... you\'d make a good henchma- actually. Let\'s do it. You need to prove it to me first that you\'re capable of these things.",
                                                Options = {
                                                    {
                                                        Response = "Great! What shall I do then?",
                                                        Next = {
                                                            Mutable = true,
                                                            Text = "Find me my vampire mask. It should look very distinctive and you can not miss it. Has a rock/concrete texture on it.",
                                                            Options = {
                                                                {
                                                                    Response = "Is that all?",
                                                                    Next = {
                                                                        Mutable = true,
                                                                        Text = "......",
                                                                        Options = {
                                                                            {
                                                                                Response = "I\'m guessing that\'s a ye-",
                                                                                Next = {
                                                                                    Mutable = true,

                                                                                    Callback = function() -- Line: 59, Name: Callback
                                                                                        -- upvalues: u1 (copy)
                                                                                        u1:CheckDialogue("Road To Immortality"):expect();

                                                                                        return {
                                                                                            Text = "MORON!! GET TO IT BEFORE I CHANGE MY MIND."
                                                                                        };
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
                        }
                    }
                },
                {
                    Response = "Damn alright.. Sorry for the bother then.",
                    Next = {
                        Text = "Scram."
                    }
                }
            }
        },
        step_2 = {
            Mutable = true,
            Text = "Did you find the mask I asked you to find?",
            Options = {
                {
                    Response = "Yeah, I\'ve found the mask you described.",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 99, Name: Callback
                            -- upvalues: u1 (copy)
                            local v3 = u1:CheckRequirement("ItemCountCheck", "ITEM_73"):expect();

                            if typeof(v3) ~= "number" or v3 <= 0 then
                                return {
                                    Text = "You aren\'t lying to me are you? Oh? You don\'t have it? Well I guess you wouldn\'t mind if I just took your blood right? Find me it for real and don\'t come back till you do."
                                };
                            end;

                            u1:CheckDialogue("Road To Immortality"):expect();

                            return {
                                Text = "You\'re more persistent than I thought. Well. Great job then. Next I need you to uhhh... Locate some blood. I had a guy scavenge some vials of blood that I had forced him to collect from people, but let\'s say he never returned and they\'ve been scattered somewhere around the area since. If you can find one, bring it to me and we can continue.",
                                Options = { {
                                        Response = "Okay.. got it.",
                                        Next = {
                                            Text = "Don\'t come back until you have found this vial of blood for me."
                                        }
                                    } }
                            };
                        end
                    }
                }
            }
        },
        step_3 = {
            Mutable = true,
            Text = "Do you have the vial of blood that I asked you to get?",
            Options = {
                {
                    Response = "Yeah, I have it right here.",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 133, Name: Callback
                            -- upvalues: u1 (copy)
                            local v4 = u1:CheckRequirement("ItemCountCheck", "ITEM_74"):expect();

                            return typeof(v4) == "number" and v4 > 0 and {
                                Text = "Fantastic. We\'re almost there. Now, you will need to pour this blood ontop of the mask again and put it on immediately.",
                                Options = {
                                    {
                                        Response = "Okay, so I just pour the blood on the mask right?",
                                        Next = {
                                            Mutable = true,

                                            Callback = function() -- Line: 143, Name: Callback
                                                -- upvalues: u1 (ref)
                                                return u1:CheckDialogue("Road To Immortality"):expect() == "ClearSpace" and {
                                                    Text = "CLEAR AN INVENTORY ITEM SLOT FIRST, THEN SPEAK TO DIO BRANDO AGAIN."
                                                } or {
                                                    Text = "Yes. Equip the Blood & Vial mask item and left click. You will be able to obtain the item from there on."
                                                };
                                            end
                                        }
                                    }
                                }
                            } or {
                                Text = "Hmmm... LIAR! I can smell blood stronger than anyone else around here can. I knew if there blood around here, EVEN IF IT\'S SEALED. Come back to me when you\'ve really found it."
                            };
                        end
                    }
                }
            }
        },
        step_4 = {
            Text = "Are you ready to pour the blood on the mask? There\'s no going back. \nMAKE SURE YOU HAVE DO NOT HAVE AN ABILITY EQUIPPED THAT YOU WANT.",
            Options = {}
        }
    }
};