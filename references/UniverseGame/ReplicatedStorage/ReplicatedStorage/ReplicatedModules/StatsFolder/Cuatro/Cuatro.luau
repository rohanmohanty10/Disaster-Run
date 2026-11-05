  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 19
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local v2 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Base = {
                Visible = true,
                Priority = 2
            },
            Murcielago = {
                Visible = false,
                Priority = 3
            },
            ["Segunda Etapa"] = {
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
    Resources = require(script.Resources)
};
v2.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    ManualMark = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    Callbacks = {
        StateChecker = function(p3, p4) -- Line: 79, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Stats = p3.Stats;

            if p3.Character:GetAttribute("Resurrection") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "Resurrection-LMB";
            end;

            return Stats;
        end
    },
    ["Resurrection-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = {
            { 0, "Start" },
            { 21, function(p5, p6, p7) -- Line: 92
                    -- upvalues: u1 (ref)
                    local Character = p7.Character;
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Slash/Cut",
                        AutoSerialize = true,
                        Origin = p7.RootPart.CFrame * CFrame.fromOrientation(0, 0, -2.356194490192345),
                        Player = p7.Player,
                        Character = Character
                    });
                end },
            { 21, 30, "Attack" }
        },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["Resurrection-LMB-2"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = {
            { 0, "Start" },
            { 23, function(p8, p9, p10) -- Line: 115
                    -- upvalues: u1 (ref)
                    local Character = p10.Character;
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Slash/Cut2",
                        AutoSerialize = true,
                        Origin = p10.RootPart.CFrame * CFrame.fromOrientation(0, -3.141592653589793, -0.7853981633974483),
                        Player = p10.Player,
                        Character = Character
                    });
                end },
            { 23, 35, "Attack" }
        },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["Resurrection-LMB-3"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = {
            { 0, "Start" },
            { 30, function(p11, p12, p13) -- Line: 138
                    -- upvalues: u1 (ref)
                    local RootPart = p13.RootPart;
                    local Character = p13.Character;
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMBPierce",
                        AutoSerialize = true,
                        Origin = RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p13.Player,
                        Scale = Character:GetScale()
                    });
                    local CFrame2 = RootPart.CFrame;
                    task.spawn(function() -- Line: 151
                        -- upvalues: CFrame2 (copy), u1 (ref), RootPart (copy)
                        for i = 1, 5 do
                            local v14 = CFrame2:Lerp(CFrame2 * CFrame.new(0, 0, -10), i / 5);
                            u1.FireAllClients("Rock Trail", {
                                Distance = 2,
                                Amount = 1,
                                Size = 1.6,
                                Duration = 2,
                                DurationOffset = 0.025,
                                Down = true,
                                Origin = v14,
                                LookVector = RootPart.CFrame.LookVector,
                                Offset = i * 0.4 + 3.4482758620689657
                            });
                            task.wait(0.025);
                        end;
                    end);
                end },
            { 30, 40, "Attack" }
        },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["Resurrection-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = {
            { 0, "Start" },
            { 33, function(p15, p16, p17) -- Line: 184
                    -- upvalues: u1 (ref)
                    local Character = p17.Character;
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Slash/Cut",
                        AutoSerialize = true,
                        Origin = p17.RootPart.CFrame * CFrame.fromOrientation(0, 0, 3.141592653589793),
                        Player = p17.Player,
                        Character = Character
                    });
                end },
            { 33, 40, "Attack" }
        },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = { { 0, "Start" }, { 26, 30, "Attack" } },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = {
            { 0, "Start" },
            { 26, function(p18, p19, p20) -- Line: 220
                    -- upvalues: u1 (ref)
                    local Character = p20.Character;
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMBPierce",
                        AutoSerialize = true,
                        Origin = p20.RootPart.CFrame * CFrame.new(0, 0, -2.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p20.Player,
                        Scale = Character:GetScale()
                    });
                end },
            { 26, 35, "Attack" }
        },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = {
            { 0, "Start" },
            { 21, function(p21, p22, p23) -- Line: 243
                    -- upvalues: u1 (ref)
                    local Character = p23.Character;
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMBPierce",
                        AutoSerialize = true,
                        Origin = p23.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p23.Player,
                        Scale = Character:GetScale()
                    });
                end },
            { 21, 28, "Attack" }
        },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.6,
        Sequence = { { 0, "Start" }, { 30, 36, "Attack" } },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2.Stats.Enclose = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p24) -- Line: 281, Name: Check
            return not p24:GetAttribute("Resurrection");
        end
    },
    Meter = {
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v2.Stats["Resurrección: Segunda Etapa"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p25) -- Line: 301, Name: Check
            return not p25:GetAttribute("SegundaEtapa");
        end
    },
    Meter = {
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v2.Stats["Fierce Slashes"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Barrage = BaseStatsModule.Stand_Barrage.Hit,
    Finisher = BaseStatsModule.Stand_Barrage.Finisher
};
v2.Stats["Lanza Slashes"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Barrage = BaseStatsModule.Stand_Barrage.Hit,
    Finisher = BaseStatsModule.Stand_Barrage.Finisher
};
v2.Stats["Lance Whip"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Hit = {
        Damage = 30,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.1
        },
        HitRemotes = { v2.Resources.Blood },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.identity
        },
        Ragdoll = {
            Time = 2
        }
    }
};
v2.Stats.Punishment = {
    Active = true,
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
        HitRemotes = { v2.Resources.Hit },
        Block = {
            BlockBreak = true
        }
    },
    Cero = {
        Damage = 25,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 30, 0),
                Speed = 70,
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
        HitRemotes = { v2.Resources.Hit }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    }
};
v2.Stats.Bala = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },
    Stun = {
        Time = 2
    }
};
v2.Stats["High Speed Regeneration"] = {
    Active = true,
    Heal = 1,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p26) -- Line: 490, Name: Check
            return p26.Humanoid.Health < p26.Humanoid.MaxHealth;
        end
    },
    Cooldown = {
        Time = 2.5,
        AfterMove = true
    },
    Priority = Enums.Intangible.Move + 1,
    HitRemotes = { v2.Resources.Regeneration }
};
v2.Stats["Finger Cero"] = {
    Active = true,
    CustomPrefix = "FingerCero",
    Frequency = 3,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Actionable = {
        Active = true
    },
    Callbacks = {
        BarrageEffect = function(p27, p28, p29, p30) -- Line: 528, Name: BarrageEffect
            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        Damage = 0.7,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 6, 18),
            Offset = CFrame.new(0, 0, -9)
        },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15
        },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 6, 18),
            Offset = CFrame.new(0, 0, -9)
        }
    },
    Search = {
        Size = 20,
        Offset = CFrame.new(0, -2, 0)
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "Finger Cero", {
                Cancelable = true
            } }, { 0, "PlaySound", "Finger Cero Voiceline", {
                Cancelable = true
            } }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 0, "CreateTag", "NoRotate" }, { 89, "Cancelable", true }, { 89, "Clashable", false }, { 90, "Barrage", true }, { 90, 180, "BarrageAttack", "Hit" }, { 180, "BarrageFinisher" }, { 180, "BarrageAttack", "Finisher" }, { 190, "End" } },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v2.Stats["Cero Oscarus"] = {
    Active = true,
    CustomPrefix = "CeroOscuras",
    Frequency = 3,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Actionable = {
        Active = true
    },
    Callbacks = {
        BarrageEffect = function(p31, p32, p33, p34) -- Line: 643, Name: BarrageEffect
            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        Damage = 0.7,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 6, 18),
            Offset = CFrame.new(0, 0, -9)
        },
        HitRemotes = { v2.Resources.Hit }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15
        },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 6, 18),
            Offset = CFrame.new(0, 0, -9)
        }
    },
    Search = {
        Size = 20,
        Offset = CFrame.new(0, -2, 0)
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "Cero Oscuras", {
                Cancelable = true
            } }, { 0, "PlaySound", "Cero Oscuras Voiceline", {
                Cancelable = true
            } }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 0, "CreateTag", "NoRotate" }, { 55, "Cancelable", true }, { 55, "Clashable", false }, { 56, "Barrage", true }, { 56, 216, "BarrageAttack", "Hit" }, { 216, "BarrageFinisher" }, { 216, "BarrageAttack", "Finisher" }, { 216, "End" } },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v2.Stats["Vampiric Rush"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 25,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v2.Resources.Hit },
        Block = {
            BlockBreak = true
        }
    },
    Drag = {
        Damage = 1,
        Priority = Enums.Intangible.Move + 1,
        HitRemotes = { v2.Resources.Hit }
    },
    Slam = {
        Damage = 20,
        Priority = Enums.Intangible.Move + 1,
        Ragdoll = {
            Time = 3,
            Intangible = false
        },
        HitRemotes = { v2.Resources.Hit }
    },
    Throw = {
        Damage = 25,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 30, 0),
                Speed = 100,
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
        HitRemotes = { v2.Resources.Hit }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    }
};
v2.Stats["Lanza del Relámpago"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },
    Explosion = {},
    Stun = {
        Time = 2
    }
};
v2.Stats["Gut Puncture"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 25,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v2.Resources.Hit },
        Block = {
            BlockBreak = true
        }
    },
    Throw = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(30, 30, 0),
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
        HitRemotes = { v2.Resources.Hit }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    }
};
v2.Stats["Terrific Force"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 25,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        HitRemotes = { v2.Resources.Hit },
        Block = {
            BlockBreak = true
        }
    },
    Punch = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        HitRemotes = { v2.Resources.Hit }
    },
    Impale = {
        Damage = 20,
        Priority = Enums.Intangible.Move + 1,
        HitRemotes = { v2.Resources.Hit }
    },
    Throw = {
        Damage = 30,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 30, 0),
                Speed = 100,
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
        HitRemotes = { v2.Resources.Hit }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    }
};
v2.Stats.Block = {
    From = "Combat.Block"
};
v2.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Stats.Pose = {
    From = "Combat.Pose"
};
v2.Stats.Sonido = {
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
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v2;