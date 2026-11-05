  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Enums = require(game.ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local Output = ReplicatedStorage.Remotes.Output;
local u1 = ReplicatedStorage["Client Assets"];
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
            Particle = u1.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(183, 82, 255)
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
            Particle = u1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(183, 82, 255)
        }
    }
};
({}).Hit = {
    SoundId = 6899463110,
    Volume = 1.5
};
({}).Hit = {
    SoundId = 6164853733,
    Volume = 3
};
v2.Summon = {
    From = "Combat.Summon",
    LeaveParts = { "StandHumanoidRootPart", "RootPart" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 0, 72)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
};
v2.Block = {
    From = "Combat.Block"
};
v2.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Grab = {
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
v2["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = false,
    MaxCombo = 4,
    ComboTick = 1.5,
    NoEndlag = false,
    ["LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.35,
        ActiveEndlag = 0.2,
        Stun = {
            Time = 0.5
        },
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" } },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 6899463110,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Stun = {
            Time = 0.3
        },
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" } },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 6164853733,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p5, p6) -- Line: 161, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p5.Stats;

            if not Knit.CollectionService:HasTag(p5.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v2["Rush Attack"] = TableUtil.Reconcile(v2["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v2["Ground Slam"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 10
    },
    Priority = Enums.Intangible.Ragdoll,
    Stun = {
        Time = 0.5,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 42,
        Velocity = Vector3.new(0, 16, 0),
        Time = 0.2
    },
    Ragdoll = {
        Time = 1.2
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Debug = false,
        Offset = CFrame.new(0, 0, -7)
    },
    Block = {
        PerfectBlockable = true,
        BlockBreak = true
    }
};
v2.Impale = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        Damage = 20,
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
        Damage = 15,
        Priority = Enums.Intangible.Move + 1,
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
v2.Barrage = TableUtil.Reconcile({
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
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 6899463110,
                Volume = 1
            }
        }
    },
    Finisher = {
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 6164853733,
                Volume = 3
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
}, BaseStatsModule.Stand_Barrage);
v2.Teleport = {
    Active = true,
    From = "Combat.Teleport",
    Actionable = {
        Active = true
    }
};
v2["Arrow Guard"] = {
    Active = true,
    Damage = 30,
    Distance = 5,
    Cooldown = 16,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 1.2
    },
    Ragdoll = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(30, 30, 30),
        Debug = false,
        Offset = CFrame.identity
    }
};
v2["Shadow Energy"] = {
    Active = true,
    Cooldown = 65,
    Percentage = 20,
    Damage = 55,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 75,
        MeterGain = 0
    },
    Properties = {
        Intangible = true,
        Restrain = true
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 20,
        Offset = CFrame.new(0, 0, -4)
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Golden Rectangle Debuff"
        } },
    Ragdoll = {
        Time = 2
    },
    Priority = Enums.Intangible.Ragdoll,
    Knockback = {
        RelativeTowards = "Target",
        Speed = 20,
        Time = 0.1
    }
};
v2["Heavy Punch"] = {
    Active = true,
    Meter = true,
    Damage = 35,
    Cooldown = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Ragdoll = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 75,
        Time = 0.15
    },
    Block = {
        BlockBreak = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9.2, 9.2, 9.2),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitSounds = {
        Hit = {
            SoundId = 6899466638,
            Volume = 1
        }
    },
    HitRemotes = { v3 }
};
v2["Knife Throw"] = {
    Active = true,
    Cooldown = 15,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8.4, 8.96, 18.48),
        Debug = false,
        Offset = CFrame.new(0, 0, -7)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Stun = {
        Time = 1.5,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
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
                    Particle = u1.Universal.BloodVFX
                }
            }
        }
    },
    Arrow = {
        Damage = 1.25,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 11370985410,
            Volume = 1.5
        }
    }
};
v2["Knife Throw OLD"] = {
    Active = true,
    Damage = 10,
    Cooldown = 16,
    Distance = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Meter = {
        RequiredAmount = 15
    },
    HitSounds = {
        Hit = {
            SoundId = 6920222797,
            Volume = 1.5
        }
    },
    WormholeKnife = {
        Damage = 2.5,
        Distance = 5,
        HitAnimations = "Default",
        HitSounds = {
            Hit = {
                SoundId = 6920222797,
                Volume = 1.5
            }
        },
        HitRemotes = { v3 }
    }
};
v2.Timestop = {
    Active = true,
    Speed = 0.675,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        CanTimestop = true
    },
    Cooldown = {
        Name = "Timestop",
        Time = 60,
        AfterMove = true
    },
    Sequence = { { 0, "PlayAnim", "Timestop" }, { 0, "PlaySound", "TimeStop" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 54, "Timestop" }, { 95, "End" } },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 6,
        Size = 150,
        StopSounds = {},
        ResumeSounds = { "TSEndVoice" }
    }
};
v2["Cursed Orb"] = {
    Cooldown = 40,
    Damage = 25,
    Stun = 0.75,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = true,
        CheckActive = true,
        CheckTimestop = true
    },
    OrbData = {
        Speed = 5,
        Offset = Vector3.new(0, 28.5, 0),
        Cooldown = 1,
        Range = 53.5,
        Length = 22.5,
        Size = Vector3.new(25, 25, 25),
        Color = Color3.fromRGB(123, 28, 255)
    },
    LightningData = {
        Amount = 17.5,
        Size = Vector3.new(0.3, 0.5, 0.3),
        Offset = 5,
        Color = Color3.fromRGB(123, 28, 255),
        Tween = { { 0.25 }, { 1.15 } }
    }
};
v2.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p7, p8) -- Line: 657, Name: PoseTransition
            -- upvalues: Output (copy), u1 (copy), ParticleHandler (copy), EnableBirthmark (copy)
            local Player = p7.Player;
            local Character = p7.Character;
            local SkinName = p8.SkinName;
            local PoseParticle = Character:FindFirstChild("PoseParticle", true);

            if PoseParticle then
                PoseParticle.Enabled = true;
            end;

            if SkinName == "U-Star" then
                local u9 = u1.STWR.AnnihilateBlackhole:Clone();
                ParticleHandler.Unusualify(u9, p7);
                u9.Name = "BlackholeEffect";
                u9.Parent = Character.Stand["Stand Left Arm"];
                Character.Stand.StandHumanoidRootPart.HowCharming:Play();
                local Weld = Instance.new("Weld");
                Weld.Part0 = Character.Stand["Stand Left Arm"];
                Weld.Part1 = u9;
                Weld.Parent = u9;
                Weld.C0 = CFrame.new(0, -1.5, -2);
                task.delay(0.2, function() -- Line: 682
                    -- upvalues: u9 (copy)
                    for _, descendant in pairs(u9:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = true;
                        end;
                    end;
                end);
            else
                Output:FireAllClients("FX", "HoldProp", Player, "STWRChair", Character.HumanoidRootPart, 100000000000, nil, true);
            end;

            EnableBirthmark(p7.Character, true);
        end,

        PoseEnd = function(p10, p11) -- Line: 693, Name: PoseEnd
            -- upvalues: Output (copy), EnableBirthmark (copy)
            local Player = p10.Player;
            local Character = p10.Character;
            local SkinName = p11.SkinName;
            local PoseParticle = Character:FindFirstChild("PoseParticle", true);

            if PoseParticle then
                PoseParticle.Enabled = false;
            end;

            if SkinName == "U-Star" then
                if Character.Stand["Stand Left Arm"]:FindFirstChild("BlackholeEffect") then
                    local BlackholeEffect = Character.Stand["Stand Left Arm"]:FindFirstChild("BlackholeEffect");
                    pcall(function() -- Line: 710
                        -- upvalues: BlackholeEffect (copy)
                        BlackholeEffect.Weld:Destroy();
                        BlackholeEffect.Name = "Gone";
                    end);
                    BlackholeEffect.Anchored = true;

                    for _, descendant in pairs(BlackholeEffect:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;

                    task.delay(3, function() -- Line: 722
                        -- upvalues: BlackholeEffect (copy)
                        BlackholeEffect:Destroy();
                    end);
                end;
            else
                Output:FireAllClients("FX", "HoldProp", Player, "STWRChair", Character.HumanoidRootPart, 0);
            end;

            EnableBirthmark(p10.Character, false);
        end
    }
};
v2["Life Drain"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Active = true,
    CheckPVPSafe = true,
    Meter = {
        RequiredAmount = 25,
        MeterGain = 0
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
    HitRemotes = { v3 },
    Drain = {
        Damage = 7.5,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Lifesteal = {
            Type = "Flat",
            Amount = 8.75
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
                        Particle = u1.Universal.BloodVFX
                    }
                }
            }
        }
    },
    Throw = {
        Meter = false,
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
v2["Instant Cleave"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    EndFrame = 40,
    AttackFrame = 26,
    Iteration = 5,
    AppearFrame = 10,
    DisappearFrame = 31,
    Priority = Enums.Intangible.Ragdoll,
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
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 6164853733,
            Volume = 3
        }
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
v2["Timestop Movement"] = {
    From = "Combat.Timestop Movement"
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
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly perform multiple strikes while this move is held down, before unleashing a finishing strike."
            },
            ["Heavy Punch"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Unleash a heavy blow in front of you."
            },
            ["Arrow Guard"] = {
                DefaultKeybind = "B",
                Description = "Summon multiple Shadow Arrows before commanding them to rush forth.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Impale = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Summon multiple Shadow Arrows before commanding them to rush forth.",
                LevelRequirement = 35
            },
            ["Knife Throw"] = {
                DefaultKeybind = "T",
                Description = "Throw multiple knives in front of you.",
                LevelRequirement = 20,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Ground Slam"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Slam your stands fist into the ground with might.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Life Drain"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                LevelRequirement = 80,
                Description = "Swiftly pierce the targets body to drain their blood, giving you health in return."
            },
            ["Shadow Energy"] = {
                DefaultKeybind = "J",
                Description = "Charge up shadow energy before unleashing it.",
                LevelRequirement = 70,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleports you a short distance.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "H+",
                Description = "Your stand briefly stops time in a radius.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "H",
                Description = "Gives you the ability to move during a timestop.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Instant Cleave"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                LevelRequirement = 45,
                Description = "The stand teleports behind a target & strikes them."
            }
        }
    },
    Animations = {
        Action = {
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            Impale = 10898039552,
            ["Impale Startup"] = 10898048721,
            ["Impale Target"] = 10898041509,
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["Life Drain"] = 107404235562968,
            ["Life Drain Followup"] = 87529051771176,
            ["Life Drain Victim"] = 14181914457,
            ["Checkmate Startup"] = 12868712369,
            ["Checkmate Loop"] = 12868713713,
            ["Checkmate Throw"] = 17109280149,
            ["Heavy Punch"] = 10603603515,
            ["Arrow Guard"] = 84758701113212,
            ["Knife Throw"] = 6648818204,
            ["Sudden Strike"] = 119220411960134,
            ["Ground Slam"] = 11005558877,
            ["Shadow Energy"] = 96957381662183,
            ["Shadow Explode"] = 6921232750,
            Timestop = 6766060710,
            PoseTransition = 7193349702,
            PoseIdle = 7193229967
        },
        Movement = {
            Walk = 115498418116063,
            Run = 76136040525289,
            SummonedRun = 76136040525289,
            SummonedWalk = 115498418116063,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 77014832550458,
            Idle = 77014832550458
        }
    },
    Stats = v2,
    Sounds = {
        ["LMB Combo"] = {
            SoundId = "rbxassetid://5287671885"
        },
        ["Arrow Shoot"] = {
            SoundId = "rbxassetid://2553983089"
        },
        ["Cursed Uppercut"] = {
            SoundId = "rbxassetid://1238240873"
        },
        ["Arrow Inversion"] = {
            SoundId = "rbxassetid://2553983089"
        },
        PoseMusic = {
            Looped = true,
            SoundId = "rbxassetid://9490159462",
            PlaybackSpeed = 0.669,
            Volume = 2
        },
        Grab = {
            SoundId = 11745738946,
            Volume = 1
        },
        Grabbed = {
            SoundId = 11745739074,
            Volume = 1
        },
        ["Impale Startup"] = {
            SoundId = 10920809881,
            Volume = 2
        },
        ["Counter Startup"] = {
            SoundId = 86768332726947,
            Volume = 2
        },
        ["Shadow Energy"] = {
            SoundId = 131107182680753,
            Volume = 2
        },
        ["Knife Throw"] = {
            SoundId = 102764250271407,
            Volume = 2
        },
        ["Sudden Strike SFX"] = {
            SoundId = 101878079180258,
            Volume = 2
        },
        ["Counter Activate"] = {
            SoundId = 88391494737707,
            Volume = 2
        },
        ["Life Drain"] = {
            SoundId = 134295693957405,
            Volume = 2
        },
        ["Life Drain Startup"] = {
            SoundId = 119020177315757,
            Volume = 2
        },
        Knives = {
            Looped = false,
            SoundId = "rbxassetid://6663265333",
            Volume = 3
        },
        ["Strong Punch SFX"] = {
            SoundId = "rbxassetid://12816602668",
            Volume = 1,
            PlaybackSpeed = 1
        },
        Desummon = {
            SoundId = "rbxassetid://6862796826",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = "rbxassetid://6663265333",
            Volume = 4
        },
        ["Checkmate Activation SFX"] = {
            SoundId = 11206834039,
            Volume = 2
        },
        ["Checkmate Windup"] = {
            SoundId = 11206836144,
            Volume = 2
        },
        Knives_Hit = {
            SoundId = 11206836835,
            Volume = 2
        },
        Knives_Ding = {
            SoundId = 11206837650,
            Volume = 2
        },
        Knives_Ting = {
            SoundId = 11206839775,
            Volume = 2
        },
        GroundSlam = {
            SoundId = "rbxassetid://11107298561",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ShadowExplosion = {
            SoundId = "rbxassetid://6920247433",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ShadowCharge = {
            SoundId = "rbxassetid://6920246042",
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ArrowThrow = {
            SoundId = "rbxassetid://6920222797",
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ArrowSummon = {
            SoundId = "rbxassetid://6920221922",
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSEndVoice = {
            SoundId = "rbxassetid://6785163547",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://6726252687",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeStop = {
            SoundId = "rbxassetid://9062037114",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Strong Punch Voiceline"] = {
            SoundId = "rbxassetid://6725294003",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Teleport = {
            SoundId = "rbxassetid://6708961375",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TeleportVoiceline = {
            SoundId = "rbxassetid://6783687651",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SwingLMB = {
            SoundId = "rbxassetid://6706981833",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://6717489528",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://6717488445",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://6717487517",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://6717486354",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://6717489528",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://6717488445",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://6717487517",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://6717486354",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://9066034416",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlamImpact = {
            SoundId = "rbxassetid://6964548853",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
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
                    SoundId = "rbxassetid://9066070476",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Some destinies deserve to be destroyed and some fates deserve to be vanquished!"
                        } }
                }, {
                    SoundId = "rbxassetid://6813818644",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hmph... it\'s futile."
                        } }
                }, {
                    SoundId = "rbxassetid://9066053206",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Invincibility... immortality... stand power!"
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p12) -- Line: 1438, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p12.Player;
            local Character = p12.Character;
            local SkinName = p12.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v13 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v13.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v13;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};