  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "King Crimson"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 16, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    v2.PoseMusic = "PoseMusic" .. math.random(1, 5);

                    return v2;
                end
            }
        }
    },
    Animations = {
        Action = {
            ["Doppio Slam"] = 10481557367,
            Donut = 10481548729,
            ["Donut Hit"] = 10533238402,
            Chop = 13622736410,
            ["Time Erase"] = 10491412549,
            PoseIdle = 10481612539,
            PoseTransition = 10481609861,
            ImpaleAttempt = 13622661245,
            Impale = 13622688279,
            GroundSlam = 13622778164
        },
        Movement = {
            Walk = 10481590694,
            SummonedWalk = 10481594496,
            SummonedRun = 10481577718
        },
        Idle = {
            Run = 10481567308,
            Idle = 10481604943,
            SummonedIdle = 10481600666
        }
    },
    Sounds = {
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://10535119702",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://10535119104",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://10535120478",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://10535114165",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://10535114965",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://10535115771",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://10535116431",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://13528394260",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://13528395180",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://13528396303",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://13528397375",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://13528466977",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GrabVoiceline = {
            SoundId = "rbxassetid://13701843044",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Grabbed = {
            SoundId = "rbxassetid://10906275262",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ScalpelThrowVoiceline = {
            SoundId = "rbxassetid://13701843871",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://13528467825",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlam = {
            SoundId = "rbxassetid://13528468800",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlamVoiceline = {
            SoundId = "rbxassetid://13528469781",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Impale = {
            SoundId = "rbxassetid://13527007718",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ImpaleVoiceline = {
            SoundId = "rbxassetid://13527009409",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Impaled = {
            SoundId = "rbxassetid://13527007201",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Chop = {
            SoundId = "rbxassetid://13528196918",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ChopVoiceline = {
            SoundId = "rbxassetid://13528197865",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DownwardStrike = {
            SoundId = "rbxassetid://13528195986",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DownwardStrikeVoiceline = {
            SoundId = "rbxassetid://13187503101",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlow = {
            SoundId = "rbxassetid://13528280250",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowRecall = {
            SoundId = "rbxassetid://13528281327",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHitSkip = {
            SoundId = "rbxassetid://13528279262",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHit = {
            SoundId = "rbxassetid://13528286462",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHitVoiceline = {
            SoundId = "rbxassetid://13528356953",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowImpale = {
            SoundId = "rbxassetid://13528341420",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowImpaleVoiceline = {
            SoundId = "rbxassetid://13528355874",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipTeleport = {
            SoundId = "rbxassetid://13528279262",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Foresight = {
            SoundId = "rbxassetid://13650641060",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightVoiceline = {
            SoundId = "rbxassetid://13528528001",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightEnd = {
            SoundId = "rbxassetid://13528528614",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Witness = {
            SoundId = "rbxassetid://13528659195",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessHit = {
            SoundId = "rbxassetid://13528576828",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessHitVoiceline = {
            SoundId = "rbxassetid://13528575951",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrab = {
            SoundId = "rbxassetid://11107368895",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrabbed = {
            SoundId = "rbxassetid://13528525348",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrabbedVoiceline = {
            SoundId = "rbxassetid://13528526219",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeErase = {
            SoundId = "rbxassetid://13528449453",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseVoiceline = {
            SoundId = "rbxassetid://13528448419",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseAmbient = {
            SoundId = "rbxassetid://13528450652",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseEnd = {
            SoundId = "rbxassetid://13528451706",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipBlow = {
            SoundId = "rbxassetid://13650473358",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipBlowEnd = {
            SoundId = "rbxassetid://13650474551",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MeterUp3 = {
            SoundId = 13650505015,
            PlaybackSpeed = 0.935,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13528200389,
            Volume = 2
        },
        PoseMusic1 = {
            SoundId = "rbxassetid://14113066274",
            Volume = 2,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.68
                }
            }
        },
        PoseMusic2 = {
            SoundId = "rbxassetid://14113077825",
            Volume = 2,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.68
                }
            }
        },
        PoseMusic3 = {
            SoundId = "rbxassetid://13526790748",
            Volume = 2,
            Looped = true
        },
        PoseMusic4 = {
            SoundId = "rbxassetid://13526811795",
            Volume = 2,
            Looped = true
        },
        PoseMusic5 = {
            SoundId = "rbxassetid://134367676023000",
            Volume = 2,
            Looped = true,
            PlaybackSpeed = 1.53
        }
    },
    QuoteInfo = {
        Groups = {
            StandOff = {
                Visible = true
            },
            StandOn = {
                Visible = false
            }
        },
        Quotes = {
            StandOn = {
                {
                    SoundId = "rbxassetid://10585996548",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Such a trash ability!",
                            Timing = 0.05
                        } }
                },
                {
                    SoundId = "rbxassetid://10585997190",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Fate has decreed that I stand at the apex!",
                            ScaleTime = 2
                        }, {
                            Quote = "",
                            EndLag = 0
                        } }
                },
                {
                    SoundId = "rbxassetid://10585997819",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You should leave this place.",
                            ScaleTime = 1.5
                        }, {
                            Quote = " Or else you will meet your end.",
                            ScaleTime = 1.5
                        } }
                },
                {
                    SoundId = "rbxassetid://10586001042",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Try and erase it",
                            ScaleTime = 1
                        }, {
                            Quote = ", but the past can never",
                            ScaleTime = 1
                        }, {
                            Quote = " be truly extinguished.",
                            ScaleTime = 2
                        } }
                },
                {
                    SoundId = "rbxassetid://10586001872",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Those who know",
                            ScaleTime = 1,
                            EndLag = 2
                        }, {
                            Quote = " my true nature",
                            ScaleTime = 1,
                            EndLag = 2.5
                        }, {
                            Quote = " cannot be left alive.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://10614899351",
                    SoundVolume = 5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "🗿"
                        } }
                }
            },
            StandOff = { {
                    SoundId = "rbxassetid://13528413418",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re a joke."
                        } }
                }, {
                    SoundId = "rbxassetid://13528414554",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Power is everything."
                        } }
                }, {
                    SoundId = "rbxassetid://13528415620",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re wasting my time. "
                        } }
                }, {
                    SoundId = "rbxassetid://13528416394",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "FOUR OF A KIND"
                        } }
                } }
        }
    }
};