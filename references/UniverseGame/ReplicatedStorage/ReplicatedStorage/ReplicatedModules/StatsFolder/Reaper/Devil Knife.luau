  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local u1 = Knit.GetService("EffectService");
local v2 = {
    SoundId = 4735718618,
    Volume = 10
};
local v3 = {
    SoundId = 138836812022795,
    Volume = 2.5
};

return {
    Inherit = {
        AbilityName = "Reaper"
    },
    Sounds = {
        DeathSentence = {
            SoundId = 92616824386158,
            Volume = 2.5
        },
        ["DeathSentence-Startup-Voiceline"] = {
            SoundId = 86253578928506,
            Volume = 1
        },
        ["DeathSentence-Voiceline"] = {
            SoundId = 77660667165352,
            Volume = 1.5
        },
        ["DeathSentence-Music"] = {
            SoundId = 121273023972779,
            Volume = 1.5
        },
        ["SoulTrespass-Startup"] = {
            SoundId = 106975525309986,
            Volume = 1
        },
        SoulTrespass = {
            SoundId = 132898279476200,
            Volume = 1
        },
        RiftSlice = {
            SoundId = 126362001637263,
            Volume = 1
        },
        Teleport = {
            SoundId = 113018692842571,
            Volume = 1
        },
        TeleportVoiceline = {
            SoundId = 115857018979076,
            Volume = 1
        },
        Quickdraw = {
            SoundId = 101047197499566,
            Volume = 1.75
        },
        RadialSwings = {
            SoundId = 81907462947364,
            Volume = 1
        },
        ["RadialSwings-Voiceline"] = {
            SoundId = 136931547618611,
            Volume = 1
        },
        ["Summon-SFX"] = {
            SoundId = 137588987338129,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 91723348090738,
            Volume = 1
        },
        ["Summon-VL"] = {
            SoundId = 119697291070530,
            Volume = 1
        },
        ["Desummon-VL"] = {
            SoundId = 115452256762331,
            Volume = 1
        },
        ["DeathSlash-Startup"] = {
            SoundId = 106522502501080,
            Volume = 1
        },
        DeathSlash = {
            SoundId = 98894523444290,
            Volume = 2
        },
        ["SoulReap-Startup"] = {
            SoundId = 106522502501080,
            Volume = 1
        },
        SoulReap = {
            SoundId = 137919557732178,
            Volume = 1
        },
        ["SoulReap-Voiceline"] = {
            SoundId = 99734239821719,
            Volume = 1
        },
        ScytheSlam = {
            SoundId = 115643948006719,
            Volume = 1
        },
        ["ScytheSlam-Voiceline"] = {
            SoundId = 111842204240599,
            Volume = 1
        },
        ["ScytheSlam-Startup"] = {
            SoundId = 107270414866382,
            Volume = 1
        },
        Barrage = {
            SoundId = 99648351025592,
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = 125827077474568,
            Volume = 1
        },
        CloakedEntrance = {
            SoundId = 102552979949605,
            Volume = 1.5
        },
        ["CloakedEntrance-Voiceline"] = {
            SoundId = 95722844312330,
            Volume = 1
        },
        Flourish = {
            SoundId = 100434571983426,
            Volume = 1.5
        },
        ["Flourish-Voiceline"] = {
            SoundId = 92233471931729,
            Volume = 1
        },
        ["ScytheRapture-Voiceline"] = {
            SoundId = 124577979271200,
            Volume = 2.3
        },
        ScytheRapture = {
            SoundId = 84557993580379,
            Volume = 1.65
        },
        ["ScytheRapture-1"] = {
            SoundId = 1,
            Volume = 1
        },
        ["ScytheRapture-2"] = {
            SoundId = 1,
            Volume = 1,
            PlaybackSpeed = 0.85
        },
        MeterUp2 = {
            SoundId = "rbxassetid://114071055995079",
            Volume = 1
        },
        MeterUp4 = {
            SoundId = "rbxassetid://75669120691759",
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 76339915679657,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 110520856551977,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 83204014465892,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 97942375508342,
            Volume = 1
        },
        StandOffPoseMusic = {
            Looped = true,
            SoundId = 95883266398074,
            Volume = 2.5
        },
        PoseMusic = {
            Looped = true,
            SoundId = 106406116288607,
            Volume = 2.5
        },
        Anything = {
            SoundId = 111295180338855,
            Volume = 1.5
        },
        ["Chaos Chaos"] = {
            SoundId = 80242265658982,
            Volume = 1.5
        },
        Meta = {
            SoundId = 116971124779749,
            Volume = 1.5
        },
        Laughter = {
            SoundId = 106757738400226,
            Volume = 1.5
        },
        ["Neo Chaos"] = {
            SoundId = 111695455398407,
            Volume = 1.5
        }
    },
    Animations = {
        Action = {
            StandOffPoseIdle = 132854053874229
        }
    },
    Stats = {
        Pose = {
            Callbacks = {
                Transformer = function(p4) -- Line: 274, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v5 = TableUtil.Copy(p4.Stats, true);

                    if Knit.CollectionService:HasTag(p4.Character, "Summoned") then
                        v5.PoseMusic = "PoseMusic";

                        return v5;
                    end;

                    v5.SkipTransition = true;
                    v5.PoseMusic = "StandOffPoseMusic";
                    v5.LoopAnim = "StandOffPoseIdle";

                    return v5;
                end,

                PoseLoop = function(p6) -- Line: 286, Name: PoseLoop
                    -- upvalues: Knit (copy), u1 (copy)
                    local Character = p6.Character;
                    local _ = Character.Stand;
                    local RootPart = p6.RootPart;

                    if not Knit.CollectionService:HasTag(Character, "Summoned") then
                        u1.FireAllClients("Q_RADIAL", {
                            Distance = 50,
                            Effect = "Jevil AfterImage",
                            Origin = RootPart.CFrame,
                            Arguments = { Character, true }
                        });
                    end;
                end,

                PoseEnd = function(p7) -- Line: 301, Name: PoseEnd
                    -- upvalues: Knit (copy), u1 (copy)
                    local Character = p7.Character;
                    local _ = Character.Stand;

                    if not Knit.CollectionService:HasTag(p7.Character, "Summoned") then
                        u1.FireAllClients({
                            {
                                Name = "Jevil AfterImage",
                                Data = { Character, false }
                            }
                        });
                    end;
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = v2
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = v2
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = v2
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = v3
                }
            }
        },
        ["Scythe Barrage"] = {
            Light = {
                HitSounds = {
                    Hit = v2
                }
            },
            Heavy = {
                HitSounds = {
                    Hit = v3
                }
            }
        },
        ["Scythe Slam"] = {
            HitSounds = {
                Hit = {
                    SoundId = 131851041635409,
                    Volume = 1.5
                }
            }
        },
        ["Quick Draw"] = {
            ["Hit-1"] = {
                HitSounds = {
                    Hit = v2
                }
            },
            ["Hit-2"] = {
                HitSounds = {
                    Hit = v2
                }
            },
            ["Hit-3"] = {
                HitSounds = {
                    Hit = v3
                }
            }
        },
        ["Radial Swings"] = {
            ["Hit-1"] = {
                HitSounds = {
                    Hit = v2
                }
            },
            ["Hit-2"] = {
                HitSounds = {
                    Hit = v2
                }
            },
            ["Hit-3"] = {
                HitSounds = {
                    Hit = v3
                }
            }
        },
        ["Scythe Rapture"] = {
            Light = {
                HitSounds = {
                    Hit = v2
                }
            },
            Heavy = {
                HitSounds = {
                    Hit = v3
                }
            }
        },
        ["Soul Reap"] = {
            HitSounds = {
                Hit = v2
            }
        },
        ["Death Slash"] = {
            HitSounds = {
                Hit = v3
            }
        },
        ["Cloaked Entrance"] = {
            Throw = {
                HitSounds = {
                    Hit = v2
                }
            },
            Teleport = {
                HitSounds = {
                    Hit = v2
                }
            }
        },
        ["Scythe Flourish"] = {
            HitSounds = {
                Hit = v2
            }
        },
        ["Soul Harvester"] = {
            HitSounds = {
                Hit = v2
            }
        },
        ["Soul Trespass"] = {
            Kick = {
                HitSounds = {
                    Hit = {
                        SoundId = 4735718618,
                        Volume = 10
                    }
                }
            },
            Slash1 = {
                HitSounds = {
                    Hit = v2
                }
            },
            Slash2 = {
                HitSounds = {
                    Hit = v2
                }
            }
        },
        ["Rift Slice"] = {
            HitSounds = {
                Hit = v2
            }
        }
    }
};