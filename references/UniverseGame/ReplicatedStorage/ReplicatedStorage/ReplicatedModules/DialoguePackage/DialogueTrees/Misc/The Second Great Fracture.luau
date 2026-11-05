  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

return {
    Title = "DELTA Cult",
    StarterTitle = "DELTA Cult",
    StarterText = "The day of the ‘Second Fracture’ is upon us! We must band together to find the one who can stop it all!",

    Start = function() -- Line: 6, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep(script.Name):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Title = "DELTA Cult",
            Text = "The day of the ‘Second Fracture’ is upon us! We must band together to find the one who can stop it all!",
            Options = {
                {
                    Response = "Sounds interesting. I want in.",
                    Next = {
                        Text = "Is that so? Meet one of our Captains around the spray painting mural.. It’s too dangerous for them to be out here with us..",
                        Options = {
                            {
                                Response = "Will do.",

                                Callback = function() -- Line: 29, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();

                                    return nil;
                                end
                            },
                            {
                                Response = "Uhh.. on second thought, this sounds insane.",

                                Callback = function(p3) -- Line: 36, Name: Callback
                                    p3:Destroy();

                                    return nil;
                                end
                            }
                        }
                    }
                },
                {
                    Response = "You people sound crazy.",

                    Callback = function(p4) -- Line: 46, Name: Callback
                        p4:Destroy();

                        return nil;
                    end
                },
                {
                    Response = "I\'m one of the new recruits.",
                    Next = {
                        Title = "DELTA Captain",
                        Text = "I assume the other members already told you of what we’re doing here, correct?",
                        Options = {
                            {
                                Response = "No..",
                                Next = {
                                    Text = "They haven’t?.. I guess I’ll have to give you the rundown for now, we’re looking towards finding the ‘Shaper’ and the ‘Delta’.. They’ll preserve us in the upcoming ‘Second Fracture’.",
                                    Options = {
                                        {
                                            Response = ". . .",
                                            Next = {
                                                Text = "Oh yeah.. I’m supposed to give you this too. He hands you a transmitter. Look towards finding each and every piece of the ‘Key’.",
                                                Options = {
                                                    {
                                                        Response = ". . .",
                                                        Next = {
                                                            Text = "Don’t think you\'re special. This is standard procedure for every new recruit. Take this too, it\'s an introductory gift. He hands you Tome 1 of PLANET//SHAPER.",
                                                            Options = {
                                                                {
                                                                    Response = "Got it",

                                                                    Callback = function() -- Line: 74, Name: Callback
                                                                        -- upvalues: u1 (copy)
                                                                        u1:CheckDialogue(script.Name):expect();

                                                                        return nil;
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
            Title = "DELTA Captain",
            Text = "Hello, can I help you?",
            Options = { {
                    Response = "Yes.",
                    Next = {
                        Text = "Haha, very funny. Now go find the shards please.",
                        Options = { {
                                Response = "Alright... Sorry.",
                                Next = {
                                    Text = "It’s whatever. Everybody else gets stuck on this part anyways."
                                }
                            } }
                    }
                } }
        },
        step_3 = {
            Title = "DELTA Captain",
            Text = "Back already? Have you gathered the shards yet?",
            Options = {}
        },
        step_4 = {
            Title = "DELTA Captain",
            Text = "Oh, I remember you. Back already? Have you gathered the shards yet?",
            Options = {
                {
                    Response = "Yes. (You hand him the shards).",
                    Next = {
                        Text = "Really? No recruit has gotten this far before.. Here it is. He reassembles the key. The key should be drawn to the chest. Look out for anything telling you about its presence.",
                        Options = {
                            {
                                Response = "I see.. Thank you.",

                                Callback = function() -- Line: 132, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();

                                    return nil;
                                end
                            }
                        }
                    }
                }
            }
        },
        step_5 = {
            Title = "DELTA Captain",
            Text = "Be sure to open up the astral chest and beat the flight minigame to progress",
            Options = {
                {
                    Response = "I need the key again",

                    Callback = function() -- Line: 149, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:CheckDialogue(script.Name):expect();

                        return nil;
                    end
                }
            }
        },
        step_6 = {
            Title = "...",
            Text = "Its aura mesmerizes you, leaving you in a trance. It begs for you to speak your mind.",
            Options = {
                {
                    Response = "I’ve seen it all. I wish to become a servant of the ‘Delta’.",
                    Next = {
                        Text = "The figure groans, raising itself above you.",
                        Options = {
                            {
                                Response = "I willingly give myself to the ‘Delta’.. I wish to undo the mess you have created by taking the place of the ‘Shaper’.",
                                Next = {
                                    Text = "A weight feels as if it\'s been draped over your shoulders. Your heart stops for a brief moment.",
                                    Options = {
                                        {
                                            Response = ". . .",

                                            Callback = function() -- Line: 173, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue(script.Name):expect();

                                                return nil;
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
};