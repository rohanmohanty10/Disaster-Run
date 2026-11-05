  

 

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
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    Resources = require(script.Resources)
};
v2.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Priority = Enums.Intangible.Ragdoll,
        Sequence = { { 0, "Start" }, { 14, "Attack" }, { 20, "End" } },
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
                        Particle = ReplicatedStorage["Client Assets"].Universal.Universal_HitVFX,
                        Color = Color3.fromRGB(255, 255, 255)
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 118287787698236,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        HitSounds = {
            Hit = {
                SoundId = 112754277379887,
                Volume = 1
            }
        },
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
                        Particle = ReplicatedStorage["Client Assets"].Universal.UniversalHeavyVFX,
                        Color = Color3.fromRGB(255, 255, 255)
                    }
                }
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2.Stats.Roar = {
    Active = true,
    Damage = 0.4,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        BlockBreak = false,
        PerfectBlockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.identity
    },
    Ragdoll = {
        Time = 1
    },
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.1
    }
};
v2.Stats.Bite = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
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
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "Shadow_Hit",
                {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    LookAt = "Attacker",
                    Particle = ReplicatedStorage["Client Assets"].Universal.BloodVFX
                }
            }
        }
    },
    Block = {
        Unblockable = true
    },
    Stun = {
        Time = 0.6
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.new(0, 0, -3)
    },
    HitSounds = {
        Hit = {
            SoundId = 100123695696377,
            Volume = 1
        }
    }
};
v2.Stats.Jab = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
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
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.1
    },
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
                    Particle = ReplicatedStorage["Client Assets"].Universal.UniversalHeavyVFX,
                    Color = Color3.fromRGB(255, 255, 255)
                }
            }
        }
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.new(0, 0, -3)
    },
    Ragdoll = {
        Time = 2
    },
    HitSounds = {
        Hit = {
            SoundId = 103331481703093,
            Volume = 1
        }
    }
};
v2.Stats.Spit = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
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
    HitSounds = {
        Hit = {
            SoundId = 74194203409595,
            Volume = 1
        }
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Poison",
            Damage = 2.5,
            Overrides = {
                Lifetime = 5,
                Rate = 0.75
            }
        } },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    }
};
v2.Stats.Slam = {
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
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativeTowards = "Target",
        Speed = 35,
        Time = 0.15,
        Velocity = Vector3.new(0, 45, 0)
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.15
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true,
        BlockBreak = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.new(0, 0, -3)
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
v2.Stats.Grab = {
    From = "Combat.Grab",
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
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v2;