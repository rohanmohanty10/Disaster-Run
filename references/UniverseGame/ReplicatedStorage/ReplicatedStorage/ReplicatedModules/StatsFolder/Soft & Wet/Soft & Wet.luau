  

 

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
Knit.OnStart():andThen(function() -- Line: 20
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
                Priority = 3
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
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
        MaxMasteryRank = 4,

        PointCap = function(p2) -- Line: 52, Name: PointCap
            return 1;
        end
    }
};
v3.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 10, 15, "Attack" }, { 19, "End" } },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 96162544792826,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 10, 15, "Attack" }, { 19, "End" } },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 93110039150014,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p4, p5) -- Line: 110, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p4.Stats;

            if not Knit.CollectionService:HasTag(p4.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v3.Stats["Rush Attack"] = TableUtil.Reconcile(v3.Stats["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v3.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    VoicelineRange = 2,
    LeaveParts = v3.Resources.LeaveParts,
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(197, 239, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(202, 243, 255)) })
};
v3.Stats.Barrage = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = v3.Resources.SoundInfo.Barrage.Hit
    },
    Finisher = {
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = v3.Resources.SoundInfo.Barrage.Finisher
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = v3.Resources.SoundInfo.Barrage.Hit
    },
    ClashFinisher = {
        HitSounds = v3.Resources.SoundInfo.Barrage.Finisher
    }
}, BaseStatsModule.Stand_Barrage);
v3.Stats["\"So slippery!\""] = {
    Active = true,
    Frequency = 3,
    Damage = 2,
    Stun = 0.8,
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
        Size = 8,
        Offset = CFrame.identity
    },
    Block = {
        PerfectBlockable = false
    },
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    HitRemotes = { v3.Resources.LightHit },
    HitSounds = v3.Resources.SoundInfo.SoSlippery
};
v3.Stats["Zero Friction"] = {
    Active = true,
    Properties = {
        Armor = true
    },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 11,
        AfterMove = true
    },
    LowKick = {
        Damage = 20,
        Stun = 0.8,
        HitAnimations = "Default",
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
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = v3.Resources.SoundInfo.ZeroFriction.First
    },
    UpperKick = {
        Damage = 20,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.2,
            Velocity = Vector3.new(0, 20, 0)
        },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = v3.Resources.SoundInfo.ZeroFriction.Second
    }
};
v3.Stats["Friction Plunder"] = {
    Active = true,
    MaxDuration = 3,
    BubblesPerSecond = 3,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p6) -- Line: 303, Name: Check
            return not p6:GetAttribute("SummonDisabled");
        end
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Explosion = {
        Damage = 10,
        HitSounds = v3.Resources.SoundInfo.ExplosiveBurst,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Plunder = {
        Damage = 20,
        Stun = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v3.Resources.LightHit },
        Block = {
            Unblockable = false
        },
        HitSounds = v3.Resources.SoundInfo.LMB
    },
    Finisher = {
        Damage = 20,
        Stun = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v3.Resources.HeavyHit },
        Block = {
            Unblockable = false
        },
        HitSounds = v3.Resources.SoundInfo.SkullCaving,
        Knockback = {
            RelativeTowards = "Target",
            Speed = 40,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        }
    }
};
v3.Stats["Spin Kick"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.new(0, 0, -5)
    },
    HitRemotes = { v3.Resources.LightHit },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    }
};
v3.Stats["Vision Plunder"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Startup = {
        Damage = 10,
        Stun = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v3.Resources.LightHit },
        Block = {
            Unblockable = true
        }
    },
    FaceSpin = {
        Damage = 2,
        Priority = Enums.Intangible.Move
    },
    Blind = {
        Damage = 10,
        Priority = Enums.Intangible.Move
    },
    Finish = {
        Damage = 2,
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
v3.Stats["Bubble Trap"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p7) -- Line: 511, Name: Check
            return not p7:GetAttribute("SummonDisabled");
        end
    },
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.new(0, 0, -5)
    },
    Block = {
        PerfectBlockable = true
    },
    Ragdoll = {
        Time = 2
    },
    HitSounds = {
        Hit = {
            SoundId = 112864750936533,
            Volume = 2.5
        }
    },
    Explosion = {
        Damage = 10,
        Priority = Enums.Intangible.Ragdoll,
        HitSounds = v3.Resources.SoundInfo.ExplosiveBurst,
        Knockback = {
            RelativePart = "Target",
            Speed = 25,
            Time = 0.1,
            Velocity = Vector3.new(0, 10, 0)
        },
        Ragdoll = {
            Time = 2
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.new(0, 0, 0)
        }
    }
};
v3.Stats["Bubble Area"] = {
    Active = true,
    Damage = 1,
    Stun = 0.3,
    DetectionRange = 25,
    BubbleCount = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Priority = Enums.Intangible.Move,
    Hitbox = {
        Size = Vector3.new(2.5, 2.5, 2.5)
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    }
};
v3.Stats.Block = {
    From = "Combat.Block"
};
v3.Stats["Shovel Slam"] = {
    Active = true,
    Actionable = {
        Active = true,

        Check = function(p8) -- Line: 618, Name: Check
            return not p8:GetAttribute("SummonDisabled");
        end
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Swing = {
        Damage = 10,
        Stun = 1,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitSounds = v3.Resources.SoundInfo.ShovelSlam
    },
    Stab = {
        Damage = 15,
        Stun = 1,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Bleed"
            } },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitSounds = v3.Resources.SoundInfo.ShovelSlam
    },
    Slam = {
        Damage = 25,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 13,
            Predict = false,
            Offset = CFrame.new(0, 0, -9)
        },
        Block = {
            Blockable = true,
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 2.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.25,
            Velocity = Vector3.new(0, 5, 0)
        }
    }
};
v3.Stats["Explosive Burst"] = {
    Active = true,
    Damage = 35,
    Stun = 0.3,
    MaxDuration = 3,
    BubblesPerSecond = 3,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Block = {
        PerfectBlockable = false
    },
    BubbleExplosion = {
        Damage = 10,
        HitSounds = v3.Resources.SoundInfo.ExplosiveBurst,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.new(0, 0, 0)
        }
    }
};
v3.Stats.Pose = {
    From = "Combat.Pose"
};
v3.Stats["Go Beyond"] = {
    Active = true,
    Damage = 50,
    Stun = 0.7,
    Priority = 10000,
    GoBeyond = true,
    TrueDamage = true,
    IgnoreLoveTrain = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        MasteryRank = 4,

        Check = function(p9) -- Line: 771, Name: Check
            return not p9:GetAttribute("SummonDisabled");
        end
    },
    Meter = {
        RequiredAmount = 100
    },
    Properties = {
        Intangible = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Block = {
        BypassCounter = true,
        Unblockable = true
    },
    BubbleExplosion = {
        Damage = 25,
        GoBeyond = true,
        IgnoreLoveTrain = true,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.1,
            Velocity = Vector3.new(0, 5, 0)
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 22,
            Offset = CFrame.new(0, 0, 0)
        },
        HitSounds = v3.Resources.SoundInfo.GoBeyond,
        Block = {
            BypassCounter = true,
            Unblockable = true
        }
    }
};
v3.Stats["Bubble Transportation"] = {
    Active = true,
    MaxDuration = 5,
    Actionable = {
        Active = true,
        Stunned = false
    },
    Properties = {
        Intangible = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    }
};
v3.Stats["Soft Pinnacle"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 80
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 9),
            HitboxType = nil,
            Offset = CFrame.new(0, 0, -4.5)
        }
    },
    Burst = {
        Damage = 10,
        MinHealth = 1,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Normal = {
        Damage = 3.75,
        MinHealth = 1,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Barrage = {
        Damage = 1.25,
        MinHealth = 1,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Slam = {
        Damage = 15,
        MinHealth = 1,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Damage = 30,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.2,
            Velocity = Vector3.new(0, 5, 0)
        }
    }
};
v3.Stats.Grab = {
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
v3.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v3;