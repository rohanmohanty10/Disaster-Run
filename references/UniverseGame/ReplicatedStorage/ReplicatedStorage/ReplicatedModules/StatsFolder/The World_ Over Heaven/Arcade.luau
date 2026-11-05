  

 

local Arcade = game.ReplicatedStorage["Client Assets"].Assets.Abilities["The World: Over Heaven"].Arcade;
local v1 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = Arcade.Global.Light
        }
    }
};
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = Arcade.Global.Heavy
        }
    }
};

return {
    Inherit = {
        AbilityName = "The World: Over Heaven"
    },
    Stats = {
        Summon = {
            SummonV2 = true,
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(166, 216, 161)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220022962,
                        Volume = 1.5
                    }
                },
                HitRemotes = { v1 }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220036746,
                        Volume = 1.5
                    }
                },
                HitRemotes = { v2 }
            }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220020214,
                        Volume = 1
                    }
                },
                HitRemotes = { v1 }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220036746,
                        Volume = 2
                    }
                },
                HitRemotes = { v2 }
            }
        },
        ["Heavy Punch"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14220036746,
                    Volume = 2
                }
            },
            HitRemotes = { v2 }
        },
        ["Round Kick"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14220022468,
                    Volume = 2
                }
            },
            HitRemotes = { v2 }
        },
        ["Rampage Force"] = {
            Startup = {
                HitRemotes = { v1 }
            },
            Lightning = {
                HitRemotes = { v1 }
            },
            Hit = {
                HitRemotes = { v1 }
            },
            Finisher = {
                HitRemotes = { v2 }
            }
        },
        Fissure = {
            HitSounds = {
                Hit = {
                    SoundId = 14220022468,
                    Volume = 2
                }
            },
            HitRemotes = { v2 }
        },
        Mangle = {
            HitSounds = {
                Hit = {
                    SoundId = 14220020677,
                    Volume = 2
                }
            }
        },
        ["Cataclysmic Throw"] = {
            Projectile = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220020992,
                        Volume = 1
                    }
                }
            }
        },
        ["Divine Retribution"] = {
            Barrage = {
                HitSounds = {
                    Hit = {
                        SoundId = 13784838361,
                        Volume = 1
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220022468,
                        Volume = 2
                    }
                }
            }
        },
        ["Reality Overwrite"] = {
            VoicelineRange = 2,
            HitSounds = {
                Hit = {
                    SoundId = 97651634912059,
                    Volume = 2.25
                }
            }
        }
    },
    Sounds = {
        MeterUp3 = {
            SoundId = 14220019665,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 14220019665,
            Volume = 2
        },
        ["Death-Voiceline"] = {
            SoundId = 14220019038,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KickVoice = {
            SoundId = 14220022596,
            Volume = 3
        },
        KickWindup = {
            SoundId = 14220022213,
            Volume = 2
        },
        Grab = {
            SoundId = 10961581608,
            Volume = 2
        },
        Grabbed = {
            SoundId = 10961580298,
            Volume = 3
        },
        ThrowVoiceline = {
            SoundId = 10961580766,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 14220022849,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = 14220022784,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = 14220022709,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = 14220022596,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SwingLMB = {
            SoundId = 6706981173,
            Volume = 0.800000011920929,
            PlaybackSpeed = 0.800000011920929,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = 14220020362,
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = 14220020125,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Behind and Above Startup"] = {
            SoundId = 14220687577,
            Volume = 2
        },
        ["Behind and Above Strike"] = {
            SoundId = 14220019561,
            Volume = 2
        },
        ["Heavy Punch Voice"] = {
            SoundId = 14220019765,
            Volume = 2
        },
        ["Heavy Punch Woosh"] = {
            SoundId = 14220019409,
            Volume = 2
        },
        ["Mangle Voice"] = {
            SoundId = 14220020488,
            Volume = 2
        },
        ["Mangle Woosh"] = {
            SoundId = 14220020581,
            Volume = 2
        },
        ["Rampage Force Startup"] = {
            SoundId = 14220020041,
            Volume = 2
        },
        ["Rampage Force Hit"] = {
            SoundId = 11006543979,
            Volume = 2
        },
        ["Fissure Woosh"] = {
            SoundId = 14226238821,
            Volume = 2
        },
        ["Fissure Voice"] = {
            SoundId = 14220687577,
            Volume = 2
        },
        ["Overwrite Infusion Woosh"] = {
            SoundId = 14220022311,
            Volume = 2
        },
        ["Overwrite Infusion Voice"] = {
            SoundId = 14220022378,
            Volume = 2
        },
        ["Cataclysmic Throw Woosh"] = {
            SoundId = 14220020792,
            Volume = 2
        },
        ["Cataclysmic Throw Voice"] = {
            SoundId = 14220020897,
            Volume = 2
        },
        ["Divine Thunder Voice"] = {
            SoundId = 14220019486,
            Volume = 2
        },
        ["Divine Thunder Woosh"] = {
            SoundId = 14220019265,
            Volume = 2
        },
        ["Immortal Strikes Voice"] = {
            SoundId = 14220021499,
            Volume = 2
        },
        ["Immortal Strikes Woosh"] = {
            SoundId = 14220021629,
            Volume = 2
        },
        ["Immortal Strikes Cutscene Voice"] = {
            SoundId = 14220021405,
            Volume = 2
        },
        ["Immortal Strikes Cutscene Woosh"] = {
            SoundId = 14220021954,
            Volume = 2
        },
        ["Rampage Force Voice"] = {
            SoundId = 14220019854,
            Volume = 2
        },
        ["Rampage Force Woosh"] = {
            SoundId = 14220020041,
            Volume = 2
        },
        ["Rampage Force Grab Woosh"] = {
            SoundId = 14220019958,
            Volume = 2
        },
        Teleport = {
            SoundId = 14226243790,
            Volume = 2
        },
        ["Timestop Voice"] = {
            SoundId = 14220021253,
            Volume = 2
        },
        ["Timestop Woosh"] = {
            SoundId = 14220021139,
            Volume = 2
        },
        ["Timestop Resume"] = {
            SoundId = 14220022142,
            Volume = 2
        },
        Explosion = {
            SoundId = 11453199824,
            Volume = 2
        },
        SummonSound = {
            SoundId = 14220021764,
            Volume = 2
        },
        SummonEffects = {
            SoundId = 14220022050,
            Volume = 2
        },
        Desummon = {
            SoundId = 14220021845,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 18429099027,
            Volume = 2,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.465, 41.1),
            LoopRegion = NumberRange.new(0.5, 41.1)
        },
        ["Divine Retribution Startup"] = {
            SoundId = 85348982798844,
            Volume = 2
        },
        ["Divine Retribution Startup Voice"] = {
            SoundId = 95673242753442,
            Volume = 2
        },
        ["Divine Retribution"] = {
            SoundId = 134775373265611,
            Volume = 2
        },
        ["Divine Retribution Voice"] = {
            SoundId = 115894536369145,
            Volume = 2
        },
        ["Reality Overwrite"] = {
            SoundId = 104030763647795,
            Volume = 2
        },
        ["Reality Overwrite Voice-1"] = {
            SoundId = 81566426528344,
            Volume = 2
        },
        ["Reality Overwrite Voice-2"] = {
            SoundId = 140283444278494,
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
                    SoundId = "rbxassetid://10011598147",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Fine then, try me. I, DIO, will be victorious!"
                        } }
                }, {
                    SoundId = "rbxassetid://10011599124",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Useless!"
                        } }
                }, {
                    SoundId = "rbxassetid://10011600458",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re Next."
                        } }
                }, {
                    SoundId = "rbxassetid://10011601448",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Well, do you wish to play a game?!"
                        } }
                } }
        }
    }
};