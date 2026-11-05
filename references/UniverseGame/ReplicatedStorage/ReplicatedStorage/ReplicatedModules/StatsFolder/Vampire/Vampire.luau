  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v2 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 6
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Resources = require(script.Resources)
};
v2.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 23, 25, "Attack" }, { 26, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 14255013145,
                Volume = 1
            }
        },
        HitRemotes = { v2.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 21, 23, "Attack" }, { 24, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 18, 20, "Attack" }, { 21, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 25, 27, "Attack" }, { 40, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 14255013727,
                Volume = 1
            }
        },
        HitRemotes = { v2.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
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
v2.Stats.Grab = {
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
};
v2.Stats.Regeneration = {
    Active = true,
    Heal = 1,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p3) -- Line: 152, Name: Check
            return p3.Humanoid.Health < p3.Humanoid.MaxHealth;
        end
    },
    Cooldown = {
        Time = 2.5,
        AfterMove = true
    },
    HitRemotes = { v2.Resources.Regeneration }
};
v2.Stats["Skeletal Fracture"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Active = true,
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    ["First Kick"] = {
        Damage = 8,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = {
                SoundId = 14255014342,
                Volume = 1
            }
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    ["Second Kick"] = {
        Damage = 12,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitSounds = {
            Hit = {
                SoundId = 14255302582,
                Volume = 1
            }
        },
        HitRemotes = { v2.Resources.LightHit }
    }
};
v2.Stats["Driving Force"] = {
    Active = true,
    Distance = 30,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Strike = {
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 11),
            Predict = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true
        },
        HitSounds = {
            Hit = v2.Resources.ForceHitSound
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Finisher = {
        Damage = 35,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 11),
            Predict = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = v2.Resources.ForceFinisherSound
        },
        HitRemotes = { v2.Resources.HeavyHit }
    }
};
v2.Stats["Shadow Bash"] = {
    Active = true,
    Damage = 25,
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
        Predict = false,
        HitboxType = "ClientHitbox",
        Offset = CFrame.identity
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    HitRemotes = { v2.Resources.LightHit },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = v2.Resources.ShadowBash
    }
};
v2.Stats["Flash Freeze"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -3)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = v2.Resources.FlashFreeze
    }
};
v2.Stats["Life Drain"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Active = true,
    CheckPVPSafe = true,
    Meter = {
        RequiredAmount = 30
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 0.85
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    HitAnimations = "Default",
    HitRemotes = { v2.Resources.LightHit },
    Drain = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Lifesteal = {
            Type = "Flat",
            Amount = 8.5
        },
        HitRemotes = { v2.Resources.Blood }
    },
    Throw = {
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        Ragdoll = {
            Time = 1.5
        }
    }
};

return v2;