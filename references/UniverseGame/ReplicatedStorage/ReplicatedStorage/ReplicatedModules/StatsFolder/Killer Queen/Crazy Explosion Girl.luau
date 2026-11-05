  

 

return {
    Inherit = {
        AbilityName = "Killer Queen"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 6, 10)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        },
        ["Primary Ability"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14975627231,
                    Volume = 1.5
                }
            },
            Hit1 = {
                Hit = {
                    SoundId = 14975627518,
                    Volume = 1.5
                }
            },
            Hit2 = {
                Hit = {
                    SoundId = 14975627299,
                    Volume = 1.5
                }
            }
        },
        ["Flying Uppercut"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14975629777,
                    Volume = 1.5
                }
            }
        },
        TMoves = {
            ["Cugious Strike"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14975628516,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Quick Plant"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14975631347,
                    Volume = 1.5
                }
            }
        },
        ["Power Display"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14975629255,
                    Volume = 1.5
                }
            }
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 14975627441,
            Volume = 1.25
        },
        SummonSound = {
            SoundId = 14975626791,
            Volume = 1.25
        },
        Desummon = {
            SoundId = 14975628254,
            Volume = 1.25
        },
        MeterUp2 = {
            SoundId = 14995940451,
            Volume = 1.5
        },
        MeterUp3 = {
            SoundId = 14995940451,
            Volume = 0
        },
        MeterUp4 = {
            SoundId = 14995940091,
            Volume = 1.5
        },
        ["LMB-1"] = {
            SoundId = 14995940799,
            Volume = 1.25
        },
        ["LMB-2"] = {
            SoundId = 14995939908,
            Volume = 1.25
        },
        ["LMB-3"] = {
            SoundId = 14995939721,
            Volume = 1.25
        },
        ["LMB-4"] = {
            SoundId = 14995940267,
            Volume = 1.25
        },
        ["SwingLMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 1.25
        },
        ["SwingLMB 4"] = {
            SoundId = 10626764953,
            Volume = 1.25
        },
        ["StandOff-LMB-1"] = {
            SoundId = 10842905304,
            Volume = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = 10842905185,
            Volume = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = 10842905241,
            Volume = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = 10842905370,
            Volume = 0
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 1.25
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 10626764953,
            Volume = 1.25
        },
        BarrageVoiceline = {
            SoundId = 14975629430,
            Volume = 1.25
        },
        Barrage = {
            SoundId = 10835571201,
            Volume = 1.25
        },
        Grab = {
            SoundId = 10906275061,
            Volume = 1.25
        },
        Grabbed = {
            SoundId = 10906275262,
            Volume = 1.25
        },
        Throw = {
            SoundId = 10906746801,
            Volume = 1.25
        },
        ThrowVoiceline = {
            SoundId = 10919755744,
            Volume = 0
        },
        PowerSFX = {
            SoundId = 14975629324,
            Volume = 1.25
        },
        PowerVoice = {
            SoundId = 14975629585,
            Volume = 1.25
        },
        PrimaryV1 = {
            SoundId = 14975628389,
            Volume = 1.25
        },
        PrimaryV2 = {
            SoundId = 14975628150,
            Volume = 1.25
        },
        PrimaryV3 = {
            SoundId = 14975627822,
            Volume = 1.25
        },
        PrimaryV4 = {
            SoundId = 14975627822,
            Volume = 1.25
        },
        MiscDetonateSFX = {
            SoundId = 14988509846,
            Volume = 1.25
        },
        ClickSwitch = {
            SoundId = 14988509846,
            Volume = 0
        },
        Planted = {
            SoundId = 6425414680,
            Volume = 0
        },
        BombPlace = {
            SoundId = 7167739366,
            Volume = 1.25
        },
        UppercutVoice = {
            SoundId = 14975629636,
            Volume = 1.25
        },
        UppercutSFX = {
            SoundId = 14975629701,
            Volume = 1.25
        },
        RestrainVoice = {
            SoundId = 14975630244,
            Volume = 1.25
        },
        RestrainBeginning = {
            SoundId = 14975629986,
            Volume = 1.25
        },
        RestrainConnect = {
            SoundId = 10855818191,
            Volume = 1.25
        },
        BombPlantVLAttempt = {
            SoundId = 14975626970,
            Volume = 1.25
        },
        BombPlantSuccessVL = {
            SoundId = 10897845160,
            Volume = 0
        },
        BombPlantKicksWoosh = {
            SoundId = 10897845160,
            Volume = 0
        },
        BombPlantSFX = {
            SoundId = 14975627140,
            Volume = 1.25
        },
        ArmChopVoice = {
            SoundId = 14975628474,
            Volume = 1.25
        },
        ArmChopSwing = {
            SoundId = 14975628557,
            Volume = 1.25
        },
        ["Face Slam Startup SFX"] = {
            SoundId = 14975630355,
            Volume = 1.25
        },
        ["Face Slam Startup Voiceline"] = {
            SoundId = 14975630115,
            Volume = 1.25
        },
        ["Face Slam"] = {
            SoundId = 14975630433,
            Volume = 1.25
        },
        ["Face Slam Success SFX"] = {
            SoundId = 14975630904,
            Volume = 1.25
        },
        ["Power Display Voice"] = {
            SoundId = 14975629585,
            Volume = 1.25
        },
        ["Power Display Swing"] = {
            SoundId = 14975629324,
            Volume = 1.25
        },
        ["Quadruple Bomb Finish Startup Woosh"] = {
            SoundId = 14975631082,
            Volume = 1.25
        },
        ["Quadruple Bomb Finish Startup Voice"] = {
            SoundId = 14975631025,
            Volume = 1.25
        },
        ["Quadruple Bomb Finish SFX"] = {
            SoundId = 14975630555,
            Volume = 1.25
        },
        ["Quadruple Bomb Finish Voice"] = {
            SoundId = 14975630659,
            Volume = 1.25
        },
        ["Yen Throw Voice"] = {
            SoundId = 14975629046,
            Volume = 1.25
        },
        ["Yen Throw SFX"] = {
            SoundId = 14988509948,
            Volume = 1.25
        },
        ["SHA Voice"] = {
            SoundId = 14975628604,
            Volume = 1.25
        },
        ["SHA SFX"] = {
            SoundId = 14975628671,
            Volume = 1.25
        },
        QuickPlantWoosh = {
            SoundId = 14975629986,
            Volume = 1.25
        },
        QuickPlantVoice = {
            SoundId = 14975631233,
            Volume = 1.25
        },
        QuickPlantSuccededVoice = {
            SoundId = 14975631141,
            Volume = 1.25
        },
        QuickPlantSucceededSFX = {
            SoundId = 11159624170,
            Volume = 0.5
        },
        PoseSFX = {
            SoundId = 14995940623,
            Volume = 1.5
        },
        PoseMusic = {
            SoundId = 14975633318,
            Volume = 1.25,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        }
    },
    Animations = {
        Action = {
            PoseTransition = 14988677809,
            PoseIdle = 14988679319
        },
        Idle = {
            Idle = 14988668598,
            SummonedIdle = 14988672761
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
                    SoundId = "rbxassetid://14975631625",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Baku-retsu Baku-retsu, la la la!"
                        } }
                }, {
                    SoundId = "rbxassetid://14975631455",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "IDIOT! I suspected as much!"
                        } }
                }, {
                    SoundId = "rbxassetid://14975631560",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Explosion!"
                        } }
                }, {
                    SoundId = "rbxassetid://14975631517",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I believe that power is the most important of all!"
                        } }
                } }
        }
    }
};