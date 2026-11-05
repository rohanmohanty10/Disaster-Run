  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local v1 = PathShortcuts.ClientAssets["Sticky Fingers"];
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
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
            Particle = v1.Global.Light
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
            Particle = v1.Global.Heavy
        }
    }
};

return {
    Stats = {
        Summon = {
            From = "Combat.Summon",
            SummonV2 = true,
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(74, 165, 227)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 216, 247)) }),
            LeaveParts = { "StandHumanoidRootPart" }
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            AnimationTimed = false,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.35,
                Sequence = { { 0, "Start" }, { 25, 26, "Attack" }, { 28, "End" } },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 14978344021,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Speed = 1.35,
                Sequence = { { 0, "Start" }, { 29, 30, "Attack" }, { 32, "End" } },
                HitSounds = {
                    Hit = {
                        SoundId = 14978344075,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 1.4,
                Sequence = { { 0, "Start" }, { 28, 29, "Attack" }, { 31, "End" } },
                HitSounds = {
                    Hit = {
                        SoundId = 14978344239,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.85,
                Sequence = { { 0, "Start" }, { 39, 40, "Attack" }, { 45, "End" } },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 14978344140,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            ["StandOff-LMB-1"] = TableUtil.Reconcile({
                Endlag = 0.2,
                ActiveEndlag = 0.1,
                Speed = 1.35,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 8,
                    Time = 0.1
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 5.5, 6),
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = { v2 },
                HitSounds = {}
            }, BaseStatsModule.Stand_Rush_Attack),
            ["StandOff-LMB-4"] = TableUtil.Reconcile({
                Speed = 1.85,
                Cooldown = 1,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 36, 42, "Attack" }, { 48, "End" } },
                HitRemotes = { v3 },
                HitSounds = {}
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                StateChecker = function(p4, p5) -- Line: 195, Name: StateChecker
                    -- upvalues: Knit (copy), TableUtil (copy)
                    local Stats = p4.Stats;

                    if not Knit.CollectionService:HasTag(p4.Character, "Summoned") then
                        Stats = TableUtil.Copy(Stats, true);
                        Stats.CustomPrefix = "StandOff-LMB";
                    end;

                    return Stats;
                end
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose"
        },
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Active = true
            },
            Grab = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
                    } }
            },
            Throw = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
                    } }
            }
        },
        ["Hypnotic Flurry"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 18,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Properties = {
                Armor = true
            },
            Damage = 1,
            Stun = {
                Time = 0.75
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14978344998,
                    Volume = 1
                }
            },
            HitAnimations = "Default",
            Finisher = {
                Damage = 20,
                HitAnimations = "Default",
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 40,
                    Time = 0.3
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = true,
                    BlockBreak = false
                },
                Stun = {
                    Time = 0.5
                },
                Ragdoll = {
                    Time = 1.5
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Zipper",
                        Damage = 2,
                        Lifetime = 4,
                        Rate = 0.3
                    } },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 14978344870,
                        Volume = 1
                    }
                }
            }
        },
        Barrage = TableUtil.Reconcile({
            From = "Combat.Barrage",
            Active = true,
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hit = {
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 14978344998,
                        Volume = 1
                    }
                }
            },
            Finisher = {
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 14978344870,
                        Volume = 1
                    }
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Zipper",
                        Damage = 4
                    } }
            }
        }, BaseStatsModule.Stand_Barrage),
        ["Interrogation Technique"] = {
            Active = true,
            Damage = 25,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 12.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Stun = {
                Time = 1.5
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 14978369022,
                    Volume = 1
                }
            }
        },
        ["Zip Tie"] = {
            Active = true,
            Damage = 17.5,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 14,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 22),
                Offset = CFrame.new(0, 0, -11)
            },
            Properties = {
                Armor = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 40,
                Time = 0.3
            },
            Block = {
                PerfectBlockable = true,
                Blockable = true,
                BlockBreak = true
            },
            Stun = {
                Time = 1.15
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 14978345334,
                    Volume = 1
                }
            }
        },
        ["Pocket Render"] = {
            Active = true,
            Damage = 5.5,
            HitAnimations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 13.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            Stun = {
                Time = 1.25
            },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14978345334,
                    Volume = 1
                }
            }
        },
        ["Neck Slice"] = {
            Active = true,
            Damage = 37.5,
            HitAnimations = "Default",
            Actionable = {
                Active = true,
                Disabled = true,
                Stunned = true,
                Summoned = true
            },
            Cooldown = {
                Time = 18,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 40,
                Time = 0.3
            },
            Stun = {
                Time = 0.5
            },
            Ragdoll = {
                Time = 1.5
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = true
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Zipper",
                    Damage = 3,
                    Lifetime = 4,
                    Rate = 0.3
                } },
            HitRemotes = {
                {
                    Name = "Output",
                    Arguments = {
                        "FX",
                        "HitEffect V3",
                        {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            AutoSerialize = true,
                            LookAt = "Attacker",
                            Particle = v1["Neck Slice"].Hit
                        }
                    }
                }
            },
            HitSounds = {
                Hit = {
                    SoundId = 14978346104,
                    Volume = 1
                }
            }
        },
        ["Ripper Cord"] = {
            Active = true,
            Damage = 35,
            HitAnimations = "Default",
            Actionable = {
                Active = true,
                Disabled = true,
                Stunned = true,
                Summoned = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Properties = {
                Armor = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 50,
                Time = 0.3,
                Velocity = Vector3.new(0, 15, 0)
            },
            Stun = {
                Time = 0.5
            },
            Ragdoll = {
                Time = 1.5
            },
            Block = {
                PerfectBlockable = true,
                Blockable = true,
                BlockBreak = false
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Zipper",
                    Damage = 3,
                    Lifetime = 4,
                    Rate = 0.3
                } },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 14978369298,
                    Volume = 1
                }
            }
        },
        ["Cord Extension"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 22.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 16),
                Offset = CFrame.new(0, 0, -8)
            },
            Meter = {
                RequiredAmount = 30
            },
            Properties = {
                Armor = true
            },
            Damage = 12.5,
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = false,
                BlockBreak = true
            },
            Stun = {
                Time = 1
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Zipper",
                    Damage = 3,
                    Lifetime = 2,
                    Rate = 1
                } },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 14978369150,
                    Volume = 1
                }
            },
            HitAnimations = "Default",
            Finisher = {
                Damage = 20,
                HitAnimations = "Default",
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 0,
                    Time = 0.3,
                    Velocity = Vector3.new(0, -20, 0)
                },
                Stun = {
                    Time = 0.5
                },
                Ragdoll = {
                    Time = 1.5
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = false,
                    BlockBreak = true
                },
                HitRemotes = { v3 }
            }
        },
        ["Zipper Resolution"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            CheckPVPSafe = true,
            Cooldown = {
                Time = 35,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 75
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 16),
                Offset = CFrame.new(0, 0, -8)
            },
            Block = {
                PerfectBlockable = false,
                Blockable = false,
                BlockBreak = false
            },
            Stun = {
                Time = 0.75
            },
            HitAnimations = "Default",
            HitRemotes = { v3 },
            Slam = {
                MinHealth = 1,
                Damage = 50,
                Priority = Enums.Intangible.Move,
                HitRemotes = { v3 }
            },
            ["Chain Attack"] = {
                MinHealth = 1,
                Damage = 6.25,
                Priority = Enums.Intangible.Move,
                HitRemotes = { v3 }
            },
            Grapple = {
                MinHealth = 1,
                Damage = 10,
                Priority = Enums.Intangible.Move,
                HitRemotes = {
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "HitEffect V3",
                            {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                AutoSerialize = true,
                                LookAt = "Attacker",
                                Particle = v1["Zipper Resolution"].Catch
                            }
                        }
                    }
                }
            },
            Hit = {
                MinHealth = 1,
                Damage = 0.25,
                Priority = Enums.Intangible.Move,
                HitRemotes = { v2 }
            },
            Finisher = {
                Damage = 30,
                Priority = Enums.Intangible.Move,
                HitRemotes = {
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "HitEffect V3",
                            {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                AutoSerialize = true,
                                LookAt = "Attacker",
                                Particle = v1["Zipper Resolution"].LastHit
                            }
                        }
                    }
                },
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 30,
                    Time = 0.3,
                    Velocity = Vector3.new(0, 15, 0)
                }
            }
        },
        ["Zipper Glide"] = {
            Active = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 30,
                AfterMove = true
            }
        },
        ["Pocket Dimension"] = {
            Actionable = {
                Active = true,
                Disabled = true,
                Stunned = true,
                Summoned = true
            },
            Active = true,
            CheckPVPSafe = true,
            Cooldown = {
                Time = 20,
                Name = "Pocket Dimension",
                Manual = true
            },
            Search = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = 40,
                Offset = CFrame.new(0, 0, 0)
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = true
            },
            Damage = 35,
            Stun = {
                Time = 0.5
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 40,
                Time = 0.3
            },
            HitRemotes = { v3 },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Zipper",
                    Damage = 3,
                    Lifetime = 4,
                    Rate = 0.3
                } },
            HitSounds = {
                Hit = {
                    SoundId = 14978345856,
                    Volume = 1
                }
            },
            Warp = {
                Block = {
                    PerfectBlockable = false,
                    Blockable = true,
                    BlockBreak = true
                },
                Stun = {
                    Time = 1.15
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 14761782729,
            ["LMB-2"] = 14761785711,
            ["LMB-3"] = 14761787502,
            ["LMB-4"] = 14761789345,
            ["Hypnotic Flurry"] = 14806881709,
            BarrageStartup = 14761595920,
            Barrage = 14761597035,
            BarrageFinisher = 14942987202,
            ["Interrogation Technique"] = 14806912467,
            ["Interrogation Technique Victim"] = 14806915250,
            ["Zip Tie"] = 14756160759,
            ["Pocket Render"] = 14761586960,
            ["Neck Slice"] = 14761651161,
            ["Ripper Cord"] = 14761731284,
            ["Cord Extension"] = 14761707994,
            ["Zipper Resolution"] = 14940925008,
            ["Zipper Resolution Followup"] = 14940923042,
            ["Zipper Resolution Victim"] = 14940927683,
            ["Zipper Resolution Camera"] = 14940932191,
            ["Zipper Glide Startup"] = 14762901561,
            ["Zipper Glide Loop"] = 14762902977,
            ["Pocket Dimension Startup"] = 14954135419,
            ["Pocket Dimension Followup"] = 14954136159,
            ["Right Zipper Open"] = 14892281159,
            ["Right Zipper Close"] = 14892282915,
            ["Right Zipper Opened"] = 14943101613,
            ["Left Zipper Open"] = 14892300330,
            ["Left Zipper Close"] = 14892301478,
            ["Left Zipper Opened"] = 14943095466,
            PoseTransition = 14996743829,
            PoseIdle = 14997179588
        },
        Movement = {
            Walk = 14811453803,
            Run = 14811456355,
            SummonedWalk = 13938221061,
            SummonedRun = 13938223163
        },
        Idle = {
            Idle = 13785536286,
            SummonedIdle = 14811449222
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 14978384560,
            Volume = 1
        },
        SummonSound = {
            SoundId = 14978343936,
            Volume = 1
        },
        Desummon = {
            SoundId = 14978343821,
            Volume = 1
        },
        DesummonVoiceline = {
            SoundId = 14978343782,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 14978344348,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 14978345376,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14978344296,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 14978344597,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14978344816,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 14978344451,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14978344200,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 14978344391,
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = 14978345093,
            Volume = 1.25
        },
        Barrage = {
            SoundId = 14978344932,
            Volume = 1.25
        },
        ["Hypnotic Flurry Voiceline"] = {
            SoundId = 14978345195,
            Volume = 1
        },
        ["Hypnotic Flurry SFX"] = {
            SoundId = 14978345282,
            Volume = 1
        },
        ["Interrogation Technique Voiceline"] = {
            SoundId = 14978343884,
            Volume = 1
        },
        ["Interrogation Technique SFX"] = {
            SoundId = 14978343752,
            Volume = 1
        },
        ["Zip Tie Voiceline"] = {
            SoundId = 14978345570,
            Volume = 1
        },
        ["Zip Tie SFX"] = {
            SoundId = 14978345448,
            Volume = 1
        },
        ["Pocket Render Voiceline"] = {
            SoundId = 14978345638,
            Volume = 1
        },
        ["Pocket Render SFX"] = {
            SoundId = 14978345681,
            Volume = 1
        },
        ["Neck Slice Voiceline"] = {
            SoundId = 14978346241,
            Volume = 1
        },
        ["Neck Slice SFX"] = {
            SoundId = 14978346176,
            Volume = 1
        },
        ["Ripper Cord Voiceline"] = {
            SoundId = 14978369066,
            Volume = 1
        },
        ["Ripper Cord SFX"] = {
            SoundId = 14978369229,
            Volume = 1
        },
        ["Cord Extension Voiceline"] = {
            SoundId = 14978369115,
            Volume = 1
        },
        ["Cord Extension SFX"] = {
            SoundId = 14978369196,
            Volume = 1
        },
        ["Zipper Resolution Success SFX"] = {
            SoundId = 14978345965,
            Volume = 1
        },
        ["Zipper Resolution SFX"] = {
            SoundId = 14978346033,
            Volume = 1
        },
        ["Pocket Dimension Voiceline"] = {
            SoundId = 14978486554,
            Volume = 1
        },
        ["Pocket Dimension SFX"] = {
            SoundId = 14978486497,
            Volume = 1
        },
        ["Pocket Dimension Warp SFX"] = {
            SoundId = 14978486615,
            Volume = 1
        },
        ["Zipper Glide SFX"] = {
            SoundId = 14978486698,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 14969491862,
            Volume = 2,
            Looped = true
        }
    },
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Summon = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Hypnotic Flurry"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Unleash a barrage of quick blows in front of you using your stands right arm."
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Unleash constant blows as the key is held before finishing with a heavy punch."
            },
            ["Interrogation Technique"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Perform a downwards blow."
            },
            ["Zip Tie"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Extend a zipper arm forward, pulling targets."
            },
            ["Pocket Render"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Perform a quick punch combo.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Neck Slice"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Perform a powerful slice to the neck.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Ripper Cord"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Unleash a heavy chop.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Cord Extension"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Extend your zipper arm forwards, performing 2 powerful blows before slamming your arm down.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Zipper Resolution"] = {
                DefaultKeybind = "H+",
                State = "StandOn",
                Description = "Extend your zipper arm forwards before following it up with a devastating beatdown.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Zipper Glide"] = {
                DefaultKeybind = "V",
                Description = "Glide on the ground, leaving behind a zipper trail.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Pocket Dimension"] = {
                DefaultKeybind = "B",
                State = "StandOn",
                Description = "Enter a pocket dimension before teleporting and unleashing a blow to the nearest target.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Metadata = {
        BarrageColors = { Color3.fromRGB(33, 126, 232), Color3.fromRGB(248, 251, 255) }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://14969491257",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The words \'I\'ll kill you\' shouldn\'t be left unsaid until the deed is already done. That\'s how it works in the gangsters\' world we live in."
                        } }
                }, {
                    SoundId = "rbxassetid://14969491958",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Unforgivable! You\'ve done it again! You betrayed my trust!"
                        } }
                }, {
                    SoundId = "rbxassetid://14969492010",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This taste... is that of a liar!"
                        } }
                } }
        }
    }
};