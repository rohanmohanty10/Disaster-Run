  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "The World"
    },
    Animations = {
        Idle = {
            Idle = 13014347491
        }
    },
    Stats = {
        Summon = {
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(216, 173, 0)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(90, 10, 10)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 10, 10)) })
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 10182687593,
            Volume = 2.75
        },
        DeathSound = {
            SoundId = 18419019480,
            Volume = 3
        },
        ["Summon-Voiceline"] = {
            SoundId = 18418453156,
            Volume = 3.25
        },
        ["Desummon-Voiceline"] = {
            SoundId = 18418455252,
            Volume = 3
        },
        ["Timestop End Voiceline"] = {
            SoundId = "rbxassetid://18222665027",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Voiceline"] = {
            SoundId = "rbxassetid://18418625614",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FullPower-Hit-Voice"] = {
            SoundId = "rbxassetid://18222664414",
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup-Voice"] = {
            SoundId = "rbxassetid://18222664159",
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["Impale Voiceline"] = {
            SoundId = "rbxassetid://18222665924",
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["Strong Punch Voiceline"] = {
            SoundId = "rbxassetid://18222665268",
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["Counter Voiceline"] = {
            SoundId = "rbxassetid://18418458193",
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["StopSign-Voice"] = {
            SoundId = "rbxassetid://18222667743",
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-Voiceline"] = {
            SoundId = "rbxassetid://18418457253",
            Volume = 4
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = "rbxassetid://18419019868",
            Volume = 4
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://18222666825",
            Volume = 4.25
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = "rbxassetid://18222666581",
            Volume = 3
        },
        ["Sudden Strike Voiceline"] = {
            SoundId = "rbxassetid://18222668131",
            Volume = 3
        },
        ["Sudden Strike SFX"] = {
            SoundId = 11460843027,
            Volume = 3
        },
        ["Kick Barrage Voiceline"] = {
            SoundId = "rbxassetid://18222667549",
            Volume = 4
        },
        ["Bloodsuck Voiceline"] = {
            SoundId = "rbxassetid://18222667098",
            Volume = 3
        },
        ["LMB-1"] = {
            SoundId = 18418455940,
            Volume = 3
        },
        ["LMB-2"] = {
            SoundId = 18418456312,
            Volume = 3
        },
        ["LMB-3"] = {
            SoundId = 18418451231,
            Volume = 3
        },
        ["LMB-4"] = {
            SoundId = 18418456693,
            Volume = 3
        },
        ["StandOff-LMB-1"] = {
            SoundId = 18418455940,
            Volume = 3
        },
        ["StandOff-LMB-2"] = {
            SoundId = 18418456312,
            Volume = 3
        },
        ["StandOff-LMB-3"] = {
            SoundId = 18418451231,
            Volume = 3
        },
        ["StandOff-LMB-4"] = {
            SoundId = 18418456693,
            Volume = 3
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 11499912997,
            Volume = 2
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
                    SoundId = "rbxassetid://18418452796",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I am immortal. I am everlasting. STAND POWER!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18418452115",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Now there\'s incontrovertible proof that no one on this miserable planet is stronger than ME!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18418450490",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Now bow before my wisdom and POWER!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18418451629",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You loathsome humans.. I shall rule over your pathetic species until the end of TIME!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18418454904",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*menacing laughter*"
                        } }
                },
                {
                    SoundId = "rbxassetid://18418453543",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It must be terrifying to stare death in the face and be helpless to stop it!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18418450882",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Are you telling me that\'s the best you\'ve got?"
                        } }
                },
                {
                    SoundId = "rbxassetid://18418453918",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "That\'s an impressive accomplishment.. Congratulations."
                        } }
                },
                {
                    SoundId = "rbxassetid://18418454239",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Prepare to die!"
                        } }
                },
                {
                    SoundId = "rbxassetid://18418452442",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "WHAT!?"
                        } }
                },
                {
                    SoundId = "rbxassetid://18419367240",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Here it is! My final dance with time!"
                        } }
                }
            }
        }
    }
};