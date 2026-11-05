  

 

return {
    Inherit = {
        AbilityName = "Magician\'s Red"
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14902309357,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 14902309357,
                        Volume = 1
                    }
                }
            }
        },
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(52, 152, 209)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 111, 209)) })
        },
        ["Red Bind"] = {
            HitSounds = {
                Hit = {
                    SoundId = 14875664106,
                    Volume = 1
                }
            }
        },
        ["Stand Barrage"] = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 14875663361,
                        Volume = 1
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 14875664002,
                        Volume = 1
                    }
                }
            }
        }
    },
    Sounds = {
        SummonSound = {
            SoundId = 14875664106,
            Volume = 1
        },
        Desummon = {
            SoundId = 14875663800,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 14902309429,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14902309429,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14902309429,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14902309279,
            Volume = 1
        },
        Barrage = {
            SoundId = 14875663253,
            Volume = 1
        },
        ["Pyrokinetic Fan SFX"] = {
            SoundId = 14787330094,
            Volume = 1
        },
        ["Pyrokinetic Fan Success SFX"] = {
            SoundId = 14787330364,
            Volume = 1
        },
        ["Fortuitous Dagger SFX"] = {
            SoundId = 14787328044,
            Volume = 1
        },
        ["Impact Strike SFX"] = {
            SoundId = 14875664182,
            Volume = 1
        },
        ["Flame Exhaust SFX"] = {
            SoundId = 14875663644,
            Volume = 1
        },
        ["Flame Bracers SFX"] = {
            SoundId = 14875662872,
            Volume = 1
        },
        ["Flare Drill SFX"] = {
            SoundId = 14875663572,
            Volume = 1
        },
        ["Seeking Flares SFX"] = {
            SoundId = 14787332135,
            Volume = 1
        },
        ["Red Bind SFX"] = {
            SoundId = 14875663453,
            Volume = 1
        },
        ["Crossfire Hurricane SFX"] = {
            SoundId = 14875663036,
            Volume = 1
        },
        ["Crossfire Hurricane+ SFX"] = {
            SoundId = 14875663036,
            Volume = 1
        },
        ["Hellfire Charge SFX"] = {
            SoundId = 14875663894,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 14875666079,
            Volume = 1
        }
    },
    Metadata = {
        BarrageColors = { Color3.fromRGB(52, 152, 209), Color3.fromRGB(0, 111, 209) }
    }
};