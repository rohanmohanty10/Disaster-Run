  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local v1 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            LookAt = "Attacker"
        } }
};
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Heavy",
            LookAt = "Attacker",
            Offset = CFrame.Angles(0, 3.141592653589793, 0)
        }
    }
};
local v3 = {
    HitRemotes = { v1 },
    HitSounds = {
        Hit = {
            SoundId = 10548160858,
            Volume = 2.5
        }
    }
};
local v4 = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 10548478139,
            Volume = 2.5
        }
    }
};

return {
    Inherit = {
        AbilityName = "Star Platinum"
    },
    Animations = {
        Action = {
            PoseTransition = 10447315561,
            PoseIdle = 10447317174,
            Timestop = 10555675754,
            HeavyPunch = 10446639889,
            Drink = 10446833371
        },
        Idle = {
            Idle = 10446637810,
            SummonedIdle = 10448470312
        }
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 107, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitRemotes = { v1 },
                HitSounds = {
                    Hit = {
                        SoundId = 13394764639,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 13394764924,
                        Volume = 1
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitRemotes = { v1 },
                HitSounds = {
                    Hit = {
                        SoundId = 13394764639,
                        Volume = 1
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 13394764924,
                        Volume = 1
                    }
                }
            }
        },
        Barrage = {
            Hit = {
                HitRemotes = { v1 },
                HitSounds = {
                    Hit = {
                        SoundId = 13394434286,
                        Volume = 0.5
                    }
                }
            },
            Finisher = {
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 13394434854,
                        Volume = 1
                    }
                }
            }
        },
        ["Grab Slam"] = v4,
        ["Star Breaker"] = {
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 13394764455,
                    Volume = 1
                }
            }
        },
        ["Lock Kick"] = {
            HitRemotes = { v1 },
            HitSounds = {
                Hit = {
                    SoundId = 13394434776,
                    Volume = 1.5
                }
            },
            Finisher = {
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 13394434691,
                        Volme = 2.5
                    }
                }
            }
        },
        ["Star Finger"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13394860419,
                    Volume = 1.5
                }
            }
        },
        ["Evil Spirit"] = v3,
        ["Ora Slam"] = v4,
        ["Destructive Combination"] = {
            Hit = v3,
            Throw = v4
        },
        ["Brute Force"] = {
            Hit = v3,
            Finisher = v4
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 9837126335,
            Volume = 3,
            PlaybackSpeed = 0.669,
            Looped = true
        },
        SummonEffects = {
            SoundId = 13394408082,
            Volume = 2
        },
        SummonSound = {
            SoundId = 13394408284,
            Volume = 2
        },
        Desummon = {
            SoundId = 13394408383,
            Volume = 2
        },
        DesummonVoiceline = {
            SoundId = 13394408190,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 10626679838,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 10626680300,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 10626680773,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 10626764348,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 10626679838,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 10626680300,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 10626680773,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 10626764348,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        Grab = {
            SoundId = 10906275061,
            Volume = 2
        },
        Grabbed = {
            SoundId = 10906275262,
            Volume = 2
        },
        Throw = {
            SoundId = 10906545315,
            Volume = 2
        },
        ThrowVoiceline = {
            SoundId = 10626951737,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 10824345295,
            Volume = 1.25
        },
        Barrage = {
            SoundId = 10835571201,
            Volume = 1.25
        },
        ClashVoiceline = {
            SoundId = 10891682269,
            Volume = 0.85
        },
        Clash = {
            SoundId = 10891681787,
            Volume = 0.65
        },
        LockDiscard = {
            SoundId = 10626951737,
            Volume = 0
        },
        ["Star Breaker Voiceline"] = {
            SoundId = 13394764771,
            Volume = 2
        },
        ["Star Breaker Whoosh"] = {
            SoundId = 13394764022,
            Volume = 2
        },
        ["Star Finger Voiceline"] = {
            SoundId = 13394860059,
            Volume = 2
        },
        ["Star Finger Whoosh"] = {
            SoundId = 13394860280,
            Volume = 2
        },
        ["Evil Spirit Voiceline"] = {
            SoundId = 13394434424,
            Volume = 2
        },
        ["Evil Spirit Equip"] = {
            SoundId = 13394434536,
            Volume = 2
        },
        ["Evil Spirit Shoot"] = {
            SoundId = 13394434608,
            Volume = 2
        },
        Inhale = {
            SoundId = 13394860146,
            Volume = 2
        },
        ["Inhale Voiceline"] = {
            SoundId = 13394859955,
            Volume = 2
        },
        ["Timestop Voiceline"] = {
            SoundId = 13394932001,
            Volume = 2
        },
        ["Timestop End Voiceline"] = {
            SoundId = 10636576633,
            Volume = 2
        },
        ["Timestop SFX"] = {
            SoundId = 13394932180,
            Volume = 3
        },
        ["Timestop End SFX"] = {
            SoundId = 10920655226,
            Volume = 2
        },
        ["Ora Slam Voiceline"] = {
            SoundId = 13394859872,
            Volume = 2
        },
        ["Ora Slam Whoosh"] = {
            SoundId = 10627144734,
            Volume = 2
        },
        ["Ora Slam SFX"] = {
            SoundId = 13394859775,
            Volume = 2
        },
        ["Brute Force Grab"] = {
            SoundId = 10725855893,
            Volume = 2
        },
        ["Brute Force Grab Voiceline"] = {
            SoundId = 10725855533,
            Volume = 2
        },
        ["Brute Force"] = {
            SoundId = 13395043102,
            Volume = 2
        },
        ["Brute Force Voiceline"] = {
            SoundId = 13395042917,
            Volume = 2
        },
        ["Can Open"] = {
            SoundId = 10627730232,
            Volume = 2
        },
        ["Can Voiceline"] = {
            SoundId = 10627730933,
            Volume = 2
        },
        ["Drink Sound"] = {
            SoundId = 3637899507,
            Volume = 1.5
        },
        ["Drink Heal"] = {
            SoundId = 10627731562,
            Volume = 2
        },
        ["BeatdownAttempt-Voiceline"] = {
            SoundId = 13394932297,
            Volume = 2
        },
        BeatdownAttempt = {
            SoundId = 13394932725,
            Volume = 2
        },
        Beatdown = {
            SoundId = 13394932610,
            Volume = 2
        },
        ["Beatdown-Voiceline"] = {
            SoundId = 13394932470,
            Volume = 2
        },
        GrabSlamVoice = {
            SoundId = 13394764126,
            Volume = 2
        },
        GrabSlamWoosh = {
            SoundId = 13394764552,
            Volume = 2
        },
        GrabSlam = {
            SoundId = 13394764259,
            Volume = 2
        },
        GrabSlamVoicelineHit = {
            SoundId = 13394763933,
            Volume = 2
        },
        LockKickWoosh = {
            SoundId = 11381734994,
            Volume = 2
        },
        LockKickVoice = {
            SoundId = 11381741912,
            Volume = 2
        },
        LockKickDiscard = {
            SoundId = 11381735025,
            Volume = 2
        },
        DeathSound = {
            SoundId = 6717175820,
            Volume = 3
        },
        BarrageSFX = {
            SoundId = 6720651784,
            Volume = 1,
            PlaybackSpeed = 1
        },
        MeterUp3 = {
            SoundId = 10927465503,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 10927466258,
            Volume = 2
        }
    }
};