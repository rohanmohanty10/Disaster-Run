  

 

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
                    v2.PoseMusic = "PoseMusic" .. math.random(1, 2);

                    return v2;
                end
            }
        },
        Chop = {
            HitSounds = {
                Hit = {
                    SoundId = 125705114881971,
                    Volume = 2
                }
            }
        },
        ["Sudden Blow"] = {
            Attack = {
                HitSounds = {
                    Hit = {
                        SoundId = 114536498245213,
                        Volume = 2
                    }
                }
            }
        }
    },
    Sounds = {
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://84945224886484",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonEffects = {
            SoundId = "rbxassetid://98434292661319",
            Volume = 2.25,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://0",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://121397412265498",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Desummon-Voiceline"] = {
            SoundId = "rbxassetid://77089753138825",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://0",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://0",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://0",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://0",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://11038125106",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://11038124864",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://11038212735",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://129152666783299",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://11157628753",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GrabVoiceline = {
            SoundId = "rbxassetid://0",
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
            SoundId = "rbxassetid://0",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://97048856784510",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlam = {
            SoundId = "rbxassetid://107003545466359",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlamVoiceline = {
            SoundId = "rbxassetid://104027007986696",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Impale = {
            SoundId = "rbxassetid://113426841859078",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ImpaleVoiceline = {
            SoundId = "rbxassetid://103491259872228",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Impaled = {
            SoundId = "rbxassetid://138726341845839",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Chop = {
            SoundId = "rbxassetid://81191958715605",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ChopVoiceline = {
            SoundId = "rbxassetid://125586837642608",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DownwardStrike = {
            SoundId = "rbxassetid://72218672956014",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DownwardStrikeVoiceline = {
            SoundId = "rbxassetid://108694165047229",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlow = {
            SoundId = "rbxassetid://109503187051183",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowRecall = {
            SoundId = "rbxassetid://112457891080130",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHitSkip = {
            SoundId = "rbxassetid://11107318541",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHit = {
            SoundId = "rbxassetid://129227051355885",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHitVoiceline = {
            SoundId = "rbxassetid://97209339161813",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowImpale = {
            SoundId = "rbxassetid://123331713504146",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowImpaleVoiceline = {
            SoundId = "rbxassetid://129168083851369",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipTeleport = {
            SoundId = "rbxassetid://97627242709243",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Foresight = {
            SoundId = "rbxassetid://113379408380715",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightVoiceline = {
            SoundId = "rbxassetid://125230104207773",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightEnd = {
            SoundId = "rbxassetid://126861474220860",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Witness = {
            SoundId = "rbxassetid://112785753306917",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessVoiceline = {
            SoundId = "rbxassetid://135305081841575",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessHit = {
            SoundId = "rbxassetid://107799139035418",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessHitVoiceline = {
            SoundId = "rbxassetid://100143484574906",
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
            SoundId = "rbxassetid://11107369239",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrabbedVoiceline = {
            SoundId = "rbxassetid://113994328246747",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeErase = {
            SoundId = "rbxassetid://77203123927304",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseVoiceline = {
            SoundId = "rbxassetid://115100955022071",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseAmbient = {
            SoundId = "rbxassetid://138381410599508",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseEnd = {
            SoundId = "rbxassetid://81236149191131",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseEndVoiceline = {
            SoundId = "rbxassetid://71952651145964",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipBlow = {
            SoundId = "rbxassetid://107221310714902",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipBlowEnd = {
            SoundId = "rbxassetid://72229700561616",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MeterUp3 = {
            SoundId = 123089930738269,
            PlaybackSpeed = 1,
            Volume = 1.5
        },
        MeterUp4 = {
            SoundId = 108392355170589,
            Volume = 1.5
        },
        PoseMusic1 = {
            SoundId = "rbxassetid://122508285766498",
            Volume = 2,
            Looped = true
        },
        PoseMusic2 = {
            SoundId = "rbxassetid://92653840336949",
            Volume = 2,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.505
                }
            }
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
            StandOn = { {
                    SoundId = "rbxassetid://113834066603786",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You will not be spared, you will not be saved.",
                            Timing = 0.05
                        } }
                }, {
                    SoundId = "rbxassetid://103011972843224",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I will vomit you back... To relive your horror!",
                            Timing = 0.05
                        } }
                }, {
                    SoundId = "rbxassetid://139857437669665",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I am you wickedness... Made of flesh.",
                            Timing = 0.05
                        } }
                }, {
                    SoundId = "rbxassetid://122747771517286",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I am here to claim... What is left of you.",
                            Timing = 0.05
                        } }
                } },
            StandOff = { {
                    SoundId = "rbxassetid://86771698834157",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Let\'s see how many times you can be pulled apart."
                        } }
                }, {
                    SoundId = "rbxassetid://70668247964833",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This time, there is more than an illusion to fear"
                        } }
                }, {
                    SoundId = "rbxassetid://88047317793693",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Let me put you back together, then take you apart all over again."
                        } }
                } }
        }
    }
};