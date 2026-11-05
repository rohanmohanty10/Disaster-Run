  

 

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
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 13, 20, "Attack" } },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 10, 16, "Attack" } },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 17, 24, "Attack" } },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 17, 23, "Attack" }, { 35, "End" } },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v4.Stats.Regenerate = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p5) -- Line: 114, Name: Check
            return not p5:GetAttribute("Mode");
        end
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    }
};
v4.Stats["Wintry Icicles"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 5,
        Stun = 2,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Slam = {
        Damage = 25,
        Stun = 0.8,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 30),
            Offset = CFrame.new(0, 0, -15)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.1,
            Velocity = Vector3.new(0, 20, 0)
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Lotus Vines"] = {
    Active = true,
    Damage = 10,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 16,
        Offset = CFrame.new(0, 0, -2)
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Freeze",
            Overrides = {
                Lifetime = 5
            }
        } },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 6,
        Time = 0.1
    },
    Stun = {
        Time = 1
    },
    HitRemotes = { v4.Resources.Hit }
};
v4.Stats["Fatal Flash"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Startup = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 8, 28),
            Offset = CFrame.new(0, 0, -14)
        },
        Stun = {
            Time = 3
        }
    },
    Dash = {
        Damage = 25,
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Hitbox = {
            Size = Vector3.new(14, 8, 28),
            Offset = CFrame.new(0, 0, 0)
        },
        Ragdoll = {
            Time = 1
        }
    }
};
v4.Stats["Frozen Lotus"] = {
    Active = true,
    Damage = 10,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
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
    HitRemotes = { v4.Resources.Hit }
};
v4.Stats["Freezing Clouds"] = {
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
        HitRemotes = { v4.Resources.Hit }
    },
    Swirl = {
        Damage = 6,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(8, 8, 8)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 3,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p6) -- Line: 386, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v7 = TableUtil.Copy(p6.Stats, true);

            if p6.Character:GetAttribute("BerserkerArmor") then
                v7.PoseMusic = "BerserkerPoseMusic";
                v7.StartAnim = "BerserkerPoseTransition";
                v7.LoopAnim = "BerserkerPoseIdle";
            end;

            return v7;
        end
    }
};
v4.Stats.Block = {
    From = "Combat.Block"
};
v4.Stats.Catastrophe = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 5,
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
        HitRemotes = { v4.Resources.Hit }
    },
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Mirror of Misfortune"] = {
    Active = true,
    Damage = 69,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(40, 15, 70),
        Offset = CFrame.new(0, 5, -35)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.1,
        Velocity = Vector3.new(0, 30, 0)
    },
    Ragdoll = {
        Time = 3
    }
};
v4.Stats["Moonlit Rushdown"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Finisher = {
        Damage = 100,
        Priority = Enums.Intangible.Move + 1,
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Velocity = Vector3.new(-25, 0, 0),
            Time = 0.3
        },
        Ragdoll = {
            Time = 7
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Startup = {
        Damage = 25,
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        Hitbox = {
            Size = Vector3.new(14, 8, 28),
            Offset = CFrame.new(0, 0, 0)
        },
        Stun = {
            Time = 1
        }
    }
};
v4.Stats["Body Absorption"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Bite = {
        Damage = 20,
        Priority = Enums.Intangible.Move + 1
    },
    Startup = {
        Damage = 5,
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
        HitRemotes = { v4.Resources.Hit }
    },
    Finisher = {
        Damage = 20,
        Priority = Enums.Intangible.Move + 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 1.2
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Barren Hanging Garden"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Bite = {
        Damage = 20,
        Priority = Enums.Intangible.Move + 1
    },
    Startup = {
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Hit = {
        Damage = 2,
        Priority = Enums.Intangible.Move + 1
    },
    Finisher = {
        Damage = 10,
        Priority = Enums.Intangible.Move + 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.2
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats.Moonbow = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(13, 8, 14),
        Offset = CFrame.new(0, 3, -8)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
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