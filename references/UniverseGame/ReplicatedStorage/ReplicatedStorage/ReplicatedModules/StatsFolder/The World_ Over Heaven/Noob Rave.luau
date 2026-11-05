  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "The World: Over Heaven"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 17, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    v2.PoseMusic = "PoseMusic" .. math.random(1, 2);

                    return v2;
                end
            }
        },
        Mangle = {
            HitSounds = {
                Hit = {
                    SoundId = 13934036941,
                    Volume = 5
                }
            }
        },
        TMoves = {
            Mangle = {
                HitSounds = {
                    Hit = {
                        SoundId = 13934036941,
                        Volume = 5
                    }
                }
            }
        },
        ["Heavy Punch"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13934036805,
                    Volume = 5
                }
            }
        },
        ["Round Kick"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13955271815,
                    Volume = 2.5
                }
            }
        },
        ["Divine Retribution"] = {
            Barrage = {
                HitSounds = {
                    Hit = {
                        SoundId = 13955271815,
                        Volume = 3
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13934036805,
                        Volume = 5
                    }
                }
            }
        },
        ["Reality Overwrite"] = {
            HitSounds = {
                Hit = {
                    SoundId = 87332753914046,
                    Volume = 2.5
                }
            }
        },
        RMoves = {
            ["Heavy Punch"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13934036805,
                        Volume = 5
                    }
                }
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 13934036085,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13934036190,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13934037649,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13934036313,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 13934035843,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 13934037218,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 13934036435,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 13934037323,
            Volume = 1
        },
        ["StandOff-LMB-1-Voiceline"] = {
            SoundId = 13934035843,
            Volume = 1
        },
        ["StandOff-LMB-2-Voiceline"] = {
            SoundId = 13934037218,
            Volume = 1
        },
        ["StandOff-LMB-3-Voiceline"] = {
            SoundId = 13934036435,
            Volume = 1
        },
        ["StandOff-LMB-4-Voiceline"] = {
            SoundId = 13934037323,
            Volume = 1
        },
        SwingLMB = {
            SoundId = 7146792142,
            Volume = 1
        },
        Barrage = {
            SoundId = 7146792142,
            Volume = 1
        },
        ["Behind and Above Startup"] = {
            SoundId = 13955272330,
            Volume = 1
        },
        ["Behind and Above Strike"] = {
            SoundId = 13955272052,
            Volume = 1
        },
        ["Cataclysmic Throw Woosh"] = {
            SoundId = 13955272467,
            Volume = 1
        },
        ["Cataclysmic Throw Voice"] = {
            SoundId = 13955272113,
            Volume = 1
        },
        ["Immortal Strikes Voice"] = {
            SoundId = 13955272699,
            Volume = 1
        },
        ["Immortal Strikes Woosh"] = {
            SoundId = 13955273318,
            Volume = 1
        },
        ["Immortal Strikes Cutscene Voice"] = {
            SoundId = 13955272919,
            Volume = 1
        },
        ["Immortal Strikes Cutscene Woosh"] = {
            SoundId = 13955273238,
            Volume = 1
        },
        ["Fissure Woosh"] = {
            SoundId = 13955272609,
            Volume = 1
        },
        ["Fissure Voice"] = {
            SoundId = 13955272229,
            Volume = 1
        },
        KickVoice = {
            SoundId = 13955271626,
            Volume = 3
        },
        KickWindup = {
            SoundId = 13955271972,
            Volume = 2
        },
        ["Mangle Voice"] = {
            SoundId = 7146792142,
            Volume = 1
        },
        SummonSound = {
            SoundId = 7146792142,
            Volume = 1
        },
        SummonEffects = {
            SoundId = 13934036005,
            Volume = 1
        },
        Desummon = {
            SoundId = 13934037770,
            Volume = 1
        },
        DesummonVoiceline = {
            SoundId = 7146792142,
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = 13955274254,
            Volume = 1
        },
        ["Mangle Woosh"] = {
            SoundId = 13934037070,
            Volume = 1
        },
        ["Overwrite Infusion Woosh"] = {
            SoundId = 13934039653,
            Volume = 1
        },
        ["Overwrite Infusion Voice"] = {
            SoundId = 13934039499,
            Volume = 1
        },
        ["Heavy Punch Voice"] = {
            SoundId = 13934036569,
            Volume = 1
        },
        ["Heavy Punch Woosh"] = {
            SoundId = 13934036684,
            Volume = 1
        },
        ["Divine Thunder Voice"] = {
            SoundId = 13934038837,
            Volume = 1
        },
        ["Divine Thunder Woosh"] = {
            SoundId = 13934039190,
            Volume = 1
        },
        ["Timestop Voice"] = {
            SoundId = 13934038274,
            Volume = 1
        },
        ["Timestop Woosh"] = {
            SoundId = 13937141570,
            Volume = 1
        },
        ["Timestop Resume"] = {
            SoundId = 13934038635,
            Volume = 1
        },
        ["Rampage Force Voice"] = {
            SoundId = 7146792142,
            Volume = 1
        },
        ["Rampage Force Woosh"] = {
            SoundId = 13934038003,
            Volume = 1
        },
        ["Rampage Force Grab Voice"] = {
            SoundId = 7146792142,
            Volume = 1
        },
        ["Rampage Force Grab Woosh"] = {
            SoundId = 13934038141,
            Volume = 1
        },
        Teleport = {
            SoundId = 13937143280,
            Volume = 1
        },
        PoseMusic1 = {
            SoundId = 13955397267,
            Volume = 1,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.7
                }
            }
        },
        ThrowVoiceline = {
            SoundId = 13934035843,
            Volume = 2
        },
        PoseMusic2 = {
            SoundId = 13937143880,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 13955274132,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13955274003,
            Volume = 2
        },
        ["Death-Voiceline"] = {
            SoundId = ""
        },
        ["Divine Retribution Startup"] = {
            SoundId = 94778258682464,
            Volume = 2
        },
        ["Divine Retribution Startup Voice"] = {
            SoundId = 128058886868785,
            Volume = 2
        },
        ["Divine Retribution"] = {
            SoundId = 82790965581082,
            Volume = 2
        },
        ["Divine Retribution Voice"] = {
            SoundId = 127861435538617,
            Volume = 2
        },
        ["Reality Overwrite"] = {
            SoundId = 95845922367624,
            Volume = 2
        },
        ["Reality Overwrite Voice"] = {
            SoundId = 103552971107343,
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
                    SoundId = "rbxassetid://13955273081",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m a fire my laser! HOOIIII!"
                        } }
                }, {
                    SoundId = "rbxassetid://13955361042",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I saw the admin named bon is giving out free restores! So if you are hearing this bon, please restore my party starter and galizur."
                        } }
                }, {
                    SoundId = "rbxassetid://13955273682",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "* BAWABABAMP *"
                        } }
                }, {
                    SoundId = "rbxassetid://13955273789",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "2006 Honda Civic"
                        } }
                } }
        }
    }
};