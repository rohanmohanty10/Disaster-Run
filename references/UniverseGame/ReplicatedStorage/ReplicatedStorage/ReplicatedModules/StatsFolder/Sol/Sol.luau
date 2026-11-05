  

 

local CurrentCamera = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 5
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("MoveInputService");
end);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local TableUtil = require(Knit.Util.TableUtil);
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Enums = require(game.ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local _ = ReplicatedStorage.Remotes.Output;
local v2 = ReplicatedStorage["Client Assets"];

local function GetFacing(p3, p4) -- Line: 29
    -- upvalues: CurrentCamera (copy)
    local v5 = nil;
    local v6 = nil;
    local v7 = p4 or 10;
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");
    local Humanoid = p3:FindFirstChild("Humanoid");

    if HumanoidRootPart and Humanoid then
        for _, child in ipairs(workspace.Living:GetChildren()) do
            if child ~= p3 then
                local Humanoid2 = child:FindFirstChild("Humanoid");
                local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");

                if Humanoid2 and (HumanoidRootPart2 and (Humanoid.Health > 0 and (Humanoid2.Health > 0 and CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector:Dot(CurrentCamera.CFrame.LookVector) > 0))) then
                    local _, v8 = CurrentCamera:WorldToScreenPoint(HumanoidRootPart2.Position);

                    if v8 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude;

                        if v7 >= Magnitude then
                            if v5 then
                                if Magnitude < v6 then
                                    v5 = child;
                                end;
                            else
                                v5 = child;
                                v6 = Magnitude;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return v5;
    end;
end;

local v9 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v2.Sol.Sol_HitVFX
        }
    }
};
local v10 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v2.Sol.Sol_HeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0)
        }
    }
};
local v11 = {
    Hit = {
        SoundId = 12718555286,
        Volume = 1.5
    }
};
local v14 = {
    Summon = {
        From = "Combat.Summon",
        SummonV2 = true,
        LeaveParts = { "StandHumanoidRootPart" },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
    },
    Block = {
        From = "Combat.Block"
    },
    Grab = {
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
    },
    ["Rush Attack"] = {
        From = "Combat.Rush Attack",
        Actionable = {
            Summoned = false
        },
        AnimationTimed = false,
        MaxCombo = 4,
        ComboTick = 1.5,
        ["LMB-1"] = TableUtil.Reconcile({
            Damage = 8,
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
            Stun = {
                Time = 0.75,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v9 },
            HitData = {
                EmitType = "Enabled",
                EmitDuration = 0.1,
                Particle = v2["Star Platinum"].SPHit.Attachment
            },
            HitSounds = v11
        }, BaseStatsModule.Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            Damage = 21,
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
            Stun = {
                Time = 0.3
            },
            HitRemotes = { v10 },
            HitData = {
                EmitType = "Enabled",
                EmitDuration = 0.2,
                Particle = v2["Star Platinum"].SPHeavy.Attachment
            },
            HitSounds = {
                Hit = {
                    SoundId = 12718536334,
                    Volume = 1.5
                }
            }
        }, BaseStatsModule.Stand_Rush_Attack_Finisher),
        ["StandOff-LMB-1"] = {
            Endlag = 0.2,
            ActiveEndlag = 0.1,
            Speed = 1.1,
            Damage = 8,
            Meter = true,
            HitAnimations = "Default",
            Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 25, "End" } },
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
                Blockable = true,
                PerfectBlockable = false,
                BlockBreak = false,
                PerfectBlockBreak = false,
                PerfectBlockTime = 0.2
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            HitRemotes = { v9 },
            HitSounds = {
                Hit = {
                    SoundId = 12718831261,
                    Volume = 1.5
                }
            }
        },
        ["StandOff-LMB-2"] = {
            Speed = 1,
            Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 25, "End" } }
        },
        ["StandOff-LMB-3"] = {
            Speed = 1,
            Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 25, "End" } }
        },
        ["StandOff-LMB-4"] = {
            Speed = 1.75,
            Cooldown = 0.75,
            Damage = 21,
            HitAnimations = "Default",
            Sequence = { { 0, "Start" }, { 30, 40, "Attack" }, { 45, "End" } },
            Stun = {
                Time = 0.3
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 64,
                Time = 0.2
            },
            HitRemotes = { v10 },
            HitSounds = {
                Hit = {
                    SoundId = 12718831312,
                    Volume = 1.5
                }
            }
        },
        Callbacks = {
            StateChecker = function(p12, p13) -- Line: 322, Name: StateChecker
                -- upvalues: Knit (copy), TableUtil (copy)
                local Stats = p12.Stats;

                if not Knit.CollectionService:HasTag(p12.Character, "Summoned") then
                    Stats = TableUtil.Copy(Stats, true);
                    Stats.CustomPrefix = "StandOff-LMB";
                end;

                return Stats;
            end
        }
    },
    ["Nova Slicer"] = {
        Active = true,
        Actionable = {
            Active = true
        },
        Cooldown = {
            Time = 17,
            Manual = true
        },
        Normal = {
            Meter = true,
            Damage = 5,
            HitAnimations = "Default",
            Stun = {
                Time = 0.85,
                Priority = Enums.Stun.Medium
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitRemotes = { v9 },
            HitSounds = {
                Hit = {
                    SoundId = 12968287722,
                    Volume = 1.5
                }
            }
        },
        Final = {
            Meter = true,
            Damage = 15,
            HitAnimations = "Default",
            Stun = {
                Time = 0.3,
                Priority = Enums.Stun.Medium
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                Unblockable = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 64,
                Time = 0.2
            },
            HitRemotes = { v10 },
            HitSounds = {
                Hit = {
                    SoundId = 12968291704,
                    Volume = 2
                }
            }
        }
    },
    ["Cosmos Barrage"] = {
        Active = true,
        Actionable = {
            Active = true
        },
        Cooldown = {
            Time = 14,
            Manual = true,
            AfterMove = true
        },
        Barrage = TableUtil.Reconcile({
            CustomPrefix = "CosmosBarrage",
            Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "CosmicBarrage-Voiceline", {
                        Cancelable = true
                    } }, { 0, "PlaySound", "CosmicBarrage-Startup", {
                        Cancelable = true
                    } }, { 0, "PlaySound", "CosmicBarrage", {
                        Cancelable = true
                    } }, { 0, "Cancelable", true }, { 0, "Clashable", true }, { 0, "Barrage", true }, { 0, 180, "BarrageAttack", "Hit" }, { 180, "Cancelable", false }, { 180, "Clashable", false }, { 180, "BarrageFinisher", {
                        AnimationSpeed = 1.5
                    } }, { 200, "BarrageAttack", "Finisher" }, { 230, "End" } },
            Hit = {
                Frequency = 7,
                Damage = 1,
                Meter = true,
                HitAnimations = "Default",
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                Stun = {
                    Time = 0.65,
                    Priority = Enums.Stun.Medium
                },
                HitRemotes = { v9 },
                HitSounds = {
                    Hit = {
                        SoundId = 12926375715,
                        Volume = 1.5
                    }
                }
            },
            Finisher = {
                HitRemotes = { v10 },
                HitSounds = {
                    Hit = {
                        SoundId = 12926422360,
                        Volume = 2
                    }
                }
            },
            ClashHit = {
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
                HitSounds = {
                    Hit = {
                        SoundId = 10725853580,
                        Volume = 2
                    }
                }
            }
        }, BaseStatsModule.Stand_Barrage)
    }
};
v14["Cosmos Barrage"].Barrage.Hit.Knockback = nil;
v14["Nova Piercer"] = {
    Active = true,
    Cooldown = 16,
    Actionable = {
        Active = true
    },
    Grab = {
        CheckPVPSafe = true,
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Heavy
        },
        Hitbox = {
            Size = Vector3.new(8, 8, 10.5),
            Debug = false,
            Offset = CFrame.new(0, 0, -5.25),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        }
    },
    Throw = {
        Meter = true,
        Damage = 30,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 25,
            Time = 0.15,
            Velocity = Vector3.new(0, 25, 0)
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        }
    }
};
v14["Star Blast"] = {
    Active = true,
    Cooldown = 15,
    Damage = 60,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Heavy
    },
    Ragdoll = {
        Time = 0.95
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 12, 12),
        Debug = false,
        Offset = CFrame.new(0, 0, -6)
    },
    Block = {
        Unblockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 80,
        Time = 0.2
    },
    HitRemotes = { v10 },
    HitSounds = {
        Hit = {
            SoundId = 12983360801,
            Volume = 2
        }
    }
};
v14["Stardust Blast"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Knockback = {
        Time = 0.15,
        Velocity = Vector3.new(0, 45, 0)
    },
    Stun = {
        Time = 1.8,
        Priority = Enums.Stun.Medium
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(20, 20, 20),
        Debug = false,
        Offset = CFrame.identity
    }
};
v14["Cosmic Greatsword"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 17,
        Manual = true
    },
    Knockback = {
        Time = 0.1,
        Velocity = Vector3.new(0, 55, 0)
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BlockBreak = true,
        PerfectBlockBreak = false
    },
    Stun = {
        Time = 0.8,
        Priority = Enums.Stun.Heavy
    },
    HitRemotes = { v9 },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(25, 25, 25),
        Debug = false,
        Offset = CFrame.identity
    }
};
v14["Terreno Magica"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Meter = {
        RemoveMeter = true,
        RequiredLevel = 2
    },
    Success = {
        Damage = 10,
        Priority = Enums.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = "rbxassetid://12756477169",
                Volume = 1.5
            }
        }
    },
    Duration = 25,
    Cooldown = 40
};
v14.Constellation = {
    Active = true,
    Damage = 5,
    Cooldown = 21,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 2,
        Priority = Enums.Stun.Heavy
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Debug = false,
        Offset = CFrame.identity
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BlockCancel = true,
        PerfectBlockCancel = false
    },
    HitSounds = {
        Hit = {
            SoundId = "rbxassetid://12756904583",
            Volume = 1.65
        }
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    }
};
v14.Blackhole = {
    Active = true,
    Damage = 20,
    Cooldown = 24,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = true,
        Amount = 0
    },
    BlackholeStats = {
        Damage = 0.5,
        Meter = false,
        Duration = 3,
        HitFrequency = 15,
        Explosion = {
            Damage = 55,
            Meter = false,
            Stun = {
                Time = 1.5,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                Override = true,
                Speed = 55,
                Time = 0.2
            },
            Ragdoll = {
                Time = 1.5
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BlockCancel = true,
                PerfectBlockCancel = true
            }
        },
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Heavy
        },
        Hitbox = {
            Size = Vector3.new(30, 30, 30),
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockCancel = false,
            PerfectBlockCancel = false
        }
    }
};
v14["Bladed Retaliation"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RemoveMeter = true,
        RequiredLevel = 1
    },
    Success = {
        Damage = 11.666666666666666,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Heavy
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        HitRemotes = { v9 },
        HitSounds = v11
    },
    Cooldown = 11
};
v14["Stellar Surroundings"] = {
    Active = true,
    Cooldown = 50,
    ArmorDuration = 30,
    Heal = 15,
    Actionable = {
        Active = true
    },
    Meter = {
        RemoveMeter = true,
        RequiredLevel = 3
    }
};
v14.Teleport = {
    From = "Combat.Teleport"
};
v14.Quickstep = {
    From = "Combat.Quickstep"
};
v14.Pose = {
    From = "Combat.Pose"
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
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Cosmos Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Teleport behind the nearest victim, as the stand unleashes multiple strikes while the move is held before ending the attack off with a finisher."
            },
            ["Nova Piercer"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Summon your sword and pierce a target before slamming them down."
            },
            ["Nova Slicer"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Description = "Summon out your sword to slice, this key can be pressed a total of 5 times consecutively, the 5th slice is a finishing slice.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Star Blast"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Description = "The stand charges up before throwing out a strong punch.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Stardust Blast"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "If a victim is nearby, kick down, unleashing a strong ground slam.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Cosmic Greatsword"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "The stand charges up before spawning a sword right above a target as it falls down.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Stellar Surroundings"] = {
                DefaultKeybind = "G",
                Description = "Enter a state where some of your statistics are temporarily buffed.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Terreno Magica"] = {
                DefaultKeybind = "H",
                State = "StandOff",
                Description = "Enter a state, enabling a passive where every move may activate ugo aim swords after it hits.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Constellation = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "The stand charges up while the move is held, forming a star in it\'s attack pattern. The range of this depends on how long the move was held for.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            Blackhole = {
                DefaultKeybind = "Z",
                Description = "Throw a projectile before it forms a blackhole to where it\'s thrown, pulling anyone before exploding. Deals increased damage to targets below 15% HP",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleport in the direction you\'re facing.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Bladed Retaliation"] = {
                DefaultKeybind = "B",
                Description = "Enter a counterattack-state, if hit, multiple swords spawn and attack the target who hit you.",
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
            BarrageStartup = 12350247491,
            Barrage = 12350253538,
            BarrageFinisher = 12350318291,
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 11371980872,
            ["StandOff-LMB-2"] = 11371981731,
            ["StandOff-LMB-3"] = 11371982707,
            ["StandOff-LMB-4"] = 11371983463,
            ["Stardust Blast"] = 12550162970,
            ["Cosmic Greatsword"] = 12917612579,
            ["Armor Activation"] = 12743658467,
            ["Armor Deactivation"] = 12743926716,
            ["Sol Bladed Retaliation"] = 12351098612,
            ["Sol BR Hit"] = 12351102315,
            ["Sol BR Miss"] = 12351101285,
            ["Terreno Magica"] = 12351105839,
            ["Sol Cosmic Greatsword"] = 12351107660,
            CosmosBarrage = 12351109775,
            CosmosBarrageStartup = 12351112563,
            CosmosBarrageFinisher = 12423794981,
            ["BlackHole Throw User"] = 12686397147,
            ["Constellation Combo"] = 13570129920,
            ["Constellation Start"] = 13570074612,
            ["Constellation Loop"] = 13570094040,
            ["Constellation End"] = 13569982845,
            ["Nova Pierce Startup"] = 12549418443,
            ["Nova Pierce FollowUp User"] = 12549422896,
            ["Nova Pierce FollowUp Victim"] = 12549426735,
            ["Sol Jab Startup"] = 12550140002,
            ["Sol Jab"] = 12550135246,
            ["Sol Jab Victim"] = 12550138153,
            ["Star Blast"] = 12937241339,
            PoseIdle = 12938888498,
            PoseTransition = 12938885014,
            ["Left Swing"] = 12795997742,
            ["Right Swing"] = 12795999391,
            ["Swing Finisher"] = 12796001250
        },
        Movement = {
            Walk = 12351087145,
            Run = 12351088089,
            ["Summoned-Walk"] = 12795791881,
            ["Summoned-Run"] = 12795789258,
            ["Armor-Walk"] = 12743673358,
            ["Armor-Run"] = 12743671426
        },
        Idle = {
            Idle = 12351085078,
            ["Summoned-Idle"] = 12795786061,
            ["Armor-Idle"] = 12743668826
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = "rbxassetid://12718536450",
            Volume = 2
        },
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://12718536612",
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = "rbxassetid://12718536585",
            Volume = 2
        },
        ["Desummon-Voiceline"] = {
            SoundId = "rbxassetid://12718536665",
            Volume = 2
        },
        ["CosmicBarrage-Startup"] = {
            SoundId = "rbxassetid://12926583776",
            Volume = 2
        },
        ["CosmicBarrage-Startup-Voiceline"] = {
            SoundId = "rbxassetid://12926607810",
            Volume = 2
        },
        ["Blackhole Voice"] = {
            SoundId = "rbxassetid://12939613183",
            Volume = 2
        },
        ["Blackhole windup SFX"] = {
            SoundId = "rbxassetid://12695472371",
            PlaybackSpeed = 1,
            Volume = 2
        },
        ["Stardust Blast Voice"] = {
            SoundId = "rbxassetid://12939606243",
            Volume = 2
        },
        ["Stardust Blast Charge"] = {
            SoundId = "rbxassetid://12718536392",
            Volume = 2,
            PlaybackSpeed = 1
        },
        ["Stardust Blast SFX"] = {
            SoundId = "rbxassetid://12718536518",
            Volume = 2,
            PlaybackSpeed = 1
        },
        ["Star Blast Voice"] = {
            SoundId = "rbxassetid://12983363436",
            Volume = 2
        },
        ["Star Blast SFX"] = {
            SoundId = "rbxassetid://12983356339",
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 12939595319,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 12939600248,
            Volume = 2
        },
        ConstellationCombo = {
            SoundId = "rbxassetid://12756904695",
            Volume = 2,
            PlaybackSpeed = 1
        },
        WindUpConstellation = {
            SoundId = "rbxassetid://12756904441",
            Volume = 1.65,
            PlaybackSpeed = 1
        },
        Teleport = {
            SoundId = "rbxassetid://12825328901",
            Volume = 1.5
        },
        ["Sol Armor"] = {
            SoundId = "rbxassetid://12756477388",
            PlaybackSpeed = 1.15,
            Volume = 1.7
        },
        ["Sol Armor Voice"] = {
            SoundId = "rbxassetid://12926540118",
            Volume = 2
        },
        ["Terreno Voice"] = {
            SoundId = "rbxassetid://12939622338",
            Volume = 2
        },
        ["Terreno Startup"] = {
            SoundId = "rbxassetid://12756476999",
            PlaybackSpeed = 1,
            Volume = 1.7
        },
        ["Nova Piercer Startup SFX"] = {
            SoundId = "rbxassetid://12968192982",
            Volume = 2
        },
        ["Nova Piercer Hit SFX"] = {
            SoundId = "rbxassetid://12968195475",
            Volume = 2
        },
        ["Nova Piercer Hit"] = {
            SoundId = "rbxassetid://12825324187",
            Volume = 2
        },
        ["Nova Piercer Startup"] = {
            SoundId = "rbxassetid://12825325519",
            Volume = 2
        },
        ["Nova Slicer Normal"] = {
            SoundId = "rbxassetid://12968276385",
            Volume = 2
        },
        ["Nova Slicer Final"] = {
            SoundId = "rbxassetid://12968289722",
            Volume = 2
        },
        ["Counter Startup"] = {
            SoundId = "rbxassetid://12756477607",
            Volume = 1
        },
        ["Greatsword Startup"] = {
            SoundId = "rbxassetid://12926475850",
            Volume = 2
        },
        ["Greatsword Voice"] = {
            SoundId = "rbxassetid://12926476917",
            Volume = 2
        },
        ["Greatsword Summon"] = {
            SoundId = "rbxassetid://12926343321",
            Volume = 1.5
        },
        ["Greatsword Explode"] = {
            SoundId = "rbxassetid://12926344283",
            Volume = 2.5
        },
        PoseMusic = {
            SoundId = 12939717502,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 12926161163,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 12926165032,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 12926169411,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 12926171848,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 11499912997,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 12926161163,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 12926165032,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 12926169411,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 12926171848,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 11499912997,
            Volume = 2
        }
    },
    Stats = v14,
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://12939713247",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Give me a break."
                        } }
                }, {
                    SoundId = "rbxassetid://12939714250",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m gonna break it... and by \'it\', I mean your face."
                        } }
                } }
        }
    }
};