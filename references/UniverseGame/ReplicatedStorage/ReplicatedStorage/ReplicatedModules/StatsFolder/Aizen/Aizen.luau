  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 18
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local v3 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            ["Kyoka Suigetsu"] = {
                Visible = false,
                Priority = 2
            },
            Butterfly = {
                Visible = false,
                Priority = 3
            },
            Monster = {
                Visible = false,
                Priority = 4
            },
            Passives = {
                Visible = false,
                Priority = 5
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 6,

        PointCap = function(p2) -- Line: 58, Name: PointCap
            return 1;
        end
    }
};
v3.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    Callbacks = {
        StateChecker = function(p4, p5) -- Line: 82, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Stats = p4.Stats;

            if p4.Character:GetAttribute("Hogyoku") and p4.Character:GetAttribute("Hogyoku") >= 1 then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "Unsheath-LMB";
            end;

            return Stats;
        end
    },
    ["Unsheath-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 22, function(p6, p7, p8) -- Line: 95
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p8.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(136, 136, 136),
                        Character = p8.Character
                    });
                end },
            { 22, 32, "Attack" }
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit },
        HitSounds = {
            Hit = {
                SoundId = 111895977998564,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["Unsheath-LMB-2"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 22, function(p9, p10, p11) -- Line: 126
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p11.RootPart,
                        Offset = CFrame.Angles(0, -1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, 2.443460952792061, 0),
                        Color = Color3.fromRGB(136, 136, 136),
                        Character = p11.Character
                    });
                end },
            { 22, 40, "Attack" }
        },
        HitSounds = {
            Hit = {
                SoundId = 111895977998564,
                Volume = 2
            }
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["Unsheath-LMB-3"] = TableUtil.Reconcile({
        Damage = 8,
        Speed = 2.15,
        Sequence = {
            { 0, "Start" },
            { 25, function(p12, p13, p14) -- Line: 160
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p14.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(136, 136, 136),
                        Character = p14.Character
                    });
                end },
            { 25, 30, "Attack" },
            { 26, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 111895977998564,
                Volume = 2
            }
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["Unsheath-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.7,
        Sequence = {
            { 0, "Start" },
            { 34, function(p15, p16, p17) -- Line: 193
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p17.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(136, 136, 136),
                        Character = p17.Character
                    });
                end },
            { 34, 38, "Attack" },
            { 26, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 91179215404504,
                Volume = 2
            }
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 22, function(p18, p19, p20) -- Line: 226
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p20.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(136, 136, 136),
                        Character = p20.Character
                    });
                end },
            { 22, 32, "Attack" }
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit },
        HitSounds = {
            Hit = {
                SoundId = 111895977998564,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 22, function(p21, p22, p23) -- Line: 257
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p23.RootPart,
                        Offset = CFrame.Angles(0, -1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, 2.443460952792061, 0),
                        Color = Color3.fromRGB(136, 136, 136),
                        Character = p23.Character
                    });
                end },
            { 22, 40, "Attack" }
        },
        HitSounds = {
            Hit = {
                SoundId = 111895977998564,
                Volume = 2
            }
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Damage = 8,
        Speed = 2.15,
        Sequence = {
            { 0, "Start" },
            { 25, function(p24, p25, p26) -- Line: 291
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p26.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(136, 136, 136),
                        Character = p26.Character
                    });
                end },
            { 25, 30, "Attack" },
            { 26, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 111895977998564,
                Volume = 2
            }
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.7,
        Sequence = {
            { 0, "Start" },
            { 34, function(p27, p28, p29) -- Line: 324
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p29.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(136, 136, 136),
                        Character = p29.Character
                    });
                end },
            { 34, 38, "Attack" },
            { 26, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 91179215404504,
                Volume = 2
            }
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v3.Stats["Heavy Attack"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = {
            Ignore = { "Shunpo" }
        }
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 7,
        Manual = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    HitRemotes = { v3.Resources.ParticleInfo.Hit },
    HitSounds = {
        Hit = {
            SoundId = 95104310613496,
            Volume = 2
        }
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.identity
    }
};
v3.Stats.Hogyoku = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p30) -- Line: 408, Name: Check
            if p30:GetAttribute("MasteryRank") and (p30:GetAttribute("MasteryRank") >= 2 and (not p30:GetAttribute("Hogyoku") or p30:GetAttribute("Hogyoku") < 3)) then
                return (p30:GetAttribute("MasteryRank") or 2) >= ({ 2, 4, 6 })[(p30:GetAttribute("Hogyoku") or 0) + 1];
            end;

            return false;
        end
    },
    Meter = {
        RequiredAmount = 75
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v3.Stats.Flurry = {
    Active = true,
    CustomPrefix = "Flurry",
    Frequency = 3,
    Speed = 1.25,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Actionable = {
        Active = {
            Ignore = { "Shunpo" }
        }
    },
    Callbacks = {
        BarrageEffect = function(p31, p32, p33, p34) -- Line: 460, Name: BarrageEffect
            -- upvalues: Knit (copy)
            local Character = p32.Character;

            if p34 then
                Knit.CollectionService:AddTag(Character, "Barrage");
                p33.SequenceTrove:Add(function() -- Line: 465
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barrage");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barrage");
            end;

            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        Damage = 0.7,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 13),
            Offset = CFrame.new(0, 0, -5.5)
        },
        HitRemotes = { v3.Resources.ParticleInfo.Hit },
        HitSounds = {
            Hit = {
                SoundId = 97086049314628,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 95104310613496,
                Volume = 2
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -2)
        }
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Flurry", {
                Cancelable = true
            } },
        { 0, "PlaySound", "Flurry Voiceline", {
                Cancelable = true
            } },
        { 43, "Cancelable", true },
        { 43, "Clashable", true },
        { 43, "CreateTag", "MaxWalkSpeed", 10 },
        { 43, "Barrage", true },
        { 43, function(p35, p36, u37) -- Line: 543
                -- upvalues: u1 (ref), AssetHandler (copy), Knit (copy)
                local u38 = os.clock();
                p35.Id = u38;
                u1.FireAllClients("Enable Particles", {
                    Enabled = true,
                    Parent = u37.RootPart,
                    Offset = CFrame.identity,
                    ReferencePart = AssetHandler.GetAsset("Particles/Barrage", u37),
                    Id = u38
                });
                u37.Trove:Add(function() -- Line: 555
                    -- upvalues: u1 (ref), u38 (copy), Knit (ref), u37 (copy)
                    u1.FireAllClients("Enable Particles", {
                        Id = u38
                    });
                    Knit.CollectionService:RemoveTag(u37.Character, "Barrage");
                end);
            end },
        { 44, 184, function(p39, p40, p41) -- Line: 560
                -- upvalues: u1 (ref)
                if p40 % 3 == 0 then
                    u1.FireAllClients("Q_RADIAL", {
                        Distance = 35,
                        Origin = p41.RootPart.CFrame,
                        Effect = { {
                                Effect = "Camera Shake Preset",
                                Arguments = { "Ride" }
                            } }
                    });
                end;
            end },
        { 44, 184, "BarrageAttack", "Hit" },
        { 184, function(p42) -- Line: 576
                -- upvalues: u1 (ref)
                u1.FireAllClients("Enable Particles", {
                    Id = p42.Id
                });
            end },
        { 184, "Cancelable", false },
        { 184, "Clashable", false },
        { 184, "Barrage", false },
        { 184, "BarrageFinisher" },
        { 203, function(p43, p44, p45) -- Line: 583
                -- upvalues: u1 (ref)
                u1.FireAllClients("Q_RADIAL", {
                    Distance = 15,
                    Effect = "Camera Shake",
                    Origin = p45.RootPart.CFrame,
                    Arguments = { { 6, 7, 0, 0.4, Vector3.new(1, 1, 1), Vector3.new(1, 1, 1), true } }
                });
                u1.FireAllClients("Anubis_Slash", {
                    Time = 0.25,
                    Size = Vector3.new(8.5, 20, 8.5),
                    SurfaceDirection = "Bottom",
                    Origin = p45.RootPart,
                    Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                    EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                    Color = Color3.fromRGB(136, 136, 136),
                    Character = p45.Character
                });
            end },
        { 205, "BarrageAttack", "Finisher" },
        { 229, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v3.Stats["Instant Slice"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Properties = {
        Restrain = {
            AutoRotate = false
        }
    },
    Meter = {
        RequiredAmount = 35
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    HitSounds = {
        Hit = {
            SoundId = 118058659118416,
            Volume = 2
        }
    },
    Hitbox = {
        Size = Vector3.new(12, 12, 36),
        Offset = CFrame.new(0, 0, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 55,
        Velocity = Vector3.new(0, 27, 0),
        Time = 0.12
    },
    Stun = {
        Time = 1.2
    },
    Ragdoll = {
        Time = 1.2
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    }
};
v3.Stats["Spiritual Pressure"] = {
    Active = true,
    Damage = 10,
    Actionable = {
        Active = true
    },
    Check = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Offset = CFrame.identity
        }
    },
    Properties = {
        Restrain = true,
        Armor = true
    },
    Cooldown = {
        Time = 40,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Block = {
        Unblockable = true
    },
    Stun = {
        Time = 0.25
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.identity
    },
    HitAnimations = { 10046328617 }
};
v3.Stats["Supreme Instinct"] = {
    Damage = 30,
    Actionable = {
        Active = true,

        Check = function(p46) -- Line: 724, Name: Check
            return not p46:GetAttribute("SupremeInstinct");
        end
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Priority = Enums.Intangible.Move,
    Ragdoll = {
        Time = 3
    },
    HitRemotes = { v3.Resources.Blood },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 36,
        Velocity = Vector3.new(0, 25, 0),
        Time = 0.1
    },
    Block = {
        Unblockable = true
    }
};
v3.Stats["Hado 63"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    HitSounds = {
        Hit = {
            SoundId = 121026109512346,
            Volume = 2
        }
    },
    Hitbox = {
        Size = Vector3.new(12, 8, 24),
        RelativePart = "HumanoidRootPart",
        Offset = CFrame.new(0, 0, -12)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 2
    }
};
v3.Stats["Kanzen Saimin"] = {
    CheckPVPSafe = true,
    Active = true,
    CloneHealth = 250,
    Actionable = {
        Active = true,

        Check = function(p47) -- Line: 806, Name: Check
            return not p47:GetAttribute("CloneSpawned");
        end
    },
    Meter = {
        RemoveMeter = false,
        RequiredAmount = 75
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 40,
        Manual = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 50,
        Offset = CFrame.identity
    }
};
v3.Stats["Hado 90"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 30,
        MeterGain = 0
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Linger = {
        Stun = {
            Time = 2
        },
        Meter = {
            MeterGain = 0
        }
    },
    Priority = Enums.Intangible.Ragdoll,
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 12, 32),
        Offset = CFrame.new(0, 0, -16)
    },
    Ragdoll = {
        Time = 3
    },
    Check = {
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            Predict = false,
            Size = Vector3.new(10, 15, 10)
        }
    }
};
v3.Stats["Hado 99"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Priority = Enums.Intangible.Quickstep,
    StunAttack = {
        Stun = {
            Time = 15
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Blast = {
        Damage = 3.3333333333333335,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Quickstep,
        Stun = {
            Time = 2
        },
        Ragdoll = {
            Time = 3
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true,
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.1
    },
    HitRemotes = { v3.Resources.Blood },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 100
    },
    Ragdoll = {
        Time = 2
    }
};
v3.Stats["True Strength"] = {
    Active = true,
    Actionable = {
        Active = true,
        Stunned = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Block = {
        Unblockable = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Slam = {
        Meter = false,
        Damage = 40,
        Priority = Enums.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Velocity = Vector3.new(0, 48, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -3)
        }
    },
    Shunpo = {
        Damage = 20,
        Ragdoll = {
            Time = 5
        },
        Stun = {
            Time = 5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 25, 0),
            Time = 0.1
        },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Size = Vector3.new(10, 10, 10),
            RelativePart = "HumanoidRootPart"
        }
    }
};
v3.Stats["Silent Elimination"] = {
    Active = true,
    FinisherPercent = 5,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 15,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v3.Resources.Hit },
        Block = {
            BlockBreak = true
        }
    },
    Throw = {
        Damage = 15,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 30, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v3.Resources.Hit }
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Impale = {
        Damage = 30,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.2
        },
        Ragdoll = {
            Time = 1.8
        },
        HitRemotes = { v3.Resources.Hit },
        Block = {
            Unblockable = true
        }
    },
    FinisherStrike = {
        Damage = 1000,
        TrueDamage = true,
        Meter = false,
        IgnoreProcessing = true,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 3
        },
        Ragdoll = {
            Time = 5
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 30, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        HitRemotes = { v3.Resources.Blood },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    }
};
v3.Stats.Shatter = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p48) -- Line: 1172, Name: Check
            return not p48:GetAttribute("KyokaSuigetsu");
        end
    },
    Meter = {
        RequiredAmount = 50
    },
    Hitbox = {
        Size = 30,
        RelativePart = "HumanoidRootPart"
    },
    Stun = {
        Time = 2
    },
    Cooldown = {
        Time = 60,
        Manual = true
    }
};
v3.Stats.Block = {
    From = "Combat.Block"
};
v3.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p49, p50) -- Line: 1207, Name: Transformer
            -- upvalues: TableUtil (copy), AssetHandler (copy), ParticleHandler (copy)
            local v51 = TableUtil.Copy(p49.Stats, true);

            if p49.Character:GetAttribute("Hogyoku") and p49.Character:GetAttribute("Hogyoku") >= 1 then
                v51.StartAnim = "HogyokuPoseTransition" .. p49.Character:GetAttribute("Hogyoku");
                v51.LoopAnim = "HogyokuPoseIdle" .. p49.Character:GetAttribute("Hogyoku");
            end;

            if p49.Character:GetAttribute("Hogyoku") and p49.Character:GetAttribute("Hogyoku") == 3 then
                local v52 = p50:Clone(AssetHandler.GetAsset("Models/HogyokuHand", p49));
                v52.Parent = p49.Character;
                ParticleHandler.AttachTo(v52, {
                    Part = p49.Character["Left Arm"]
                });
            end;

            return v51;
        end
    }
};
v3.Stats.Shunpo = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block" }
        }
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    }
};
v3.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v3;