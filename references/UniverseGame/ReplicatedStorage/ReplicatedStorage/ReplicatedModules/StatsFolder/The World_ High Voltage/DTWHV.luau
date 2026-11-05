  

 

return {
    Inherit = {
        AbilityName = "The World: High Voltage"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(144, 92, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(71, 52, 97)) })
        },
        Pose = {
            Callbacks = {
                PoseTransition = function(p1, p2) -- Line: 15, Name: PoseTransition
                    local Humanoid = p1.Character.Humanoid;
                    local Trove = p2.Trove;
                    Humanoid.HipHeight = 0.5;
                    Trove:Add(function() -- Line: 23
                        -- upvalues: Humanoid (copy)
                        Humanoid.HipHeight = 0;
                    end);
                end
            }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 17288119173,
            PoseIdle = 17288117975,
            AttackPose = 6600255288,
            Cutscene = 7037887987,
            Gasoline = 5697356924,
            Kick = 5224441129,
            KnifeAnim = 7195050558,
            UrgentTS = 6612929603,
            Pose1 = 5730215005,
            GunFire = 6501360764,
            Pose2 = 5730215005,
            PunchBarrage = 5704092469,
            StandJump = 5889373753,
            HeavyPunch = 6663831578,
            Timestop = 7060238054,
            Sit = 5718959564,
            WireThrow = 6649402629,
            HeavyMuda = 6768306270
        },
        Idle = {
            StandIdle = 6606063246
        }
    },
    Sounds = {
        SummonSound = {
            SoundId = 13794970460,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 13794969211,
            Volume = 2
        },
        ["Desummon-Voiceline"] = {
            SoundId = 17452553268,
            Volume = 1
        },
        ["Fierce Rushdown Voiceline"] = {
            SoundId = 17452552640,
            Volume = 1
        },
        Teleport = {
            SoundId = 6773724319,
            Volume = 1
        },
        ["Flashbang Voiceline"] = {
            SoundId = 17452552542,
            Volume = 1
        },
        ["Lethal Grasp Startup Voiceline"] = {
            SoundId = 17452554009,
            Volume = 1
        },
        ["Blink Execution Startup Voiceline"] = {
            SoundId = 17452552784,
            Volume = 1
        },
        ["Chop Voiceline"] = {
            SoundId = 17452552225,
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = 13794969718,
            Volume = 1
        },
        Barrage = {
            SoundId = 11206831402,
            Volume = 1
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = 17452552406,
            Volume = 1
        },
        ["Revolver Flank Voiceline"] = {
            SoundId = 17452554487,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 17452554632,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 17452554337,
            Volume = 1
        },
        ["Timestop Second Voiceline"] = {
            SoundId = 17452554116,
            Volume = 1
        },
        ["Timestop Startup Voiceline"] = {
            SoundId = 17452554228,
            Volume = 1
        },
        ["Shining Impale Voiceline"] = {
            SoundId = 17452553883,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 13794988895,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 13794972371,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 13794972553,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 13794972291,
            Volume = 1
        },
        ["Vicious Cleaving Voiceline"] = {
            SoundId = 17452553733,
            Volume = 1
        },
        KnivesOutStartup = {
            SoundId = 13169011988,
            Volume = 2
        },
        KnivesOutStartupVoice = {
            SoundId = 13795297619,
            Volume = 2
        },
        KnivesOut = {
            SoundId = 13169012233,
            Volume = 2
        },
        KnivesOutVoice = {
            SoundId = 13795291869,
            Volume = 2
        },
        ["PoseMusic-1"] = {
            SoundId = 17288121269,
            Volume = 1
        },
        ["PoseMusic-2"] = {
            SoundId = 17288121269,
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
                    SoundId = "rbxassetid://13794971964",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Is it already over?"
                        } }
                }, {
                    SoundId = "rbxassetid://13794972190",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Too bad. I\'ve already got a plan to beat you."
                        } }
                }, {
                    SoundId = "rbxassetid://13794972079",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The winner will be ME, DIO!"
                        } }
                }, {
                    SoundId = "rbxassetid://13794972019",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The end will come faster than if time were stopped!"
                        } }
                } }
        }
    }
};