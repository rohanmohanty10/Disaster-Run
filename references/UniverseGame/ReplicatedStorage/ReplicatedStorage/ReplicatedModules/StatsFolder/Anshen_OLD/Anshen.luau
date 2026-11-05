  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Output = Knit.Remotes.Output;
local Anshen = ClientAssets.Anshen;
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = true
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    Damage = 11.25,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        ActiveEndlag = 0.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p2, p3, u4) -- Line: 39
                    -- upvalues: Output (copy)
                    Output:FireAllClients("FX", "ToggleTrails", u4.Character.Stand, true);
                    task.delay(0.38, function() -- Line: 41
                        -- upvalues: Output (ref), u4 (copy)
                        Output:FireAllClients("FX", "ToggleTrails", u4.Character.Stand, false);
                    end);
                end },
            { 23, 26, "Attack" },
            { 28, "End" }
        },
        Stun = {
            Time = 0.525,
            Priority = EnumsModule.Stun.Medium
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
                        Particle = Anshen.AnshenHit
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 8759531468,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.45,
        Sequence = {
            { 0, "Start" },
            { 0, function(p5, p6, u7) -- Line: 79
                    -- upvalues: Output (copy)
                    Output:FireAllClients("FX", "ToggleTrails", u7.Character.Stand, true);
                    task.delay(0.38, function() -- Line: 81
                        -- upvalues: Output (ref), u7 (copy)
                        Output:FireAllClients("FX", "ToggleTrails", u7.Character.Stand, false);
                    end);
                end },
            { 23, 26, "Attack" },
            { 28, "End" }
        },
        Stun = {
            Time = 0.525,
            Priority = EnumsModule.Stun.Medium
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
                        Particle = Anshen.AnshenHit
                    }
                }
            }
        }
    },
    ["LMB-3"] = {
        Speed = 1.45,
        Sequence = {
            { 0, "Start" },
            { 0, function(p8, p9, u10) -- Line: 112
                    -- upvalues: Output (copy)
                    Output:FireAllClients("FX", "ToggleTrails", u10.Character.Stand, true);
                    task.delay(0.41, function() -- Line: 114
                        -- upvalues: Output (ref), u10 (copy)
                        Output:FireAllClients("FX", "ToggleTrails", u10.Character.Stand, false);
                    end);
                end },
            { 29, 32, "Attack" },
            { 38, "End" }
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
                        Particle = Anshen.AnshenHit
                    }
                }
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = {
            { 0, "Start" },
            { 0, function(p11, p12, u13) -- Line: 142
                    -- upvalues: Output (copy)
                    Output:FireAllClients("FX", "ToggleTrails", u13.Character.Stand, true);
                    task.delay(0.4, function() -- Line: 144
                        -- upvalues: Output (ref), u13 (copy)
                        Output:FireAllClients("FX", "ToggleTrails", u13.Character.Stand, false);
                    end);
                end },
            { 21, 24, "Attack" },
            { 30, "End" }
        },
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 8759531468,
                Volume = 2,
                Pitch = 0.9
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
                        Particle = Anshen.AnshenHeavy
                    }
                }
            }
        },
        Stun = {
            Time = 0.525,
            Priority = EnumsModule.Stun.Medium
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v1.Block = {
    From = "Combat.Block"
};
v1.Pose = {
    From = "Combat.Pose",
    Actionable = {
        Summoned = true
    }
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Summoned = true
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
v1.Summon = {
    From = "Combat.Summon"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1["Accelerated Slam"] = {
    Cooldown = 12,
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Movement = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 8775748486,
                Volume = 1.5
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11, 11, 11),
            Debug = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.1
        }
    },
    Slam = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11, 11, 11),
            Debug = false,
            Offset = CFrame.new(0, 0, -5.5)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false
        },
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Velocity = Vector3.new(0, -20, 0),
            Time = 0.1
        }
    }
};
v1["Overloaded Lance"] = {
    Cooldown = 12,
    Damage = 30,
    Active = true,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Properties = {
        Armor = true
    },
    Block = {
        BlockBreak = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5.25, 6.75, 12.5),
        Debug = false,
        Offset = CFrame.new(0, 1, -6)
    },
    Throw = {
        HitAnimations = "Default",
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 70,
            Time = 0.15
        }
    }
};
v1["Energy Charge"] = {
    Cooldown = 20,
    Active = true,
    Duration = 25,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Meter = {
        RequiredLevel = 2,
        MeterGain = 0
    }
};
v1["Consecutive Slashes"] = {
    Cooldown = 11,
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    LesserHit = {
        Damage = 5,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
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
                        Particle = Anshen.AnshenHit
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 8759531468,
                Volume = 2
            }
        }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.15
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Anshen_HeavyHit", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 10657941340,
                Volume = 2
            }
        }
    }
};
v1["Lance Retrieval"] = {
    Cooldown = 15,
    Active = true,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Meter = {
        RequiredLevel = 1
    },
    Stun = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 11158014581,
            Volume = 1
        }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Velocity = Vector3.new(0, -20, 0),
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 8804198795,
                Volume = 1
            }
        }
    }
};
v1["Cataclysm Smash"] = {
    Cooldown = 20,
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Meter = {
        RequiredLevel = 1
    },
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 1.5
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Velocity = Vector3.new(0, -20, 0),
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 8804198795,
                Volume = 1
            }
        },
        Block = {
            PerfectBlockable = false
        }
    }
};
v1["Justice (Execution)"] = {
    Cooldown = 30,
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Stun = {
        Time = 0.7
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5.25, 6.75, 12.5),
        Debug = false,
        Offset = CFrame.new(0, 1, -6)
    },
    AttackStun = {
        Stun = {
            Time = 5
        }
    },
    Block = {
        Blockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 10417138987,
            Volume = 1
        }
    },
    Finisher = {
        Damage = 999,
        TrueDamage = true,
        Recovery = false,
        HitAnimations = "Default",
        Meter = false,
        HitSounds = {
            Hit = {
                SoundId = 8804198795,
                Volume = 1
            }
        }
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 50
    }
};
v1["Backslash Strike"] = {
    Cooldown = 18,
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(20, 20, 20),
        Debug = false,
        Offset = CFrame.identity
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 70,
        Time = 0.15,
        Velocity = Vector3.new(0, 20, 0)
    },
    Ragdoll = {
        Time = 0.6
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true
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
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false,
                State = "StandOn"
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Accelerated Slam"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Dash forward and then slam the ground using your lance."
            },
            ["Overloaded Lance"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Stab forward before throwing away whoever is caught by the lance."
            },
            ["Lance Retrieval"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Throw your lance forward. Upon connection with a target, you will be brought to where they are.",
                LevelRequirement = 20,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Consecutive Slashes"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Unleash a flurry of slashes into a finishing slice.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Backslash Strike"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Slam the ground in a wide AOE.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Justice (Execution)"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Execute anyone who has low enough HP instantly.",
                LevelRequirement = 120,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Cataclysm Smash"] = {
                DefaultKeybind = "V",
                State = "StandOn",
                Description = "Leap into the air before throwing your lance back down at the ground, slamming down briefly afterwards.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Energy Charge"] = {
                DefaultKeybind = "J",
                State = "StandOn",
                Description = "Gain a 25% increase in damage temporarily.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 10583694475,
            PoseIdle = 10583695744,
            ["LMB-1"] = 10584173915,
            ["LMB-2"] = 10584174823,
            ["LMB-3"] = 10584175663,
            ["LMB-4"] = 10584176570,
            ["Counter-Startup"] = 10558960348,
            ["Counter-Hit"] = 9217197796,
            ConsecutiveSlashes = 10584122382,
            Summon = 8269567032,
            AcceleratedSwing = 8099605049,
            SwiftWings = 8269661162,
            Swing = 8118489878,
            Throw = 8118487070,
            EnergyCharge = 8269577491,
            LanceRetrieval = 8118482919,
            LanceAttack = 8118477962,
            CataclysmSmashWind = 8099627588,
            CataclysmSmashAssault = 8099633176,
            JusticeWindup = 8118460630,
            Execution = 8152935668,
            Grab = 11110729280,
            ThrowVictim = 11110732132,
            ["StandOn-Grab"] = 11110729280,
            ["StandOn-Throw"] = 11110730939,
            ["StandOn-ThrowVictim"] = 11110732132,
            ["Stand-Block"] = 12499353550
        },
        Movement = {
            SummonedRun = 8303099403,
            SummonedWalk = 8303100740
        },
        Idle = {
            SummonedIdle = 8303096030
        }
    },
    Stats = v1,
    Sounds = {
        ["LMB-1"] = {
            SoundId = 8759525785,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 8759526393,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 8759525785,
            Volume = 2,
            Pitch = 0.95
        },
        ["LMB-4"] = {
            SoundId = 8759527309,
            Volume = 2
        },
        EnergyCharge = {
            SoundId = 10417130927,
            Volume = 2.5
        },
        EnergyChargeVoice = {
            SoundId = 10582271448,
            Volume = 2.5
        },
        StartSlash = {
            SoundId = 10417133875,
            Volume = 1.5
        },
        Slam = {
            SoundId = 10417136580,
            Volume = 1.5
        },
        Hitsound2 = {
            SoundId = 10417138987,
            Volume = 1.5
        },
        Hitsound1 = {
            SoundId = 10417140735,
            Volume = 1.5
        },
        CounterStart = {
            SoundId = 10417141965,
            Volume = 1.5
        },
        Desummon = {
            SoundId = 8748461581,
            Volume = 1.5
        },
        Summon = {
            SoundId = 8748443693,
            Volume = 1.5
        },
        AnshenRush = {
            SoundId = 8775745795,
            Volume = 1.5
        },
        Dash = {
            SoundId = 10657940287,
            Volume = 1.5
        },
        Slashes = {
            SoundId = 10657942171,
            Volume = 1.5
        },
        PoseMusic = {
            SoundId = 15026700853,
            Volume = 1.5
        },
        LanceSwing = {
            SoundId = 8800802691,
            Volume = 1.5
        },
        LanceSwingHit = {
            SoundId = 8800805271,
            Volume = 1.5
        },
        LanceThrow = {
            SoundId = 8804196473,
            Volume = 1.5
        },
        LanceSlam = {
            SoundId = 8824626315,
            Volume = 2.5
        },
        Fly = {
            SoundId = 8824625528,
            Volume = 2.5
        },
        LanceHeavyHit = {
            SoundId = 8804198795,
            Volume = 1.5
        }
    }
};