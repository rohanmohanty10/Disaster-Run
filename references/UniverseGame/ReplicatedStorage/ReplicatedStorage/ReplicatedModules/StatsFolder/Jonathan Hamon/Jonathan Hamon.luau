  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local EnableTrail = require(script.EnableTrail);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local v2 = ClientAssets["Jonathan Hamon"];
local v3 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v2.Global.Light
        }
    }
};
local v4 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v2.Global.Heavy
        }
    }
};
local v5 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v2.__Pluck.Hit
        }
    }
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 12, 15, "Attack" }, { 16, "End" } },
        Stun = {
            Time = 0.75,
            StunDecay = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14264218162,
                Volume = 1
            }
        },
        HitRemotes = { v3 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 18, 20, "Attack" }, { 22, "End" } },
        Stun = {
            Time = 0.75,
            StunDecay = true
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 24, 26, "Attack" }, { 27, "End" } },
        Stun = {
            Time = 1,
            StunDecay = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14264218560,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 19, 21, "Attack" }, { 28, "End" } },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 14264217850,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["Pluck LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 21, 23, "Attack" }, { 27, "End" } },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -5.5)
        },
        Stun = {
            Time = 0.85,
            StunDecay = true
        },
        Block = {
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 14282524031,
                Volume = 1
            }
        },
        HitRemotes = { v5 }
    }, BaseStatsModule.Rush_Attack),
    ["Pluck LMB-2"] = TableUtil.Reconcile({
        Speed = 1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 11, 13, "Attack" }, { 26, "End" } },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -5.5)
        },
        Stun = {
            Time = 0.85,
            StunDecay = true
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v5 }
    }, BaseStatsModule.Rush_Attack),
    ["Pluck LMB-3"] = TableUtil.Reconcile({
        Speed = 1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 14, 16, "Attack" }, { 26, "End" } },
        Stun = {
            Time = 1.15,
            StunDecay = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -5.5)
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v5 }
    }, BaseStatsModule.Rush_Attack),
    ["Pluck LMB-4"] = TableUtil.Reconcile({
        Speed = 1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 37, 39, "Attack" }, { 70, "End" } },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -5.5)
        },
        Block = {
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 14282524227,
                Volume = 1
            }
        },
        HitRemotes = { v5 }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p6, p7) -- Line: 290, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p6.Stats;

            if Knit.CollectionService:HasTag(p6.Character, "PluckToggled") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "Pluck LMB";
            end;

            return Stats;
        end,

        PreAnim = function(p8, p9) -- Line: 301, Name: PreAnim
            -- upvalues: EnableTrail (copy)
            local _ = p8.Player;
            local Character = p8.Character;
            local _ = p8.Stats;
            local _ = Character.Humanoid;
            local _ = Character.HumanoidRootPart;
            local _ = Character.Stand;
            local Count = p9.MoveState.Count;

            if Count == 1 then
                EnableTrail(Character, { "Left", true });

                return;
            end;

            if Count == 2 then
                EnableTrail(Character, { "Right", true });

                return;
            end;

            if Count == 3 then
                EnableTrail(Character, { "Both", true });

                return;
            end;

            if Count == 4 then
                EnableTrail(Character, { "Both", true });
            end;
        end,

        PostAnim = function(p10, p11) -- Line: 322, Name: PostAnim
            -- upvalues: EnableTrail (copy)
            local _ = p10.Player;
            local Character = p10.Character;
            local _ = p10.Stats;
            local _ = Character.Humanoid;
            local _ = Character.HumanoidRootPart;
            local _ = Character.Stand;
            EnableTrail(Character, { "Both", false });
        end
    }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Grab = {
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
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p12, p13) -- Line: 363, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p12.Character, true);
        end,

        PoseEnd = function(p14, p15) -- Line: 366, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p14.Character, false);
        end
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
};
v1["Ripple Charge"] = {
    Active = true,
    MaxHamon = 4,
    ChargeRate = 0.175,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 1.5,
        AfterMove = true
    }
};
v1["Overdrive Barrage"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Damage = 1,
    Stun = {
        Time = 0.65
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14264219559,
            Volume = 1
        }
    },
    HitRemotes = { v3 },
    HitAnimations = "Default",
    ["Feint Jab"] = {
        Stun = {
            Time = 1.15
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v3 }
    },
    ["Finisher Jab"] = {
        Damage = 15,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 1
        },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.3
        },
        Block = {
            BlockBreak = true
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 14264219346,
                Volume = 1
            }
        }
    }
};
v1["Overhead Strike"] = {
    Active = true,
    Damage = 27.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
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
            SoundId = 14226882866,
            Volume = 1
        }
    },
    HitRemotes = { v5 }
};
v1["Scarlet Overdrive"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Properties = {
        Armor = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.3,
        Velocity = Vector3.new(0, 10, 0)
    },
    Ragdoll = {
        Time = 1
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 2.5,
            Overrides = {
                Lifetime = 5,
                Rate = 0.5
            }
        } },
    Stun = {
        Time = 0.65
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 14226880542,
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
                    Particle = v2["Scarlet Overdrive"].ScarletHit
                }
            }
        }
    }
};
v1["Sendo Ripple Overdrive"] = {
    Active = true,
    Damage = 4,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 33
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(26.488, 10, 25.462),
        Offset = CFrame.new(0, 1, 0)
    },
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.05
    },
    HitRemotes = {
        v3,
        {
            Name = "Output",
            Clients = { "__Data.AttackerPlayer" },
            Arguments = { "FX", "BoxCameraShake", "Vibration" }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 10575725181,
            Volume = 2
        }
    }
};
v1["Sword Stab"] = {
    Active = true,
    Damage = 22.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18.5,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Properties = {
        Armor = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 14226883474,
            Volume = 1
        }
    },
    HitRemotes = { v5 }
};
v1.Purification = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Damage = 28.5,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14226921760,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    HitRemotes = { v5 },
    Kick = {
        Damage = 7.5,
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
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14226883797,
                Volume = 1
            }
        },
        HitRemotes = { v3 }
    }
};
v1["Zoom Punch"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 14.5),
        Offset = CFrame.new(0, 0, -6.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Stun = {
        Time = 0.955
    },
    Meter = {
        RequiredAmount = 15
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14226881300,
            Volume = 1
        }
    },
    HitRemotes = { v4 }
};
v1["Fencing Guard"] = {
    Active = true,
    Damage = 20.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14226883474,
            Volume = 1
        }
    },
    HitRemotes = { v5 }
};
v1["Bull Rush"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 33
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8.85),
        Offset = CFrame.new(0, 0, -4.25)
    },
    Stun = {
        Time = 1.15
    },
    Block = {
        PerfectBlockable = false
    },
    Attack = {
        Damage = 32.5,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3,
            Velocity = Vector3.new(0, 10, 0)
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14226880377,
                Volume = 1
            }
        },
        HitRemotes = { v4 }
    },
    ["Wall Hit"] = {
        Knockback = {
            RelativePart = "Attacker",
            Speed = -10,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            PerfectBlockable = false
        }
    }
};
v1["Luck & Pluck"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 22.5,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Damage = 13,
    Stun = {
        Time = 1
    },
    Meter = {
        RequiredLevel = 1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14226921760,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    HitRemotes = { v5 },
    Followup = {
        Damage = 11.5,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.3
        },
        Stun = {
            Time = 1.15
        },
        HitSounds = {
            Hit = {
                SoundId = 14226921760,
                Volume = 1
            }
        },
        HitRemotes = { v5 }
    }
};
v1["Sunlight Yellow Overdrive"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    Stun = {
        Time = 0.75
    },
    HitAnimations = "Default",
    HitRemotes = { v3 },
    ["Face Slam"] = {
        Damage = 15,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4 }
    },
    ["Chain Attack"] = {
        Damage = 3,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v3 }
    },
    Hit = {
        Damage = 1,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v3 }
    },
    Release = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4 },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3
        },
        Ragdoll = {
            Time = 2.5
        }
    }
};
v1["Ripple Infusion"] = {
    Active = true,
    Armor = true,
    BuffDuration = 10,
    Damage = 28.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.75
    },
    HitSounds = {},
    HitRemotes = { v5 }
};
v1["Righteous Fury"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 22.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true
    },
    Stun = {
        Time = 2.5
    },
    Meter = {
        RequiredAmount = 25
    },
    Hit = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 10536272068,
                Volume = 2
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
                        Particle = ClientAssets["Jonathan Hamon"]["Righteous Fury"].Hit
                    }
                }
            }
        }
    },
    HamonHit = {
        Damage = 3,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
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
                        Particle = ClientAssets["Jonathan Hamon"]["Righteous Fury"].Hit
                    }
                }
            }
        }
    },
    Throw = {
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 65,
            Time = 0.3,
            Velocity = Vector3.new(0, 25, 0)
        },
        Ragdoll = {
            Time = 1.5
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
                        Particle = ClientAssets["Jonathan Hamon"]["Righteous Fury"].Explosion
                    }
                }
            }
        }
    }
};
v1["Metal Silver Overdrive"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Armor = true,
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Damage = 30,
    Stun = {
        Time = 2.5
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    HitAnimations = "Default",
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
                    Particle = ClientAssets["Jonathan Hamon"]["Metal Silver Overdrive"].Hit
                }
            }
        }
    },
    Followup = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.3
        },
        Ragdoll = {
            Time = 1.5
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
                        Particle = ClientAssets["Jonathan Hamon"]["Metal Silver Overdrive"].Explode
                    }
                }
            }
        }
    }
};
v1["Luck & Pluck Toggle"] = {
    Active = true,
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1.Standoff = {
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Active = true,
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Stun = {
        Time = 5
    },
    Followup = {
        Damage = 42.5,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.3
        },
        Ragdoll = {
            Time = 1.5
        }
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            PluckOff = {
                Visible = true,
                Priority = 1
            },
            PluckOn = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            ["Ripple Charge"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false,
                Description = "Hold to continously charge meter at a slow pace"
            },
            ["Luck & Pluck Toggle"] = {
                DefaultKeybind = "Z",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Overdrive Barrage"] = {
                DefaultKeybind = "E",
                State = "PluckOff",
                Unlocked = true,
                Description = "Unleash a barrage of hamon infused blows as the key is held down before finishing with a heavy punch"
            },
            ["Overhead Strike"] = {
                DefaultKeybind = "E",
                State = "PluckOn",
                Unlocked = true,
                Description = "Slash your sword downwards."
            },
            ["Scarlet Overdrive"] = {
                DefaultKeybind = "R",
                State = "PluckOff",
                Unlocked = true,
                Description = "Channel your hamon and unleash it in a fiery heavy punch, setting your opponent on fire."
            },
            ["Sword Stab"] = {
                DefaultKeybind = "R",
                State = "PluckOn",
                Unlocked = true,
                Description = "Perform a heavy sword slash forwards."
            },
            ["Sendo Ripple Overdrive"] = {
                DefaultKeybind = "R+",
                State = "PluckOff",
                Description = "Channel your hamon and unleash it below you in a ripple motion.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Purification = {
                DefaultKeybind = "R+",
                State = "PluckOn",
                Description = "Throw out a kick then follow it up with a sword slash.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Zoom Punch"] = {
                DefaultKeybind = "T",
                State = "PluckOff",
                Description = "Extend your arm forward for a quick blow.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Fencing Guard"] = {
                DefaultKeybind = "T",
                State = "PluckOn",
                Description = "Dash forwards with a heavy sword slash.",
                LevelRequirement = 30,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Bull Rush"] = {
                DefaultKeybind = "Y",
                State = "PluckOff",
                Description = "Charge forward with great force, unleashing a heavy blow when u hit a target.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Luck & Pluck"] = {
                DefaultKeybind = "Y",
                State = "PluckOn",
                Description = "Unleash 2 heavy slashes with your sword.",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Sunlight Yellow Overdrive"] = {
                DefaultKeybind = "G",
                State = "PluckOff",
                Description = "Unleash a powerful kick before following it up with a devastating beatdown.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Ripple Infusion"] = {
                DefaultKeybind = "G",
                State = "PluckOn",
                Description = "Channel your hamon before unleashing a heavy sword slash.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Righteous Fury"] = {
                DefaultKeybind = "H",
                State = "PluckOff",
                Description = "Grab your opponent before channeling your hamon inside them, knocking them away in the process.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Metal Silver Overdrive"] = {
                DefaultKeybind = "H",
                State = "PluckOn",
                Description = "Swing your sword in front of you before impaling the target, then channel your hamon before knocking them away.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Standoff = {
                DefaultKeybind = "B",
                Description = "",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 14097643973,
            ["LMB-2"] = 14097646338,
            ["LMB-3"] = 14097650394,
            ["LMB-4"] = 14097653050,
            ["Pluck LMB-1"] = 14112492085,
            ["Pluck LMB-2"] = 14112497857,
            ["Pluck LMB-3"] = 14112509074,
            ["Pluck LMB-4"] = 14112508063,
            ["Hamon Charge Startup"] = 10441557592,
            ["Hamon Charge Loop"] = 10441559558,
            ["Overdrive Barrage"] = 14091071298,
            ["Scarlet Overdrive"] = 14033221437,
            ["Sendo Ripple Overdrive"] = 10539686054,
            ["Zoom Punch"] = 14050771951,
            ["Bull Rush Startup"] = 14062051477,
            ["Bull Rush Run"] = 14062053164,
            ["Bull Rush Wall Hit"] = 14062054990,
            ["Bull Rush End"] = 14062056454,
            ["Bull Rush End No Hit"] = 14079554125,
            ["Sunlight Yellow Overdrive"] = 14202494477,
            ["Sunlight Yellow Overdrive Followup"] = 14202539785,
            ["Sunlight Yellow Overdrive Victim"] = 14202497438,
            ["Sunlight Yellow Overdrive Camera"] = 14202525595,
            ["Righteous Fury Startup"] = 10523113554,
            ["Righteous Fury Followup"] = 10523134118,
            ["Righteous Fury Victim"] = 10523136400,
            Standoff = 14032622807,
            ["Standoff Followup"] = 14032625894,
            ["Standoff Victim"] = 14032629183,
            ["Overhead Strike"] = 14030220872,
            ["Sword Stab"] = 14030226924,
            Purification = 14030223405,
            ["Fencing Guard"] = 14030232315,
            ["Luck & Pluck"] = 14050918866,
            ["Ripple Infusion"] = 14030235918,
            ["Metal Silver Overdrive"] = 14030255163,
            ["Metal Silver Overdrive Followup"] = 14030248991,
            ["Metal Silver Overdrive Victim"] = 14030252123,
            ["Luck & Pluck Equip"] = 10481736577,
            ["Luck & Pluck Unequip"] = 10481757171,
            PoseIdle = 11159566929,
            PoseTransition = 11159565402,
            PluckPoseIdle = 11159594979,
            PluckPoseTransition = 11159564007
        },
        Movement = {
            Walk = 10344439263,
            Run = 10344441371,
            PluckWalk = 10481741482,
            PluckRun = 10481745496
        },
        Idle = {
            Idle = 10344437299,
            PluckIdle = 10481749940
        }
    },
    Stats = v1,
    Sounds = {
        ["Charge Voiceline"] = {
            SoundId = 14391964878,
            Volume = 1
        },
        ["Charge SFX"] = {
            SoundId = 14391964546,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 14264217693,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 14264219451,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14264218397,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 14264219185,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14264217981,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 14264218995,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14264218732,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 14264218873,
            Volume = 1
        },
        ["Pluck LMB-1"] = {
            SoundId = 14282524128,
            Volume = 1
        },
        ["Pluck LMB-1-Voiceline"] = {
            SoundId = 14264219451,
            Volume = 1
        },
        ["Pluck LMB-2"] = {
            SoundId = 14282524456,
            Volume = 1
        },
        ["Pluck LMB-2-Voiceline"] = {
            SoundId = 14264219185,
            Volume = 1
        },
        ["Pluck LMB-3"] = {
            SoundId = 14282524351,
            Volume = 1
        },
        ["Pluck LMB-3-Voiceline"] = {
            SoundId = 14264218995,
            Volume = 1
        },
        ["Pluck LMB-4"] = {
            SoundId = 14282524615,
            Volume = 1
        },
        ["Pluck LMB-4-Voiceline"] = {
            SoundId = 14264218873,
            Volume = 1
        },
        ["Overdrive Barrage Voiceline"] = {
            SoundId = 14264220238,
            Volume = 1
        },
        ["Overdrive Barrage SFX"] = {
            SoundId = 14264219722,
            Volume = 1
        },
        ["Overhead Strike SFX"] = {
            SoundId = 14226882998,
            Volume = 1
        },
        ["Scarlet Overdrive Voiceline"] = {
            SoundId = 14226881192,
            Volume = 1
        },
        ["Scarlet Overdrive SFX"] = {
            SoundId = 14553943441,
            Volume = 1
        },
        ["Sendo Ripple Overdrive Voiceline"] = {
            SoundId = 11118194999,
            Volume = 2
        },
        ["Sendo Ripple Overdrive SFX"] = {
            SoundId = 11118225846,
            Volume = 2
        },
        ["Sword Stab Voiceline"] = {
            SoundId = 14226883299,
            Volume = 1
        },
        ["Sword Stab SFX"] = {
            SoundId = 14553943964,
            Volume = 1
        },
        ["Purification Voiceline"] = {
            SoundId = 14226883917,
            Volume = 1
        },
        ["Purificaiton SFX"] = {
            SoundId = 14553944074,
            Volume = 1
        },
        ["Zoom Punch Voiceline"] = {
            SoundId = 14226881514,
            Volume = 1
        },
        ["Zoom Punch SFX"] = {
            SoundId = 14553943341,
            Volume = 1
        },
        ["Fencing Guard SFX"] = {
            SoundId = 14553943777,
            Volume = 1
        },
        ["Bull Rush Voiceline"] = {
            SoundId = 14226880675,
            Volume = 1
        },
        ["Bull Rush SFX"] = {
            SoundId = 14226880994,
            Volume = 1
        },
        ["Bull Rush Loop SFX"] = {
            SoundId = 14226881081,
            Looped = true,
            Volume = 1
        },
        ["Bull Rush End SFX"] = {
            SoundId = 14226880893,
            Volume = 1
        },
        ["Luck & Pluck Voiceline"] = {
            SoundId = 14226884138,
            Volume = 1
        },
        ["Luck & Pluck SFX"] = {
            SoundId = 14553943728,
            Volume = 1
        },
        ["Luck & Pluck Followup SFX"] = {
            SoundId = 14553943876,
            Volume = 1
        },
        ["Sunlight Yellow Overdrive Voiceline"] = {
            SoundId = 14264220679,
            Volume = 1
        },
        ["Sunlight Yellow Overdrive SFX"] = {
            SoundId = 14264221002,
            Volume = 1
        },
        ["Sunlight Yellow Overdrive Cutscene Voiceline"] = {
            SoundId = 14264220488,
            Volume = 1
        },
        ["Sunlight Yellow Overdrive Cutscene SFX"] = {
            SoundId = 14264220054,
            Volume = 1
        },
        ["Ripple Infusion Voiceline"] = {
            SoundId = 14226884388,
            Volume = 1
        },
        ["Ripple Infusion SFX"] = {
            SoundId = 14226884582,
            Volume = 1
        },
        ["Righteous Fury Startup Voiceline"] = {
            SoundId = 11159029110,
            Volume = 2
        },
        ["Righteous Fury Startup Woosh"] = {
            SoundId = 11159029152,
            Volume = 2
        },
        ["Righteous Fury Grab Voiceline"] = {
            SoundId = 11159029240,
            Volume = 2
        },
        ["Righteous Fury Grab Charge"] = {
            SoundId = 11159029300,
            Volume = 2
        },
        ["Metal Silver Overdrive Voiceline"] = {
            SoundId = 14226882470,
            Volume = 1
        },
        ["Metal Silver Overdrive SFX"] = {
            SoundId = 14553943639,
            Volume = 1
        },
        ["Metal Silver Overdrive Success Voiceline"] = {
            SoundId = 14226882194,
            Volume = 1
        },
        ["Metal Silver Overdrive Success SFX"] = {
            SoundId = 14226881970,
            Volume = 1
        },
        ["Standoff SFX"] = {
            SoundId = 14226882360,
            Volume = 1
        },
        ["Standoff Success Voiceline"] = {
            SoundId = 14226881661,
            Volume = 1
        },
        ["Standoff Success SFX"] = {
            SoundId = 14226881805,
            Volume = 1
        },
        ["Equip Sword"] = {
            SoundId = 10526043311,
            Volume = 2
        },
        ["Equip Sword Voiceline"] = {
            SoundId = 10526044209,
            Volume = 2
        },
        ["Sheathe Sword"] = {
            SoundId = 10526109480,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 14969465248,
            Volume = 2
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://11159824512",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Give me a break. I don\'t have time for your bad jokes."
                        } }
                }, {
                    SoundId = "rbxassetid://11159824419",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Come! I\'ll send all of my hamon rippling into you!"
                        } }
                }, {
                    SoundId = "rbxassetid://11159824659",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You will die here!"
                        } }
                }, {
                    SoundId = "rbxassetid://11159824584",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m going to keep beating you until you cry!"
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p16) -- Line: 2157, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p16.Player;
            local Character = p16.Character;
            local SkinName = p16.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v17 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v17.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v17;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};