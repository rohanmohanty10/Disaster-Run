  

 

game:GetService("ReplicatedStorage");

return {
    Inherit = {
        AbilityName = "Sticky Fingers"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 220, 44)), ColorSequenceKeypoint.new(0.25, Color3.fromRGB(198, 255, 185)), ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 0, 3)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 86660936322949,
                        Volume = 1
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 134646674348928,
                        Volume = 1
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 75953229992165,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 79964195534418,
                        Volume = 1
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 86660936322949,
                        Volume = 1
                    }
                }
            },
            ["StandOff-LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 134646674348928,
                        Volume = 1
                    }
                }
            },
            ["StandOff-LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 75953229992165,
                        Volume = 1
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 79964195534418,
                        Volume = 1
                    }
                }
            }
        },
        Barrage = {
            VoicelineRange = 2,
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 125482329068201,
                        Volume = 0.75
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 92478881260774,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Hypnotic Flurry"] = {
            HitSounds = {
                Hit = {
                    SoundId = 137017520620725,
                    Volume = 1
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 132415908680382,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Zip Tie"] = {
            HitSounds = {
                Hit = {
                    SoundId = 139456140981919,
                    Volume = 1
                }
            }
        },
        ["Pocket Render"] = {
            HitSounds = {
                Hit = {
                    SoundId = 109306226222780,
                    Volume = 1
                }
            }
        },
        ["Neck Slice"] = {
            HitSounds = {
                Hit = {
                    SoundId = 117987130159456,
                    Volume = 1
                }
            }
        },
        ["Ripper Chord"] = {
            HitSounds = {
                Hit = {
                    SoundId = 103869768007984,
                    Volume = 1
                }
            }
        },
        ["Cord Extension"] = {
            HitSounds = {
                Hit = {
                    SoundId = 123685964700274,
                    Volume = 1
                }
            }
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 92310452832688,
            Volume = 1
        },
        Desummon = {
            SoundId = 87735841685594,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 78886417857505,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 133063325529210,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 123241633748648,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 86135078472879,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 78886417857505,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 133063325529210,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 123241633748648,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 86135078472879,
            Volume = 1
        },
        Barrage = {
            SoundId = 84987003430372,
            Volume = 1.25
        },
        ["Hypnotic Flurry SFX"] = {
            SoundId = 97193101684822,
            Volume = 1
        },
        ["Interrogation Technique SFX"] = {
            SoundId = 93051045663011,
            Volume = 1
        },
        ["Zip Tie SFX"] = {
            SoundId = 77247376785066,
            Volume = 1
        },
        ["Pocket Render SFX"] = {
            SoundId = 127541748152122,
            Volume = 1
        },
        ["Neck Slice SFX"] = {
            SoundId = 135537788686537,
            Volume = 1
        },
        ["Ripper Cord SFX"] = {
            SoundId = 140684776895175,
            Volume = 1
        },
        ["Cord Extension SFX"] = {
            SoundId = 129915129912881,
            Volume = 1
        },
        ["Zipper Resolution Success SFX"] = {
            SoundId = 124106204012630,
            Volume = 1
        },
        ["Zipper Resolution SFX"] = {
            SoundId = 100277070969877,
            Volume = 1
        },
        ["Pocket Dimension SFX"] = {
            SoundId = 101377902451012,
            Volume = 1
        },
        ["Pocket Dimension Warp SFX"] = {
            SoundId = 140218102683334,
            Volume = 1
        },
        ["Zipper Glide SFX"] = {
            SoundId = 80432273059658,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 110093051231384,
            Volume = 2,
            Looped = true
        }
    }
};