  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local u1 = Knit.GetService("EffectService");

return {
    Inherit = {
        AbilityName = "The World"
    },
    Animations = {
        Action = {
            PoseTransitionStand = 10115498195,
            PoseTransition = 10115501315,
            PoseIdle = 10115507976
        },
        Idle = {
            Idle = 10115525271,
            SummonedIdle = 10115522627
        }
    },
    Stats = {
        Summon = {
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 190, 118)), ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 83, 62)) }),
            IgnoreParts = { "Meshes/gear", "StandHumanoidRootPart" }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 13773027716,
                        Volume = 1
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13784838361,
                        Volume = 1
                    }
                }
            }
        },
        ["Kick Barrage"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13773027716,
                    Volume = 1
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13784838361,
                        Volume = 1
                    }
                }
            }
        },
        Impale = {
            HitSounds = {
                Hit = {
                    SoundId = 13784580924,
                    Volume = 1
                }
            }
        },
        ["Sudden Strike"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13784838361,
                    Volume = 1
                }
            }
        },
        ["Strong Punch"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13784838361,
                    Volume = 1
                }
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13773024919,
                        Volume = 1
                    }
                }
            },
            ["LMB-2"] = {
                Hit = {
                    SoundId = 13773024919,
                    Volume = 1
                }
            },
            ["LMB-3"] = {
                Hit = {
                    SoundId = 13773027830,
                    Volume = 1
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13784838361,
                        Volume = 1
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13773024919,
                        Volume = 1
                    }
                }
            },
            ["StandOff-LMB-2"] = {
                Hit = {
                    SoundId = 13773024919,
                    Volume = 1
                }
            },
            ["StandOff-LMB-3"] = {
                Hit = {
                    SoundId = 13773027830,
                    Volume = 1
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13784838361,
                        Volume = 1
                    }
                }
            }
        },
        Pose = {
            Callbacks = {
                PoseTransition = function(p2, p3) -- Line: 166, Name: PoseTransition
                    -- upvalues: Knit (copy), u1 (copy)
                    local Character = p2.Character;
                    p2.Animator:PlayAnimation("PoseTransitionStand");

                    if not Knit.CollectionService:HasTag(Character, "Summoned") then
                        return;
                    end;

                    Character.Stand["Meshes/gear"].Transparency = 0;
                    local _ = Character.Stand["Stand Left Arm"].GearWeld;
                    u1.FireAllClients("ArcadeGearSpin", Character);
                end,

                PoseEnd = function(p4, p5) -- Line: 178, Name: PoseEnd
                    p4.Character.Stand["Meshes/gear"].Transparency = 1;
                end
            }
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 13784574526,
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = 13784574573,
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 13784574633,
            Volume = 2
        },
        ["Timestop End SFX"] = {
            SoundId = 11498446637,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop End Voiceline"] = {
            SoundId = 13773027543,
            Volume = 10,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop SFX"] = {
            SoundId = 13773027447,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Voiceline"] = {
            SoundId = 13773027383,
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Teleport = {
            SoundId = "rbxassetid://6773724319",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FullPower-Hit-Voice"] = {
            SoundId = 13773023575,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["FullPower-Hit"] = {
            SoundId = 13773024051,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup-Voice"] = {
            SoundId = 13773024178,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup"] = {
            SoundId = "rbxassetid://12816615597",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["KnifeFlurry-Voice"] = {
            SoundId = "rbxassetid://12816610133",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["KnifeFlurry-Startup"] = {
            SoundId = "rbxassetid://12816612317",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["KnifeFlurry-Hit"] = {
            SoundId = "rbxassetid://12816611235",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Impale Voiceline"] = {
            SoundId = 13773027975,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Impale SFX"] = {
            SoundId = 13784581148,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Strong Punch Voiceline"] = {
            SoundId = 13773024673,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Strong Punch SFX"] = {
            SoundId = 13784838490,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Counter Voiceline"] = {
            SoundId = 1,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Counter Startup"] = {
            SoundId = 13773025089,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["StopSign-Voice"] = {
            SoundId = 1,
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["StopSign-Startup"] = {
            SoundId = "rbxassetid://12816581578",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Stop Sign Slam"] = {
            SoundId = "rbxassetid://12816580648",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-SFX"] = {
            SoundId = 13773023989,
            Volume = 2
        },
        ["RoadRoller-Startup-Voiceline"] = {
            SoundId = 13773024112,
            Volume = 2
        },
        ["RoadRoller-Hit"] = {
            SoundId = 13773023920,
            Volume = 0
        },
        ["RoadRoller-SFX"] = {
            SoundId = 13773023920,
            Volume = 1
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = 13773023732,
            Volume = 3
        },
        BarrageVoiceline = {
            SoundId = 13773024724,
            Volume = 3
        },
        Barrage = {
            SoundId = 13773024577,
            Volume = 3
        },
        ["Checkmate Activation SFX"] = {
            SoundId = 13773026101,
            Volume = 2
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = 13773025573,
            Volume = 2
        },
        ["Checkmate Windup"] = {
            SoundId = 13773026218,
            Volume = 2
        },
        Knives_Hit = {
            SoundId = 13773025678,
            Volume = 2
        },
        Knives_Ding = {
            SoundId = 11206837650,
            Volume = 2
        },
        Knives_Ting = {
            SoundId = 11206839775,
            Volume = 2
        },
        ["Sudden Strike Voiceline"] = {
            SoundId = 13784605763,
            Volume = 3
        },
        ["Sudden Strike SFX"] = {
            SoundId = 13784605708,
            Volume = 3
        },
        ["Kick Barrage Voiceline"] = {
            SoundId = 13773026602,
            Volume = 3
        },
        ["Kick Barrage SFX"] = {
            SoundId = 13773025006,
            Volume = 3
        },
        ["Bloodsuck Startup"] = {
            SoundId = 13773025458,
            Volume = 3
        },
        ["Bloodsuck SFX"] = {
            SoundId = 13773025313,
            Volume = 3
        },
        ["Bloodsuck Voiceline"] = {
            SoundId = 13773025188,
            Volume = 3
        },
        ["LMB-1"] = {
            SoundId = 13773026924,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 13773026859,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 13773026749,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 13773028079,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 0
        },
        ["SwingLMB 4"] = {
            SoundId = 11499912997,
            Volume = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13773026924,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13773026859,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13773026749,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13773028079,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 0
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 11499912997,
            Volume = 0
        },
        PoseMusic = {
            SoundId = 10011610678,
            Volume = 1
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
                    SoundId = "rbxassetid://10011598147",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Fine then, try me. I, DIO, will be victorious!"
                        } }
                }, {
                    SoundId = "rbxassetid://10011599124",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Useless!"
                        } }
                }, {
                    SoundId = "rbxassetid://10011600458",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re Next."
                        } }
                }, {
                    SoundId = "rbxassetid://10011601448",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Well, do you wish to play a game?!"
                        } }
                } }
        }
    }
};