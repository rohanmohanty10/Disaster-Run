  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage["Client Assets"];
local Output = game.ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Enums = require(game.ReplicatedStorage.ReplicatedModules.Enums);
local v2 = {
    Hit = {
        SoundId = 11181353616,
        Volume = 2
    }
};
local v3 = {
    Hit = {
        SoundId = 11181353926,
        Volume = 1
    }
};
local v4 = {
    Hit = {
        SoundId = 11181353723,
        Volume = 2
    }
};
v1.Summon = {
    From = "Combat.Summon",
    LeaveParts = { "StandHumanoidRootPart", "Stand Torso", "Stand Head", "Stand Left Arm", "Stand Right Arm", "Stand Left Leg", "Stand Right Leg" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 239, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 138, 138)) })
};
v1.Barrage = {
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Summoned = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Barrage = TableUtil.Reconcile({
        Callbacks = {
            BarrageEffect = function(p5, p6, p7, p8) -- Line: 69, Name: BarrageEffect
                -- upvalues: CollectionService (copy), Output (copy)
                local Character = p6.Character;

                if p8 then
                    CollectionService:AddTag(Character, "Barraging");
                    Output:FireAllClients("FX", "ChariotBarrage", Character);
                else
                    CollectionService:RemoveTag(Character, "Barraging");
                end;

                return true;
            end
        },
        Hit = {
            Meter = true,
            HitAnimations = "Default",
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(7.5, 7.5, 13),
                Debug = false,
                Offset = CFrame.new(0, 0, -6.5)
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/SC Barrage Effect",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } },
            HitSounds = v3
        },
        Finisher = {
            HitAnimations = "Default",
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(7.5, 7.5, 13),
                Debug = false,
                Offset = CFrame.new(0, 0, -6.5)
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/SC R Effect",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } },
            HitSounds = v4
        }
    }, BaseStatsModule.Stand_Barrage)
};
v1["Triple Strike"] = {
    Active = true,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 7, 9),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Stun = {
        Time = 0.65,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/SC Barrage Effect",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    HitSounds = v3,
    FinalHit = {
        Damage = 15,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 6, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.25)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.2
        },
        HitSounds = v4,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC R Effect",
                        AutoSerialize = true
                    } }
            } }
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
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB-1SFX" }, { 29, 33, "Attack" }, { 38, "End" } },
        Stun = {
            Time = 0.875,
            Priority = Enums.Stun.Medium
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.25, 7.25, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC LMB Effect",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 11181353463,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.45,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB-4SFX" }, { 40, 44, "Attack" }, { 55, "End" } },
        Stun = {
            Time = 0.3
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.25, 7.25, 9),
            Debug = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC R Effect",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = v2
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = {
        Endlag = 0.2,
        ActiveEndlag = 0.1,
        Speed = 1.1,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
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
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 5.5, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC LMB Effect",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 11713885181,
                Volume = 2
            }
        }
    },
    ["StandOff-LMB-2"] = {
        Speed = 1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } }
    },
    ["StandOff-LMB-4"] = {
        Speed = 1.75,
        Cooldown = 1,
        Damage = 25,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 36, 42, "Attack" }, { 48, "End" } },
        Stun = {
            Time = 0.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC R Effect",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 11713885288,
                Volume = 2
            }
        }
    },
    Callbacks = {
        StateChecker = function(p9, p10) -- Line: 468, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p9.Stats;

            if not Knit.CollectionService:HasTag(p9.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end,

        PreAnim = function(p11, p12) -- Line: 477, Name: PreAnim
            -- upvalues: Knit (copy)
            local _ = p12.AttackStats;
            local _ = p11.Input;
            local Character = p11.Player.Character;

            if Knit.CollectionService:HasTag(Character, "Summoned") then
                Character.Stand.Rapier.Blade.Trail.Enabled = true;
            end;
        end,

        PostAnim = function(p13, p14) -- Line: 487, Name: PostAnim
            -- upvalues: Knit (copy)
            local _ = p14.AttackStats;
            local _ = p13.Input;
            local Character = p13.Player.Character;

            if Knit.CollectionService:HasTag(Character, "Summoned") then
                Character.Stand.Rapier.Blade.Trail.Enabled = false;
            end;
        end
    }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1["Eye Of The Storm"] = {
    Active = true,
    Length = 2,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Summoned = true,
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 0.75
    },
    HitSounds = v2,
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/MultiSlashHit",
                    AutoSerialize = true
                } }
        } },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 12.5,
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    }
};
v1.Clobber = {
    Active = true,
    Cooldown = 10,
    Damage = 20,
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    Properties = {
        Armor = true
    },
    Ragdoll = {
        Time = 0.9
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 65,
        Time = 0.2
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/SC R Effect",
                    AutoSerialize = true
                } }
        } },
    HitSounds = {
        Hit = {
            SoundId = 11309338722,
            Volume = 2
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 9),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.5)
    }
};
v1["Instant Slice"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 11),
        Debug = false,
        Offset = CFrame.new(0, 0, -5.5)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BlockBreak = true
    },
    Ragdoll = {
        Time = 0.75
    },
    HitSounds = v2,
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/SC R Effect",
                    AutoSerialize = true
                } }
        } }
};
v1["Ricochet Shot"] = {
    Active = true,
    Distance = 4,
    Damage = 40,
    HitAnimations = "Default",
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Actionable = {
        Active = true,
        Summoned = true
    },
    Block = {
        BypassCounter = true,
        PerfectBlockable = false,
        Blockable = false
    },
    HitSounds = v4,
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/SC R Effect",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } }
};
v1["Piercing Finisher"] = {
    Active = true,
    CheckPVPSafe = true,
    HitAnimations = "Default",
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 12.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -6.25)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    Stun = {
        Time = 0.7
    },
    Meter = {
        RequiredLevel = 1
    },
    Properties = {
        Armor = true
    },
    HitSounds = v3,
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/SC R Effect",
                    AutoSerialize = true
                } }
        } },
    Jab = {
        Damage = 1,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true,
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC LMB Effect",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = v3
    },
    Slice = {
        Damage = 3,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true,
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC R Effect",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = v3
    },
    FinalSlice = {
        Damage = 30,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true,
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/MultiSlashHit",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = v2
    }
};
v1["Immobilizing Slices"] = {
    Active = true,
    Damage = 3,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 9),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Stun = {
        Time = 0.7
    },
    Meter = {
        RequiredLevel = 1
    },
    HitSounds = v3,
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/SC LMB Effect",
                    AutoSerialize = true
                } }
        } },
    Block = {
        PerfectBlockable = true,
        Blockable = false
    },
    FirstHit = {
        Damage = 3,
        Block = {
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC R Effect",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = v3
    },
    Throw = {
        Damage = 8,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Unblockable = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/MultiSlashHit",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = v4
    },
    ArmorOff = {
        Damage = 1.75,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(18, 10, 50),
            Offset = CFrame.new(0, 0, -25)
        },
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 13197146710,
                Volume = 2
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC LMB Effect",
                        AutoSerialize = true
                    } }
            } }
    }
};
v1["En Garde"] = {
    Active = true,
    Cooldown = 60,
    Duration = 25,
    Actionable = {
        Summoned = true,
        Active = true
    },
    Meter = {
        RequiredLevel = 2
    }
};
v1["Armor Off"] = {
    Active = true,
    Duration = 25,
    Actionable = {
        Summoned = true,
        Active = true
    },
    Meter = {
        RequiredLevel = 3
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v1.Riposte = {
    Active = true,
    Actionable = {
        Summoned = true,
        Active = true
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Jab = {
        Damage = 8.5,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SC LMB Effect",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = v3
    },
    FinalStrike = {
        Damage = 19,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/MultiSlashHit",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = v2
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
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false,
                State = "StandOff"
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "The stand rapidly performs multiple slashes while this move is held down, before unleashing a finishing slash."
            },
            ["Triple Strike"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "The stand\'s right arm is quickly summoned as it performs 3 strikes."
            },
            Clobber = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Quickly dash forward and unleash a slash."
            },
            ["Instant Slice"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Description = "The stand charges up while the key is held down before quickly slashing.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Immobilizing Slices"] = {
                DefaultKeybind = "X",
                State = "StandOn",
                Description = "The user sends out the stand, if the stand hits someone, it will unleash a quick combo at them. If used during armor off, the user and the stand will quickly dash forward as they slice multiple times.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Ricochet Shot"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "The stand sends out it\'s blade, which ugomatically targets an opponent. If it hits a wall, it will redirect.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Piercing Finisher"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "The stand unleashes a devastating grab on a victim.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Eye Of The Storm"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "The stand charges up while the key is held down before unleashing a strong AOE slash.",
                LevelRequirement = 85,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["En Garde"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Enter the en-garde state where all moves deal burn damage.",
                LevelRequirement = 95,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Armor Off"] = {
                DefaultKeybind = "V",
                State = "StandOn",
                Description = "Enter the armor-off state where all moves are sped up.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Riposte = {
                DefaultKeybind = "B",
                State = "StandOn",
                Description = "Enter a counterattack-state, if you are hit, silver chariot unleashes a quick combo on the victim.",
                LevelRequirement = 60,
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
            BarrageStartup = 10838298509,
            Barrage = 10159962142,
            BarrageFinisher = 10159965589,
            BarrageClashEnd = 10839831781,
            ["LMB-1"] = 9754322259,
            ["LMB-2"] = 9754324260,
            ["LMB-3"] = 9754326370,
            ["LMB-4"] = 9754328810,
            ["StandOff-LMB-1"] = 11127865908,
            ["StandOff-LMB-2"] = 11127868260,
            ["StandOff-LMB-3"] = 11127869614,
            ["StandOff-LMB-4"] = 11127870798,
            SummonAnim = 9571449255,
            PoseIdle = 13189533492,
            PoseTransition = 13171119547,
            ["Counter Startup"] = 13198835983,
            ["Counter Loop"] = 13198847748,
            ["Counter Execution"] = 13198849694,
            ["Armor Off"] = 9754332079,
            ["Armor Off Idle"] = 10118566913,
            ["Skull Piercing Thrust Startup"] = 10216765477,
            ["Skull Piercing Thrust Stance"] = 9617463614,
            ["Skull Piercing Thrust Success"] = 9617465658,
            ["Instant Slice Hold"] = 9617467779,
            ["Instant Slice"] = 9617469445,
            ["Ricochet Shot"] = 9617472189,
            ["You\'re Lying"] = 9617474580,
            ["Eye Of The Storm Start"] = 10280037313,
            ["Eye Of The Storm Loop"] = 10959747857,
            ["Eye Of The Storm End"] = 10280056707,
            TempPierceFinishStart = 10938760715,
            TempPierceFinishLoop = 10938762256,
            ["Piercing Finisher Attempt"] = 10593374578,
            ["Piercing Finisher Attack"] = 10593389885,
            ["Piercing Finisher Victim"] = 10593426309,
            ["Triple Strike"] = 10967692379,
            Clobber = 11163414930,
            ["Immobilizing Slices"] = 11163653420,
            ["Immobilizing Slices Succeeded"] = 11163658200,
            ["Immobilizing Slices Failed"] = 11163659709,
            ["En Garde"] = 13186059207
        },
        Movement = {
            SummonedWalk = 13170934020,
            Walk = 13170934020,
            SummonedRun = 13170931291,
            Run = 13170931291,
            EnGardeWalk = 13188051258,
            EnGardeRun = 13188057422,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            EnGardeIdle = 13186574609,
            SummonedIdle = 13170926984,
            Idle = 13170926984
        }
    },
    Stats = v1,
    Sounds = {
        SummonEffects = {
            SoundId = 9571418149,
            Volume = 1
        },
        SummonSound = {
            SoundId = 9571419973,
            Volume = 1
        },
        Desummon = {
            SoundId = 9571420724,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 11126520965,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 11126521365,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 10271930391,
            Volume = 1.25
        },
        Barrage = {
            SoundId = 10271930627,
            Volume = 1.25
        },
        SliceStartSFX = {
            SoundId = 10271926204,
            Volume = 1
        },
        SliceStartVoice = {
            SoundId = 10271926503,
            Volume = 1
        },
        SliceVoice = {
            SoundId = 10271926832,
            Volume = 1
        },
        SliceSFX = {
            SoundId = 10271925543,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 10271927978,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 10271927735,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 10271927302,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 1027192571,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13205273098,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13205272051,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13205272206,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13205272641,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 10271928169,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 10271929090,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 10271927508,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 10271925925,
            Volume = 1
        },
        EyeOfTheStormPrepare = {
            SoundId = 10566467548,
            Volume = 1
        },
        EyeOfTheStormReleaseVoice = {
            SoundId = 6183169009,
            Volume = 2
        },
        EyeOfTheStormReleaseSFX = {
            SoundId = 10566468261,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 10394760037,
            Volume = 2,
            Looped = true
        },
        RicochetShotAim = {
            SoundId = 10576631007,
            Volume = 2
        },
        RicochetShotFireSFX = {
            SoundId = 10576631114,
            Volume = 2
        },
        RicochetShotFireVoice = {
            SoundId = 10576631230,
            Volume = 2
        },
        TripleStrikeVoice = {
            SoundId = 11165385689,
            Volume = 2
        },
        TripleStrikeSFX = {
            SoundId = 11165385256,
            Volume = 2
        },
        VMoveStartSFX = {
            SoundId = 11165385256,
            Volume = 2
        },
        VMoveLandedSFX = {
            SoundId = 11181353270,
            Volume = 2
        },
        VMoveLandedVoice = {
            SoundId = 11181353156,
            Volume = 2
        },
        RMoveDashSFX = {
            SoundId = 11309338896,
            Volume = 2
        },
        YMoveReturn = {
            SoundId = 11309338502,
            Volume = 2
        },
        YMoveHitVoice = {
            SoundId = 11309338528,
            Volume = 2
        },
        YMoveHitSFX = {
            SoundId = 11309338577,
            Volume = 2
        },
        YMoveDashSFX = {
            SoundId = 11309338649,
            Volume = 2
        },
        ArmorOffSfx = {
            SoundId = 13196824628,
            Volume = 2
        },
        ArmorOffVoice = {
            SoundId = 13196824535,
            Volume = 2
        },
        ArmorOffDashVoice = {
            SoundId = 13197147023,
            Volume = 2
        },
        ArmorOffDashSfx = {
            SoundId = 13197147319,
            Volume = 2
        },
        StartYMoveArmorOffSfx = {
            SoundId = 13205272780,
            Volume = 2
        },
        StartYMoveArmorOffVoice = {
            SoundId = 13205271930,
            Volume = 2
        },
        YMoveArmorOffSfx = {
            SoundId = 13205271611,
            Volume = 2
        },
        YMoveArmorOffVoice = {
            SoundId = 13205271828,
            Volume = 2
        },
        EnGardeSfx = {
            SoundId = 13205273258,
            Volume = 2
        },
        EnGardeVoice = {
            SoundId = 13205272979,
            Volume = 2
        },
        CounterStartup = {
            SoundId = 13206094628,
            Volume = 2
        },
        CounterVoice = {
            SoundId = 13206094520,
            Volume = 2
        },
        CounterSfx = {
            SoundId = 13206094791,
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
                    SoundId = "rbxassetid://13279650470",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I will throw you into the depths of despair!"
                        } }
                }, {
                    SoundId = "rbxassetid://13279654195",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You think you can beat me?"
                        } }
                }, {
                    SoundId = "rbxassetid://13279715563",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My stand will give you what you deserve!"
                        } }
                } }
        }
    }
};