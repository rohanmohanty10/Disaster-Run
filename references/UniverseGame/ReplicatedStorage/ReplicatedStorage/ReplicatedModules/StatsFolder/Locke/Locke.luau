  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Utility);
local CollectionService = game:GetService("CollectionService");
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("MoveInputService");
end);
local v2 = {};
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
            Particle = ClientAssets.Locke.Particles.LockeHitVFX
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
            Particle = ClientAssets.Locke.Particles.LockeHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0)
        }
    }
};
v2.Summon = {
    From = "Combat.Summon",
    IgnoreParts = { "RootPart", "StandHumanoidRootPart", "Stand Left Arm", "Stand Right Arm", "Stand Left Leg", "Stand Right Leg", "Stand Head", "Stand Torso" },
    SummonSounds = {
        StandHumanoidRootPart = { "Summon-SFX1", "Summon-SFX2" }
    },

    OnSummon = function(p5, p6) -- Line: 55, Name: OnSummon
        for _, descendant in ipairs(p5.Character.Stand:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "StandAura" then
                descendant.Enabled = p6;
            end;
        end;
    end
};
v2.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p7, p8) -- Line: 68, Name: PoseTransition
            p8.AnimationObject:GetAnimation("PoseTransitionStand"):Play();
        end
    }
};
v2["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Damage = 8,
    MaxCombo = 4,
    Endlag = 0.3,
    ComboTick = 1.5,
    Speed = 1.25,
    Sequence = { { 0, "PlayAnim" }, { 0, "PlaySound" }, { 0, "PlayVoiceline" }, { 0, "PlaySound", "SwingLMB" }, { 0, "CreateTag", "NoRun" }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 10, 14, "Attack" }, { 24, "End" } },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 0.5,
        StunDecay = true,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Block = {
        PerfectBlockable = false
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 10982291617,
            Volume = 1.5
        }
    },
    HitAnimations = "Default",
    ["LMB-2"] = {
        HitSounds = {
            Hit = {
                SoundId = 10982291833,
                Volume = 1.5
            }
        }
    },
    ["LMB-3"] = {
        HitSounds = {
            Hit = {
                SoundId = 10982292052,
                Volume = 1.5
            }
        }
    },
    ["LMB-4"] = {
        Cooldown = 1.5,
        Damage = 21,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 10982291240,
                Volume = 5
            }
        }
    },
    ["StandOff-LMB-1"] = {
        Speed = 1.5,
        Endlag = 0.3,
        Sequence = {
            { 0, "PlayAnim", nil, {} },
            { 0, "PlaySound" },
            { 0, "PlayVoiceline" },
            { 0, "CreateTag", "NoRun" },
            { 0, "CreateTag", "MaxJumpPower", 0 },
            { 0, "PlaySound", "SwingLMB" },
            { 19, function(p9, p10, p11, p12) -- Line: 179
                    -- upvalues: Knit (copy)
                    if p12.MoveState.Count ~= 3 then
                        return;
                    end;

                    local v13 = Knit.GetService("EffectService");
                    local _ = p12.AttackStats;
                    local _ = p11.Input;
                    v13.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LockeLightningBolt",
                        AbilityName = "Locke",
                        Player = p11.Player,
                        Origin = p11.Character.HumanoidRootPart,
                        Offset = CFrame.new(0, -2, -4),
                        SkinName = p11.SkinName
                    });
                end },
            { 19, 24, "Attack" },
            { 30, "End" }
        }
    },
    ["StandOff-LMB-2"] = {
        HitSounds = {
            Hit = {
                SoundId = 10982291833,
                Volume = 1.5
            }
        }
    },
    ["StandOff-LMB-3"] = {
        HitSounds = {
            Hit = {
                SoundId = 10982292052,
                Volume = 1.5
            }
        }
    },
    ["StandOff-LMB-4"] = {
        Cooldown = 1.5,
        Damage = 21,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { v4 },
        Stun = {
            Time = 0.3,
            StunDecay = true,
            Priority = EnumsModule.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 10982291240,
                Volume = 5
            }
        }
    },
    Callbacks = {
        StateChecker = function(p14, p15) -- Line: 244, Name: StateChecker
            -- upvalues: CollectionService (copy), TableUtil (copy)
            if not CollectionService:HasTag(p14.Character, "Summoned") then
                local v16 = TableUtil.Copy(p14.Stats);
                v16.CustomPrefix = "StandOff-LMB";

                return v16;
            end;
        end
    }
};
v2.Block = {
    From = "Combat.Block"
};
v2.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Kingslayer = {
    Active = true,
    Damage = 15,
    Cooldown = 20,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.4,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.identity
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true
    },
    Tweens = {
        End = { 0.2, Enum.EasingStyle.Linear }
    },
    Props = {
        Start = {
            Transparency = 0.5,
            Color = Color3.new(1, 1, 0)
        },
        End = {
            Transparency = 1
        }
    }
};
v2["Kinetic Charge"] = {
    Active = true,
    Damage = 3.3333333333333335,
    MaxDamage = 10,
    Cooldown = 13,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Blockable = true,
        BlockBreak = false,
        PerfectBlockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Tweens = {
        End = { 0.2, Enum.EasingStyle.Linear }
    },
    Props = {
        Start = {
            Transparency = 0.5,
            Color = Color3.new(1, 1, 0)
        },
        End = {
            Transparency = 1
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 11935829101,
            Volme = 3
        }
    },
    HitRemotes = { v4 }
};
v2["Electric Strike"] = {
    Active = true,
    Damage = 20,
    Cooldown = 12,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 10),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.identity
    },
    HitSounds = {
        Hit = {
            SoundId = 12568493741,
            Volme = 3
        }
    },
    HitRemotes = { v3 },
    Block = {
        PerfectBlockable = false
    }
};
v2["Kinetic Orb"] = {
    Active = true,
    Damage = 30,
    Cooldown = 1.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Meter = {
        RequiredAmount = 10,
        MeterGain = 0
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        MaxDistance = 999,
        Debug = false,
        Offset = CFrame.identity
    },
    HitSounds = {
        Hit = {
            SoundId = 7181838845,
            Volme = 3
        }
    },
    HitRemotes = { v3 }
};
v2["Kinetic Blast"] = {
    Active = true,
    Damage = 20,
    Distance = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 15),
        Debug = false,
        Offset = CFrame.identity
    },
    HitSounds = {
        Hit = {
            SoundId = 12568478526,
            Volume = 1
        }
    }
};
v2["Dual Shocker"] = {
    Active = true,
    Damage = 7.5,
    Cooldown = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Time = 0.1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitSounds = {
        Hit = {
            SoundId = 12106444927,
            Volume = 3
        }
    },
    HitRemotes = { v3 }
};
v2["Static Buster"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Damage = 30,
    Block = {
        Unblockable = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 4
    },
    ["Lightning-1"] = {
        Damage = 2.5,
        Amount = 10,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true,
            PerfectBlockable = false
        }
    },
    ["Lightning-2"] = {
        Damage = 1,
        Amount = 25,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Unblockable = true,
            PerfectBlockable = false
        }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true,
            PerfectBlockable = false
        }
    },
    Cooldown = {
        Time = 45,
        AfterMove = true
    },
    Hitbox = {
        Debug = false,
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    TargetHitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(13, 25, 13),
        MaxDistance = 999,
        Offset = CFrame.identity
    }
};
v2.Overvolt = {
    Actionable = {
        Active = true
    },
    Active = true,
    Damage = 10,
    Block = {
        Blockable = false,
        Unblockable = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 2
    },
    Hit = {
        Damage = 5,
        Block = {
            Blockable = false,
            Unblockable = true
        }
    },
    Lightning = {
        Damage = 0.5,
        Amount = 10,
        Block = {
            Blockable = false,
            Unblockable = true
        }
    },
    Explode = {
        Damage = 20,
        Block = {
            Blockable = false,
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Ragdoll = {
            Time = 1.5
        }
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Hitbox = {
        Debug = false,
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    }
};
v2["Shock Stab"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 45,
        Time = 0.2
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Ragdoll = {
        Time = 0.756
    },
    Hitbox = {
        Debug = false,
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    HitSounds = {
        Hit = {
            SoundId = 12568504636,
            Volme = 3
        }
    },
    HitRemotes = { v3 }
};
v2["Energy Overflow"] = {
    Active = true,
    Shield = 75,
    Damage = 40,
    Cooldown = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 2,
            Overrides = {
                Lifetime = 5,
                Rate = 1,
                MeterGain = 0
            }
        } },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 2
    },
    Hitbox = {
        Type = "Region3",
        Size = 15,
        Debug = false,
        Offset = CFrame.identity
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 64,
        Time = 0.2
    },
    Ragdoll = {
        Time = 0.5
    },
    HitSounds = {
        Hit = {
            SoundId = 7181838845,
            Volme = 3
        }
    },
    HitRemotes = { v3 }
};
v2.Takedown = {
    Active = true,
    Damage = 15,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Block = {
        Unblockable = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Debug = false,
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Slam = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Offset = CFrame.new(0, -2.5, -4.5)
        },
        Ragdoll = {
            Time = 2,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Unblockable = true
        }
    }
};
v2.Discharge = {
    Active = true,
    Damage = 30,
    Cooldown = 15,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = false
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 2,
            Overrides = {
                Lifetime = 5,
                MeterGain = 0,
                Rate = 1
            }
        } },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 5,
        Offset = CFrame.identity
    },
    HitSounds = {
        Hit = {
            SoundId = 12568507464,
            Volme = 1
        }
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "HitEffect V3",
                {
                    AutoSerialize = true,
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Particle = ClientAssets.Locke.Particles.LockeLightningBolt,
                    Offset = CFrame.new(0, -2, 0)
                }
            }
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
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
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
            Summon = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Kingslayer = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Dash forward before grabbing a target and choking them then throwing them away. You will heal 50% of the damage dealt to the victim at the end of the move."
            },
            ["Kinetic Charge"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Dash forward thrice, attacking anyone in your way."
            },
            ["Electric Strike"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Dash forward twice, attacking anyone in your way."
            },
            ["Kinetic Orb"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "The stand places down a bomb which explodes shortly after, attacking anyone in it\'s range."
            },
            Takedown = {
                DefaultKeybind = "X",
                State = "StandOn",
                Description = "The stand grabs a target before slamming them down.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Kinetic Blast"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Throw a projectile, if recasted, the projectile will explode.",
                LevelRequirement = 30,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Dual Shocker"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "The stand unleashes two quick strikes.",
                LevelRequirement = 45,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Static Buster"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                Description = "Jab someone, grabbing them before a feral beam strikes them from above multiple times.",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Overvolt = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "The stand grabs a target before performing a combo on them.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Discharge = {
                DefaultKeybind = "Z",
                Description = "The user charges up to increase the range while the key is held, any targets in range are prey to lightning strikes.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Shock Stab"] = {
                DefaultKeybind = "V",
                State = "StandOff",
                Description = "Quickly form a dagger of lighting, stabbing whomever comes your way.",
                LevelRequirement = 80,
                IndicatorInfo = {
                    DisplayName = "Shock Jab"
                },
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Energy Overflow"] = {
                DefaultKeybind = "V",
                State = "StandOn",
                Description = "Unleash a devastating blast around you.",
                LevelRequirement = 70,
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
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 11145849040,
            ["StandOff-LMB-2"] = 11145855160,
            ["StandOff-LMB-3"] = 11145858535,
            ["StandOff-LMB-4"] = 11145861505,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            ["Takedown Target"] = 8285211959,
            ["Takedown Startup"] = 8285226742,
            Takedown = 8285196150,
            ["Kinetic Orb"] = 12019785309,
            ["Kingslayer Startup"] = 11145872017,
            ["Kingslayer Grab"] = 11145880135,
            ["Kingslayer Victim"] = 11145883563,
            ["Electric Strike"] = 12019750460,
            ["Kinetic Charge"] = 10967339170,
            ["Kinetic Blast"] = 12073490958,
            ["Discharge Start"] = 12073878240,
            ["Discharge Loop"] = 12073880893,
            ["Discharge End"] = 12073883588,
            ["Static Buster Windup"] = 11309255791,
            ["Static Buster"] = 10967375191,
            ["Static Buster Target"] = 11309236607,
            ["Shock Stab"] = 11004911419,
            ["Overvolt Grab"] = 11004928092,
            ["Overvolt Shock"] = 11004938170,
            ["Overvolt Victim"] = 11031344895,
            ["Energy Overflow"] = 11102603443,
            ["Dual Shocker"] = 11935179354,
            ["Detonate-1"] = 12085072035,
            ["Detonate-2"] = 12085076069,
            ["Detonate-3"] = 12085080247,
            PoseTransitionStand = 129544464949048,
            PoseTransition = 129544464949048,
            PoseIdle = 125655365979850
        },
        Movement = {
            Run = 10982240350,
            Walk = 10982237279,
            SummonedRun = 10982240350,
            SummonedWalk = 10982237279
        },
        Idle = {
            SummonedIdle = 10982229550,
            Idle = 10982229550
        }
    },
    Stats = v2,
    Sounds = {
        ["Energy-Overflow"] = {
            SoundId = 12570485385,
            Volume = 1
        },
        ["Shock-Stab"] = {
            SoundId = 12568506197,
            Volume = 1
        },
        Discharge = {
            SoundId = 12568503592,
            Volume = 1
        },
        ["Static-Buster-Startup"] = {
            SoundId = 12568502393,
            Volume = 1
        },
        ["Static-Buster-Hit"] = {
            SoundId = 12568500564,
            Volume = 1
        },
        ["Overvolt-Startup"] = {
            SoundId = 12568499068,
            Volume = 1
        },
        ["Overvolt-Hit"] = {
            SoundId = 12568497123,
            Volume = 1
        },
        ["Electric-Strike"] = {
            SoundId = 12568495013,
            Volume = 1,
            PlaybackSpeed = 0.85
        },
        ["Kinetic-Blast"] = {
            SoundId = 12568480801,
            Volume = 1
        },
        ["Kingslayer-Dash"] = {
            SoundId = 12568476965,
            Volume = 1
        },
        ["Kingslayer-Grab"] = {
            SoundId = 12568475210,
            Volume = 1
        },
        ["DualShocker-2"] = {
            SoundId = 12106446655,
            Volume = 3
        },
        ["DualShocker-1"] = {
            SoundId = 12106444102,
            Volume = 3
        },
        OrbExplode = {
            SoundId = 12106443353,
            Volume = 3
        },
        OrbStartup = {
            SoundId = 12106442606,
            Volume = 3
        },
        OrbSFX = {
            SoundId = 12106441978,
            Volume = 3
        },
        Takedown = {
            SoundId = 11935827343,
            Volume = 3
        },
        TakedownAttempt = {
            SoundId = 11935826621,
            Volume = 3
        },
        KineticCharge = {
            SoundId = 11935828338,
            Volume = 3,
            PlaybackSpeed = 0.8
        },
        ["LMB-1"] = {
            SoundId = 11935823050,
            Volume = 3
        },
        ["LMB-2"] = {
            SoundId = 11935823776,
            Volume = 3
        },
        ["LMB-3"] = {
            SoundId = 11935824500,
            Volume = 3
        },
        ["LMB-4"] = {
            SoundId = 11935825461,
            Volume = 3
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 1
        },
        SummonSound = {
            SoundId = 11935820027,
            Volume = 1
        },
        Desummon = {
            SoundId = 11935816950,
            Volume = 1
        },
        PoseMusic = {
            Looped = true,
            SoundId = 77178770953799,
            Volume = 2,
            TimePosition = 1.7
        },
        ["Grab-SFX"] = {
            SoundId = 10982292912,
            Volume = 3
        },
        MeterUp3 = {
            SoundId = 11023484185,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 11023490526,
            Volume = 2
        },
        Grab = {
            SoundId = 10906275061,
            Volume = 2
        },
        Grabbed = {
            SoundId = 11023496611,
            Volume = 2
        },
        ["Grab-SuccessSFX"] = {
            SoundId = 10982292564,
            Volume = 3
        }
    }
};