  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local ItemData = require(PathShortcuts.ReplicatedModules.ItemData);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 17
    -- upvalues: u2 (ref), Knit (copy), PathShortcuts (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local Skins = ItemData.Skins;
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
            Particle = v1.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(255, 255, 255)
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
            Particle = v1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
local v6 = {
    Name = "Output",
    Arguments = { "FX", "Shadow_Hit", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Hit",
            LookAt = "Attacker"
        } }
};
local v7 = {
    SoundId = 13703109883,
    PlaybackSpeed = 1.05,
    Volume = 0.69
};
local v8 = {
    SoundId = 13703109883,
    Volume = 1.5
};
local v9 = {
    SoundId = 13703109636,
    Volume = 1.5
};
local v10 = {
    Animations = require(script.Animations),
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
    Stats = {},
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes)
};
v10.Stats.Block = {
    From = "Combat.Block"
};
v10.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v10.Stats.Pose = {
    From = "Combat.Pose"
};
v10.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    CustomAura = {
        AuraName = "Nocturnus"
    },
    LeaveParts = { "StandHumanoidRootPart", "Trails" },

    OnSummon = function(p11, p12) -- Line: 131, Name: OnSummon
        -- upvalues: Skins (copy), ParticleHandler (copy)
        local Character = p11.Character;
        local _ = Character.Humanoid;
        local _ = p11.Animator;
        local v13 = p11.Player or game.Players:GetPlayerFromCharacter(Character);
        local v14 = Character:FindFirstChild("Right Claw");
        local v15 = Character:FindFirstChild("Left Claw");
        local v16 = v13 and v13:IsA("Player") and v13.Data.Skin.Value;
        local v17 = p12 and 1 or 0;

        if (Skins["SKIN_2555_" .. v16] and Skins["SKIN_2555_" .. v16].Name) ~= "Nocturnus: Chainsaw Devil" then
            v14.Transparency = v17;
            v15.Transparency = v17;
            ParticleHandler.EnableParticle(v15, not p12);
            ParticleHandler.EnableParticle(v14, not p12);
        end;
    end
};
v10.Stats.Grab = {
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
v10.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = false,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = v8
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v9
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p18, p19) -- Line: 238, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p18.Stats;

            if not Knit.CollectionService:HasTag(p18.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v10.Stats["Rush Attack"] = TableUtil.Reconcile(v10.Stats["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v10.Stats["Bloodstained Rushdown"] = {
    Active = true,
    Speed = 1.35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true,
        CooldownReduction = false
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } },
        { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } },
        { 34, "BarrageAttack", "Punch" },
        { 34, function(p20, p21, p22) -- Line: 272
                -- upvalues: Knit (copy)
                Knit.GetService("EffectService").FireAllClients("Emit Particle V3", {
                    Path = "Particles/Scratch",
                    AutoSerialize = true,
                    Origin = p22.RootPart.CFrame * CFrame.new(0, 0, -6) * CFrame.Angles(1.5707963267948966, 0, 0),
                    SkinName = p22.SkinName,
                    AbilityName = p22.AbilityName,
                    Player = p22.Player
                });
            end },
        { 64, "BarrageAttack", "Punch2" },
        { 64, function(p23, p24, p25) -- Line: 285
                -- upvalues: Knit (copy)
                Knit.GetService("EffectService").FireAllClients("Emit Particle V3", {
                    Path = "Particles/Scratch",
                    AutoSerialize = true,
                    Origin = p25.RootPart.CFrame * CFrame.new(0, 0, -6) * CFrame.Angles(1.5707963267948966, 0, 0),
                    SkinName = p25.SkinName,
                    AbilityName = p25.AbilityName,
                    Player = p25.Player
                });
            end },
        { 83, "Cancelable", true },
        { 83, "Clashable", true },
        { 83, "Barrage", true },
        { 83, 263, "BarrageAttack", "Hit" },
        { 263, "Cancelable", false },
        { 263, "Clashable", false },
        { 263, "BarrageFinisher" },
        { 290, "BarrageAttack", "Finisher" },
        { 326, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    Hit = TableUtil.Reconcile({
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 14),
            Offset = CFrame.new(0, 0, -5),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart",
                Offset = CFrame.new(0, 0, -3.5)
            }
        },
        HitRemotes = { v4 },
        HitSounds = { v7 }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        HitRemotes = { v5 },
        HitSounds = { v9 }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    Punch = {
        Damage = 4,
        HitAnimations = "Default",
        HitRemotes = { v6 },
        HitSounds = { v8 },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        }
    },
    Punch2 = {
        Damage = 4,
        HitAnimations = "Default",
        HitRemotes = { v6 },
        HitSounds = { v8 },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        }
    },
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v10.Stats["Claw Barrage"] = {
    Active = true,
    Damage = 1.35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true,
        CooldownReduction = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Offset = CFrame.new(0, -1.5, -5)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitRemotes = { v6 },
    HitSounds = { v7 },
    Stun = {
        Time = 0.7,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.1
    },
    Finisher = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11, 9, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v6 },
        HitSounds = { v9 },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.35,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        }
    }
};
v10.Stats["Bloodthirsty Strike"] = {
    Active = true,
    HealCount = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Strike = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Heavy
        },
        Ragdoll = {
            Time = 1.5
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.2
        },
        HitSounds = {
            Hit = {
                SoundId = 132874176577466,
                Volume = 1.5
            }
        },
        HitRemotes = { v6 }
    },
    Lifesteal = {
        Damage = 4.5,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move + 1,
        HitRemotes = { v6 },
        Block = {
            BypassCounter = true,
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 113151534807608,
                Volume = 1.5
            }
        }
    },
    Properties = {
        Armor = {
            Highlight = false
        }
    },
    Gain = {
        Heal = 5,
        Priority = EnumsModule.Intangible.Move + 1,
        HitSounds = {
            Hit = {
                SoundId = 73580496254033,
                Volume = 1.5
            }
        },
        Block = {
            BypassCounter = true,
            Unblockable = true
        }
    }
};
v10.Stats["Piercing Whirl"] = {
    Active = true,
    Damage = 4,
    Frequency = 6,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Stun = {
        Time = 0.35,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 14),
        Predict = false,
        Offset = CFrame.new(0, 0, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    HitRemotes = { v6 },
    HitSounds = {
        Hit = v9
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    }
};
v10.Stats["Crimson Surge"] = {
    Damage = 20,
    Active = true,
    ExtendedRagdoll = 1.1,
    HitAnimations = "Default",
    Actionable = {
        Summoned = true,
        Active = true
    },
    Cooldown = {
        Time = 12
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Stun = {
        Time = 1.15,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "DawnBurn"
        } },
    Hitbox = {
        Size = Vector3.new(15, 15, 30),
        Offset = CFrame.new(0, 0, -15)
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = v8
    },
    Priority = EnumsModule.Intangible.Ragdoll
};
v10.Stats["Rending Cross"] = {
    Active = true,
    Damage = 25,
    Stun = 0.75,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 132874176577466,
            Volume = 1.5
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 5,
        Offset = CFrame.identity
    }
};
v10.Stats["Relentless Laceration"] = {
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
            BlockBreak = true
        }
    },
    Throw = {
        Priority = EnumsModule.Intangible.Move + 1,
        Stun = {
            Time = 0.3
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
            Time = 2
        },
        Block = {
            Unblockable = true
        }
    }
};
v10.Stats["Ground Breaker"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Priority = EnumsModule.Intangible.Ragdoll,
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
        Size = 15,
        Offset = CFrame.new(0, 0, -4)
    }
};
v10.Stats["Instant Cleave"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    EndFrame = 40,
    AttackFrame = 26,
    Iteration = 5,
    AppearFrame = 10,
    DisappearFrame = 31,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Stun = {
        Time = 0.15
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 10
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "StandHumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Predict = false,
        Offset = CFrame.new(0, 0, -6)
    },
    Knockback = {
        RelativePart = "Target",
        Speed = 40,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75
    },
    HitRemotes = { v5 },
    HitSounds = {
        Hit = v9
    },
    Block = {
        PerfectBlockable = false
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "WoundedRightArm",
            Lifetime = 3,
            Cut = true
        } },
    C0 = CFrame.new(0, 0, 9),
    Detect = {
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    }
};
v10.Stats["Scarlet Descent"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 50,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Startup = {
        Damage = 30,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v5 },
        Block = {
            BlockBreak = true
        }
    },
    Punch = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4 }
    },
    Slam = {
        Damage = 40,
        Priority = EnumsModule.Intangible.Move
    },
    Impact = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.1
        }
    }
};
v10.Stats["Redshift Ascension"] = {
    Active = true,
    Damage = 45,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p26) -- Line: 964, Name: Check
            return not p26:GetAttribute("Redshift");
        end
    },
    Cooldown = {
        Time = 75,
        AfterMove = true
    },
    Properties = {
        Intangible = EnumsModule.Intangible.Move
    },
    Meter = {
        RequiredAmount = 100
    },
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
        Time = 1.8,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.new(0, 0, -4)
    }
};
v10.Stats.Teleport = {
    From = "Combat.Teleport"
};
v10.Stats["Vengeful Step"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RemoveMeter = true,
        RequiredLevel = 1
    },
    Success = {
        Damage = 35,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 2,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { v6 },
        HitSounds = {
            Hit = {
                SoundId = 134923352135073,
                Volume = 2
            }
        }
    },
    Cooldown = 11
};

return v10;