  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(Knit.Util.Trove);

return {
    Inherit = {
        AbilityName = "Anshen"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 18, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    v2.PoseMusic = "PoseMusic" .. math.random(1, 4);

                    return v2;
                end
            }
        }
    },
    Sounds = {
        ["LMB-1-Voiceline"] = {
            SoundId = 73776228914890,
            Volume = 2.5
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 98256352006996,
            Volume = 2.5
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 132425154876908,
            Volume = 2.5
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 114087497490802,
            Volume = 2.5
        },
        MeterUp1 = {
            SoundId = 78878847825413,
            Volume = 0
        },
        MeterUp2 = {
            SoundId = 78878847825413,
            Volume = 2.5
        },
        MeterUp3 = {
            SoundId = 78878847825413,
            Volume = 0
        },
        MeterUp4 = {
            SoundId = 114157072073246,
            Volume = 2.5
        },
        ["Cataclysm Smash Voiceline"] = {
            SoundId = 73802691827087,
            Volume = 2.5
        },
        ["Consecutive Slashes Voiceline"] = {
            SoundId = 99086675710037,
            Volume = 2.5
        },
        ["Energy Burst Voiceline"] = {
            SoundId = 129949825612913,
            Volume = 2.5
        },
        ["Energy Charge Voiceline"] = {
            SoundId = 77979807259671,
            Volume = 2.5
        },
        ["Energy Charge Music"] = {
            SoundId = 113039728997094,
            Volume = 1.75
        },
        ["Extended Slam Voiceline"] = {
            SoundId = 74334002561307,
            Volume = 2.5
        },
        ["Fierce Combo Voiceline"] = {
            SoundId = 102356608241152,
            Volume = 2.5
        },
        ["Flight Startup Voiceline"] = {
            SoundId = 108946472136746,
            Volume = 2.5
        },
        ["Flight End Voiceline"] = {
            SoundId = 98242255452546,
            Volume = 2.5
        },
        ["Horn Bash Startup Voiceline"] = {
            SoundId = 119828507954694,
            Volume = 2.5
        },
        ["Horn Bash Voiceline"] = {
            SoundId = 118997394512554,
            Volume = 2.5
        },
        ["Lance Extension Voiceline"] = {
            SoundId = 111113246012065,
            Volume = 2.5
        },
        ["Lance Extension Startup Voiceline"] = {
            SoundId = 105906496308087,
            Volume = 2.5
        },
        ["Justice Voiceline"] = {
            SoundId = 88716214378481,
            Volume = 2.5
        },
        ["Justice Finisher Voiceline"] = {
            SoundId = 98619870541040,
            Volume = 2.5
        },
        ["Justice Finisher Music"] = {
            SoundId = 131728446707238,
            Volume = 1.75
        },
        PoseMusic1 = {
            SoundId = 109249043689401,
            Volume = 2.5,
            Looped = true
        },
        PoseMusic2 = {
            SoundId = 128542382977759,
            Volume = 2.5,
            Looped = true
        },
        PoseMusic3 = {
            SoundId = 90712705842613,
            Volume = 2.5,
            Looped = true
        },
        PoseMusic4 = {
            SoundId = 133820079311608,
            Volume = 2.5,
            Looped = true
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                {
                    SoundId = "rbxassetid://81947961959151",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Call on my name in times of danger from kings, thieves, fire, water, Rakshasas, Chakkini demons, or poison. The \"Three-Eyed and Five-Enlightened Immortal\" -- \"Xiao\" -- has responded to your summons."
                        } }
                },
                {
                    SoundId = "rbxassetid://112571198033831",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hmph, I remembered something unpleasant."
                        } }
                },
                {
                    SoundId = "rbxassetid://128184970972771",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m not human, I don\'t really understand human emotions."
                        } }
                },
                {
                    SoundId = "rbxassetid://128972229715692",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Over the past thousand years, I have hunted tens of thousands of souls. If you don\'t want to get into trouble, stay away from me. Treat me like a tool."
                        } }
                },
                {
                    SoundId = "rbxassetid://122827072312992",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "\"Those\" voices... I often hear them in my ears. Roaring, crying... screaming to be killed...This is my choice, and my punishment. It has nothing to do with you."
                        } }
                },
                {
                    SoundId = "rbxassetid://127012102986459",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I have no interest in human food because the cooking process is complicated and the waiting time is long. However, I can eat almond tofu."
                        } }
                },
                {
                    SoundId = "rbxassetid://139789276909300",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Starburst Stream"
                        } }
                }
            }
        }
    }
};