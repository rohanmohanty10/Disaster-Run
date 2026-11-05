  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local v1 = {
    Hit = {
        SoundId = 93342676329690,
        Volume = 1
    }
};
local v2 = {
    Hit = {
        SoundId = 105402108299411,
        Volume = 1
    }
};
local v3 = {
    Hit = {
        SoundId = 81727631662370,
        Volume = 1
    }
};

return {
    Inherit = {
        AbilityName = "Killer Queen"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 255, 120)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = v1
            },
            ["LMB-4"] = {
                HitSounds = v2
            },
            ["StandOff-LMB-1"] = {
                HitSounds = v1
            },
            ["StandOff-LMB-2"] = {
                HitSounds = v2
            },
            ["StandOff-LMB-3"] = {
                HitSounds = v3
            },
            ["StandOff-LMB-4"] = {
                HitSounds = v1
            }
        },
        Barrage = {
            Hit = {
                HitSounds = v1
            },
            Finisher = {
                HitSounds = v2
            },
            ClashHit = {
                HitSounds = v2
            },
            ClashFinisher = {
                HitSounds = v3
            }
        },
        ["Limb Burst"] = {
            HitSounds = v1,
            Burst = {
                HitSounds = {
                    Hit = {
                        SoundId = 131761071587692,
                        Volume = 1
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            PoseIdle = 90652562021088,
            PoseTransition = 121131171927987
        },
        Idle = {
            SummonedIdle = 137014574029735,
            Idle = 137014574029735
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 132194785995607,
            Volume = 0
        },
        SummonSound = {
            SoundId = 87172402660434,
            Volume = 1
        },
        Desummon = {
            SoundId = 100885731769864,
            Volume = 1
        },
        MeterUp1 = {
            SoundId = 75575083968833,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 90799311600182,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 10927467009,
            Volume = 0
        },
        MeterUp4 = {
            SoundId = 108286394171590,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 108811627882135,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 85316565136786,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 109826358769663,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 73830619064320,
            Volume = 1
        },
        ["SwingLMB 1-3"] = {
            SoundId = 119494909272113,
            Volume = 1
        },
        ["SwingLMB 4"] = {
            SoundId = 125518965842060,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 108811627882135,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 85316565136786,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 109826358769663,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 73830619064320,
            Volume = 1
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 119494909272113,
            Volume = 1
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 125518965842060,
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = 7167737842,
            Volume = 0
        },
        Barrage = {
            SoundId = 109984353530869,
            Volume = 1
        },
        Grab = {
            SoundId = 10906275061,
            Volume = 1
        },
        Grabbed = {
            SoundId = 10906275262,
            Volume = 1
        },
        Throw = {
            SoundId = 10906746801,
            Volume = 1
        },
        ThrowVoiceline = {
            SoundId = 10919755744,
            Volume = 0
        },
        PowerSFX = {
            SoundId = 10920809881,
            Volume = 1
        },
        PowerVoice = {
            SoundId = 10920810178,
            Volume = 1
        },
        PrimaryV1 = {
            SoundId = 10842751862,
            Volume = 0
        },
        PrimaryV2 = {
            SoundId = 10842751768,
            Volume = 0
        },
        PrimaryV3 = {
            SoundId = 10842751660,
            Volume = 0
        },
        PrimaryV4 = {
            SoundId = 10842751526,
            Volume = 0
        },
        ClickSwitch = {
            SoundId = 10842752271,
            Volume = 1
        },
        Planted = {
            SoundId = 6425414680,
            Volume = 1
        },
        BombPlace = {
            SoundId = 7167739366,
            Volume = 1
        },
        UppercutVoice = {
            SoundId = 10847606246,
            Volume = 1
        },
        UppercutSFX = {
            SoundId = 10847606454,
            Volume = 1
        },
        RestrainVoice = {
            SoundId = 10855815043,
            Volume = 1
        },
        RestrainBeginning = {
            SoundId = 10855815135,
            Volume = 1
        },
        RestrainConnect = {
            SoundId = 10855818191,
            Volume = 1
        },
        BombPlantVLAttempt = {
            SoundId = 10897845259,
            Volume = 1
        },
        BombPlantSuccessVL = {
            SoundId = 10897845160,
            Volume = 1
        },
        BombPlantKicksWoosh = {
            SoundId = 10897845160,
            Volume = 1
        },
        BombPlantSFX = {
            SoundId = 10897845423,
            Volume = 1
        },
        ArmChopVoice = {
            SoundId = 10897845642,
            Volume = 1
        },
        ArmChopSwing = {
            SoundId = 10897845731,
            Volume = 1
        },
        ["Face Slam Startup SFX"] = {
            SoundId = 120835943515085,
            Volume = 1
        },
        ["Face Slam Startup Voiceline"] = {
            SoundId = 120173296443708,
            Volume = 1
        },
        ["Face Slam"] = {
            SoundId = 108168778614425,
            Volume = 1
        },
        ["Face Slam Voiceline"] = {
            SoundId = 72932512833552,
            Volume = 1
        },
        ["Power Display Voice"] = {
            SoundId = 10920810178,
            Volume = 1
        },
        ["Power Display Swing"] = {
            SoundId = 10920809881,
            Volume = 1
        },
        ["Withdraw Change LMB"] = {
            SoundId = 92740303164637,
            Volume = 1
        },
        ["Withdraw Change"] = {
            SoundId = 73783577313308,
            Volume = 1
        },
        ["Withdraw Change Voiceline"] = {
            SoundId = 88464571669179,
            Volume = 1
        },
        ["Surface Detonation"] = {
            SoundId = 133405074751031,
            Volume = 1
        },
        ["Surface Detonation Voiceline"] = {
            SoundId = 74120043839309,
            Volume = 1
        },
        ["Power Display"] = {
            SoundId = 107771925016711,
            Volume = 1
        },
        ["Power Display Startup"] = {
            SoundId = 109541850762796,
            Volume = 1
        },
        ["Power Display Voiceline"] = {
            SoundId = 82923776321202,
            Volume = 1
        },
        ["Explosion 1"] = {
            SoundId = 102461447691053,
            Volume = 1
        },
        ["Explosion 2"] = {
            SoundId = 136727819603784,
            Volume = 1
        },
        ["Explosion 3"] = {
            SoundId = 91289876325774,
            Volume = 1
        },
        ["Limb Burst"] = {
            SoundId = 80216058975686,
            Volume = 1
        },
        ["Limb Burst Voiceline"] = {
            SoundId = 110870846166729,
            Volume = 1
        },
        ["Arm Slice"] = {
            SoundId = 134577691560467,
            Volume = 1
        },
        ["Arm Slice Voiceline"] = {
            SoundId = 130395862489907,
            Volume = 1
        },
        ["Quadruple Bomb Counter Startup"] = {
            SoundId = 118929116921617,
            Volume = 1
        },
        ["Quadruple Bomb Counter Startup Voiceline"] = {
            SoundId = 103922497457691,
            Volume = 1
        },
        ["Quadruple Bomb Counter"] = {
            SoundId = 115270529066183,
            Volume = 1
        },
        ["Quadruple Bomb Counter Voiceline"] = {
            SoundId = 124971056651879,
            Volume = 1
        },
        ["Yen Throw Voice"] = {
            SoundId = 10969901544,
            Volume = 1
        },
        ["Yen Throw SFX"] = {
            SoundId = 10969901566,
            Volume = 1
        },
        ["Sheer Heart Attack Voiceline"] = {
            SoundId = 11118195383,
            Volume = 0
        },
        ["Sheer Heart Attack"] = {
            SoundId = 71781211095417,
            Volume = 1
        },
        ["Global Detonation"] = {
            SoundId = 136955536206209,
            Volume = 1
        },
        ["Plant Bomb"] = {
            SoundId = 83703434874935,
            Volume = 1
        },
        ["Plant Bomb Startup"] = {
            SoundId = 128097191210930,
            Volume = 1
        },
        ["Plant Bomb Voiceline"] = {
            SoundId = 108326578388243,
            Volume = 0
        },
        ["Plant Bomb Startup Voiceline"] = {
            SoundId = 114567530406715,
            Volume = 0
        },
        ["Quick Plant"] = {
            SoundId = 73795643891636,
            Volume = 1
        },
        ["Quick Plant Startup"] = {
            SoundId = 85366173153252,
            Volume = 1
        },
        ["Quick Plant Startup Voiceline"] = {
            SoundId = 83557133929619,
            Volume = 1
        },
        ["Quick Plant Voiceline"] = {
            SoundId = 94192062462376,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 9971779872,
            PlaybackSpeed = 1.11
        }
    },
    QuoteInfo = {
        Groups = {
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
            }
        },
        Quotes = {
            StandOn = { {
                    SoundId = "rbxassetid://111621841005481",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Creeper? Aw man"
                        } }
                }, {
                    SoundId = "rbxassetid://97369180274498",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m a creeper: Minecraft\'s grim reaper"
                        } }
                } },
            StandOff = {
                {
                    SoundId = "rbxassetid://95047857438744",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Chicken jockey"
                        } }
                },
                {
                    SoundId = "rbxassetid://123629766859979",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You really are the worst"
                        } }
                },
                {
                    SoundId = "rbxassetid://137534400071509",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The overworld"
                        } }
                },
                {
                    SoundId = "rbxassetid://83923441301119",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "As a child I YEARNED for the mines"
                        } }
                },
                {
                    SoundId = "rbxassetid://84729747857825",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "That\'s right"
                        } }
                },
                {
                    SoundId = "rbxassetid://86077864884217",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You got yourself a SWEET BLADE"
                        } }
                },
                {
                    SoundId = "rbxassetid://108614851880082",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Chungus"
                        } }
                },
                {
                    SoundId = "rbxassetid://115728102850178",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Elytra Wing Suits...Ska-TA! SKA-TA!!!"
                        } }
                },
                {
                    SoundId = "rbxassetid://107283662109582",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I....AM STEVE."
                        } }
                },
                {
                    SoundId = "rbxassetid://76573223035167",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "La-la-la-lava, ch-ch-ch-chicken Steve\'s Lava Chicken, yeah, it\'s tasty as hell Ooh, mamacita, now you\'re ringin\' the bell Crispy and juicy, now you\'re havin\' a snack Ooh, super spicy, it\'s a lava attack"
                        } }
                },
                {
                    SoundId = "rbxassetid://85616137772201",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Go now, Dennis Change Dawn\'s life, Dennis Go on a journey and think of me, Dennis Go now, legendary wolf of my dreams My doggie, doggie, doggie My Dennis Awoo-ooh-hoo-hoo, yeah"
                        } }
                }
            }
        }
    }
};