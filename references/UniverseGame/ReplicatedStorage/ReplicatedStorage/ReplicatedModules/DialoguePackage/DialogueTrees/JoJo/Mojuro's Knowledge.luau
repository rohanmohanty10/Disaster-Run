  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function AbilityCheck() -- Line: 9
    -- upvalues: LocalPlayer (copy)
    local v3 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
    local v4 = LocalPlayer.Data.Ability:GetAttribute("AscensionRank");
    local v5;

    if v3 == "Kars" then
        v5 = v4 >= 5;
    else
        v5 = false;
    end;

    return v5;
end;

local v9 = {
    Text = "Lord Kars would never name one of his moves such atrocities. I do not believe you. Go on and prove yourself by beating the rats known as Hamon Users.",
    Options = {
        {
            Response = "It will be done.",

            Callback = function(p6, p7, p8) -- Line: 27, Name: Callback
                -- upvalues: u1 (copy)
                u1:CheckDialogue(script.Name):expect();
            end,

            Next = Dialogue.PLACEHOLDER
        }
    }
};

return {
    Title = "Mojuro",

    Start = function() -- Line: 15, Name: GetStart
        -- upvalues: u2 (copy), LocalPlayer (copy)
        local v10 = u2:GetCurrentStep(script.Name):expect();
        local v11 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
        local v12 = LocalPlayer.Data.Ability:GetAttribute("AscensionRank");
        local v13;

        if v11 == "Kars" then
            v13 = v12 >= 5;
        else
            v13 = false;
        end;

        return v13 and `step_{v10 or 1}` or "no_kars";
    end,

    Nodes = {
        no_kars = {
            Text = "Who do you think you are, roaming around my turf without permission? Scram, before you shall be dealt with swiftly. (MUST HAVE ASCENSION 5+ ON KARS WHILE IT IS EQUIPPED)"
        },
        step_1 = {
            Mutable = true,
            Text = "Are my eyes deceiving me? Those brilliant bone blades... there is no mistaking it. Are you... finally back, my lord?",
            Options = {
                {
                    Response = "Who do you happen to be, again?",
                    Next = {
                        Text = "Haaa? How could you forget? I was your finest minion in the Golden Age of Pillarmen! Are you really Lord Kars...?",
                        Options = {
                            {
                                Response = "Hey now, I am \"Lord Kars\", really.",
                                Next = {
                                    Text = "Lord Kars would never forget about his greatest soldier. Prove it!",
                                    Options = {
                                        {
                                            Response = "Witness my Brilliant Bone Blades!",
                                            Next = v9
                                        },
                                        {
                                            Response = "Observe my Blinding Light!",
                                            Next = v9
                                        },
                                        {
                                            Response = "Taste my Lotus Grip!",
                                            Next = v9
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
            Text = "Well, what are you waiting for? Take down Jonathan, Joseph and the Hamon Trainer to prove that you really are the Greatest Pillarman."
        },
        step_3 = {
            Mutable = true,
            Text = "Have you took care of those rats yet?",
            Options = {
                {
                    Response = "It was over in a blink.",
                    Next = {
                        Text = "Wow, you truly are as impressive as I remember! I am relieved you are finally back, Lord Kars.",
                        Options = {
                            {
                                Response = "Tell me... What are you here for?",
                                Next = {
                                    Text = "I have searched the present world for quite some time now, and... I believe I have discovered a way for your excellence to be further enhanced!",
                                    Options = {
                                        {
                                            Response = "Go on. I am listening.",
                                            Next = {
                                                Text = "The Ultimate Lifeform... a distinct yet alluring idea. A being that has conquered the sun and anything basking under it. I believe that you are more than capable of obtaining this form, Lord Kars.",
                                                Options = {
                                                    {
                                                        Response = "I am interested. How should we proceed with this?",
                                                        Next = {
                                                            Text = "I believe you should begin by showering your blades with the genes of various foes residing in the present world. Return to me when you are done, Lord Kars.",
                                                            Options = {
                                                                {
                                                                    Response = "You keep referring to by my name. I believe it is fair I do the same. What is your name?",
                                                                    Next = {
                                                                        Text = "My name is Lithos Uma Disi Mowjuhros The 3rd. You may refer to me as Mojuro, or however you please, Lord Kars.",
                                                                        Options = {
                                                                            {
                                                                                Response = "How wild.",

                                                                                Callback = function(p14, p15, p16) -- Line: 110, Name: Callback
                                                                                    -- upvalues: u1 (copy)
                                                                                    u1:CheckDialogue(script.Name):expect();
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
            }
        },
        step_4 = {
            Text = "Please pursue the knowledge that resides within the present world, Lord Kars."
        },
        step_5 = {
            Mutable = true,
            Text = "Have you obtained the valuable offerings of knowledge this world has plenty of yet, Lord Kars?",
            Options = {
                {
                    Response = "I feel enlightened already.",
                    Next = {
                        Text = "We get closer to obtaining The Ultimate Lifeform by the minute. Very well.",
                        Options = {
                            {
                                Response = "What is next?",
                                Next = {
                                    Text = "The next step for our goal requires the unique and strong genes of various formidable foes residing in the present world. Although, it wont be a breeze like the last objective.",
                                    Options = {
                                        {
                                            Response = "And why is that?",
                                            Next = {
                                                Text = "We require a newfound breakthrough in science to complete our objective. It is called the \"Lifeblood Extractor\", crafted by none other than the experienced scientists inside The Khronos Lab. You must break inside and acquire this device by any means necessary, Lord Kars.",
                                                Options = {
                                                    {
                                                        Response = "It will be a walk in the park.",
                                                        Next = {
                                                            Text = "Once you have succesfully obtained the Lifeblood Extractor, you must slay these formidable foes I mentioned earlier and harvest their genes.",
                                                            Options = {
                                                                {
                                                                    Response = "Understood.",

                                                                    Callback = function(p17, p18, p19) -- Line: 160, Name: Callback
                                                                        -- upvalues: u1 (copy)
                                                                        u1:CheckDialogue(script.Name):expect();
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
        step_6 = {
            Text = "Please proceed with crafting the \"Lifeblood Extractor\" at The Khronos Labs and extract the genes of the formidable foes I have told you about, Lord Kars."
        },
        step_7 = {
            Mutable = true,
            Text = "Have you extracted the unique and strong genes residing within formidable foes, Lord Kars?",
            Options = {
                {
                    Response = "I have done as you asked.",
                    Next = {
                        Text = "These genes are really valuable for our cause. Great work, Lord Kars. Our next step would be to gather an ample supply of otherworldly blood to store the genes we have gathered for future use.",
                        Options = {
                            {
                                Response = "Where should I obtain the blood?",
                                Next = {
                                    Text = "Proceed to the Joestar Mansion. You must slay a sufficent amount of zombies and bring their blood back to me for the storation process.",
                                    Options = {
                                        {
                                            Response = "Right on it.",
                                            Next = {
                                                Text = "And one more thing, Lord Kars. We must forge the most beugiful jewel of them all, The Aja Stone. We must hone and perfect it to allow the absorption of powerful UV lights originating from the sun. Please gather multiple of these stones for the honing process.",
                                                Options = {
                                                    {
                                                        Response = "It will be done.",

                                                        Callback = function(p20, p21, p22) -- Line: 202, Name: Callback
                                                            -- upvalues: u1 (copy)
                                                            u1:CheckDialogue(script.Name):expect();
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
        step_8 = {
            Text = "Please proceed with the obtainment of otherworldly blood and the stones of Aja, Lord Kars."
        },
        step_9 = {
            Mutable = true,
            Text = "Have you obtained the supplies I need for the two processes I told you about, Lord Kars?",
            Options = {
                {
                    Response = "They are right here.",
                    Next = {
                        Text = "Excellent work, Lord Kars. Now remains one more thing before we witness the birth of The Ultimate Lifeform.",
                        Options = {
                            {
                                Response = "What is next?",
                                Next = {
                                    Text = "Our final objective is to forge a masterwork Stone Mask, one transcending all the others. We must make use of an \"Ancient Alloy\" scientists at The Khronos Lab have uncovered. A break-in is once again necessary for our cause.",
                                    Options = {
                                        {
                                            Response = "I will take care of it swiftly.",

                                            Callback = function(p23, p24, p25) -- Line: 236, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue(script.Name):expect();
                                            end,

                                            Next = {
                                                Text = "This will be the last step necessary before we have all the needed items. The world shall embrace true strength once you transcend to be The Ultimate Lifeform, Lord Kars. Please proceed by crafting the Perfected Stone Mask once you are done."
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
        step_10 = {
            Text = "Please proceed with obtaining \"Ancient Alloy\" from The Khronos Labs and combining a True Stone Mask with it at the Master Crafter for a Perfected Stone Mask, Lord Kars.",

            Transformer = function(p26, p27, p28) -- Line: 253, Name: Transformer
                -- upvalues: u1 (copy)
                u1:CheckDialogue(script.Name):expect();
            end
        },
        step_11 = {
            Mutable = true,
            Text = "Are you done with the forging process of the new vessel for the Perfected Aja Stone, Lord Kars?",
            Options = {
                {
                    Response = "It is right here.",
                    Next = {
                        Text = "Perfect... PERFECT! We finally have everything needed! Now remains one last thing that only the Master Crafter may accomplish.",
                        Options = {
                            {
                                Response = "What else is necessary??",
                                Next = {
                                    Text = "You must proceed with the combining process for the brand new vessel of the Perfected Aja Stone, Lord Kars. Combine the Perfected Aja Stone and Perfected Stone Mask for the Perfected Aja Mask. You must supply the mask with ample blood, too, so combine the Lifeblood Extractor and Blood Concoction for the Unbound Blood Vial. And...",
                                    Options = {
                                        {
                                            Response = "And?",
                                            Next = {
                                                Text = "And... combine the Perfected Aja Mask and Unbound Blood Vial to finally get your hands on the Ultimate Stone Mask, put it on, and embrace the finest form of creation, witnessing the fruit of your efforts! Our journey ends here, Lord Kars. I am glad to have been able to serve you.",
                                                Options = {
                                                    {
                                                        Response = "Thank you, Mojuro",

                                                        Callback = function(p29, p30, p31) -- Line: 278, Name: Callback
                                                            -- upvalues: u1 (copy)
                                                            u1:CheckDialogue(script.Name):expect();
                                                        end,

                                                        Next = {
                                                            Text = "In another life, I would serve you again... Lord Kars, it has been a pleasure."
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
        step_12 = {
            Text = "...",

            Transformer = function(p32, p33) -- Line: 297, Name: Transformer
                -- upvalues: u1 (copy)
                u1:CheckDialogue(script.Name):expect();
            end
        }
    }
};