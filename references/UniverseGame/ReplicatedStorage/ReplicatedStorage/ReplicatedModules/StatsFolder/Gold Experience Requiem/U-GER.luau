  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local v1 = {
    EchoSoundEffect = {
        Delay = 0.2,
        DryLevel = 3.5,
        Feedback = 0.25,
        Priority = 0,
        WetLevel = -10
    }
};
local v2 = { {
        SoundId = "rbxassetid://13894609117",
        SoundVolume = 2,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "You will never get to the truth."
            } }
    }, {
        SoundId = "rbxassetid://13894609267",
        SoundVolume = 2,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Only the truth of this world will survive."
            } }
    }, {
        SoundId = "rbxassetid://13894611127",
        SoundVolume = 2,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "The fact that I have to say it over and over again means it\'s useless, and I don\'t like things that are useless."
            } }
    } };
local v3 = {
    Name = "Output",
    Arguments = { "FX", "UGER_Hit", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};

return {
    Inherit = {
        AbilityName = "Gold Experience Requiem"
    },
    Animations = {
        Action = {
            PoseIdle = 125835559224064,
            PoseTransition = 76621679844699,
            StandPoseIdle = 91782302400090,
            StandPoseTransition = 110837991495592
        },
        Movement = {
            Walk = 126726320128516,
            SummonedWalk = 126726320128516,
            Run = 122891912440611,
            SummonedRun = 122891912440611
        },
        Idle = {
            Idle = 112649871612943,
            SummonedIdle = 112649871612943
        }
    },
    Stats = {
        Reversal = {
            ReversalColor = BrickColor.new("Bright blue").Color
        },
        Barrage = {
            Hit = {
                HitRemotes = { v3 }
            }
        },
        ["Kick Barrage"] = {
            Hit = {
                HitRemotes = { v3 }
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitRemotes = { v3 }
            },
            ["StandOff-LMB-1"] = {
                HitRemotes = { v3 }
            }
        },
        ["Consecutive Rushdown"] = {
            Startup = {
                HitRemotes = { v3 }
            },
            Punch = {
                HitRemotes = { v3 }
            }
        },
        ["Righteous Resolution"] = {
            StandKick = {
                HitRemotes = { v3 }
            },
            Barrage = {
                HitRemotes = { v3 }
            }
        }
    },
    Sounds = {
        ["Summon-Voiceline"] = {
            SoundId = 90339753543750,
            SoundEffects = v1
        },
        ["Desummon-Voiceline"] = {
            SoundId = 125847784344205,
            Volume = 3.5,
            SoundEffects = v1
        },
        ReturnToZeroVoiceline = {
            SoundId = 4693900237,
            Volume = 7.5,
            SoundEffects = v1
        },
        ReturnToZeroGalaxyBall = {
            SoundId = 4709238543,
            Volume = 3.5
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 87683396104638,
            Volume = 4,
            SoundEffects = v1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 112159304903718,
            Volume = 4,
            SoundEffects = v1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 135462767769851,
            Volume = 4,
            SoundEffects = v1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 119037507052222,
            Volume = 4,
            SoundEffects = v1
        },
        BarrageVoiceline = {
            SoundEffects = v1
        },
        KickBarrageVoiceline = {
            SoundEffects = v1
        },
        RootStabVoiceline = {
            SoundEffects = v1
        },
        StrongPunchVoiceline = {
            SoundId = 118462372477260,
            Volume = 4,
            SoundEffects = v1
        },
        CombinationAttackStartupVoiceline = {
            SoundEffects = v1
        },
        CombinationAttackVoiceline = {
            SoundEffects = v1
        },
        DebrisShotVoiceline = {
            SoundId = 88837132159075,
            Volume = 4,
            SoundEffects = v1
        },
        DevastatingForceStartupVoiceline = {
            SoundEffects = v1
        },
        DevastatingForceVoiceline = {
            SoundEffects = v1
        },
        ConsecutiveRushdownStartupVoiceline = {
            SoundEffects = v1
        },
        ConsecutiveRushdownVoiceline = {
            SoundId = 117366006248937,
            Volume = 4,
            SoundEffects = v1
        },
        NullificationStartupVoiceline = {
            SoundEffects = v1
        },
        NullificationVoiceline = {
            SoundEffects = v1
        },
        RighteousResolutionStartupVoiceline = {
            SoundId = 105172990561624,
            Volume = 4,
            SoundEffects = v1
        },
        RighteousResolutionVoiceline = {
            SoundId = 125344655757386,
            Volume = 4,
            SoundEffects = v1
        },
        HealVoiceline = {
            SoundEffects = v1
        },
        SelfHealVoiceline = {
            SoundEffects = v1
        },
        ["Death-Voiceline"] = {
            SoundId = 128288284239069,
            Volume = 4
        },
        PoseMusic = {
            SoundId = 76135159239560,
            PlaybackSpeed = 1.1111111111111112,
            Volume = 4.5
        },
        StandPoseMusic = {
            SoundId = 76164011272173,
            PlaybackSpeed = 1,
            Volume = 4
        }
    },
    QuoteInfo = {
        Groups = {
            StandOff = {
                Visible = true
            },
            StandOn = {
                Visible = false
            }
        },
        Quotes = {
            StandOff = v2,
            StandOn = TableUtil.Extend(v2, { {
                    SoundId = "rbxassetid://86540452587198",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    StandHead = true,
                    FullQuote = { {
                            Timing = 0.04,
                            EndLag = 1,
                            Quote = "Those who stand before me"
                        }, {
                            Timing = 0.04,
                            EndLag = 1.35,
                            Quote = ", no matter their ability"
                        }, {
                            Timing = 0.04,
                            EndLag = 1.2,
                            Quote = ", will never reach the truth."
                        }, {
                            Timing = 0.06,
                            EndLag = 0.825,
                            Quote = " This is..."
                        }, {
                            Timing = 0.04,
                            EndLag = 1,
                            Quote = " Gold Experience Requiem!"
                        } }
                }, {
                    SoundId = "rbxassetid://112936861770303",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    StandHead = true,
                    FullQuote = { {
                            Quote = "You will never reach the truth."
                        } }
                } })
        }
    }
};