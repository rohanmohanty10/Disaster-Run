  

 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 28
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);
local v5 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOn = {
                Visible = false,
                Priority = 2
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            Passive = {
                Visible = true,
                Priority = 4
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v5.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    MaxCombo = 4,
    ComboTick = 1,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.35,
        HitRemotes = { v5.Resources.LightHit },
        Sequence = { { 0, "Start" }, { 18, 25, "Attack" }, { 30, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 138480313827039,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 20, 26, "Attack" }, { 31, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 103827480179769,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 16, 22, "Attack" }, { 28, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 103827480179769,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.7,
        Sequence = {
            { 0, "Start" },
            { 0, "CreateTag", "MaxWalkSpeed", 5 },
            { 0, "CreateTag", "MaxJumpPower", 0 },
            { 33, "Attack" },
            { 33, "PlaySound", "Fatal Strike Slam" },
            { 33, function(p6, p7, p8, p9) -- Line: 138
                    -- upvalues: u2 (ref), AssetHandler (copy)
                    local AttackStats = p9.AttackStats;
                    local Player = p8.Player;
                    local Character = p8.Character;
                    local v10 = p8.RootPart.CFrame * AttackStats.Hitbox.Offset;
                    u2.FireAllClients({
                        {
                            Name = "Q_RADIAL",
                            Data = {
                                {
                                    Distance = 20,
                                    Origin = v10,
                                    Effect = { {
                                            Effect = "Camera Shake Preset",
                                            Arguments = { "Explosion" }
                                        } }
                                }
                            }
                        },
                        {
                            Name = "DS_DEBRIS",
                            Data = {
                                {
                                    Trail = AssetHandler.GetAsset("Particles/RockTrail", p8),
                                    Player = Player,
                                    Character = Character,
                                    Amount = math.random(3, 7),
                                    UpVelocity = NumberRange.new(25, 45),
                                    SideVelocity = NumberRange.new(-40, 40),
                                    Origin = v10
                                }
                            }
                        },
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Slam",
                                    Scale = 0.7,
                                    AutoSerialize = true,
                                    Origin = v10 * CFrame.new(0, -2.75, 0),
                                    Player = Player,
                                    AbilityName = p8.AbilityName,
                                    SkinName = p8.SkinName
                                }
                            }
                        },
                        {
                            Name = "Rock Debris",
                            Data = {
                                {
                                    Lifetime = 1.5,
                                    Size = Vector3.new(2.3, 2.3, 2.3),
                                    Origin = v10,
                                    Radius = AttackStats.Hitbox.Size,
                                    Amount = AttackStats.Hitbox.Size * 2
                                }
                            }
                        }
                    });
                end },
            { 45, "End" }
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 11,
            Offset = CFrame.new(0, 0, -8)
        },
        Ragdoll = {
            Time = 0.6
        },
        Stun = {
            Time = 0.35,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 45,
            Time = 0.1,
            Velocity = Vector3.new(0, 25, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 112416120787252,
                Volume = 1.4
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.15,
        HitRemotes = { v5.Resources.LightHit },
        HitSounds = {
            Hit = v5.Resources.SOffLMBHit
        },
        Sequence = { { 0, "Start" }, { 19, 25, "Attack" }, { 28, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = {
            { 0, "Start" },
            { 12, 15, "Attack" },
            { 13, function(p11) -- Line: 261
                end },
            { 23, "End" }
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-3"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = { { 0, "Start" }, { 17, 23, "Attack" }, { 26, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.25,
        HitRemotes = { v5.Resources.HeavyHit },
        HitSounds = {
            Hit = v5.Resources.SOffLMBFinisher
        },
        Sequence = { { 0, "Start" }, { 26, 32, "Attack" }, { 36, "End" } }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p12, p13) -- Line: 297, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p12.Stats;

            if not Knit.CollectionService:HasTag(p12.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v5.Stats.Summon = {
    From = "Combat.Summon",
    DesummonDelay = 0.9,
    LeaveParts = { "Bones", "StandHumanoidRootPart" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(172, 87, 172)), ColorSequenceKeypoint.new(1, Color3.fromRGB(228, 146, 255)) }),
    TweenTime = {
        Summon = 0.1,
        Desummon = 0.15
    },

    OnSummon = function(p14, p15) -- Line: 331, Name: OnSummon
        local Animator = p14.Animator;

        if p15 then
            Animator:PlayAnimation("Summon");

            return;
        end;

        Animator:PlayAnimation("Desummon");
    end
};
v5.Stats["Nail Breakthrough"] = {
    Interval = 3,
    CheckPVPSafe = true,
    Speed = 50,
    Duration = 2,
    Active = true,
    Actionable = {
        Active = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7, 7, 7),
        Offset = CFrame.new(0, 0, -6)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true
    },
    Kick = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v5.Resources.LightHit }
    },
    Grab = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v5.Resources.LightHit }
    },
    Slam = {
        Damage = 10,
        Priority = Enums.Intangible.Move
    },
    Shot = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { v5.Resources.Blood },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 4, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    }
};
v5.Stats.Barrage = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Speed = 1.5,
    Offset = -2,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 6,
        AfterMove = true
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } }, { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } }, { 37, "Cancelable", true }, { 37, "Clashable", true }, { 37, "Barrage", true }, { 37, 247, "BarrageAttack", "Hit" }, { 247, "Cancelable", false }, { 247, "Clashable", false }, { 247, "BarrageFinisher" }, { 287, "BarrageAttack", "Finisher" }, { 313, "End" } },
    Hit = {
        HitRemotes = { v5.Resources.LightHit },
        HitSounds = {
            Hit = v5.Resources.BarrageHitSound
        }
    },
    Finisher = {
        Damage = 20,
        HitRemotes = { v5.Resources.HeavyHit },
        HitSounds = {
            Hit = v5.Resources.BarrageFinisherSound
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15,
            Velocity = Vector3.new(0, 30, 0)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -4.5)
        }
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    ClashFinisher = {
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
}, BaseStatsModule.Stand_Barrage);
v5.Stats["Fatal Strike"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Slam = {
        Damage = 35,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 16,
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 112416120787252,
                Volume = 1.4
            }
        }
    }
};
v5.Stats["Final Point"] = {
    Active = true,
    Damage = 8,
    Stun = 1,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitRemotes = { v5.Resources.Blood },
    LessonEffect = {
        Damage = 3,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Quickstep,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        HitRemotes = { v5.Resources.Blood }
    }
};
v5.Stats["Spinning Continuum"] = {
    Active = true,
    MaxCount = 20,
    Damage = 20,
    HitAnimations = "Default",
    IgnoreLoveTrain = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Tick = {
        Damage = 1,
        HitAnimations = "Default",
        IgnoreLoveTrain = true,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 114294690713951,
                Volume = 0.375
            }
        }
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 5,
        Offset = CFrame.identity
    },
    HitSounds = {
        Hit = {
            SoundId = 114294690713951,
            Volume = 0.6
        }
    }
};
v5.Stats["Wormhole Retrieval"] = {
    Interval = 3,
    Damage = 20,
    Duration = 0.8,
    Reach = 50,
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(8, 8, 6),
        Offset = CFrame.new(0, 0, -3.75)
    },
    Priority = Enums.Intangible.Quickstep,
    Stun = {
        Time = 0.3,
        Priority = Enums.Stun.Heavy
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true
    },
    Warp = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 2,
            Priority = Enums.Stun.Heavy
        }
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    }
};
v5.Stats["Nail Shot"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35,
        MeterGain = 0,
        OmitTargetMeter = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitRemotes = { v5.Resources.Blood },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 5,
        Offset = CFrame.identity
    },
    Max = {
        Damage = 10,
        HitAnimations = "Default",
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v5.Resources.Blood },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 5,
            Offset = CFrame.identity
        }
    }
};
v5.Stats["Herbal Tea"] = {
    Active = true,
    HoldDuration = 4,
    MeterGain = 20,
    Heal = 35,
    MeterOverTime = 25,
    HealOverTime = 40,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    }
};
v5.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p16) -- Line: 848, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v17 = TableUtil.Copy(p16.Stats, true);

            if Knit.CollectionService:HasTag(p16.Character, "Summoned") then
                v17.StartAnim = "StandPoseTransition";
                v17.LoopAnim = "StandPoseIdle";
            end;

            return v17;
        end,

        PoseTransition = function(p18) -- Line: 858, Name: PoseTransition
            -- upvalues: Knit (copy), u2 (ref), ParticleHandler (copy)
            if not Knit.CollectionService:HasTag(p18.Character, "Summoned") then
                return;
            end;

            local Player = p18.Player;
            local Trove = p18.Trove;
            local Character = p18.Character;
            local RootPart = p18.RootPart;
            local _ = p18.Humanoid;
            local Folder = Instance.new("Folder");
            Folder.Name = os.clock();
            Folder.Parent = Character;
            Trove:Add(Folder);
            u2.FireAllClients("Tusk_GoldenSquares", {
                Thickness = 0.15,
                Scale = 0.9,
                RotationStrength = 1,
                AttachPart = RootPart,
                Player = Player,
                Reference = Folder,
                HSVData = ParticleHandler.GetUnusualHSVData(p18)
            });
        end
    }
};
v5.Stats.Block = {
    From = "Combat.Block"
};
v5.Stats["Wormhole Pursuit"] = {
    Interval = 3,
    Active = true,
    Actionable = {
        Active = true
    },
    Scan = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 80,
            Offset = CFrame.identity
        }
    },
    Initial = {
        Damage = 30,
        Meter = false,
        Hitbox = {
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 8.5,
            Offset = CFrame.identity
        },
        Priority = Enums.Intangible.Ragdoll,
        HitSounds = {
            Hit = {
                SoundId = 134398842547330,
                Volume = 3
            }
        },
        Stun = {
            Time = 0.95,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { v5.Resources.HeavyHit },
        KnockbackData = { {
                Type = "Velocity",
                Time = 0.25,
                Velocity = Vector3.new(0, 57.5, 0)
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 6, 0),
                Time = 0.35
            } },
        Ragdoll = {
            Time = 1.25
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        }
    },
    FollowUp = {
        Damage = 25,
        Hitbox = {
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 11,
            Offset = CFrame.identity
        },
        Priority = Enums.Intangible.Ragdoll,
        Stun = {
            Time = 0.6,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { v5.Resources.HeavyHit },
        KnockbackData = { {
                Type = "Velocity",
                Time = 0.2,
                Velocity = Vector3.new(0, 35, 0)
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(5, 6, 5),
                Time = 0.25
            } },
        Ragdoll = {
            Time = 1.1
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        }
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Manual = true
    }
};
v5.Stats["The Sacrifice"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Cooldown = {
        Time = 45,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitRemotes = { v5.Resources.LightHit },
        Block = {
            Unblockable = true
        }
    },
    Throw = {
        Damage = 4,
        Priority = Enums.Intangible.Move
    },
    Punch = {
        Damage = 8,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v5.Resources.LightHit }
    },
    Final = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 80,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v5.Stats["Dark Determination"] = {
    Active = true,
    Time = 30,
    Actionable = {
        Active = true
    },
    Meter = {
        RemoveMeter = false,
        RequiredAmount = 50
    },
    Cooldown = {
        Time = 35,
        AfterMove = true
    }
};
v5.Stats["Lesson 5"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Startup = {
        Damage = 15,
        Stun = 1,
        Priority = Enums.Intangible.Quickstep,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v5.Resources.LightHit },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    },
    Shoot = {
        Damage = 8,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v5.Resources.Blood }
    },
    Twist = {
        Damage = 4,
        Priority = Enums.Intangible.Move
    },
    Slam = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Predict = false,
            Offset = CFrame.new(1, 0, -5)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        }
    },
    Punch = {
        Damage = 6,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v5.Resources.LightHit }
    },
    Finisher = {
        Damage = 1000,
        Priority = Enums.Intangible.True,
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 150,
                Time = 0.25
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.25
            } },
        Ragdoll = {
            Time = 10
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        }
    },
    Final = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 80,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        }
    },
    LoveTrainVariant = {
        Damage = 286,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 80,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true,
            BypassCounter = true
        }
    }
};
v5.Stats["Cataclysmic Assault"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 12),
            Offset = CFrame.new(0, 0, -5.5)
        },
        Block = {
            Unblockable = true
        }
    },
    Drag = {
        Damage = 1,
        Priority = Enums.Intangible.Move
    },
    Slam = {
        Damage = 8,
        Priority = Enums.Intangible.Move,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Predict = false,
            Offset = CFrame.new(1, 0, -8.25)
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = false
        }
    },
    Punch = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v5.Resources.LightHit }
    },
    Throw = {
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v5.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v5.Stats["Lesson 3"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Damage = 10,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        Block = {
            Unblockable = true
        }
    },
    Finish = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { v5.Resources.Blood },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            } },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Lesson 3"
            } },
        Ragdoll = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v5.Stats["Below The Road"] = {
    Duration = 4,
    Active = true,
    Damage = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    ClientActionable = {
        Active = true,
        Ground = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Cooldown = {
        Time = 35,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Stun = {
        Time = 0.75
    },
    Hitbox = {
        Size = 25,
        RelativePart = "HumanoidRootPart",
        Offset = CFrame.identity
    },
    KnockbackData = { {
            Type = "Velocity",
            Speed = 8,
            Time = 0.1,
            RelativeTowards = "Target"
        } },
    HitRemotes = { v5.Resources.Blood },
    Block = {
        Blockable = true,
        BlockBreak = false,
        BypassCounter = true,
        PerfectBlockable = false
    }
};
v5.Stats["Glorious Rebound"] = {
    Active = true,
    Damage = 30,
    Stun = 0.5,
    Distance = 2.5,
    HitAnimations = "Default",
    Priority = Enums.Intangible.True,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    HitRemotes = { v5.Resources.Blood },
    Properties = {
        Restrain = true
    },
    HitSounds = {
        Hit = {
            SoundId = 17487881331,
            Volume = 2
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 3,
        Offset = CFrame.identity
    }
};

return v5;