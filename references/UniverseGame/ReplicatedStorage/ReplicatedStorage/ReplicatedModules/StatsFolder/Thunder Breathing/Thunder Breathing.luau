  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 22
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v4 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    Resources = require(script.Resources)
};
v4.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 12, function(p5, p6, p7) -- Line: 65
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMB/LMB1",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p7.RootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                        Player = p7.Player,
                        AbilityName = p7.AbilityName,
                        SkinName = p7.SkinName
                    });
                end },
            { 11, 15, "Attack" }
        },
        HitSounds = {
            Hit = {
                SoundId = 115429462036490,
                Volume = 1
            }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 11, function(p8, p9, p10) -- Line: 95
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMB/LMB2",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p10.RootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                        Player = p10.Player,
                        AbilityName = p10.AbilityName,
                        SkinName = p10.SkinName
                    });
                end },
            { 12, 16, "Attack" }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Damage = 5,
        Sequence = {
            { 0, "Start" },
            { 12, function(p11, p12, p13) -- Line: 117
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMB/LMB3_1",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p13.RootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                        Player = p13.Player,
                        AbilityName = p13.AbilityName,
                        SkinName = p13.SkinName
                    });
                end },
            { 13, 16, "Attack" },
            { 17, function(p14, p15, p16, p17, p18) -- Line: 129
                    p14.Hit[p17.FullName] = {};
                end },
            { 23, function(p19, p20, p21) -- Line: 132
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMB/LMB2",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p21.RootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                        Player = p21.Player,
                        AbilityName = p21.AbilityName,
                        SkinName = p21.SkinName
                    });
                end },
            { 22, 25, "Attack" }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 4" },
            { 13, function(p22, p23, p24) -- Line: 157
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMB/LMB4",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p24.RootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0),
                        Player = p24.Player,
                        AbilityName = p24.AbilityName,
                        SkinName = p24.SkinName
                    });
                end },
            { 13, 18, "Attack" },
            { 54, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 88446909360368,
                Volume = 1
            }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v4.Stats.Godspeed = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p25) -- Line: 189, Name: Check
            return not p25:GetAttribute("BerserkerArmor");
        end
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Grab = {
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 12),
            Offset = CFrame.new(0, 0, -3)
        },
        Ragdoll = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 92773279295310,
                Volume = 1
            }
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Finisher = {
        Damage = 25,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 12),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 136180435181067,
                Volume = 1
            }
        },
        Ragdoll = {
            Time = 3
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    TargetFinisher = {
        Damage = 40,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move + 1,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.1
        },
        Ragdoll = {
            Time = 3
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Lightning Speed"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Slash = {
        Damage = 50,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Ragdoll = {
            Time = 2
        },
        HitSounds = {
            Hit = {
                SoundId = 88446909360368,
                Volume = 1
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.1
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Rice Spirit"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 6,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 115429462036490,
                Volume = 1
            }
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Sword Throw"] = {
    DamageThreshold = 20,
    Active = true,
    Actionable = {
        Active = true
    },
    Impale = {
        Damage = 30,
        Priority = Enums.Intangible.Move + 1,
        HitRemotes = { v4.Resources.Hit }
    },
    Pull = {
        Damage = 30,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    }
};
v4.Stats["Heat Lightning"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -3)
        },
        HitSounds = {
            Hit = {
                SoundId = 75147621894315,
                Volume = 1
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 1,
            Time = 0.4,
            Velocity = Vector3.new(0, 30, 0)
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.HeatLightningHit }
    }
};
v4.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p26) -- Line: 481, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v27 = TableUtil.Copy(p26.Stats, true);

            if p26.Character:GetAttribute("BerserkerArmor") then
                v27.PoseMusic = "BerserkerPoseMusic";
                v27.StartAnim = "BerserkerPoseTransition";
                v27.LoopAnim = "BerserkerPoseIdle";
            end;

            return v27;
        end
    }
};
v4.Stats.Block = {
    From = "Combat.Block"
};
v4.Stats["Thunderclap & Flash"] = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Block = {
        Blockable = false,
        BlockBreak = false,
        PerfectBlockable = false,
        Unblockable = true
    },
    Hitbox = {
        Size = Vector3.new(12, 8, 28),
        Offset = CFrame.new(0, 0, 0)
    },
    HitRemotes = { v4.Resources.HeatLightningHit },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 112515613867410,
            Volume = 1
        }
    },
    Leap = {
        Damage = 40,
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.1
        },
        Hitbox = {
            Size = Vector3.new(12, 30, 28),
            Offset = CFrame.new(0, 25, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 112515613867410,
                Volume = 1
            }
        },
        Meter = {
            RequiredAmount = 30,
            RemoveMeter = false
        },
        HitRemotes = { v4.Resources.HeatLightningHit },
        Ragdoll = {
            Time = 3
        },
        Stun = {
            Time = 1
        }
    }
};
v4.Stats["Flaming Thunder Dragon"] = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Freeze = {
        Stun = 3
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 12, 12),
        Offset = CFrame.new(0, 0, 0)
    },
    Ragdoll = {
        Time = 6
    },
    Stun = {
        Time = 1
    },
    HitRemotes = { v4.Resources.Hit }
};
v4.Stats.Impale = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        Damage = 35,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1.35
        },
        Block = {
            Unblockable = true
        }
    },
    Impale = {
        Damage = 35,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 1.35
        },
        Block = {
            BlockBreak = true
        }
    },
    Throw = {
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 2
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 10,
                Time = 0.1
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.1
            } },
        Block = {
            Unblockable = true
        }
    }
};
v4.Stats["Thunderclap Beatdown"] = {
    DamageThreshold = 20,
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Damage = 20,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 1.35
        },
        Block = {
            Unblockable = true
        }
    },
    Finisher = {
        Damage = 100,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        Ragdoll = {
            Time = 25
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 7.5,
        AfterMove = true
    }
};
v4.Stats["Travelling Slice Flurry"] = {
    Active = true,
    Frequency = 3,
    Damage = 3,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    HitSounds = {
        Hit = {
            SoundId = 126888360274402,
            Volume = 1
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 10),
        Offset = CFrame.new(0, 0, -5)
    },
    Stun = {
        Time = 1
    },
    HitRemotes = { v4.Resources.Hit }
};
v4.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v4.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v4;