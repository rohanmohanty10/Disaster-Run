  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "The World",
        SkinName = "Greatest High"
    },
    Metadata = {
        CopyQuotes = false
    },
    Stats = {
        Summon = {
            CustomAura = {
                Properties = {
                    Color = ColorSequence.new(Color3.fromRGB(170, 0, 255))
                }
            }
        }
    },
    Sounds = {
        ["Kick Barrage Voiceline"] = {
            SoundId = 10824345295,
            Volume = 3
        },
        ["Sudden Strike Voiceline"] = {
            SoundId = 10627078121,
            Volume = 3
        },
        ["Impale Voiceline"] = {
            SoundId = 10636575952,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["FullPower-Hit-Voice"] = {
            SoundId = 14003280725,
            Volume = 3,
            PlaybackSpeed = 1,
            TimePosition = 0.5
        },
        ["Timestop Voiceline"] = {
            SoundId = 14003334356,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Bloodsuck SFX"] = {
            SoundId = 14021780067,
            Volume = 3
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = 14022272353,
            Volume = 3
        },
        PoseMusic = {
            SoundId = 9073410546,
            Volume = 1,
            Looped = true
        },
        PoseMusic2 = {
            SoundId = 18751654254,
            Volume = 2,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(4.133, 600000)
        },
        ["Summon-Voiceline"] = {
            SoundId = 5700753924,
            Volume = 3.5,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.22, 600000)
        },
        ["Desummon-SFX"] = {
            SoundId = 137935917,
            Volume = 2.75,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.65, 600000)
        },
        ["Summon-SFX"] = {
            SoundId = 13146815734,
            Volume = 0.5
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = 130781850,
            Volume = 5,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.01, 2.65)
        },
        ["Checkmate Windup"] = {
            SoundId = 130781850,
            Volume = 5,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(2.65, 600000)
        },
        Teleport = {
            SoundId = 649548882,
            Volume = 2.5,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.7, 600000)
        },
        ["FullPower-Startup-Voice"] = {
            SoundId = 4580584763,
            Volume = 1.5,
            PlaybackSpeed = 1
        },
        ["Counter Voiceline"] = {
            SoundId = 7151747110,
            Volume = 1.75,
            PlaybackSpeed = 1,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.15, 600000)
        },
        ["StopSign-Voice"] = {
            SoundId = 143796003,
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-Voiceline"] = {
            SoundId = 5493389935,
            Volume = 2
        },
        Die = {
            SoundId = 160718677,
            Volume = 2
        },
        ["Strong Punch Voiceline"] = {
            SoundId = 182790064,
            Volume = 2,
            PlaybackSpeed = 1
        },
        BarrageVoiceline = {
            SoundId = 130758889,
            Volume = 1
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://14003280725",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "HELLO I AM EMU OTORI :DDDD, EMU IS MEANING SMILEEE"
                        } }
                }, {
                    SoundId = "rbxassetid://14003334356",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "YOKOSO KIRAKIRA DOKIDOKI MOCHIMOCHI PUYOPUYO WAKUWAKU WASHOI WANDAESTEIYEI"
                        } }
                }, {
                    SoundId = "rbxassetid://14055447353",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "WONDERHOY"
                        } }
                } }
        }
    }
};