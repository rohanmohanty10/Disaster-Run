  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Title = "Debt Collector",

    Start = function() -- Line: 13, Name: GetStart
        -- upvalues: u2 (copy)
        return "stepA_" .. (u2:GetCurrentStep("My Beloved"):expect() or 1);
    end,

    Nodes = {
        not_allowed = {
            Text = "Who are you? I have no business with you.",
            Options = nil
        },
        stepA_1 = {
            Mutable = true,
            Text = "Back away from me. I don\'t even know you and you attempt to approach me.",
            Options = {
                {
                    Response = "Oh, sorry. I know you\'re a debt collector. I was wondering if you have any jobs you have available. I really could use the money.",
                    Next = {
                        Text = "Kid, I don\'t handout. Like I said, back away and we have no problems.",
                        Options = {
                            {
                                Response = "I\'ll do anything. I just need that reward please.",
                                Next = {
                                    Text = "You know, I can care less about your sorry self but if it means you get away from me, take care of some things for me. They owe me money and haven\'t paid up yet.",
                                    Options = {
                                        {
                                            Response = "All this? Okay, you better reward me good.",

                                            Callback = function(p3, p4, p5) -- Line: 44, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue("My Beloved"):expect();
                                                p4.Next = {
                                                    Text = "Would also be great if you didn\'t come back. Unless you collect those debts.",
                                                    Next = nil
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
                    }
                }
            }
        },
        stepA_2 = {
            Mutable = true,
            Text = "Why are you back? I said you either come back when you\'ve taken care of what I asked you to or never.",
            Options = nil
        },
        stepA_3 = {
            Mutable = true,
            Text = "Atta\' boy. Say, you\'re not so bad. If you want to join me for a much more steady salary, I need a measly 500,000. How does that sound to you?",
            Options = {
                {
                    Response = "I\'m all in! Anything for the money.",

                    Callback = function(p6, p7, p8) -- Line: 78, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("My Beloved"):expect() then
                            p7.Next = {
                                Text = "Heh. What a fool you are. You thought I\'d let you in like that? You\'ll need to be ridden of now.",
                                Options = {
                                    {
                                        Response = "(INITIATE BOSS FIGHT)",

                                        Callback = function(p9, p10) -- Line: 87, Name: Callback
                                            -- upvalues: u1 (ref)
                                            u1:CheckDialogue("My Beloved"):expect();
                                            p10.Next = nil;
                                        end
                                    },
                                    {
                                        Response = "Oh okay, I mean I guess.",
                                        Next = nil
                                    }
                                }
                            };

                            return;
                        end;

                        p7.Next = {
                            Text = "So... Where\'s the money? Kid if you knew who I was, you\'d know I don\'t play. If you got the cash, come back. If not then don\'t even consider stepping near me.",
                            Options = nil
                        };
                    end
                },
                {
                    Response = "500k? That\'s quite outrageous. I\'ll pass.",
                    Next = nil
                }
            }
        },
        stepA_4 = {
            Mutable = true,
            Text = "Heh. You\'re back again for more? Don\'t matter, I\'ll just do it again.",
            Options = {
                {
                    Response = "(INITIATE BOSS FIGHT)",

                    Callback = function(p11, p12) -- Line: 120, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("My Beloved"):expect();
                        p12.Next = nil;
                    end
                },
                {
                    Response = "Oh okay, I mean I guess.",
                    Next = nil
                }
            }
        }
    }
};