  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Title = "Doflamingo, The Joker",

    Start = function() -- Line: 9, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("Doflamingo\'s Daring Trial"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Hey. I would say you got the potential. Do you have what it takes to take on the duty of The Surgeon of Death, though?",
            Options = {
                {
                    Response = "Yes.",
                    Next = {
                        Text = "Then I have good news, as I possess the coveted Ope Ope Devil Fruit. If you can prove your worth, I may deem you ready to wield its mythical powers. You will need to go through a tough training, endure numerous dangers, face mighty warriors, and do me a few favors. That sit well with you?",
                        Options = {
                            {
                                Response = "I am ready.",

                                Callback = function(p3, p4) -- Line: 29, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("Doflamingo\'s Daring Trial"):expect();
                                    p4.Next = {
                                        Text = "Glad to hear that. The first step is learning to yield Kikoku. Do you have what it takes to wield the cursed sword? We shall see. Return back to me when you are done."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                },
                {
                    Response = "OK I FEEL THREATENED IM LEAVING",
                    Next = {
                        Text = "Scram fool."
                    }
                }
            }
        },
        step_2 = {
            Mutable = true,
            Text = "Have you surprassed your swordsmanship potential yet?",
            Options = { {
                    Response = "Not yet.",
                    Next = {
                        Text = "Then what are you idling here for? Go."
                    }
                } }
        },
        step_3 = {
            Mutable = true,
            Text = "The Worst Generation is the World Government\'s priority. Are you worthy of being a part of it?",
            Options = {
                {
                    Response = "I am",

                    Callback = function(p5, p6) -- Line: 66, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Doflamingo\'s Daring Trial"):expect();
                        p6.Next = {
                            Text = "I like your energy. Return back to me when you are done."
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                {
                    Response = "Not yet.",
                    Next = {
                        Text = "Then what are you idling here for? Go."
                    }
                }
            }
        },
        step_4 = {
            Mutable = true,
            Text = "Are you worthy of possesing the title of \'The Worst Generation\' yet?",
            Options = { {
                    Response = "Not yet.",
                    Next = {
                        Text = "Then what are you idling here for? Go."
                    }
                } }
        },
        step_5 = {
            Mutable = true,
            Text = "I will now need you to gather me some materials that will prove helpful in my ruling of Dressrosa and SLIME research.",
            Options = {
                {
                    Response = "I shall do so.",

                    Callback = function(p7, p8) -- Line: 100, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue("Doflamingo\'s Daring Trial"):expect();
                        p8.Next = {
                            Text = "Those resources won\'t collect themselves."
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        },
        step_6 = {
            Mutable = true,
            Text = "Have you brought the materials I requested?",
            Options = { {
                    Response = "I have.",
                    Next = {
                        Text = "Liar, get back to training."
                    }
                } }
        },
        step_7 = {
            Mutable = true,
            Text = "Did I stutter? Return back to me when you have brought the 2.5 Million uCoins and Law\'s Cap.",
            Options = {
                {
                    Response = "I have the goods right here.",

                    Callback = function(p9, p10) -- Line: 128, Name: Callback
                        -- upvalues: u1 (copy)
                        local v11 = u1:CheckDialogue("Doflamingo\'s Daring Trial"):expect();

                        if v11 == true then
                            p10.Next = {
                                Text = "You have earned this. Take this coveted Ope Ope No Mi Devil Fruit and make good use of it. I believe in you."
                            };

                            return;
                        end;

                        if typeof(v11) == "number" then
                            p10.Next = {
                                Text = string.format("Liar, get back to work. You still need [%s more uCoins]", v11)
                            };

                            return;
                        end;

                        p10.Next = {
                            Text = "Liar, you still need to bring me Law\'s Cap."
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                {
                    Response = "I will not forget this.",
                    Next = {
                        Text = "Sounds good to me."
                    }
                }
            }
        }
    }
};