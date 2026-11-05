  

 

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
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 11, 15, "Attack" } },
        HitSounds = {
            Hit = {
                SoundId = 133426461876480,
                Volume = 1
            }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 12, 16, "Attack" } },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Damage = 5,
        Sequence = {
            { 0, "Start" },
            { 13, 16, "Attack" },
            { 17, function(p5, p6, p7, p8, p9) -- Line: 94
                    p5.Hit[p8.FullName] = {};
                end },
            { 22, 25, "Attack" }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 13, 18, "Attack" }, { 35, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 107306570637053,
                Volume = 1
            }
        },
        HitRemotes = { v4.Resources.Hit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v4.Stats["Sword Manipulation"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p10) -- Line: 130, Name: Check
            return not p10:GetAttribute("Mode");
        end
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 100
    }
};
v4.Stats["Perpetual Night"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Barrage = {
        Damage = 2,
        Stun = 0.8,
        HitAnimations = "Default",
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
        HitSounds = {
            Hit = {
                SoundId = 117636288709783,
                Volume = 1
            }
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Dark Moon"] = {
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
        HitSounds = {
            Hit = {
                SoundId = 98677870553736,
                Volume = 1
            }
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
    }
};
v4.Stats["Moon-Dragon Ringtail"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 20
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
        HitSounds = {
            Hit = {
                SoundId = 98677870553736,
                Volume = 1
            }
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Ringtail = {
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
                SoundId = 125552707681306,
                Volume = 1
            }
        },
        HitRemotes = { v4.Resources.Hit }
    }
};
v4.Stats["Pearl Flower Moongazing"] = {
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
        HitSounds = {
            Hit = {
                SoundId = 129342586821091,
                Volume = 1
            }
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
    }
};
v4.Stats["Loathsome Moon"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        Manual = true
    },
    Hit = {
        Damage = 10,
        Knockback = nil,
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
    }
};
v4.Stats["Moon Spirit Calamitous Eddy"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40
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
        HitSounds = {
            Hit = {
                SoundId = 96626130053420,
                Volume = 1
            }
        },
        Stun = {
            Time = 1
        },
        HitRemotes = { v4.Resources.Hit }
    },
    Swirl = {
        Damage = 3,
        HitAnimations = "Default",
        Hitbox = {
            Size = 15
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 3,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 86244073131702,
                Volume = 1
            }
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
        Transformer = function(p11) -- Line: 488, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v12 = TableUtil.Copy(p11.Stats, true);

            if p11.Character:GetAttribute("BerserkerArmor") then
                v12.PoseMusic = "BerserkerPoseMusic";
                v12.StartAnim = "BerserkerPoseTransition";
                v12.LoopAnim = "BerserkerPoseIdle";
            end;

            return v12;
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
        HitSounds = {
            Hit = {
                SoundId = 113309544377272,
                Volume = 1
            }
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
        HitSounds = {
            Hit = {
                SoundId = 110531216767960,
                Volume = 1
            }
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
    Damage = 75,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
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
v4.Stats["Drilling Slashes"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Drag = {
        Damage = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Slash = {
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
        Damage = 5,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v4.Resources.Hit },
        Lifesteal = {
            Type = "Flat",
            Amount = 9
        },
        Meter = {
            MeterGain = 0
        }
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
v4.Stats["Waning Moonswaths"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        Manual = true
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
        Stun = {
            Time = 1
        }
    },
    Drag = {
        Damage = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Slash = {
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
    }
};
v4.Stats.Moonbow = {
    Active = true,
    Damage = 45,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50
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