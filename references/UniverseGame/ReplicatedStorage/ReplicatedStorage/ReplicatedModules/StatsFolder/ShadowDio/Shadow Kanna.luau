  

 

return {
    Inherit = {
        AbilityName = "ShadowDio"
    },
    Metadata = {
        ReconcileSounds = false,
        CopyQuotes = false
    },
    Stats = {
        Summon = {
            From = "Combat.Summon",
            Cooldown = 0.5,
            SummonV2 = true,
            LeaveParts = { "StandHumanoidRootPart", "Exception", "HeadShadow" },
            CustomTransparency = {
                HeadShadow = {
                    SummonTransparency = 1
                }
            }
        },
        ["Rush Attack"] = {
            Damage = 25,
            NoEndlag = true
        },
        ["High Kick"] = {
            Damage = 50,
            Cooldown = 0.5,
            Meter = {
                RequiredLevel = 0
            }
        },
        Uppercut = {
            Damage = 50,
            Cooldown = 0.5,
            Meter = {
                RequiredLevel = 0
            }
        },
        ["Knife Barrage"] = {
            Damage = 5,
            Cooldown = 1,
            Meter = {
                RequiredLevel = 0
            }
        },
        ["Space Ripper"] = {
            Damage = 50,
            Cooldown = 1,
            Meter = {
                RequiredLevel = 0
            }
        },
        ["Stand Uppercut"] = {
            Damage = 50,
            Cooldown = 0.5,
            Meter = {
                RequiredLevel = 0
            },
            HitSounds = {
                Hit = {
                    SoundId = 13243141997,
                    Volume = 1
                }
            }
        },
        ["Stand Strike"] = {
            Damage = 50,
            Cooldown = 0.5,
            Meter = {
                RequiredLevel = 0
            },
            HitSounds = {
                Hit = {
                    SoundId = 13243325215,
                    Volume = 1
                }
            }
        },
        ["Blood Suck"] = {
            Cooldown = 1,
            Meter = {
                RequiredLevel = 0
            }
        },
        Counter = {
            Cooldown = 1,
            Meter = {
                RequiredLevel = 0
            }
        },
        Punishment = {
            Damage = 50,
            Cooldown = 1,
            Meter = {
                RequiredLevel = 0
            }
        },
        Swipe = {
            Damage = 50,
            Cooldown = 0.5,
            Meter = {
                RequiredLevel = 0
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 13267593286,
            Volume = 1,
            Looped = true
        },
        ["Timestop-Voice"] = {
            SoundId = 13243597584,
            Volume = 1
        },
        ["StandUppercut-SFX"] = {
            SoundId = 13243141998,
            Volume = 1
        },
        ["KnifeBarrage-SFX"] = {
            SoundId = 13243278136,
            Volume = 1
        },
        ["KnifeBarrage-Voiceline"] = {
            SoundId = 13243141989,
            Volume = 1
        },
        ["PunishmentStartup-SFX"] = {
            SoundId = 13243278135,
            Volume = 1
        },
        ["Punishment-SFX"] = {
            SoundId = 13243278132,
            Volume = 1
        },
        ["Punishment-Voiceline"] = {
            SoundId = 13243278131,
            Volume = 1
        },
        ["HighKick-SFX"] = {
            SoundId = 13243314785,
            Volume = 1
        },
        ["HighKick-Voiceline"] = {
            SoundId = 13243314783,
            Volume = 1
        },
        ["Uppercut-SFX"] = {
            SoundId = 13243314785,
            Volume = 1
        },
        ["Uppercut-Voiceline"] = {
            SoundId = 13243314783,
            Volume = 1
        },
        ["StandStrike-SFX"] = {
            SoundId = 13243314788,
            Volume = 1
        },
        ["SpaceRipperStartup-SFX"] = {
            SoundId = 13243325795,
            Volume = 1
        },
        ["BloodSuck-SFX"] = {
            SoundId = 13243362098,
            Volume = 1
        },
        ["BloodSuck-Voiceline"] = {
            SoundId = 13243362515,
            Volume = 1
        },
        ["BloodSuckHit-SFX"] = {
            SoundId = 13243361524,
            Volume = 1
        }
    }
};