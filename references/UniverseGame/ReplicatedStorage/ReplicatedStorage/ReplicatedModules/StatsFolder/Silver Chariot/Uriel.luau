  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Silver Chariot"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 15, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.PoseMusic = "StandOn-PoseMusic" .. math.random(1, 3);

                        return v2;
                    end;

                    v2.PoseMusic = "StandOff-PoseMusic" .. math.random(1, 3);

                    return v2;
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 135748010159491,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 135748010159491,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 135748010159491,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 95302199353500,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 135748010159491,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 135748010159491,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 135748010159491,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 95302199353500,
                        Volume = 1.5
                    }
                }
            }
        },
        Barrage = {
            Barrage = {
                Hit = {
                    HitSounds = {
                        Hit = {
                            SoundId = 112902387378994,
                            Volume = 1.5
                        }
                    }
                },
                Finisher = {
                    HitSounds = {
                        Hit = {
                            SoundId = 82171064927631,
                            Volume = 1.5
                        }
                    }
                }
            }
        },
        ["Triple Strike"] = {
            HitSounds = {
                Hit = {
                    SoundId = 75032585568687,
                    Volume = 1.5
                }
            },
            FinalHit = {
                HitSounds = {
                    Hit = {
                        SoundId = 111905934601041,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Immobilizing Slices"] = {
            ArmorOff = {
                HitSounds = {
                    Hit = {
                        SoundId = 75032585568687,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Ricochet Shot"] = {
            HitSounds = {
                Hit = {
                    SoundId = 111905934601041,
                    Volume = 1.5
                }
            }
        },
        ["Instant Slice"] = {
            HitSounds = {
                Hit = {
                    SoundId = 82171064927631,
                    Volume = 1.5
                }
            }
        },
        ["Eye Of The Storm"] = {
            HitSounds = {
                Hit = {
                    SoundId = 82171064927631,
                    Volume = 1.5
                }
            }
        },
        Clobber = {
            HitSounds = {
                Hit = {
                    SoundId = 104352113198443,
                    Volume = 1.5
                }
            }
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 91788495822940,
            Volume = 1
        },
        SummonSound = {
            SoundId = 99120890522806,
            Volume = 1
        },
        ["Death-Voiceline"] = {
            SoundId = 78390665019332,
            Volume = 1
        },
        Desummon = {
            SoundId = 111091828027878,
            Volume = 1
        },
        ["Desummon-Voiceline"] = {
            SoundId = 127563779390776,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 135875389646788,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 103514747229789,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 119855856861150,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 93149196037753,
            Volume = 1.25
        },
        Barrage = {
            SoundId = 107864760204730,
            Volume = 1.25
        },
        SliceStartSFX = {
            SoundId = 101997874124575,
            Volume = 1
        },
        SliceStartVoice = {
            SoundId = 10271926503,
            Volume = 0
        },
        SliceVoice = {
            SoundId = 96519224900576,
            Volume = 1
        },
        SliceSFX = {
            SoundId = 106522020014177,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 105732965763455,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 109343166524361,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 102975675768252,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 71833821144050,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 81246929458490,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 119451225732623,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 116119782828832,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 72865041173070,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 105732965763455,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 109343166524361,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 102975675768252,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 71833821144050,
            Volume = 1
        },
        EyeOfTheStormPrepare = {
            SoundId = 113287666529627,
            Volume = 1
        },
        ["EyeOfTheStormPrepare-Voiceline"] = {
            SoundId = 71272477486399,
            Volume = 1
        },
        EyeOfTheStormHold = {
            SoundId = 100969570487326,
            Volume = 1
        },
        EyeOfTheStormReleaseVoice = {
            SoundId = 99867886165075,
            Volume = 2
        },
        EyeOfTheStormReleaseSFX = {
            SoundId = 130264432410135,
            Volume = 2
        },
        RicochetShotAim = {
            SoundId = 79447463908933,
            Volume = 2
        },
        RicochetShotFireSFX = {
            SoundId = 79447463908933,
            Volume = 0
        },
        RicochetShotFireVoice = {
            SoundId = 123260118444054,
            Volume = 0
        },
        RicochetShotAimVoice = {
            SoundId = 123260118444054,
            Volume = 2
        },
        ["RicochetShotAO-Aim"] = {
            SoundId = 82866358849163,
            Volume = 2
        },
        ["RicochetShotAO-Shoot"] = {
            SoundId = 122640481025364,
            Volume = 2
        },
        TripleStrikeVoice = {
            SoundId = 11165385689,
            Volume = 0
        },
        TripleStrikeSFX = {
            SoundId = 110936130678066,
            Volume = 2
        },
        VMoveStartSFX = {
            SoundId = 127295642773169,
            Volume = 2
        },
        VMoveStartVoice = {
            SoundId = 82657363392848,
            Volume = 2
        },
        VMoveLandedSFX = {
            SoundId = 114120401959268,
            Volume = 2
        },
        VMoveLandedVoice = {
            SoundId = 127721494270046,
            Volume = 2
        },
        RMoveDashSFX = {
            SoundId = 96594580027301,
            Volume = 2
        },
        YMoveReturn = {
            SoundId = 11309338502,
            Volume = 2
        },
        YMoveHitVoice = {
            SoundId = 138146519083931,
            Volume = 2
        },
        YMoveHitSFX = {
            SoundId = 96287225703698,
            Volume = 2
        },
        YMoveDashSFX = {
            SoundId = 96898508447487,
            Volume = 2
        },
        ArmorOffSfx = {
            SoundId = 70778708624679,
            Volume = 2
        },
        ArmorOffVoice = {
            SoundId = 94428201978001,
            Volume = 2
        },
        ArmorOffMusic = {
            SoundId = 122249994414262,
            Volume = 2
        },
        ArmorOffDashVoice = {
            SoundId = 93215584995352,
            Volume = 2
        },
        ArmorOffDashSfx = {
            SoundId = 91869760297221,
            Volume = 2
        },
        StartYMoveArmorOffSfx = {
            SoundId = 76550906167275,
            Volume = 2
        },
        StartYMoveArmorOffVoice = {
            SoundId = 82657363392848,
            Volume = 2
        },
        YMoveArmorOffSfx = {
            SoundId = 70621094510266,
            Volume = 2
        },
        YMoveArmorOffVoice = {
            SoundId = 127721494270046,
            Volume = 2
        },
        EnGardeSfx = {
            SoundId = 134719755585620,
            Volume = 2
        },
        EnGardeVoice = {
            SoundId = 85395436981467,
            Volume = 2
        },
        CounterStartup = {
            SoundId = 99899223217546,
            Volume = 2
        },
        CounterVoice = {
            SoundId = 87220799058041,
            Volume = 2
        },
        CounterSfx = {
            SoundId = 76511508127455,
            Volume = 2
        },
        ["StandOff-PoseMusic1"] = {
            SoundId = 113445917222913,
            Volume = 2,
            Looped = true
        },
        ["StandOff-PoseMusic2"] = {
            SoundId = 90458224522789,
            Volume = 2,
            Looped = true
        },
        ["StandOff-PoseMusic3"] = {
            SoundId = 88268336712063,
            Volume = 2,
            Looped = true
        },
        ["StandOn-PoseMusic1"] = {
            SoundId = 75805477750577,
            Volume = 2,
            Looped = true
        },
        ["StandOn-PoseMusic2"] = {
            SoundId = 139873714154673,
            Volume = 2,
            Looped = true
        },
        ["StandOn-PoseMusic3"] = {
            SoundId = 74791811474073,
            Volume = 2,
            Looped = true
        }
    },
    Animations = {
        Idle = {
            ["Wing Flail"] = 125046999253779
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
                    SoundId = "rbxassetid://77809645210116",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Now THIS is a fight worthy of God\'s will!"
                        } }
                },
                {
                    SoundId = "rbxassetid://90280105247511",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What IS this FEELING..? *laughter"
                        } }
                },
                {
                    SoundId = "rbxassetid://102842396366741",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Is that the best you\'ve GOT!? *laughter"
                        } }
                },
                {
                    SoundId = "rbxassetid://70819732731936",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "May your woes be many...and your days few."
                        } }
                },
                {
                    SoundId = "rbxassetid://115338002486237",
                    SoundVolume = 2,
                    YieldSound = true,
                    MaxYield = 15,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Machine...I will cut. You. Down. Break you apart, spray the gore of your profane form across the stars! I will grind GRIND you down until the very SPARKS cry for mercy! My hands shall RELISH ENDING YOU, HERE. AND. NOW!!! "
                        } }
                }
            }
        }
    }
};