  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local CollectionService = game:GetService("CollectionService");
local v1 = {
    Rush_Attack = {
        Endlag = 0.2,
        ActiveEndlag = 0.05,
        Damage = 8,
        HitAnimations = "Default",
        Stun = {
            Time = 0.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        }
    },
    Rush_Attack_Finisher = {
        Endlag = 0.2,
        ActiveEndlag = 0.05,
        Cooldown = 1,
        Damage = 21,
        HitAnimations = "Default",
        Stun = {
            Time = 0.275
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        }
    },
    Rush_Attack_Step = {
        Normal = Vector3.new(0, 0, -1),
        Speed = 36,
        Time = 0.1,
        MaxDistance = 12
    }
};
v1.Stand_Rush_Attack = TableUtil.Reconcile({
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4),
        PilotData = {
            Size = Vector3.new(6, 5.5, 6),
            RelativePart = "Stand.StandHumanoidRootPart"
        }
    }
}, v1.Rush_Attack);
v1.Stand_Rush_Attack_Finisher = TableUtil.Reconcile({
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4),
        PilotData = {
            Size = Vector3.new(6, 5.5, 6),
            RelativePart = "Stand.StandHumanoidRootPart"
        }
    }
}, v1.Rush_Attack_Finisher);
local v2 = game:GetService("ReplicatedStorage")["Client Assets"];
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
            Particle = v2.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(255, 255, 255)
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
            Particle = v2.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
v1["StandOff Rush Attack"] = {
    ["StandOff-LMB-1"] = {
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 15, "Attack" }, { 21, "End" } },
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v3 },
        HitSounds = { {
                SoundId = 10626698543,
                Volume = 3
            } }
    },
    ["StandOff-LMB-2"] = {},
    ["StandOff-LMB-3"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 18, "Attack" }, { 25, "End" } }
    },
    ["StandOff-LMB-4"] = {
        Cooldown = 1,
        Damage = 21,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 18, "Attack" }, { 23, "End" } },
        Stun = {
            Time = 0.3
        },
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        HitRemotes = { v4 },
        HitSounds = { {
                SoundId = 10626763879,
                Volume = 3
            } }
    },
    Callbacks = {
        StateChecker = function(p5, p6) -- Line: 208, Name: StateChecker
            -- upvalues: CollectionService (copy), TableUtil (copy)
            if not CollectionService:HasTag(p5.Character, "Summoned") then
                local v7 = TableUtil.Copy(p5.Stats);
                v7.CustomPrefix = "StandOff-LMB";

                return v7;
            end;
        end
    }
};
v1.Stand_Barrage = {
    Active = true,
    Actionable = {
        Active = true
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } }, { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } }, { 23, "Cancelable", true }, { 24, "Clashable", true }, { 24, "Barrage", true }, { 24, 144, "BarrageAttack", "Hit" }, { 144, "Cancelable", false }, { 144, "Clashable", false }, { 144, "BarrageFinisher" }, { 163, "BarrageAttack", "Finisher" }, { 193, "End" } },
    ClashSequence = { { 0, "BarrageStart" }, { 0, "StopSound", "BarrageVoiceline" }, { 0, "PlaySound", "ClashVoiceline" }, { 0, "Clashable", false }, { 0, "Clash" }, { 0, "Barrage", true }, { 0, 60, "ClashAttack", "ClashHit" }, { 0, 60, "ClashRotate", true }, { 61, "ClashEnd" }, { 61, "ClashAttack", "ClashFinisher" }, { 64, "End" } },
    Hit = {
        Frequency = 6,
        Damage = 1,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 8, 8.5),
            Offset = CFrame.new(0, 0, -4.25),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart",
                Offset = CFrame.new(0, 0, -3.5)
            }
        },
        Stun = {
            Time = 0.65,
            Barrage = true,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Frequency = 360,
        Damage = 29,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 8, 8.5),
            Offset = CFrame.new(0, 0, -4.25),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart",
                Offset = CFrame.new(0, 0, -3.5)
            }
        },
        Stun = {
            Time = 0.3,
            Barrage = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        }
    },
    ClashHit = {
        Frequency = 6,
        Damage = 1,
        Priority = EnumsModule.Intangible.Clash,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 8, 8.5),
            Offset = CFrame.new(0, 0, -4.25),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6.5),
                RelativePart = "Stand.StandHumanoidRootPart",
                Offset = CFrame.new(0, 0, -3.5)
            }
        },
        Stun = {
            Time = 0.1,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    ClashFinisher = {
        Frequency = 360,
        Damage = 15,
        Priority = EnumsModule.Intangible.Clash,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 8, 8.5),
            Offset = CFrame.new(0, 0, -4.25),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6.5),
                RelativePart = "Stand.StandHumanoidRootPart",
                Offset = CFrame.new(0, 0, -3.5)
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.15
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
};
v1.MovesInfo = {
    Pose = {
        Description = "Strike a pose unique to your ability."
    },
    ["Rush Attack"] = {
        Description = "Perform a chain of strikes ending with a powerful blow, knocking targets away."
    },
    Summon = {
        Description = "Summon/activate your ability and, if given, alternate between available moves."
    },
    Quickstep = {
        Description = "You initiate a swift directional dash, briefly making you intangible to attacks."
    },
    Block = {
        Description = "Enter a blocking state to reduce incoming damage, or, if timed correctly, negate the damage fully and stun the attacker. This state may be broken or bypassed by some attacks."
    },
    Grab = {
        Description = "Reach out for your target. If connected, the target is knocked away with a powerful throw. <b>Bypasses blocking</b>."
    },
    ["Busoshoku Haki"] = {
        Description = "Enter a buffed state for a short amount of time, where generally, your strength capabilities would be increased. <b>Further effects of this technique entirely depend on your current haki stage or the amount of points in it.</b>."
    },
    ["Kenbunshoku Haki"] = {
        Description = "Enter a defensive state for a short amount of time. Generally, this state would grant you an amount of dodges alongside a cooldown which may increase depending on the amount of dodges you have, more dodges would mean a lower cooldown. <b>Further effects of this technique entirely depend on your current haki stage or the amount of points in it.</b>."
    },
    ["Haoshoku Haki"] = {
        Description = "Release a shockwave which would put any entities caught in it to a partially unconcious state. <b>Further effects of this technique entirely depend on your current haki stage or the amount of points in it.</b>."
    }
};

return v1;