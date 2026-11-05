  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "King Crimson"
    },
    Animations = {
        Action = {
            PoseIdle = 135416909701294,
            PoseTransition = 100247377610059
        },
        Movement = {
            Walk = 101687666595472,
            SummonedWalk = 101687666595472,
            Run = 129177008869510,
            SummonedRun = 129177008869510
        },
        Idle = {
            Idle = 140361401923643,
            SummonedIdle = 140361401923643
        }
    },
    Stats = {
        Summon = {
            VoicelineRange = 2,
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(229, 140, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 209, 70)) })
        },
        Pose = {
            MusicAmount = 5
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 72486480184453,
                        Volume = 3.25
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 117999318798074,
                        Volume = 2.5
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 97109134010799,
                        Volume = 2.5
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 100434756767218,
                        Volume = 2.5
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 133591725272830,
                        Volume = 2.5
                    }
                }
            },
            ["StandOff-LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 96612354761063,
                        Volume = 2.5
                    }
                }
            },
            ["StandOff-LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 91800833353138,
                        Volume = 2.5
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 111408396153418,
                        Volume = 2.5
                    }
                }
            }
        },
        Barrage = {
            VoicelineRange = 2,
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 84147569220278,
                        Volume = 2
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 71897296161015,
                        Volume = 3.5
                    }
                }
            }
        },
        Chop = {
            VoicelineRange = 2,
            HitSounds = {
                Hit = {
                    SoundId = 87120249189487,
                    Volume = 2
                }
            }
        },
        ["Cleaving Strikes"] = {
            VoicelineRange = 2,
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 140330197508324,
                        Volume = 2
                    }
                }
            },
            Second_Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 73642353074028,
                        Volume = 2
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 78176612279758,
                        Volume = 2
                    }
                }
            }
        },
        Foresight = {
            VoicelineRange = 2,
            VoicelineSummonStatus = true
        },
        Witness = {
            VoicelineRange = 2,
            VoicelineSummonStatus = true
        },
        ["Ground Slam"] = {
            VoicelineRange = 2
        },
        Impale = {
            VoicelineRange = 2
        },
        ["Fierce Grab"] = {
            VoicelineRange = 2
        },
        ["Downward Strike"] = {
            VoicelineRange = 2
        },
        ["Sudden Blow"] = {
            VoicelineRange = 2
        },
        ["Scalpel Throw"] = {
            VoicelineRange = 2,
            HitSounds = {
                Hit = {
                    SoundId = 119929399142288,
                    Volume = 0.5
                }
            }
        },
        ["Timeskip Blow"] = {
            VoicelineRange = 2,
            VoicelineSummonStatus = true
        },
        ["Time Erase"] = {
            VoicelineRange = 2,
            VoicelineSummonStatus = true
        }
    },
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = 10505779013,
            Volume = 3,
            Looped = true,
            PlaybackSpeed = 1,
            SoundEffects = {}
        },
        ["PoseMusic-2"] = {
            SoundId = 18494185445,
            Volume = 3,
            Looped = true,
            PlaybackSpeed = 1,
            SoundEffects = {}
        },
        ["PoseMusic-3"] = {
            SoundId = 117561665392435,
            Volume = 3,
            Looped = true,
            PlaybackSpeed = 1,
            SoundEffects = {}
        },
        ["PoseMusic-4"] = {
            SoundId = 98430644356221,
            Volume = 3,
            Looped = true,
            PlaybackSpeed = 1,
            SoundEffects = {}
        },
        ["PoseMusic-5"] = {
            SoundId = 90611751890537,
            Volume = 3,
            Looped = true,
            PlaybackSpeed = 1,
            SoundEffects = {}
        },
        SummonSound = {
            SoundId = ""
        },
        ["Summon-Voiceline-1"] = {
            SoundId = 101427262700327,
            Volume = 3.15,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Summon-Voiceline-2"] = {
            SoundId = 115612438228231,
            Volume = 3.15
        },
        SummonEffects = {
            SoundId = 100581869836587,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = 97568463063939,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Desummon-Voiceline-1"] = {
            SoundId = 119046763971893,
            Volume = 3.15,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Desummon-Voiceline-2"] = {
            SoundId = 108349831071624,
            Volume = 3.15
        },
        ["LMB-1"] = {
            SoundId = 82377628590503,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = ""
        },
        ["LMB-2"] = {
            SoundId = 123403720669809,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = ""
        },
        ["LMB-3"] = {
            SoundId = 81652340943220,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = ""
        },
        ["LMB-4"] = {
            SoundId = 125552202152216,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = ""
        },
        ["StandOff-LMB-1"] = {
            SoundId = 121597698166515,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = 96471756646155,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = 74515918919655,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = 101950045091755,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOn-Death-Voiceline"] = {
            SoundId = 78219540817461,
            Volume = 6
        },
        ["StandOff-Death-Voiceline"] = {
            SoundId = 77327136223520,
            Volume = 6
        },
        Barrage = {
            SoundId = 93976404576368,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = ""
        },
        ["BarrageVoiceline-1"] = {
            SoundId = 139710776725227,
            Volume = 3.15
        },
        ["BarrageVoiceline-2"] = {
            SoundId = 102916468739504,
            Volume = 3.15
        },
        Chop = {
            SoundId = 124560663388440,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ChopVoiceline = {
            SoundId = ""
        },
        ["ChopVoiceline-1"] = {
            SoundId = 105865716049367,
            Volume = 3.15
        },
        ["ChopVoiceline-2"] = {
            SoundId = 127055560127343,
            Volume = 3.15
        },
        CleavingStrikes = {
            SoundId = 88185638921361,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["CleavingStrikesVoiceline-1"] = {
            SoundId = 102292872802682,
            Volume = 3.15
        },
        ["CleavingStrikesVoiceline-2"] = {
            SoundId = 76938592492465,
            Volume = 3.15
        },
        Foresight = {
            SoundId = 108553169874888,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightAmbience = {
            SoundId = 120186111788333,
            Volume = 3
        },
        ForesightVoiceline = {
            SoundId = ""
        },
        ["StandOn-ForesightVoiceline-1"] = {
            SoundId = 81313883889205,
            Volume = 3.15
        },
        ["StandOn-ForesightVoiceline-2"] = {
            SoundId = 90613950654020,
            Volume = 3.15
        },
        ["StandOff-ForesightVoiceline-1"] = {
            SoundId = 128719682410599,
            Volume = 3.15
        },
        ["StandOff-ForesightVoiceline-2"] = {
            SoundId = 105420710213043,
            Volume = 3.15
        },
        ForesightEnd = {
            SoundId = ""
        },
        Witness = {
            SoundId = 114931859797524,
            Volume = 2.25,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-WitnessVoiceline-1"] = {
            SoundId = 115988461911371,
            Volume = 3.15
        },
        ["StandOff-WitnessVoiceline-2"] = {
            SoundId = 137087356206753,
            Volume = 3.15
        },
        ["StandOn-WitnessVoiceline-1"] = {
            SoundId = 109171384137080,
            Volume = 3.15
        },
        ["StandOn-WitnessVoiceline-2"] = {
            SoundId = 116340348426836,
            Volume = 3.15
        },
        WitnessHit = {
            SoundId = 136172569339289,
            Volume = 3.25,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessHitVoiceline = {
            SoundId = ""
        },
        ["StandOff-WitnessHitVoiceline-1"] = {
            SoundId = 106977915373308,
            Volume = 3.15
        },
        ["StandOff-WitnessHitVoiceline-2"] = {
            SoundId = 92908927079802,
            Volume = 3.15
        },
        ["StandOn-WitnessHitVoiceline-1"] = {
            SoundId = 116865529048087,
            Volume = 3.15
        },
        ["StandOn-WitnessHitVoiceline-2"] = {
            SoundId = 72469646307027,
            Volume = 3.15
        },
        GroundSlam = {
            SoundId = 103798104686267,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlamImpact = {
            SoundId = 112381662214481,
            Volume = 2
        },
        GroundSlamVoiceline = {
            SoundId = ""
        },
        ["GroundSlamVoiceline-1"] = {
            SoundId = 123128375274058,
            Volume = 4
        },
        ["GroundSlamVoiceline-2"] = {
            SoundId = 80565286919331,
            Volume = 4
        },
        Impale = {
            SoundId = 87299472625079,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ImpaleVoiceline = {
            SoundId = ""
        },
        ["ImpaleVoiceline-1"] = {
            SoundId = 132408551421455,
            Volume = 3.15
        },
        ["ImpaleVoiceline-2"] = {
            SoundId = 96085208548758,
            Volume = 3.15
        },
        Impaled = {
            SoundId = 94394221335205,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["ImpaledVoiceline-1"] = {
            SoundId = 85652255264503,
            Volume = 3.15
        },
        ["ImpaledVoiceline-2"] = {
            SoundId = 136937177547392,
            Volume = 3.15
        },
        FierceGrab = {
            SoundId = 108190676702095,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FierceGrabVoiceline-1"] = {
            SoundId = 125339525441140,
            Volume = 3.15
        },
        ["FierceGrabVoiceline-2"] = {
            SoundId = 107438251986971,
            Volume = 3.15
        },
        FierceGrabbed = {
            SoundId = 85052177184889,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrabbedVoiceline = {
            SoundId = ""
        },
        ["FierceGrabbedVoiceline-1"] = {
            SoundId = 82626724043460,
            Volume = 3.15
        },
        ["FierceGrabbedVoiceline-2"] = {
            SoundId = 78832687420949,
            Volume = 3.15
        },
        DownwardStrike = {
            SoundId = 128985443667842,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DownwardStrikeImpact = {
            SoundId = 74306843618595,
            Volume = 2
        },
        DownwardStrikeVoiceline = {
            SoundId = ""
        },
        ["DownwardStrikeVoiceline-1"] = {
            SoundId = 127069047709163,
            Volume = 3.15
        },
        ["DownwardStrikeVoiceline-2"] = {
            SoundId = 138317607897173,
            Volume = 3.15
        },
        SuddenBlow = {
            SoundId = 109488555094275,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["SuddenBlowVoiceline-1"] = {
            SoundId = 137302684220054,
            Volume = 3.15
        },
        ["SuddenBlowVoiceline-2"] = {
            SoundId = 128631525592706,
            Volume = 3.15
        },
        SuddenBlowHitSkip = {
            SoundId = 90704114766126,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHit = {
            SoundId = ""
        },
        SuddenBlowHitVoiceline = {
            SoundId = ""
        },
        ["SuddenBlowHitVoiceline-1"] = {
            SoundId = 92909836046524,
            Volume = 3.15
        },
        ["SuddenBlowHitVoiceline-2"] = {
            SoundId = 75061335520124,
            Volume = 3.15
        },
        SuddenBlowImpale = {
            SoundId = 96365361925907,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowImpaleVoiceline = {
            SoundId = ""
        },
        ["SuddenBlowImpaleVoiceline-1"] = {
            SoundId = 109050475105480,
            Volume = 3.15
        },
        ["SuddenBlowImpaleVoiceline-2"] = {
            SoundId = 133237680462380,
            Volume = 3.15
        },
        ScalpelThrow = {
            SoundId = 107797397234912,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ScalpelThrowVoiceline = {
            SoundId = ""
        },
        ["ScalpelThrowVoiceline-1"] = {
            SoundId = 74741297233124,
            Volume = 3.15
        },
        ["ScalpelThrowVoiceline-2"] = {
            SoundId = 98973524434705,
            Volume = 3.15
        },
        TimeSkipBlow = {
            SoundId = 92287336496049,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOn-TimeSkipBlowVoiceline-1"] = {
            SoundId = 85831403905179,
            Volume = 3.15
        },
        ["StandOn-TimeSkipBlowVoiceline-2"] = {
            SoundId = 131987366075764,
            Volume = 3.15
        },
        ["StandOff-TimeSkipBlowVoiceline-1"] = {
            SoundId = 139466111158687,
            Volume = 3.15
        },
        ["StandOff-TimeSkipBlowVoiceline-2"] = {
            SoundId = 79204808017506,
            Volume = 3.15
        },
        TimeSkipBlowEnd = {
            SoundId = 122224650745686,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeErase = {
            SoundId = 92398148614754,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseActivate = {
            SoundId = 132737888411258,
            Volume = 2
        },
        TimeEraseVoiceline = {
            SoundId = ""
        },
        ["StandOn-TimeEraseVoicelinePanic"] = {
            SoundId = 116086316067301,
            Volume = 3.15
        },
        ["StandOff-TimeEraseVoicelinePanic"] = {
            SoundId = 134803608611070,
            Volume = 3.15
        },
        ["StandOn-TimeEraseVoiceline-1"] = {
            SoundId = 76392208855827,
            Volume = 3.15
        },
        ["StandOn-TimeEraseVoiceline-2"] = {
            SoundId = 111218535612690,
            Volume = 3.15
        },
        ["StandOff-TimeEraseVoiceline-1"] = {
            SoundId = 106361416034079,
            Volume = 3.15
        },
        ["StandOff-TimeEraseVoiceline-2"] = {
            SoundId = 117290096927626,
            Volume = 3.15
        },
        TimeEraseAmbient = {
            SoundId = 119790813077891,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseAmbientPanic = {
            SoundId = 104987889246525,
            Volume = 2
        },
        TimeEraseEnd = {
            SoundId = 135088920361860,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOn-TimeEraseEndVoiceline-1"] = {
            SoundId = 112298860608695,
            Volume = 3.15
        },
        ["StandOn-TimeEraseEndVoiceline-2"] = {
            SoundId = 87169066156789,
            Volume = 3.15
        },
        ["StandOff-TimeEraseEndVoiceline-1"] = {
            SoundId = 126623927211510,
            Volume = 3.15
        },
        ["StandOff-TimeEraseEndVoiceline-2"] = {
            SoundId = 107343713446046,
            Volume = 3.15
        },
        MeterUp1 = {
            SoundId = ""
        },
        MeterUp2 = {
            SoundId = 133588218897274,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = ""
        },
        MeterUp4 = {
            SoundId = 106146233775152,
            Volume = 2
        },
        TimeSkipTeleport = {
            SoundId = 71604929806287,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Grabbed = {
            SoundId = ""
        }
    },
    QuoteInfo = require(script.Quotes)
};