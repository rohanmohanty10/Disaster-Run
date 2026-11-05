  

 

return {
    Inherit = {
        AbilityName = "Gold Experience Requiem"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(148, 42, 42)), ColorSequenceKeypoint.new(1, Color3.fromRGB(173, 26, 26)) })
        },
        Heal = {
            HitSounds = { {
                    SoundId = 14722245469,
                    Volume = 2
                } }
        },
        ["Self Heal"] = {
            HitSounds = { {
                    SoundId = 14722245469,
                    Volume = 2
                } }
        }
    },
    Animations = {
        Action = {
            StandPoseIdle = 14730157743,
            StandPoseTransition = 14730159770
        },
        Movement = {
            Walk = 14730150773,
            SummonedWalk = 14730150773,
            Run = 14730149093,
            SummonedRun = 14730149093
        },
        Idle = {
            Idle = 14730146406,
            SummonedIdle = 14730146406
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 14721862040,
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = 14721863392,
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 14721862174,
            Volume = 2
        },
        ["Desummon-Voiceline"] = {
            SoundId = 0,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 13811775667,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 14721864122,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = 13811776659,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 14721863807,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = 13811775667,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 14721863807,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = 13811775921,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 14721863905,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = 14722245615,
            Volume = 2
        },
        Barrage = {
            SoundId = 13811776383,
            Volume = 2
        },
        KickBarrage = {
            SoundId = 14730520639,
            Volume = 2
        },
        KickBarrageVoiceline = {
            SoundId = 14721864541,
            Volume = 2
        },
        RootStabStartup = {
            SoundId = 14730520992,
            Volume = 2
        },
        RootStabSpawn = {
            SoundId = 0,
            Volume = 2
        },
        RootStabVoiceline = {
            SoundId = 0,
            Volume = 2
        },
        StrongPunch = {
            SoundId = 14721862551,
            Volume = 2
        },
        StrongPunchVoiceline = {
            SoundId = 14721864686,
            Volume = 2
        },
        CombinationAttackStartup = {
            SoundId = 14721862904,
            Volume = 2
        },
        CombinationAttackStartupVoiceline = {
            SoundId = 14721863270,
            Volume = 2
        },
        CombinationAttack = {
            SoundId = 14721863048,
            Volume = 2
        },
        CombinationAttackVoiceline = {
            SoundId = 0,
            Volume = 2
        },
        DebrisShotStartup = {
            SoundId = 14721863154,
            Volume = 2
        },
        DebrisShotVoiceline = {
            SoundId = 14721863667,
            Volume = 2
        },
        DebrisShot = {
            SoundId = 13803264129,
            Volume = 2
        },
        DevastatingForceStartup = {
            SoundId = 14721862279,
            Volume = 2
        },
        DevastatingForceStartupVoiceline = {
            SoundId = 0,
            Volume = 2
        },
        DevastatingForce = {
            SoundId = 14721861911,
            Volume = 2
        },
        DevastatingForceVoiceline = {
            SoundId = 14721864235,
            Volume = 2
        },
        ConsecutiveRushdownStartup = {
            SoundId = 14721862446,
            Volume = 2
        },
        ConsecutiveRushdownStartupVoiceline = {
            SoundId = 0,
            Volume = 2
        },
        ConsecutiveRushdown = {
            SoundId = 14721861733,
            Volume = 2
        },
        ConsecutiveRushdownVoiceline = {
            SoundId = 0,
            Volume = 2
        },
        NullificationStartup = {
            SoundId = 13803266447,
            Volume = 2
        },
        Nullification = {
            SoundId = 13803266329,
            Volume = 2
        },
        ReturnToZero = {
            SoundId = 14721862670,
            Volume = 2
        },
        ReturnToZeroVoiceline = {
            SoundId = 0,
            Volume = 2
        },
        Reversal = {
            SoundId = 13803266381,
            Volume = 2
        },
        RighteousResolutionStartup = {
            SoundId = 14721862742,
            Volume = 2
        },
        RighteousResolutionStartupVoiceline = {
            SoundId = 0,
            Volume = 2
        },
        RighteousResolution = {
            SoundId = 14721865259,
            Volume = 2
        },
        RighteousResolutionVoiceline = {
            SoundId = 14721864416,
            Volume = 2
        },
        Heal = {
            SoundId = 13886247955,
            Volume = 2
        },
        HealVoiceline = {
            SoundId = 14721864941,
            Volume = 2
        },
        SelfHeal = {
            SoundId = 13886248123,
            Volume = 2
        },
        SelfHealVoiceline = {
            SoundId = 14721865049,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 14721867387,
            PlaybackSpeed = 1,
            Volume = 2
        },
        StandPoseMusic = {
            SoundId = 14721867387,
            PlaybackSpeed = 1,
            Volume = 2
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
                    SoundId = "rbxassetid://14730520425",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The true world squirms beneath our feet."
                        } }
                }, {
                    SoundId = "rbxassetid://14730519879",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "So prideful."
                        } }
                }, {
                    SoundId = "rbxassetid://14730520798",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Kneel afore us or thy flesh will feed the gods!"
                        } }
                } }
        }
    }
};