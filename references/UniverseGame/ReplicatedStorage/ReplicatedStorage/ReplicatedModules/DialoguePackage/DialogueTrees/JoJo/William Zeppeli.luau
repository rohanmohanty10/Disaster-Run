  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local u3 = {
    Response = "I\'m sorry, I have to go.",
    Next = "reject"
};
local u4 = { 22, 1300, 19 };

return {
    Title = "William Zeppeli",

    Start = function() -- Line: 13, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("Jonathan\'s Informant"):expect() or 1}`;
    end,

    Nodes = {
        reject = {
            Text = "Come back soon!"
        },
        step_1 = {
            Mutable = true,
            Text = "You don\'t seem like no hamon user. Get away from here.",
            Options = { {
                    Response = "I didn\'t want to talk to you anyway!"
                } },

            Transformer = function(p5, p6) -- Line: 42, Name: Transformer
                -- upvalues: Players (copy), u4 (copy), u1 (copy), u3 (copy)
                if not table.find(u4, Players.LocalPlayer.Data.Ability.Value) then
                    return;
                end;

                p6.Text = "You seem like a fellow Hamon user. Are you a Hamon user?";
                p6.Options = {
                    {
                        Response = "Yes, I just got done training my Base Hamon. I learned it from the Hamon Trainer.",
                        Next = {
                            Text = "What brings you here to me then?",
                            Options = {
                                {
                                    Response = "I wanna further learn my Hamon. Do you by chance know if I\'m able to learn anymore styles from anyone else? Like you?",
                                    Next = {
                                        Text = "Hmmm.. I follow Base Hamon training too. I don\'t have much uniqueness in my style worth learning but... Got it. I know a guy. Name\'s Jonathan.",
                                        Options = {
                                            {
                                                Response = "Jonathan? Oh yeah sure how can I get to him?",
                                                Next = {
                                                    Text = "Well, the problem is not getting to him. It\'s you. I need you to prove it\'s worth getting to him.",
                                                    Options = {
                                                        {
                                                            Response = "How do you expect for me to do that then?",
                                                            Next = {
                                                                Text = "Defeat 10 Hooligans at the port for me. Come talk to me when you\'re done.",
                                                                Options = { {
                                                                        Response = "Thank you!"
                                                                    } }
                                                            },

                                                            Callback = function() -- Line: 76, Name: Callback
                                                                -- upvalues: u1 (ref)
                                                                u1:CheckDialogue("Jonathan\'s Informant"):expect();
                                                            end
                                                        },
                                                        u3
                                                    }
                                                }
                                            },
                                            u3
                                        }
                                    }
                                },
                                u3
                            }
                        }
                    },
                    {
                        Response = "Nah, I\'m not a fellow Hamon user.",
                        Next = {
                            Text = "You sure? You seem like one. Whatever, probably a waste of my time anyway.",
                            Options = { {
                                    Response = "Whatever floats your boat."
                                } }
                        }
                    }
                };
            end
        },
        step_2 = {
            Mutable = true,
            Text = "Have you taken care of the Hooligans at the Port like I\'ve asked you to?",
            Options = {
                {
                    Response = "Yes I\'ve taken care of them.",
                    Next = {
                        Mutable = true,
                        Text = "Very well. Now I just need a payment. Consider this a payment of service. I\'ll need 375,000 UCoins.",

                        Transformer = function(p7, p8) -- Line: 117, Name: Transformer
                            -- upvalues: u2 (copy)
                            local v9 = u2:GetCurrentStep("Jonathan\'s Informant"):expect();

                            if v9 ~= 2 then
                                if v9 == 3 then
                                    table.insert(p8.Options, 1, { {
                                            Response = "I have the money.",
                                            Next = "step_3"
                                        } });
                                end;

                                return;
                            end;

                            p8.Text = "Liar.. I know you haven\'t taken care of them. You don\'t even look beat up at all. Come to me when you have.";
                            p8.Options = { {
                                    Response = "My bad, I\'ll go do it now."
                                } };
                        end,

                        Options = { u3 }
                    }
                },
                u3
            }
        },
        step_3 = {
            Text = "Do you have the money?",
            Options = {
                {
                    Response = "Heres the money.",
                    Next = {
                        Mutable = true,
                        Text = "",

                        Transformer = function(p10, p11) -- Line: 153, Name: Transformer
                            -- upvalues: u1 (copy), Players (copy)
                            if u1:CheckDialogue("Jonathan\'s Informant"):expect() then
                                p11.Text = "Very well! I\'m going to give you some time to make sure you have a free slot in your inventory before attempting to hand it over to you first.";
                                p11.Options = { {
                                        Response = "Thank you kind sir."
                                    } };

                                return;
                            end;

                            p11.Text = `Is this all? I need more. You need [{375000 - Players.LocalPlayer.Data.UCoins.Value} more uCoins]`;
                            p11.Options = { {
                                    Response = "🥺 heyyy stawp pocket watching!"
                                } };
                        end
                    }
                },
                u3
            }
        },
        step_4 = {
            Text = "Do you have the space to hold this letter of referral?",
            Options = {
                {
                    Response = "Yes I do.",
                    Next = {
                        Mutable = true,
                        Text = "",

                        Transformer = function(p12, p13) -- Line: 187, Name: Transformer
                            -- upvalues: u1 (copy)
                            if u1:CheckDialogue("Jonathan\'s Informant"):expect() then
                                p13.Text = "Very well! Take this letter and go look for Jonathan. He\'ll teach you his style.";
                                p13.Options = { {
                                        Response = "Thank you kind sir."
                                    } };

                                return;
                            end;

                            p13.Text = "I need you to clear up your inventory. Please go clear your inventory first before attempting to take this letter.";
                            p13.Options = { {
                                    Response = "Oopsie Poopsie. 🥺"
                                } };
                        end
                    }
                },
                u3
            }
        }
    }
};