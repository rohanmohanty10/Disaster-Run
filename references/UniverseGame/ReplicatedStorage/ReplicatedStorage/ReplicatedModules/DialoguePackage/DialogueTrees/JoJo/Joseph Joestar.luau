  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local LocalPlayer = game.Players.LocalPlayer;

return {
    Title = "Joseph Joestar",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: LocalPlayer (copy), u2 (copy)
        return LocalPlayer.Data.Ability.Value ~= 22 and "not_allowed" or `step_{u2:GetCurrentStep("Learning Joseph\'s Style"):expect() or 1}`;
    end,

    Nodes = {
        not_allowed = {
            Text = "I can just tell by looking at you you\'re not supposed to be talking with me. Get out of here.",
            Options = {}
        },
        step_1 = {
            Mutable = true,
            Text = "Hey stranger, you\'re gonna tell me you\'re a Hamon user, right?",
            Options = {
                {
                    Response = "I was referred here by a guy called Speedwagon.",
                    Next = {
                        Mutable = true,
                        Text = "Oh, now were you? He gives an item you\'re supposed to give to me if so. Do you have it?",
                        Options = {
                            {
                                Response = "Yes, I have it right here.",
                                Next = {
                                    Mutable = true,

                                    Callback = function() -- Line: 45, Name: Callback
                                        -- upvalues: u1 (copy)
                                        return u1:CheckDialogue("Learning Joseph\'s Style"):expect() and {
                                            Text = "Very well. I need your help then. I need to make sure you\'re willing to be committed to this. On my way back from a diner, I encountered some hooligans at the port. It was about 15 of them. Defeat 15 of them then return to me once you have."
                                        } or {
                                            Text = "No, you do not. I do not see it in your inventory. Come back to me when you have it. Talk to a man named Speedwagon."
                                        };
                                    end
                                }
                            }
                        }
                    }
                },
                {
                    Response = "Sorry, didn\'t mean to strike up a conversation.",
                    Next = {
                        Text = "Who just goes up to someone random to talk to them just to walk away? Ok then."
                    }
                }
            }
        },
        step_2 = {
            Text = "Did you take care of those hooligans like I asked you to?",
            Options = { {
                    Response = "Yes, I took care of the hooligans like you asked me to.",
                    Next = {
                        Text = "Have you? I don\'t think so. Last time I went back to check, seems like a couple were left. Come back to me once you\'re serious about taking them all out."
                    }
                } }
        },
        step_3 = {
            Mutable = true,
            Text = "Did you take care of those hooligans like I asked you to?",
            Options = {
                {
                    Response = "Yes, I took care of the hooligans like you asked me to.",
                    Next = {
                        Mutable = true,
                        Text = "Sweet!!! Ok, I need some help. I\'m battling these weird pillar dudes. They\'ve been there for many years and they seem to be awakened. Bring me some clackers, would ya? They\'re usually spawned around the map.",
                        Options = {
                            {
                                Response = "Just some clackers? Alright then.",
                                Next = {
                                    Mutable = true,

                                    Callback = function() -- Line: 97, Name: Callback
                                        -- upvalues: u1 (copy)
                                        u1:CheckDialogue("Learning Joseph\'s Style"):expect();

                                        return {
                                            Text = "Yep. And don\'t return until you\'ve found them. I\'ll be watching you."
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
            Text = "Did ya get me those clackers I asked from you?",
            Options = {
                {
                    Response = "Yes, I got them right here.",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 119, Name: Callback
                            -- upvalues: u1 (copy)
                            return u1:CheckDialogue("Learning Joseph\'s Style"):expect() and {
                                Text = "Sweet! I need this weird Aja stone thing. I think you can also find it somewhere around here. It spawns around here. Bring that to me too, yeah?"
                            } or {
                                Text = "Wow. What a liar you are, aren\'t you? Bring me those clackers. I seriously need them. Otherwise, don\'t bother returning to me."
                            };
                        end
                    }
                }
            }
        },
        step_5 = {
            Mutable = true,
            Text = "Where\'s the Aja Stone? Do you have it on you?",
            Options = {
                {
                    Response = "Yes, I have the Aja stone right here.",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 144, Name: Callback
                            -- upvalues: u1 (copy)
                            return u1:CheckDialogue("Learning Joseph\'s Style"):expect() and {
                                Text = "Sweet, this is all I\'ll need your help with.. Thanks, I\'ll keep in touch! \nHINT: TO CONTINUE, TALK TO JOSEPH WHEN YOU FIND CAESAR\'S HEADBAND."
                            } or {
                                Text = "Lying to me? I thought you were noble? Bring me that AJA STONE next time you talk to me."
                            };
                        end
                    }
                }
            }
        },
        step_6 = {
            Mutable = true,
            Text = "What\'s up, buddy? I said I\'d be in touch when I needed your help.",
            Options = {
                {
                    Response = "I found this weird headband lying around the area.",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 169, Name: Callback
                            -- upvalues: u1 (copy)
                            local v3 = u1:CheckDialogue("Learning Joseph\'s Style"):expect();

                            return v3 and (v3 == "ClearSpace" and {
                                Text = "CLEAR AN INVENTORY ITEM SLOT FIRST, THEN SPEAK TO JOSEPH AGAIN."
                            } or {
                                Text = "....This is... Caesar\'s headband... WHERE DID YOU FIND IT? YOU KILLED HIM, DIDN\'T YA? ALRIGHT THEN. I SEE HOW IT IS. TAKE THIS SIGNAL AND FIGHT ME. I\'LL MAKE YOU PAY FOR WHAT YOU DID TO CAESAR."
                            }) or {
                                Text = "??? What headband? You\'re not showing me anything? Look, just come back when I ask you to come back."
                            };
                        end
                    }
                }
            }
        },
        step_7 = {
            Mutable = true,
            Text = "...",
            Options = {
                {
                    Response = "...",
                    Next = {
                        Mutable = true,

                        Callback = function() -- Line: 200, Name: Callback
                            -- upvalues: u1 (copy)
                            local v4 = u1:CheckDialogue("Learning Joseph\'s Style"):expect();

                            return v4 and (v4 == "ClearSpace" and {
                                Text = "CLEAR AN ABILITY SLOT FIRST, THEN SPEAK TO JOSEPH AGAIN."
                            } or {
                                Text = "So... You didn\'t kill Caesar. That\'s my fault... I\'ll have to make it up to you... I\'ll give you my style techniques here... Take it..."
                            }) or {
                                Text = "YOU HAVEN\'T FOUGHT ME YET? IF YOU LOST YOUR SIGNAL, I\'LL REPLACE IT. OTHERWISE, FIGHT ME FIRST THEN RETURN BACK."
                            };
                        end
                    }
                }
            }
        }
    }
};