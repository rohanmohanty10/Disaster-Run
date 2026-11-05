  

 

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
            { 16, function(p5, p6, p7) -- Line: 65
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Slash",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p7.RootPart.CFrame * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0),
                        Player = p7.Player,
                        AbilityName = p7.AbilityName,
                        SkinName = p7.SkinName
                    });
                end },
            { 16, 22, "Attack" }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 1-3" },
            { 15, function(p8, p9, p10) -- Line: 88
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Slash",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p10.RootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p10.Player,
                        AbilityName = p10.AbilityName,
                        SkinName = p10.SkinName
                    });
                end },
            { 15, 20, "Attack" }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 16, function(p11, p12, p13) -- Line: 110
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Slash",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p13.RootPart.CFrame * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0),
                        Player = p13.Player,
                        AbilityName = p13.AbilityName,
                        SkinName = p13.SkinName
                    });
                end },
            { 16, 21, "Attack" }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "SwingLMB 4" },
            { 15, function(p14, p15, p16) -- Line: 133
                    -- upvalues: u2 (ref)
                    u2.FireAllClients("Emit Particle V3", {
                        Path = "Particles/Slash",
                        AutoSerialize = true,
                        BypassRenderCap = true,
                        Origin = p16.RootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p16.Player,
                        AbilityName = p16.AbilityName,
                        SkinName = p16.SkinName
                    });
                end },
            { 15, 20, "Attack" },
            { 35, "End" }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v4.Stats["Burning Bones"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Slash = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    BigSlash = {
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            Size = 8,
            Predict = false
        },
        Knockback = {
            RelativeTowards = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 0.5
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    }
};
v4.Stats.Dance = {
    Active = true,
    Actionable = {
        Active = true
    },
    Slash = {
        Damage = 30,
        HitAnimations = "Default",
        Hitbox = {
            Predict = false,
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -2)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    }
};
v4.Stats["Flame Dance"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Finisher = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.1
        },
        Stun = {
            Time = 1.5
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    }
};
v4.Stats["Raging Sun"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Slash = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    }
};
v4.Stats["Clear Blue Sky"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    },
    Slash = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    BigSlash = {
        Damage = 40,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(5, 5, 5),
            Predict = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 40, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 4
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Sunflower Thrust"] = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
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
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 1
    }
};
v4.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p17) -- Line: 470, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v18 = TableUtil.Copy(p17.Stats, true);

            if p17.Character:GetAttribute("BerserkerArmor") then
                v18.PoseMusic = "BerserkerPoseMusic";
                v18.StartAnim = "BerserkerPoseTransition";
                v18.LoopAnim = "BerserkerPoseIdle";
            end;

            return v18;
        end
    }
};
v4.Stats.Block = {
    From = "Combat.Block"
};
v4.Stats["Solar Heat Haze"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 25
        }
    },
    Slash = {
        Damage = 30,
        HitAnimations = "Default",
        Hitbox = {
            Predict = false,
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    }
};
v4.Stats["Beneficient Radiance"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Slash = {
        Damage = 30,
        HitAnimations = "Default",
        Hitbox = {
            Predict = false,
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    }
};
v4.Stats["Dragon Sun Halo Head Dance"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Slash = {
        Damage = 30,
        HitAnimations = "Default",
        Hitbox = {
            Predict = false,
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -3)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    }
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
v4.Stats["Fake Rainbow"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Impale = {
        Damage = 35,
        Priority = Enums.Intangible.Move
    },
    Kick = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 40,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Cooldown = {
        Time = 3,
        AfterMove = true
    }
};
v4.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v4.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v4;