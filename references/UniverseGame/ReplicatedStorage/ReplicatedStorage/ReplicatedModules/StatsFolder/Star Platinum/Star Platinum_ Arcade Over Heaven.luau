  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Star Platinum"
    },
    Animations = {
        Action = {
            HeavyPunch = 10466747790,
            Timestop = 10492455324,
            PoseTransition = 10520887665,
            PoseIdle = 10520885312,
            GrabAttempt = 10534057574,
            GrabSuccess = 10534063288,
            GrabVictim = 10534060972
        },
        Idle = {
            Idle = 10181750896,
            SummonedIdle = 10463742205
        }
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 137, 73)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 89, 0)) })
        },
        Pose = {
            MusicAmount = 2
        }
    },
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = "rbxassetid://10562594724",
            Volume = 2,
            Looped = true,
            TimePosition = 0
        },
        ["PoseMusic-2"] = {
            SoundId = 72760409563074,
            Volume = 3,
            Looped = true,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = 10492282191,
            Volume = 2,
            Looped = false
        },
        BarrageVoiceline = {
            SoundId = 10492278638,
            Volume = 2,
            Looped = false
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://10557684153",
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://10557684834",
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://10557685288",
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://12899840899",
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 12899842236,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 12899840899,
            Volume = 2
        },
        Desummon = {
            SoundId = "rbxassetid://10492279245",
            Volume = 1
        },
        ["Ora Slam Voiceline"] = {
            SoundId = 14065135085,
            Volume = 1.5
        },
        Grab = {
            SoundId = 12899850732,
            Volume = 2
        },
        Grabbed = {
            SoundId = 10906275262,
            Volume = 2
        },
        Throw = {
            SoundId = 12899847431,
            Volume = 2
        },
        ThrowVoiceline = {
            SoundId = 12899842960,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 12899837533,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 12899838665,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 12899839745,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            Volume = 0
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 12899842236,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 12899840899,
            Volume = 2
        },
        ["Timestop SFX"] = {
            SoundId = "rbxassetid://12899834308"
        },
        ["Timestop Voiceline"] = {
            SoundId = "rbxassetid://12887343420"
        },
        ["Timestop End Voiceline"] = {
            SoundId = "rbxassetid://12887350984"
        },
        ["Brute Force Grab Voiceline"] = {
            SoundId = "rbxassetid://12887378761"
        },
        ["Brute Force Grab"] = {
            SoundId = "rbxassetid://12887400185"
        },
        ["Brute Force Voiceline"] = {
            SoundId = "rbxassetid://12887387767"
        },
        ["Brute Force"] = {
            SoundId = "rbxassetid://12887393705"
        },
        GrabSlamVoice = {
            SoundId = 12899820617,
            Volume = 2
        },
        GrabSlamWoosh = {
            SoundId = 12899836634,
            Volume = 2
        },
        GrabSlam = {
            SoundId = 12899835241,
            Volume = 2
        },
        GrabSlamVoicelineHit = {
            SoundId = 12899835963,
            Volume = 2
        },
        ["Star Finger Voiceline"] = {
            SoundId = "rbxassetid://12887431266"
        },
        ["Star Finger Whoosh"] = {
            SoundId = "rbxassetid://12887436639"
        },
        LockKickVoice = {
            SoundId = "rbxassetid://12887442072"
        },
        ["Ground Slam SFX"] = {
            SoundId = "rbxassetid://14065134622"
        },
        BeatdownAttempt = {
            SoundId = "rbxassetid://12899823094"
        },
        ["BeatdownAttempt-Voiceline"] = {
            SoundId = "rbxassetid://12887455837",
            Volume = 4
        },
        Beatdown = {
            SoundId = "rbxassetid://12899824339"
        },
        ["Beatdown-Voiceline"] = {
            SoundId = "rbxassetid://12887463828",
            Volume = 4
        },
        Inhale = {
            SoundId = 12899827149,
            Volume = 2
        },
        ["Inhale Voiceline"] = {
            SoundId = 12899825905,
            Volume = 2
        },
        ["Star Breaker Voiceline"] = {
            SoundId = 12899828545,
            Volume = 2
        },
        ["Star Breaker Whoosh"] = {
            SoundId = 12899830685,
            Volume = 2
        },
        ["Evil Spirit Voiceline"] = {
            SoundId = 12899832662,
            Volume = 2
        },
        ["Evil Spirit Equip"] = {
            SoundId = 12899833378,
            Volume = 2
        },
        ["Evil Spirit Shoot"] = {
            SoundId = 12899831744,
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
            Universal = { {
                    SoundId = "rbxassetid://18875403450",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t worry, I held back."
                        } }
                }, {
                    SoundId = "rbxassetid://18875403801",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You really ticked me off."
                        } }
                }, {
                    SoundId = "rbxassetid://18875404147",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Good grief."
                        } }
                }, {
                    SoundId = "rbxassetid://18875404774",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I will be the judge!"
                        } }
                }, {
                    SoundId = "rbxassetid://18875404457",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "That alone is the reason for your defeat."
                        } }
                } }
        }
    },
    Metadata = {
        BarrageColors = { Color3.fromRGB(255, 137, 73), Color3.fromRGB(79, 79, 79) }
    }
};