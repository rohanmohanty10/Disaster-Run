  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local v1 = {
    Light = {
        Hit = {
            SoundId = 113581810174129,
            Volume = 3
        }
    },
    Heavy = {
        Hit = {
            SoundId = 113581810174129,
            Volume = 3,
            PlaybackSpeed = 0.95
        }
    },
    Barrage = {
        Hit = {
            SoundId = 113581810174129,
            Volume = 2,
            PlaybackSpeed = 1.5
        }
    }
};

return {
    Inherit = {
        AbilityName = "The World"
    },
    Stats = {
        Summon = {
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(103, 220, 95)), ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 86, 6)) })
        },
        Pose = {
            MusicAmount = 2
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = v1.Light
            },
            ["LMB-4"] = {
                HitSounds = v1.Heavy
            },
            ["StandOff-LMB-1"] = {
                HitSounds = v1.Light
            },
            ["StandOff-LMB-4"] = {
                HitSounds = v1.Heavy
            }
        },
        ["Kick Barrage"] = {
            HitSounds = v1.Light,
            Finisher = {
                HitSounds = v1.Heavy
            }
        },
        Barrage = {
            Hit = {
                HitSounds = v1.Barrage
            },
            Finisher = {
                HitSounds = v1.Heavy
            }
        },
        ["Sudden Strike"] = {
            HitSounds = v1.Light
        },
        ["Strong Punch"] = {
            HitSounds = v1.Heavy
        },
        Checkmate = {
            HitSounds = v1.Barrage
        }
    },
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = 135152543623582,
            Volume = 4.75,
            PlaybackSpeed = 1.25,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(1.089, 600000)
        },
        ["PoseMusic-2"] = {
            SoundId = 118298480687786,
            Volume = 4.5,
            Looped = true
        },
        ["Summon-Voiceline"] = {
            SoundId = 81426474295021,
            Volume = 4
        },
        ["Summon-SFX"] = {
            SoundId = 113581810174129,
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 113581810174129,
            Volume = 2
        },
        ["Timestop End Voiceline"] = {
            SoundId = 114110766123538,
            Volume = 3.5
        },
        ["Timestop SFX"] = {
            SoundId = 113581810174129,
            Volume = 2.5,
            PlaybackSpeed = 0.8,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Voiceline"] = {
            SoundId = 84978451470814,
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FullPower-Hit-Voice"] = {
            SoundId = 133076932498814,
            Volume = 4,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup-Voice"] = {
            SoundId = 128781764873254,
            Volume = 4,
            PlaybackSpeed = 1
        },
        ["Impale Voiceline"] = {
            SoundId = 95022458736625,
            Volume = 4,
            PlaybackSpeed = 1
        },
        ["Strong Punch Voiceline"] = {
            SoundId = 101883337283814,
            Volume = 4,
            PlaybackSpeed = 1,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 0.5)
        },
        ["Counter Voiceline"] = {
            SoundId = 115438715844683,
            Volume = 4,
            PlaybackSpeed = 1
        },
        ["StopSign-Voice"] = {
            SoundId = 80111781307093,
            Volume = 4,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-Voiceline"] = {
            SoundId = 87292778788569,
            Volume = 4
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = 100878609141877,
            Volume = 4.25
        },
        BarrageVoiceline = {
            SoundId = 89329675955112,
            Volume = 4
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = 108562447130141,
            Volume = 4
        },
        ["Sudden Strike Voiceline"] = {
            SoundId = 126576531908629,
            Volume = 4
        },
        ["Kick Barrage Voiceline"] = {
            SoundId = 131952481506382,
            Volume = 4
        },
        ["Bloodsuck Voiceline"] = {
            SoundId = 91467746231869,
            Volume = 4
        },
        ["LMB-1"] = {
            SoundId = 97686577672482,
            Volume = 4
        },
        ["LMB-2"] = {
            SoundId = 125199747797951,
            Volume = 4
        },
        ["LMB-3"] = {
            SoundId = 140377677783907,
            Volume = 4
        },
        ["LMB-4"] = {
            SoundId = 117938059003470,
            Volume = 4
        },
        ["SwingLMB 1-3"] = {
            SoundId = 113581810174129,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 113581810174129,
            PlaybackSpeed = 0.95,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 97686577672482,
            Volume = 4
        },
        ["StandOff-LMB-2"] = {
            SoundId = 125199747797951,
            Volume = 4
        },
        ["StandOff-LMB-3"] = {
            SoundId = 140377677783907,
            Volume = 4
        },
        ["StandOff-LMB-4"] = {
            SoundId = 117938059003470,
            Volume = 4
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 113581810174129,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 113581810174129,
            PlaybackSpeed = 0.95,
            Volume = 2
        },
        Teleport = {
            SoundId = 113581810174129,
            Volume = 2,
            PlaybackSpeed = 1.15
        },
        ["Death-Voiceline"] = {
            SoundId = 86681871005472,
            Volume = 3
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
                    SoundId = "rbxassetid://113581810174129",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*whistle*"
                        } }
                }, {
                    SoundId = "rbxassetid://112749608091664",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*laughter*"
                        } }
                }, {
                    SoundId = "rbxassetid://130312952617716",
                    SoundVolume = 2.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*laughter* 2"
                        } }
                } }
        }
    }
};