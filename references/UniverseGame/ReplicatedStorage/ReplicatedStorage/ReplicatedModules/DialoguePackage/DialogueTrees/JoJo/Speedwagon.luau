  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local LocalPlayer = game.Players.LocalPlayer;

local function GetMissingMoney() -- Line: 21
    -- upvalues: LocalPlayer (copy)
    return 375000 - (LocalPlayer.Data.UCoins and LocalPlayer.Data.UCoins.Value or 0);
end;

return {
    Title = "Speedwagon",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: LocalPlayer (copy), u2 (copy)
        local Value = LocalPlayer.Data.Ability.Value;

        return Value ~= 22 and (Value ~= 13 and Value ~= 19) and "not_allowed" or `step_{u2:GetCurrentStep("Joseph\'s Informant"):expect() or 1}`;
    end,

    Nodes = {
        not_allowed = {
            Text = "Get out of here stranger, you don\'t seem like someone I\'m supposed to be meeting.",
            Options = {}
        },
        step_1 = {
            Mutable = true,
            Text = "You seem like the guy I was told to be on the lookout for.",
            Options = {
                {
                    Response = "Wait what..? Am I wanted or something?",
                    Next = {
                        Mutable = true,
                        Text = "No no no no. The Hamon Trainer told me there was a new person in town with Hamon. Described the way you look and that you know it.",
                        Options = {
                            {
                                Response = "That\'s great but, I wanna further learn my Hamon. Do you by chance know if I\'m able to learn anymore styles from anyone else?",
                                Next = {
                                    Mutable = true,
                                    Text = "Well I mean, I\'m not a Hamon user myself. I just met these guys but actually.. I know a guy. His name is Joseph.",
                                    Options = {
                                        {
                                            Response = "Joseph? Oh yeah sure how can I get to him?",
                                            Next = {
                                                Mutable = true,
                                                Text = "Well, the problem is not getting to him. It\'s you. I need you to prove it\'s worth getting to him.",
                                                Options = {
                                                    {
                                                        Response = "How do you expect for me to do that then?",
                                                        Next = {
                                                            Mutable = true,
                                                            Text = "Defeat 10 Hooligans at the port for me. Come talk to me when you\'re done."
                                                        },

                                                        Callback = function() -- Line: 63, Name: Callback
                                                            -- upvalues: u1 (copy)
                                                            u1:CheckDialogue("Joseph\'s Informant"):expect();
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
                },
                {
                    Response = "Nah, you got it all wrong.",
                    Next = {
                        Text = "You sure? You seem to look like him. Whatever, probably a waste of my time anyway."
                    }
                }
            }
        },
        step_2 = {
            Text = "Have you taken care of the Hooligans at the Port like I\'ve asked you to?",
            Options = { {
                    Response = "Yes I\'ve taken care of them.",
                    Next = {
                        Text = "Liar.. I know you haven\'t taken care of them. You don\'t even look beat up at all. Come to me when you have."
                    }
                } }
        },
        step_3 = {
            Mutable = true,
            Text = "Have you taken care of the Hooligans at the Port like I\'ve asked you to?",
            Options = {
                {
                    Response = "Yes I\'ve taken care of them.",
                    Next = {
                        Mutable = true,
                        Text = "Very well. Now I just need a payment. Consider this a payment of service. I\'ll need 375,000 UCoins.",
                        Options = {
                            {
                                Response = "Okay, I have the money here.",
                                Next = "",

                                Callback = function(p3, p4) -- Line: 110, Name: Callback
                                    -- upvalues: u1 (copy)
                                    if u1:CheckDialogue("Joseph\'s Informant"):expect() then
                                        p4.Next = "step_3_1";

                                        return;
                                    end;

                                    p4.Next = "step_3_not_enough";
                                end
                            }
                        }
                    }
                }
            }
        },
        step_3_not_enough = {
            Text = function() -- Line: 126, Name: Text
                -- upvalues: LocalPlayer (copy)
                return string.format("Is this all? I need more. You need [%s more uCoins]", 375000 - (LocalPlayer.Data.UCoins and LocalPlayer.Data.UCoins.Value or 0));
            end,

            Options = {}
        },
        step_3_1 = {
            Mutable = true,
            Text = "Very well! I\'m going to give you some time to make sure you have a free slot in your inventory before attempting to hand it over to you first.",
            Options = { {
                    Response = "Okay.",
                    Next = "step_4"
                } }
        },
        step_4 = {
            Mutable = true,
            Text = "Do you have the space to hold this letter of referral?",
            Options = {
                {
                    Response = "Yes I do.",
                    Next = "",

                    Callback = function(p5, p6) -- Line: 150, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckDialogue("Joseph\'s Informant"):expect() then
                            p6.Next = "step_4_success";

                            return;
                        end;

                        p6.Next = "step_4_fail";
                    end
                }
            }
        },
        step_4_success = {
            Text = "Very well! Take this letter and go look for Joseph. He\'ll teach you his style.",
            Options = {}
        },
        step_4_fail = {
            Text = "I need you to clear up your inventory. Please go clear your inventory first before attempting to take this letter.",
            Options = {}
        }
    }
};