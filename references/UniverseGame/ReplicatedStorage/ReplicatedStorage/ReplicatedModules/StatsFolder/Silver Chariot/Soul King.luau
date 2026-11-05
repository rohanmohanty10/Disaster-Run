  

 

local Effects = game:GetService("ReplicatedStorage")["Client Assets"]["Silver Chariot"]["SCSoul King"].Effects;
local v1 = {
    Hit = {
        SoundId = 13958000525,
        Volume = 1.2
    }
};
local v2 = {
    Hit = {
        SoundId = 14043459031,
        Volume = 1.3
    }
};
local v3 = {
    {
        Name = "Output",
        Arguments = {
            "FX",
            "_Emit Particles",
            "__Attacker",
            "__Target",
            Effects["SC Barrage Effect"],
            {
                Type = "Emit"
            }
        }
    }
};
local v4 = {
    {
        Name = "Output",
        Arguments = {
            "FX",
            "_Emit Particles",
            "__Attacker",
            "__Target",
            Effects["SC R Effect"],
            {
                Type = "Emit"
            }
        }
    }
};
local v5 = {
    {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V2",
            "__Legacy",
            {
                AutoSerialize = true,
                Particle = Effects["SC LMB Effect"]
            }
        }
    }
};
local v6 = {
    {
        Name = "Output",
        Arguments = {
            "FX",
            "_Emit Particles",
            "__Attacker",
            "__Target",
            Effects.MultiSlashHit,
            {
                Type = "Emit"
            }
        }
    }
};

return {
    Inherit = {
        AbilityName = "Silver Chariot"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(21, 144, 238)), ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 142, 255)) })
        },
        Barrage = {
            Barrage = {
                Hit = {
                    HitSounds = v1,
                    HitRemotes = v3
                },
                Finisher = {
                    HitSounds = v2,
                    HitRemotes = v4
                }
            }
        },
        ["Immobilizing Slices"] = {
            HitSounds = v1,
            HitRemotes = v5,
            ArmorOff = {
                HitSounds = v1,
                HitRemotes = v5
            },
            FirstHit = {
                HitSounds = v1,
                HitRemotes = v4
            },
            Throw = {
                HitSounds = v2,
                HitRemotes = v6
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = v1,
                HitRemotes = v5
            },
            ["LMB-2"] = {
                HitSounds = v1,
                HitRemotes = v5
            },
            ["LMB-3"] = {
                HitSounds = v1,
                HitRemotes = v5
            },
            ["StandOff-LMB-1"] = {
                HitSounds = v1,
                HitRemotes = v5
            },
            ["StandOff-LMB-2"] = {
                HitSounds = v1,
                HitRemotes = v5
            },
            ["StandOff-LMB-3"] = {
                HitSounds = v1,
                HitRemotes = v5
            },
            ["LMB-4"] = {
                HitSounds = v2,
                HitRemotes = v4
            },
            ["StandOff-LMB-4"] = {
                HitSounds = v2,
                HitRemotes = v4
            }
        },
        ["Piercing Finisher"] = {
            HitSounds = v1,
            HitRemotes = v4,
            Jab = {
                HitSounds = v1,
                HitRemotes = v5
            },
            Slice = {
                HitSounds = v1,
                HitRemotes = v4
            },
            FinalSlice = {
                HitSounds = v1,
                HitRemotes = v6
            }
        },
        Clobber = {
            HitRemotes = v4,
            HitSounds = {
                Hit = {
                    SoundId = 14043576161,
                    Volume = 2
                }
            }
        },
        ["Triple Strike"] = {
            HitSounds = v1,
            HitRemotes = v3,
            FinalHit = {
                HitSounds = v2,
                HitRemotes = v4
            }
        },
        ["Eye Of The Storm"] = {
            HitSounds = v1,
            HitRemotes = v6
        },
        ["Instant Slice"] = {
            HitRemotes = v4,
            HitSounds = v1
        },
        Riposte = {
            Jab = {
                HitSounds = v2,
                HitRemotes = v5
            },
            FinalStrike = {
                HitSounds = v1,
                HitRemotes = v6
            }
        },
        ["Ricochet Shot"] = {
            HitRemotes = v4
        }
    },
    Animations = {
        Movement = {
            SummonedWalk = 13480840184,
            Walk = 13480840184,
            SummonedRun = 13480838043,
            Run = 13480838043,
            EnGardeWalk = 14172850721,
            EnGardeRun = 14172847673
        },
        Idle = {
            SummonedIdle = 13480828690,
            Idle = 13480828690,
            EnGardeIdle = 14172843547
        },
        Action = {
            ["Different Immobilizing Slices"] = 14172794309,
            ["En Garde"] = 14172827018,
            ["Armor Off"] = 14172925393
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 13958001092,
            Volume = 1
        },
        SummonSound = {
            SoundId = 13958000978,
            Volume = 1
        },
        Desummon = {
            SoundId = 13958000809,
            Volume = 1
        },
        DesummonVoiceline = {
            SoundId = 13958000467,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 11126520965,
            Volume = 0
        },
        MeterUp4 = {
            SoundId = 11126521365,
            Volume = 0
        },
        BarrageVoiceline = {
            SoundId = 13958000882,
            Volume = 1.25
        },
        Barrage = {
            SoundId = 13958000710,
            Volume = 1.25
        },
        SliceStartSFX = {
            SoundId = 14043458708,
            Volume = 1
        },
        SliceStartVoice = {
            SoundId = 14043458411,
            Volume = 1
        },
        SliceVoice = {
            SoundId = 14043458533,
            Volume = 1
        },
        SliceSFX = {
            SoundId = 14043459115,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 14043399443,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14043399367,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14043399273,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14043399218,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 14043399443,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 14043399367,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 14043399273,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 14043399218,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 14043399158,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 14043399158,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 14043399158,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 14043399090,
            Volume = 1
        },
        EyeOfTheStormPrepare = {
            SoundId = 14043576551,
            Volume = 1
        },
        EyeOfTheStormReleaseVoice = {
            SoundId = 14043576669,
            Volume = 2
        },
        EyeOfTheStormReleaseSFX = {
            SoundId = 14043576276,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 14187246476,
            Volume = 1.5,
            Looped = true
        },
        RicochetShotAim = {
            SoundId = 14181697964,
            Volume = 2
        },
        RicochetShotFireSFX = {
            SoundId = 14043458780,
            Volume = 2
        },
        RicochetShotFireVoice = {
            SoundId = 14043458632,
            Volume = 2
        },
        TripleStrikeVoice = {
            SoundId = 14043578685,
            Volume = 2
        },
        TripleStrikeSFX = {
            SoundId = 14043579092,
            Volume = 2
        },
        VMoveStartSFX = {
            SoundId = 14043836044,
            Volume = 2
        },
        VMoveStartVoice = {
            SoundId = 14054163163,
            Volume = 2
        },
        VMoveLandedSFX = {
            SoundId = 14043835587,
            Volume = 2
        },
        VMoveLandedVoice = {
            SoundId = 14043835505,
            Volume = 2
        },
        RMoveDashSFX = {
            SoundId = 14043576413,
            Volume = 2
        },
        YMoveReturn = {
            SoundId = 14043835781,
            Volume = 2
        },
        YMoveHitVoice = {
            SoundId = 14054162715,
            Volume = 2
        },
        YMoveHitSFX = {
            SoundId = 14043835877,
            Volume = 2
        },
        YMoveDashSFX = {
            SoundId = 14043835967,
            Volume = 2
        },
        ArmorOffSfx = {
            SoundId = 14172933636,
            Volume = 2
        },
        ArmorOffVoice = {
            SoundId = 14172933772,
            Volume = 2
        },
        ArmorOffDashVoice = {
            SoundId = 13958000584,
            Volume = 2
        },
        ArmorOffDashSfx = {
            SoundId = 13197147319,
            Volume = 2
        },
        StartYMoveArmorOffSfx = {
            SoundId = 14043836044,
            Volume = 2
        },
        StartYMoveArmorOffVoice = {
            SoundId = 14054162906,
            Volume = 2
        },
        YMoveArmorOffSfx = {
            SoundId = 14054162838,
            Volume = 2
        },
        YMoveArmorOffVoice = {
            SoundId = 14054163032,
            Volume = 2
        },
        EnGardeSfx = {
            SoundId = 14043835414,
            Volume = 2
        },
        EnGardeVoice = {
            SoundId = 14043578931,
            Volume = 2
        },
        CounterStartup = {
            SoundId = 14043836396,
            Volume = 2
        },
        CounterVoice = {
            SoundId = 14043836203,
            Volume = 2
        },
        CounterSfx = {
            SoundId = 14043836309,
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
                    SoundId = "rbxassetid://14044025744",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Well, I only have bones. Yohoho!"
                        } }
                }, {
                    SoundId = "rbxassetid://14044025857",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Not quite there yet."
                        } }
                }, {
                    SoundId = "rbxassetid://14044025637",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m bone, so I\'m relaxed!"
                        } }
                } }
        }
    }
};