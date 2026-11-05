  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local v1 = {
    Inherit = {
        AbilityName = "The Strongest"
    },
    Stats = {},
    Animations = {
        Action = {
            BlindfoldOff = 15568855687,
            BlindfoldOn = 15568848649,
            HollowPurpleStartup = 15577277893,
            HollowPurpleLoop = 15568321058,
            HollowPurpleFire = 15568309187,
            ["Quote-3"] = 15685217044,
            ["Quote-3-Idle"] = 15685374463
        },
        Idle = {
            Idle = 15568747152
        }
    },
    Resources = {
        RushAttackSFX = {
            SoundId = 15180818873,
            Volume = 2
        },
        RushAttack2SFX = {
            SoundId = 15577387323,
            Volume = 2
        },
        RushFinisherSFX = {
            SoundId = 15577388227,
            Volume = 2
        },
        FlashComboSFX = {
            SoundId = 15201907699,
            Volume = 2
        },
        FlashComboFinisherSFX = {
            SoundId = 15201908019,
            Volume = 2
        },
        TwofoldKickSFX1 = {
            SoundId = 15169520611,
            Volume = 2
        },
        TwofoldKickSFX2 = {
            SoundId = 15169520669,
            Volume = 2
        },
        GleamingStrikeHit = {
            SoundId = 15169521029,
            Volume = 2
        },
        LapseCollapseSFX = {
            SoundId = 15169521884,
            Volume = 2
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 15685471831,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true
        },
        SixEyesPoseMusic = {
            SoundId = 15626308536,
            Volume = 1.7,
            Looped = true
        },
        MeterUp2 = {
            SoundId = 15577388592,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 15577388409,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 15180818666,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 15180818704,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = 15180818805,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 15577387901,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = 15180818502,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 15180819000,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = 15577387576,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 15180818932,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlindfoldOff = {
            SoundId = 15577388891,
            Volume = 2
        },
        BlindfoldOn = {
            SoundId = 15577388746,
            Volume = 2
        },
        FlashCombo = {
            SoundId = 15201907623,
            Volume = 2
        },
        FlashComboVoiceline = {
            SoundId = 15201907520,
            Volume = 2
        },
        TwofoldKick = {
            SoundId = 15169520763,
            Volume = 2
        },
        TwofoldKickVoiceline = {
            SoundId = 15169520763,
            Volume = 2
        },
        BeatdownStartup = {
            SoundId = 15105163795,
            Volume = 2
        },
        Beatdown = {
            SoundId = 15169521316,
            Volume = 2
        },
        BeatdownStartupVoiceline = {
            SoundId = 15169521550,
            Volume = 2
        },
        BeatdownVoiceline = {
            SoundId = 15169521188,
            Volume = 2
        },
        GleamingStrike = {
            SoundId = 15169520859,
            Volume = 2
        },
        GleamingStrikeVoiceline = {
            SoundId = 15169521100,
            Volume = 2
        },
        ViceGripStartup = {
            SoundId = 15169523134,
            Volume = 2
        },
        ViceGrip = {
            SoundId = 15169522917,
            Volume = 2
        },
        ViceGripStartupVoiceline = {
            SoundId = 15169523016,
            Volume = 2
        },
        ViceGripFinisher = {
            SoundId = 15438748632,
            Volume = 2
        },
        ViceGripFinisherVoiceline = {
            SoundId = 15438748783,
            Volume = 2
        },
        LapseAttract = {
            SoundId = 15169522143,
            Volume = 2
        },
        LapseAttractVoiceline = {
            SoundId = 15486898701,
            Volume = 2
        },
        LapsePull = {
            SoundId = 15169521743,
            Volume = 2
        },
        LapsePulled = {
            SoundId = 15169522256,
            Volume = 2
        },
        LapseCollapse = {
            SoundId = 15169521987,
            Volume = 2
        },
        LapseCollapseVoiceline = {
            SoundId = 15169521638,
            Volume = 2
        },
        LapseMaximum = {
            SoundId = 15169522364,
            Volume = 2
        },
        LapseMaximumLoop = {
            SoundId = 15486898775,
            Volume = 2
        },
        LapseMaximumEnd = {
            SoundId = 15169522442,
            Volume = 2
        },
        LapseMaximumVoiceline = {
            SoundId = 15486898737,
            Volume = 2
        },
        LimitlessTechnique = {
            SoundId = 15170335875,
            Volume = 2
        },
        LimitlessTechniqueStartup = {
            SoundId = 15170336034,
            Volume = 2
        },
        LimitlessTechniqueVoiceline = {
            SoundId = 15201907926,
            Volume = 2
        },
        HollowPurpleStartup = {
            SoundId = 15577389062,
            Volume = 2
        },
        HollowPurpleShoot = {
            SoundId = 15577447374,
            Volume = 2
        },
        HollowPurpleLoop = {
            SoundId = 15282657490,
            RollOffMaxDistance = 10000,
            RollOffMinDistance = 36,
            Volume = 2
        },
        HollowPurpleVoiceline = {
            SoundId = 15577496510,
            Volume = 2
        },
        ReversalPush = {
            SoundId = 15170335519,
            Volume = 2
        },
        ReversalPushShoot = {
            SoundId = 15170335076,
            Volume = 2
        },
        ReversalPushExplode = {
            SoundId = 15170339446,
            Volume = 2
        },
        ReversalRepel = {
            SoundId = 15169521474,
            Volume = 2
        },
        ReversalRepelVoiceline = {
            SoundId = 15486898808,
            Volume = 2
        },
        ReversalForce = {
            SoundId = 15105162255,
            Volume = 2
        },
        ReversalForceShoot = {
            SoundId = 15169522663,
            Volume = 2
        },
        ReversalForceExplode = {
            SoundId = 15169522606,
            Volume = 2
        },
        ReversalBlast = {
            SoundId = 15246858617,
            Volume = 2
        },
        ReversalBlastVoiceline = {
            SoundId = 15246858161,
            Volume = 2
        },
        ReversalBlastShoot = {
            SoundId = 15246858351,
            Volume = 2
        },
        DomainExpansionStartup = {
            SoundId = 15229137209,
            Volume = 2
        },
        DomainExpansionStartupVoiceline = {
            SoundId = 15229137282,
            Volume = 2
        },
        DomainExpansionAmbience = {
            SoundId = 15229137066,
            Volume = 2
        },
        DomainExpansionEnd = {
            SoundId = 15229137137,
            Volume = 2
        },
        Teleport = {
            SoundId = 15201907818,
            Volume = 2
        },
        InfinityVoiceline = {
            SoundId = 15577388079,
            Volume = 2
        },
        InfinityHit = {
            SoundId = 15577387470,
            Volume = 2
        },
        InfinityStartup = {
            SoundId = 15577387168,
            Volume = 2
        },
        InfinityEnd = {
            SoundId = 15577387695,
            Volume = 2
        },
        RuthlessBarrageStartup = {
            SoundId = 15609023299,
            Volume = 2
        },
        RuthlessBarrageStartupVoiceline = {
            SoundId = 15609023170,
            Volume = 2
        },
        RuthlessBarrage = {
            SoundId = 15609023006,
            Volume = 2
        },
        RuthlessBarrageVoiceline = {
            SoundId = 15609023417,
            Volume = 2
        },
        ThreefoldKickMastery = {
            SoundId = 76250607865390,
            Volume = 2
        },
        Mastery = {
            SoundId = 118194630137353,
            Volume = 2
        },
        RedImpact = {
            SoundId = 108119669632594,
            Volume = 2
        },
        RedImpactStartup = {
            SoundId = 111102141128317,
            Volume = 2
        },
        InstantStrike = {
            SoundId = 123571600195726,
            Volume = 2
        },
        BlackFlashHit = {
            SoundId = 102494741166019,
            Volume = 2
        },
        BlackFlashFailure = {
            SoundId = 100754998906849,
            Volume = 2
        },
        UnlimitedHollow = {
            SoundId = 89671339452025,
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
            Universal = {
                {
                    SoundId = "rbxassetid://15170335361",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Yo.",
                            ScaleTime = 0.2058423913043478
                        }, {
                            Quote = " Long time no see.",
                            ScaleTime = 0.34103260869565216
                        } }
                },
                {
                    SoundId = "rbxassetid://15170336197",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "For real, real. I feel like new!"
                        } }
                },
                {
                    SoundId = "rbxassetid://15170336339",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What?",
                            ScaleTime = 0.07902439024390244
                        }, {
                            Quote = " Is that right?",
                            ScaleTime = 0.10526829268292683
                        }, {
                            Quote = " Maybe you\'re right.",
                            ScaleTime = 0.10565853658536585
                        }, {
                            Quote = " YOU\'RE SO RIGHT!",
                            ScaleTime = 0.23570731707317072
                        } }
                },
                {
                    SoundId = "rbxassetid://15170336435",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Through-out heaven and earth...",
                            ScaleTime = 0.2691121014741173
                        }, {
                            Quote = " I alone am the honored one.",
                            ScaleTime = 0.2949948577305451
                        } }
                }
            }
        }
    }
};
v1.Stats["Rush Attack"] = {
    ["LMB-1"] = {
        HitSounds = { v1.Resources.RushAttackSFX }
    },
    ["LMB-2"] = {
        HitSounds = { v1.Resources.RushAttack2SFX }
    },
    ["LMB-3"] = {
        HitSounds = { v1.Resources.RushAttackSFX }
    },
    ["LMB-4"] = {
        HitSounds = { v1.Resources.RushFinisherSFX }
    }
};
v1.Stats["Flash Combo"] = {
    Hook = {
        HitSounds = { v1.Resources.FlashComboSFX }
    },
    SweepKick = {
        HitSounds = { v1.Resources.FlashComboSFX }
    },
    Kick = {
        HitSounds = { v1.Resources.FlashComboSFX }
    },
    Jab1 = {
        HitSounds = { v1.Resources.FlashComboSFX }
    },
    Jab2 = {
        HitSounds = { v1.Resources.FlashComboSFX }
    },
    Jab3 = {
        HitSounds = { v1.Resources.FlashComboSFX }
    },
    FlyingKick = {
        HitSounds = { v1.Resources.FlashComboFinisherSFX }
    }
};
v1.Stats["Twofold Kick"] = {
    DoubleKick = {
        HitSounds = { v1.Resources.TwofoldKickSFX1 }
    },
    Kick = {
        HitSounds = { v1.Resources.TwofoldKickSFX2 }
    }
};
v1.Stats["Gleaming Strike"] = {
    Kick = {
        HitSounds = { v1.Resources.GleamingStrikeHit }
    }
};
v1.Stats["Lapse Blue: Collapse"] = {
    Collapse = {
        HitSounds = { v1.Resources.LapseCollapseSFX }
    }
};

return v1;