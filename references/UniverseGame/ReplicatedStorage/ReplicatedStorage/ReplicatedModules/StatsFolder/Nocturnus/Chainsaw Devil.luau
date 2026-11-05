  

 

local v1 = game:GetService("ReplicatedStorage")["Client Assets"];
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
            Particle = v1.Nocturnus.Particles.Light
        }
    }
};
local v3 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Nocturnus.Particles.Heavy
        }
    }
};

return {
    Inherit = {
        AbilityName = "Nocturnus"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 76, 21)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13436493553,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13436493084,
                        Volume = 1
                    }
                },
                HitRemotes = { v3 }
            }
        },
        ["Leash Slash"] = {
            First = {
                HitSounds = {
                    Hit = {
                        SoundId = 13436493553,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            },
            Second = {
                HitSounds = {
                    Hit = {
                        SoundId = 13436493084,
                        Volume = 1
                    }
                },
                HitRemotes = { v3 }
            }
        },
        ["Flash Slash"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13436489862,
                    Volume = 1
                }
            },
            HitRemotes = { v3 }
        },
        ["Gnash Slash"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13436493952,
                    Volume = 1
                }
            },
            HitRemotes = { v3 }
        },
        ["Crash Slash"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13436492681,
                    Volume = 1
                }
            },
            HitRemotes = { v3 }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 13456602016,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 13456602016,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13456602596,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 13456602880,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13456602596,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 13456603265,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13456603485,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 13456613402,
            Volume = 1
        },
        SummonEffects = {
            SoundId = 13436491110,
            Volume = 2
        },
        SummonSound = {
            SoundId = 13436487656,
            Volume = 2
        },
        Desummon = {
            SoundId = 13436491110,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://13556148750",
            Volume = 1.5,
            PlaybackSpeed = 1.4,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.7
                }
            }
        },
        ["Leash Slash SFX"] = {
            SoundId = 13436488557,
            Volume = 1
        },
        ["Leash Slash Voiceline"] = {
            SoundId = 13436487299,
            Volume = 1
        },
        ["Gnash Slash SFX"] = {
            SoundId = 13436488557,
            Volume = 1
        },
        ["Gnash Slash Voiceline"] = {
            SoundId = 13436486317,
            Volume = 1
        },
        ["Flash Slash SFX"] = {
            SoundId = 13436489009,
            Volume = 1
        },
        ["Flash Slash Voiceline"] = {
            SoundId = 13436486657,
            Volume = 1
        },
        ["Crash Slash Startup SFX"] = {
            SoundId = 13436492096,
            Volume = 1
        },
        ["Crash Slash Startup Voiceline"] = {
            SoundId = 13436488086,
            Volume = 1
        },
        ["Crash Slash Hit"] = {
            SoundId = 13436485826,
            Volume = 1
        },
        Teleport = {
            SoundId = "rbxassetid://6934988582",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        }
    },
    Animations = {
        Action = {
            PoseTransition = 13456571634,
            PoseIdle = 13456572850
        },
        Idle = {
            Idle = 13446255841,
            SummonedIdle = 13446255841
        }
    }
};