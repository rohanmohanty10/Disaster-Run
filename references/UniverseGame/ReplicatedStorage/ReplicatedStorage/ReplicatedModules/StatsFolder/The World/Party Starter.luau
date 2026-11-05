  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
Knit.OnStart():andThen(function() -- Line: 10
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u4 (ref), u5 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u4 = Knit.GetService("RigService");
    u5 = Knit.GetService("TagService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = {
        AbilityName = "The World"
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { ((function(p6, p7, p8) -- Line: 22, Name: CreateQuote
                    return {
                        SoundVolume = 2,
                        YieldSound = true,
                        Visible = true,
                        SoundId = `rbxassetid://{p6}`,
                        PlaybackSpeed = p8,
                        FullQuote = {
                            {
                                Quote = p7
                            }
                        }
                    };
                end)(124526547189312, "ahh blud manga mrs twoh divine thunder point blank 😭 🔥 🚒", 4)) }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 17478425222,
            PoseIdle = 17478440064
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 9962886856,
            Volume = 3,
            Looped = true
        },
        ["Summon-SFX"] = {
            SoundId = 96742717285403,
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = "",
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 127436466961178,
            Volume = 2
        },
        ["Timestop End SFX"] = {
            SoundId = 105356364158053,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop End Voiceline"] = {
            SoundId = "",
            Volume = 10,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Startup"] = {
            SoundId = 113855248281538,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop SFX"] = {
            SoundId = 128128695276298,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop Voiceline"] = {
            SoundId = "",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Teleport = {
            SoundId = 83802927130479,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FullPower-Hit-Voice"] = {
            SoundId = "",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["FullPower-Hit"] = {
            SoundId = 137217849206434,
            Volume = 2,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup-Voice"] = {
            SoundId = "",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup"] = {
            SoundId = 72483684804373,
            Volume = 2,
            PlaybackSpeed = 1
        },
        ["Impale Voiceline"] = {
            SoundId = "",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Impale Startup"] = {
            SoundId = 116555741079491,
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Strong Punch Voiceline"] = {
            SoundId = "",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Strong Punch SFX"] = {
            SoundId = 96254277836683,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Counter SFX"] = {
            SoundId = 135768944467328,
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Counter Voiceline"] = {
            SoundId = "",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["StopSign-Voice"] = {
            SoundId = "",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["StopSign-Startup"] = {
            SoundId = 73252055263423,
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-SFX"] = {
            SoundId = 104000225384792,
            Volume = 2
        },
        ["RoadRoller-Startup-Voiceline"] = {
            SoundId = "",
            Volume = 2
        },
        ["RoadRoller-SFX"] = {
            SoundId = 123278199891821,
            Volume = 2.5
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = 77871871572952,
            Volume = 3
        },
        BarrageVoiceline = {
            SoundId = ""
        },
        Barrage = {
            SoundId = 111850659711549,
            Volume = 3
        },
        ["Checkmate Activation SFX"] = {
            SoundId = 11206834039,
            Volume = 2
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = "",
            Volume = 2
        },
        ["Checkmate Windup"] = {
            SoundId = 74365053881917,
            Volume = 2
        },
        Knives_Hit = {
            SoundId = 86244850091866,
            Volume = 2
        },
        Knives_Ding = {
            SoundId = 75965421150828,
            Volume = 2
        },
        Knives_Ting = {
            SoundId = 75137334073955,
            Volume = 2
        },
        ["Sudden Strike Voiceline"] = {
            SoundId = "",
            Volume = 3
        },
        ["Sudden Strike SFX"] = {
            SoundId = 113383030886494,
            Volume = 3
        },
        ["Kick Barrage Voiceline"] = {
            SoundId = "",
            Volume = 3
        },
        ["Kick Barrage SFX"] = {
            SoundId = 132809096455436,
            Volume = 3
        },
        ["Bloodsuck SFX"] = {
            SoundId = 118778801305810,
            Volume = 3
        },
        ["Bloodsuck Voiceline"] = {
            SoundId = 117492336332264,
            Volume = 3
        },
        ["Bloodsuck Startup"] = {
            SoundId = 113302760215055,
            Volume = 3
        },
        ["LMB-1"] = {
            SoundId = 121870762797340,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 79646274496984,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 92267095493929,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 88049467538780,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 121870762797340,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 79646274496984,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 92267095493929,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 88049467538780,
            Volume = 2
        },
        ["SwingLMB-1"] = {
            SoundId = "",
            Volume = 2
        },
        ["SwingLMB-2"] = {
            SoundId = "",
            Volume = 2
        },
        ["SwingLMB-3"] = {
            SoundId = "",
            Volume = 2
        },
        ["SwingLMB-4"] = {
            SoundId = "",
            Volume = 2
        },
        ["StandOffSwingLMB-1"] = {
            SoundId = "",
            Volume = 2
        },
        ["StandOffSwingLMB-2"] = {
            SoundId = "",
            Volume = 2
        },
        ["StandOffSwingLMB-3"] = {
            SoundId = "",
            Volume = 2
        },
        ["StandOffSwingLMB-4"] = {
            SoundId = "",
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = "",
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = "",
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = "",
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = "",
            Volume = 2
        }
    },
    Stats = {
        Checkmate = {
            HitSounds = {
                Hit = {
                    SoundId = 86244850091866,
                    Volume = 2
                }
            }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 92080004034020,
                        Volume = 2
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 107770024800613,
                        Volume = 2
                    }
                }
            }
        },
        ["Kick Barrage"] = {
            HitSounds = {
                Hit = {
                    SoundId = 135100358982874,
                    Volume = 1
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 103294618348519,
                        Volume = 2
                    }
                }
            }
        },
        Impale = {
            HitSounds = {
                Hit = {
                    SoundId = 99725340242141,
                    Volume = 2
                }
            }
        },
        ["Sudden Strike"] = {
            HitSounds = {
                Hit = {
                    SoundId = 133239819473054,
                    Volume = 2
                }
            }
        },
        ["Strong Punch"] = {
            HitSounds = {
                Hit = {
                    SoundId = 135302423334691,
                    Volume = 2
                }
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 103206879583941,
                        Volume = 2
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 103206879583941,
                        Volume = 2
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 103206879583941,
                        Volume = 2
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 115039298001683,
                        Volume = 2
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 103206879583941,
                        Volume = 2
                    }
                }
            },
            ["StandOff-LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 103206879583941,
                        Volume = 2
                    }
                }
            },
            ["StandOff-LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 103206879583941,
                        Volume = 2
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 115039298001683,
                        Volume = 2
                    }
                }
            }
        },
        Pose = {
            Callbacks = {
                PoseLoop = function(p9, p10) -- Line: 537, Name: PoseLoop
                    local _ = p9.Stats;
                    local _ = p9.Player;
                    local _ = p9.Character;
                    local _ = p9.RootPart;
                    local _ = p10.Trove;
                end,

                PoseTransition = function(p11, p12) -- Line: 548, Name: PoseTransition
                    -- upvalues: AssetHandler (copy), u5 (ref)
                    local _ = p11.Stats;
                    local _ = p11.Player;
                    local Character = p11.Character;
                    local RootPart = p11.RootPart;
                    local Trove = p12.Trove;
                    local Tags = p11.Tags;
                    local _ = p11.Animator;
                    local v13 = Trove:Construct(Instance, "Model");
                    v13.Parent = Character;
                    v13.Name = "happybirth";
                    local v14 = AssetHandler.CloneAsset("Models/Handle", p11);
                    v14.Parent = v13;
                    v13.Archivable = true;
                    v13.PrimaryPart = v14;
                    local v15 = Trove:Construct(Instance, "Motor6D");
                    v15.Parent = RootPart;
                    v15.Part0 = RootPart;
                    v15.Part1 = v14;
                    v15.C0 = CFrame.new(0, -1.431, -0);
                    Trove:Add(u5:Add(Tags, "NoRotate"));
                end
            }
        }
    }
};