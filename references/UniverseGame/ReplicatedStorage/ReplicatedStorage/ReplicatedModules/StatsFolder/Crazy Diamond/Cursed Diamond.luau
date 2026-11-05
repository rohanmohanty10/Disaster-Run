  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Crazy Diamond"
    },
    Stats = {
        Summon = {
            LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(67, 49, 106)), ColorSequenceKeypoint.new(1, Color3.fromRGB(118, 71, 172)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17896463223",
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14220381690,
                        Volume = 1
                    }
                }
            }
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 40, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    v2.PoseMusic = "PoseMusic" .. Random.new():NextInteger(1, 2);

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.StartAnim = "StandPoseTransition";
                        v2.LoopAnim = "StandPoseIdle";
                        v2.PoseMusic = "StandPoseMusic" .. Random.new():NextInteger(1, 2);
                    end;

                    return v2;
                end
            }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17896462347",
                        Volume = 1
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17896462113",
                        Volume = 1
                    }
                }
            }
        },
        ["Duplex Combination"] = {
            Punch = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17888439180",
                        Volume = 2
                    }
                }
            }
        },
        ["Reverse Healing"] = {
            Knock = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17898271094",
                        Volume = 2
                    }
                }
            }
        },
        ["Destructive Blitz"] = {
            Punch = {
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://17888469601",
                        Volume = 2
                    }
                }
            }
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = "rbxassetid://17896458988",
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://17896460573",
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = "rbxassetid://17896460840",
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 17487725438,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://17896459251",
            Volume = 2
        },
        ["LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://17896461359",
            Volume = 2
        },
        ["LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://17896461110",
            Volume = 2
        },
        ["LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://17896460184",
            Volume = 2
        },
        ["Bearing Shot Voiceline"] = {
            SoundId = "rbxassetid://17896462598",
            Volume = 2
        },
        ["Precise Shards SFX"] = {
            SoundId = "rbxassetid://17896463575",
            Volume = 2
        },
        ["Precise Shards Voiceline"] = {
            SoundId = "rbxassetid://17896462900",
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://17896461874",
            Volume = 2
        },
        ["Destructive Blitz SFX"] = {
            SoundId = "rbxassetid://17896463885",
            Volume = 2
        },
        ["Destructive Blitz Voiceline"] = {
            SoundId = "rbxassetid://17896464174",
            Volume = 2
        },
        ["Stoning Thrust SFX"] = {
            SoundId = "rbxassetid://17896640285",
            Volume = 2
        },
        ["Stoning Thrust Voiceline"] = {
            SoundId = "rbxassetid://17896639732",
            Volume = 2
        },
        ["Stoning Thrust Startup Voiceline"] = {
            SoundId = "rbxassetid://17896639956",
            Volume = 2
        },
        ["Rampage Voiceline"] = {
            SoundId = "rbxassetid://17898267473",
            Volume = 2
        },
        ["Duplex Combination Voiceline"] = {
            SoundId = "rbxassetid://17896641363",
            Volume = 2
        },
        ["Duplex Combination Slam"] = {
            SoundId = "rbxassetid://17896640582",
            Volume = 2
        },
        ["Duplex Combination SFX"] = {
            SoundId = "rbxassetid://17896641117",
            Volume = 2
        },
        ["Diamond Devastation SFX"] = {
            SoundId = "rbxassetid://17896639098",
            Volume = 2
        },
        ["Diamond Devastation Voiceline"] = {
            SoundId = "rbxassetid://17896639459",
            Volume = 2
        },
        ["Diamond Devastation Startup Voiceline"] = {
            SoundId = "rbxassetid://17896640847",
            Volume = 2
        },
        ["Reverse Healing SFX"] = {
            SoundId = 17898267158,
            Volume = 2
        },
        ["Reverse Healing Voiceline"] = {
            SoundId = 17898266058,
            Volume = 2
        },
        ["Reverse Healing Startup SFX"] = {
            SoundId = 17845226231,
            Volume = 2
        },
        ["Reverse Healing Startup Voiceline"] = {
            SoundId = 17898266058,
            Volume = 2
        },
        ["Recoil Impale SFX"] = {
            SoundId = 17898271734,
            Volume = 2
        },
        ["Recoil Impale Voiceline"] = {
            SoundId = 17898268793,
            Volume = 2
        },
        ["Recoil Impale Startup SFX"] = {
            SoundId = 17898269093,
            Volume = 2
        },
        ["Recoil Impale Startup Voiceline"] = {
            SoundId = 17898269422,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = "rbxassetid://17896765335",
            Volume = 2
        },
        MeterUp3 = {
            SoundId = "rbxassetid://17896766471",
            Volume = 2
        },
        StandPoseMusic1 = {
            SoundId = "rbxassetid://17898270372",
            Volume = 2,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.4
                }
            }
        },
        StandPoseMusic2 = {
            SoundId = "rbxassetid://18429112052",
            Volume = 2,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.355
                }
            }
        },
        PoseMusic1 = {
            SoundId = "rbxassetid://17898272545",
            Volume = 2,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.4
                }
            }
        },
        PoseMusic2 = {
            SoundId = "rbxassetid://17898272545",
            Volume = 2,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.4
                }
            }
        }
    },
    Quotes = {
        Universal = { {
                SoundId = "rbxassetid://17898268389",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Yo Angelo!"
                    } }
            }, {
                SoundId = "rbxassetid://17898267933",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "My Crazy Diamond will rip you apart..."
                    } }
            }, {
                SoundId = "rbxassetid://17898265685",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "I think I was going to kill you..."
                    } }
            }, {
                SoundId = "rbxassetid://17898266356",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Out of my way or I wreck your face!"
                    } }
            } }
    }
};