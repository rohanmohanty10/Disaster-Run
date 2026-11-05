  

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);
local v6 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = require(script.Moves)
    },
    Sounds = require(script.Sounds),
    Animations = require(script.Animations),
    Resources = require(script.Resources),
    Metadata = {
        PostRig = function(p5) -- Line: 50, Name: PostRig
            -- upvalues: CollectionService (copy)
            local Character = p5.Character;
            local Player = p5.Player;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player then
                Player:HasAppearanceLoaded();
            end;

            CollectionService:AddTag(Character, "Summoned");
        end
    }
};
v6.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    MaxCombo = 4,
    ComboTick = 1,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.15,
        HitRemotes = { v6.Resources.LightHit },
        HitSounds = { v6.Resources["LMB Hit"] },
        Sequence = { { 0, "Start" }, { 19, 25, "Attack" }, { 28, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = {
            { 0, "Start" },
            { 12, 15, "Attack" },
            { 13, function(p7) -- Line: 93
                end },
            { 23, "End" }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = { { 0, "Start" }, { 17, 23, "Attack" }, { 26, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.25,
        HitRemotes = { v6.Resources.HeavyHit },
        HitSounds = { v6.Resources["LMB Finisher Hit"] },
        Sequence = { { 0, "Start" }, { 26, 32, "Attack" }, { 36, "End" } }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v6.Stats["Spin Charge"] = {
    Active = true,
    MaxCharge = 4,
    ChargeRate = 0.2,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    }
};
v6.Stats["Nail Barrage"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Jab = {
        Stun = 0.35,
        Damage = 5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, -2, -4)
        },
        Blockable = {
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        HitRemotes = { v6.Resources.LightHit },
        HitSounds = { v6.Resources["Nail Barrage Hit"] }
    },
    Barrage = TableUtil.Reconcile({
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, -2, -4)
        },
        HitRemotes = { v6.Resources.LightHit },
        HitSounds = { v6.Resources["Nail Barrage Hit"] }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, -2, -4)
        },
        HitRemotes = { v6.Resources.HeavyHit },
        HitSounds = { v6.Resources["Nail Barrage Finisher"] },
        Ragdoll = {
            Time = 2
        }
    }, BaseStatsModule.Stand_Barrage.Finisher)
};
v6.Stats.Tusk = {
    Active = true,
    Damage = 20,
    Stun = 1,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    HitRemotes = { v6.Resources.Blood },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    }
};
v6.Stats["Lesson 2"] = {
    Active = true,
    Damage = 20,
    Stun = 1,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitRemotes = { v6.Resources.Blood },
    LessonEffect = {
        Damage = 2,
        Priority = Enums.Intangible.Quickstep,
        HitRemotes = { v6.Resources.Blood },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 2
        }
    }
};
v6.Stats["Herbal Tea"] = {
    Active = true,
    HoldDuration = 4,
    MeterGain = 10,
    Heal = 35,
    MeterOverTime = 30,
    HealOverTime = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Block = {
        Unblockable = true,
        BypassCounter = true,
        PerfectBlockable = false
    }
};
v6.Stats.Pose = {
    From = "Combat.Pose"
};
v6.Stats.Block = {
    From = "Combat.Block"
};
v6.Stats.Bloodshed = {
    Active = true,
    Armor = true,
    Stun = 0.25,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    HitRemotes = { v6.Resources.Blood },
    HitSounds = { v6.Resources["Bloodshed Hit"] },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, -2, -4)
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    }
};
v6.Stats["Dark Determination"] = {
    Active = true,
    Time = 20,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RemoveMeter = false,
        RequiredAmount = 100
    }
};
v6.Stats["Lesson 4"] = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 5,
        Offset = CFrame.identity
    },
    Meter = {
        RequiredAmount = 25
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    HitRemotes = { v6.Resources.Blood },
    HitSounds = { v6.Resources["Lesson 4 Hit"] },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Ragdoll = {
        Time = 3
    }
};
v6.Stats["Lesson 3"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
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
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        HitRemotes = { v6.Resources.Blood },
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
            Time = 3
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v6.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v6.Stats["Nail Glide"] = {
    Speed = 40,
    Duration = 4,
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    }
};

return v6;