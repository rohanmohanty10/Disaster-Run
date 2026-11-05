  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return {
    Inherit = {
        AbilityName = "Star Platinum"
    },
    Stats = {
        Summon = {
            LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 119, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 63, 172)) })
        },
        Pose = {
            MusicAmount = 4,
            Callbacks = {
                Transformer = function(p1) -- Line: 24, Name: Transformer
                    -- upvalues: Knit (copy), AssetHandler (copy)
                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        local v2 = AssetHandler.CloneAsset("Models/ion blaster", p1);
                        v2.Parent = p1.Character;
                        v2:PivotTo(p1.Character.Stand["Stand Right Arm"].CFrame * CFrame.new(0, -1.7, -1) * CFrame.Angles(0, 0, 1.5707963267948966));
                        v2.Cube.Anchored = false;
                        v2.Cube.WeldConstraint.Part0 = p1.Character.Stand["Stand Right Arm"];
                        p1.Trove:Add(v2);
                    end;

                    return p1.Stats;
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 108008687774179,
                        Volume = 3
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 78856968628411,
                        Volume = 3
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 108008687774179,
                        Volume = 3
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 78856968628411,
                        Volume = 3
                    }
                }
            }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 80935181662694,
                        Volume = 2
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 115787222395142,
                        Volume = 3
                    }
                }
            }
        },
        ["Star Breaker"] = {
            HitSounds = {
                Hit = {
                    SoundId = 139366020611471,
                    Volme = 5
                }
            }
        },
        ["Lock Kick"] = {
            HitSounds = {
                Hit = {
                    SoundId = 88628664034720,
                    Volme = 3
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 91776264429682,
                        Volme = 3
                    }
                }
            }
        },
        ["Star Finger"] = {
            HitSounds = {
                Hit = {
                    SoundId = 119733579903330,
                    Volme = 3
                }
            }
        },
        ["Evil Spirit"] = {
            HitSounds = {
                Hit = {
                    SoundId = 140382992754897,
                    Volme = 5
                }
            }
        }
    },
    Animations = {
        Action = {
            PoseIdle = 80514355923436,
            PoseTransition = 99719970913827
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 96940215882980,
            Volume = 2
        },
        SummonSound = {
            SoundId = "",
            Volume = 0
        },
        Desummon = {
            SoundId = 111851495157445,
            Volume = 2
        },
        ThrowVoiceline = {
            SoundId = "",
            Volume = 0
        },
        BarrageVoiceline = {
            SoundId = 108311277074822,
            Volume = 3.5
        },
        ["Star Finger Voiceline"] = {
            SoundId = 88855944581930,
            Volume = 3.5
        },
        ["Star Finger Whoosh"] = {
            SoundId = 111846513632993,
            Volume = 2
        },
        ["Star Breaker Voiceline"] = {
            SoundId = 78023974644051,
            Volume = 3.5
        },
        ["Star Breaker Whoosh"] = {
            SoundId = 110021216276586,
            Volume = 2
        },
        ["Inhale Voiceline"] = {
            SoundId = 117139186814976,
            Volume = 3.5
        },
        Inhale = {
            SoundId = 113898166901248,
            Volume = 2,
            Looped = false
        },
        ["Ora Slam Voiceline"] = {
            SoundId = 117657978398274,
            Volume = 3.5
        },
        ["Ora Slam Whoosh"] = {
            SoundId = 109320489581658,
            Volume = 2
        },
        ["Ora Slam SFX"] = {
            SoundId = 119249034778399,
            Volume = 2
        },
        LockKickWoosh = {
            SoundId = 117484695437165,
            Volume = 2
        },
        LockKickVoice = {
            SoundId = 129259208397945,
            Volume = 3.5
        },
        LockKickDiscard = {
            SoundId = "",
            Volume = 0
        },
        ["BeatdownAttempt-Voiceline"] = {
            SoundId = 107266829135581,
            Volume = 3.5
        },
        BeatdownAttempt = {
            SoundId = 120161908375694,
            Volume = 2
        },
        Beatdown = {
            SoundId = 87340409336051,
            Volume = 2
        },
        ["Beatdown-Voiceline"] = {
            SoundId = 91148715149958,
            Volume = 3.5
        },
        ClashVoiceline = {
            SoundId = "",
            Volume = 0
        },
        ["Brute Force"] = {
            SoundId = 117359645604475,
            Volume = 2
        },
        ["Brute Force Voiceline"] = {
            SoundId = 115711520770849,
            Volume = 3.5
        },
        ["Brute Force Grab"] = {
            SoundId = 125351181766113,
            Volume = 2
        },
        ["Brute Force Grab Voiceline"] = {
            SoundId = 88527892706430,
            Volume = 3.5
        },
        MeterUp3 = {
            SoundId = 77993970162975,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 85568352020217,
            Volume = 2
        },
        DeathSound = {
            SoundId = "",
            Volume = 0
        },
        Teleport = {
            SoundId = 73256816526054,
            Volume = 2
        },
        Timestop = {
            SoundId = 91105519014595,
            Volume = 2
        },
        ["Timestop Voiceline"] = {
            SoundId = 78834057783720,
            Volume = 4
        },
        ["Timestop End Voiceline"] = {
            SoundId = "",
            Volume = 0
        },
        ["Timestop SFX"] = {
            SoundId = 92389589304709,
            Volume = 3
        },
        ["Timestop End SFX"] = {
            SoundId = 115515605334224,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 120509306493851,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 86517052725767,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 108336989522810,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 124730233365547,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 101174423840955,
            Volume = 3.5
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 87007708670534,
            Volume = 3.5
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 105424502703325,
            Volume = 3.5
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 87777811097782,
            Volume = 3.5
        },
        ["SwingLMB 1-3"] = {
            SoundId = "",
            Volume = 0
        },
        ["SwingLMB 4"] = {
            SoundId = "",
            Volume = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = 120509306493851,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 86517052725767,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 108336989522810,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 124730233365547,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = "",
            Volume = 0
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = "",
            Volume = 0
        },
        ["Evil Spirit Voiceline"] = {
            SoundId = 83738171633664,
            Volume = 3.5
        },
        ["Evil Spirit Equip"] = {
            SoundId = 71714571394692,
            Volume = 2
        },
        ["Evil Spirit Shoot"] = {
            SoundId = 98456290130791,
            Volume = 2
        },
        GrabSlamVoice = {
            SoundId = "",
            Volume = 0
        },
        GrabSlamWoosh = {
            SoundId = 122296893010784,
            Volume = 2
        },
        GrabSlam = {
            SoundId = 124684631093169,
            Volume = 2
        },
        GrabSlamVoicelineHit = {
            SoundId = 70463105487346,
            Volume = 3.5
        },
        ["PoseMusic-1"] = {
            SoundId = 99732772963646,
            Volume = 2.5,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.325
                }
            }
        },
        ["PoseMusic-2"] = {
            SoundId = 111186051244653,
            Volume = 2.5,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.325
                }
            }
        },
        ["PoseMusic-3"] = {
            SoundId = 81667413932809,
            Volume = 2.5,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.325
                }
            }
        },
        ["PoseMusic-4"] = {
            SoundId = 130070143960162,
            Volume = 2.5,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.446
                }
            }
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
                    SoundId = "rbxassetid://124274794952626",
                    SoundVolume = 4,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "We\'re ugobots, were from cybertron. A planet far from earth.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://135566171515539",
                    SoundVolume = 4,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "One shall stand, one shall fall.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://93961093040657",
                    SoundVolume = 4,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Autobots. Transform! And Roll Out!",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://110425182106707",
                    SoundVolume = 4,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I am Optimus Prime. Leader of the Autobots!",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://117666241884182",
                    SoundVolume = 4,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "There\'s a thin line between being a hero and being a memory.",
                            ScaleTime = 1
                        } }
                } }
        }
    }
};