  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local EnumsModule = require(PathShortcuts.EnumsModule);
require(PathShortcuts.BaseStatsModule);

local function CreateMultiIndicator(p1) -- Line: 16
    local v2 = {};

    for i, v in pairs(p1) do
        if i ~= "Overrides" then
            table.insert(v2, {
                InputText = "%s",
                Visible = true,
                Group = i,
                Name = v,
                DisplayName = v,
                CooldownName = v,
                ActiveName = v
            });
        end;
    end;

    if p1.Overrides then
        for _, v in ipairs(v2) do
            for i, v3 in pairs(p1.Overrides) do
                v[i] = v3;
            end;
        end;
    end;

    return v2;
end;

local v3 = { {
        Name = "Output",
        Arguments = { "FX", "HitEffect", "__Legacy" }
    } };
local v4 = { {
        Name = "Output",
        Arguments = { "FX", "HeavyEffect", "__Legacy" }
    } };

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            },
            StandOn = {
                Visible = false
            },
            StandOff = {}
        },
        Moves = {
            MouseButton1 = "Rush Attack",
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            Q = "Summon",
            E = "Gaster Combo",
            R = "Primary Abilities",
            G = "Hand Abilities",
            V = "Hand Toggle",
            B = "Hand Toggle"
        }
    },
    Animations = {
        Action = {
            Summon = 7125583123,
            Core = 7125643137,
            Desummon = 7125689200,
            SelfHeal = 5629226076,
            AllyHeal = 5629228404,
            Slash = 5641408651,
            Bullets = 5630120742,
            Bombs = 5630323630,
            Block = 7126320310,
            Laser = 5641461493,
            Saw = 5630087705,
            Pully = 5629647334,
            ["StandOff-LMB-1"] = 12483102391,
            ["StandOff-LMB-2"] = 12483106270,
            ["StandOff-LMB-3"] = 12483107424,
            ["StandOff-LMB-4"] = 12483108580,
            ["LMB-1"] = 12483102391,
            ["LMB-2"] = 12483106270,
            ["LMB-3"] = 12483107424,
            ["LMB-4"] = 12483108580,
            ["Combo Punch-1"] = 7126321786,
            ["Combo Punch-2"] = 7126322486,
            ["Combo Punch-3"] = 7126323109,
            ["Combo Punch-4"] = 7126323755
        },
        Movement = {
            Walk = 5627215440,
            SummonedWalk = 5627215440
        },
        Idle = {
            Idle = 7125645251,
            SummonedIdle = 7125645251
        }
    },
    Sounds = {
        Switch = {
            SoundId = "rbxassetid://5626913862",
            Volume = 1
        },
        ["Summon-SFX"] = {
            SoundId = "rbxassetid://5626915499",
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = "rbxassetid://7129359630",
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 2
        },
        SwingLMB = {
            SoundId = "rbxassetid://7128994145",
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 2
        },
        ["Combo Punch"] = {
            SoundId = "rbxassetid://7128994145",
            Volume = 1
        },
        Heal = {
            SoundId = "rbxassetid://5629245964",
            Volume = 1
        },
        Yoink = {
            SoundId = "rbxassetid://5629639442",
            Volume = 1
        },
        Saw = {
            SoundId = "rbxassetid://5626913862",
            Volume = 1,
            PlaybackSpeed = 1.25
        },
        Bullet = {
            SoundId = "rbxassetid://5629639442",
            Volume = 1,
            PlaybackSpeed = 2
        },
        Shield = {
            SoundId = "rbxassetid://747238556",
            Volume = 1,
            PlaybackSpeed = 2
        },
        ShieldBreak = {
            SoundId = "rbxassetid://516789356",
            Volume = 1,
            PlaybackSpeed = 2
        },
        Purple = {
            SoundId = "rbxassetid://340722848",
            Volume = 1
        },
        PoseMusic = {
            SoundId = "rbxassetid://9062188707",
            Volume = 1
        },
        Teleport = {
            SoundId = "rbxassetid://5626915499",
            Volume = 1,
            PlaybackSpeed = 2
        },
        AwkCHG = {
            SoundId = "rbxassetid://5679060347",
            Volume = 1
        },
        AwkFire = {
            SoundId = "rbxassetid://5679060863",
            Volume = 1
        }
    },
    Stats = {
        Summon = {
            From = "Combat.Summon",
            SummonV2 = true,
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            Indicators = CreateMultiIndicator({
                Universal = "Summon"
            }),
            Callbacks = {
                Summon = function(p5) -- Line: 67, Name: Summon
                    -- upvalues: AnimationHandler (copy)
                    local _ = p5.Player;
                    local _ = p5.Stats;
                    local _ = p5.Input;
                    local Character = p5.Character;
                    local Animator = Character.Humanoid.Animator;
                    local Stand = Character:FindFirstChild("Stand");

                    if Stand then
                        Stand:FindFirstChild("StandHumanoidRootPart");
                    end;

                    for _, descendant in pairs(Stand:GetDescendants()) do
                        if descendant.Name == "soul" and descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = true;
                        end;
                    end;

                    local v6 = AnimationHandler.Get(Animator);
                    local v7 = v6:GetAnimation("Summon");
                    v7:Play();
                    v7.Stopped:Wait();
                    v6:GetAnimation("Core"):Play();
                end,

                Desummon = function(p8) -- Line: 93, Name: Desummon
                    -- upvalues: AnimationHandler (copy)
                    local _ = p8.Player;
                    local _ = p8.Stats;
                    local _ = p8.Input;
                    local Character = p8.Character;
                    local Animator = Character.Humanoid.Animator;
                    local Stand = Character:FindFirstChild("Stand");

                    if Stand then
                        Stand:FindFirstChild("StandHumanoidRootPart");
                    end;

                    for _, descendant in pairs(Stand:GetDescendants()) do
                        if descendant.Name == "soul" and descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;

                    local v9 = AnimationHandler.Get(Animator);
                    v9:StopAnimation("Summon");
                    v9:PlayAnimation("Desummon");
                end
            }
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Summoned = false
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = {
                Endlag = 0.2,
                ActiveEndlag = 0.1,
                Speed = 1.1,
                Damage = 8,
                Meter = true,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
                Stun = {
                    Time = 0.425,
                    Priority = EnumsModule.Stun.Medium
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
                    Size = Vector3.new(6, 5.5, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = v3,
                HitSounds = {
                    Hit = {
                        SoundId = 11499913064,
                        Volume = 3
                    }
                }
            },
            ["LMB-4"] = {
                Cooldown = 0.75,
                Damage = 25,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
                Stun = {
                    Time = 0.3
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                HitRemotes = v3,
                HitSounds = {
                    Hit = {
                        SoundId = 11499913235,
                        Volume = 3
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                Endlag = 0.2,
                ActiveEndlag = 0.1,
                Speed = 1.1,
                Damage = 8,
                Meter = true,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 30, "End" } },
                Stun = {
                    Time = 0.425,
                    Priority = EnumsModule.Stun.Medium
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
                    Size = Vector3.new(6, 5.5, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = v3,
                HitSounds = {
                    Hit = {
                        SoundId = 11499913064,
                        Volume = 3
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
                Cooldown = 0.75,
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
                HitRemotes = v3,
                HitSounds = {
                    Hit = {
                        SoundId = 11499913235,
                        Volume = 3
                    }
                }
            },
            Callbacks = {
                StateChecker = function(p10, p11) -- Line: 317, Name: StateChecker
                    -- upvalues: Knit (copy), TableUtil (copy)
                    local Stats = p10.Stats;

                    if not Knit.CollectionService:HasTag(p10.Character, "Summoned") then
                        Stats = TableUtil.Copy(Stats, true);
                        Stats.CustomPrefix = "StandOff-LMB";
                    end;

                    return Stats;
                end
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Active = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Grab"
            }),
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
        ["Hand Toggle"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Indicators = CreateMultiIndicator({
                StandOn = "Hand Toggle"
            }),
            Cooldown = {
                Time = 0.25,
                AfterMove = true
            }
        },
        ["Gaster Combo"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Indicators = CreateMultiIndicator({
                StandOn = "Gaster Combo"
            }),
            Cooldown = {
                Name = "Gaster Combo",
                Time = 7.5,
                Manual = true
            },
            Active = true,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Damage = 5,
            Stun = {
                Time = 0.7,
                Priority = EnumsModule.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 15,
                Time = 0.1
            },
            HitAnimation = "Default",
            HitSounds = {
                Hit = {
                    SoundId = 7128998371,
                    Volume = 1.5
                }
            },
            HitRemotes = v3,
            ["Final Hit"] = {
                Damage = 13,
                HitAnimation = "Default",
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                Stun = {
                    Time = 0.2,
                    Priority = EnumsModule.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 55,
                    Time = 0.25
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7128999212,
                        Volume = 1.5
                    }
                },
                HitRemotes = v3
            }
        },
        ["Hand Abilities"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Indicators = CreateMultiIndicator({
                StandOn = "Hand Abilities"
            }),
            Active = true,
            SelfHeal = {
                Recovery = {
                    Recover = 25
                },
                HitSounds = {
                    Hit = {
                        SoundId = 5629245964,
                        Volume = 1.5
                    }
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GasterHeal", "__Target", "__Attacker" }
                    } },
                Cooldown = {
                    Name = "SelfHeal-HandAbilities",
                    Time = 25
                }
            },
            Slash = {
                Damage = 15,
                HitAnimation = "Default",
                Stun = {
                    Time = 0.1,
                    Priority = EnumsModule.Stun.Medium
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7125385558,
                        Volume = 1.5
                    }
                },
                HitRemotes = v4,
                Cooldown = {
                    Name = "Slash-HandAbilities",
                    Time = 10
                }
            },
            Bullets = {
                Damage = 8,
                HitAnimation = "Default",
                Stun = {
                    Time = 0.1,
                    Priority = EnumsModule.Stun.Medium
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GasterBulletHit", "__Target", "__Attacker" }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 7128998371,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Bullets-HandAbilities",
                    Time = 10
                }
            },
            Bombs = {
                Damage = 8,
                HitAnimation = "Default",
                Hitbox = {
                    Type = "Magnitude",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(7, 7, 7),
                    Debug = false,
                    Offset = CFrame.new(0, 0, 0)
                },
                Stun = {
                    Time = 0.1,
                    Priority = EnumsModule.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 25,
                    Time = 0.25
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GasterBombHit", "__Target", "__Attacker" }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 7128999212,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Bombs-HandAbilities",
                    Time = 8
                }
            },
            Saw = {
                Damage = 2.25,
                HitAnimation = "Default",
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 5,
                    Time = 0.25
                },
                Stun = {
                    Time = 0.25,
                    Priority = EnumsModule.Stun.Medium
                },
                HitRemotes = v4,
                HitSounds = {
                    Hit = {
                        SoundId = 6849041223,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Saw-HandAbilities",
                    Time = 5
                }
            },
            Pully = {
                Cooldown = {
                    Name = "Pully-HandAbilities",
                    Time = 12
                }
            },
            Laser = {
                Damage = 13.25,
                HitAnimation = "Default",
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "",
                    Debug = false,
                    Size = Vector3.new(),
                    Offset = CFrame.new()
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 15,
                    Time = 0.25
                },
                Stun = {
                    Time = 0.25,
                    Priority = EnumsModule.Stun.Medium
                },
                HitRemotes = v4,
                HitSounds = {
                    Hit = {
                        SoundId = 6849041223,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Laser-HandAbilities",
                    Time = 8
                }
            }
        },
        ["Primary Abilities"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Indicators = CreateMultiIndicator({
                StandOn = "Primary Abilities"
            }),
            Active = true,
            AllyHeal = {
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                Recovery = {
                    Recover = 25
                },
                HitSounds = {
                    Hit = {
                        SoundId = 5629245964,
                        Volume = 1.5
                    }
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GasterHeal", "__Attacker", "__Target" }
                    } },
                Cooldown = {
                    Name = "AllyHeal-PrimAbilities",
                    Time = 25
                }
            },
            Slash = {
                Damage = 15,
                HitAnimation = "Default",
                Stun = {
                    Time = 0.15,
                    Priority = EnumsModule.Stun.Medium
                },
                HitRemotes = v4,
                HitSounds = {
                    Hit = {
                        SoundId = 7128998371,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Slash-PrimaryAbilities",
                    Time = 10
                }
            },
            Bullets = {
                Damage = 3.5,
                HitAnimation = "Default",
                Stun = {
                    Time = 0.1,
                    Priority = EnumsModule.Stun.Medium
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GasterBulletHit", "__Target", "__Attacker" }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 7128998371,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Bullets-PrimaryAbilities",
                    Time = 10
                }
            },
            Bombs = {
                Damage = 35,
                HitAnimation = "Default",
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 100,
                    Time = 0.25
                },
                Stun = {
                    Time = 0.15,
                    Priority = EnumsModule.Stun.Medium
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GasterBombHit", "__Target", "__Attacker" }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 7128998371,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Bombs-PrimaryAbilities",
                    Time = 8
                }
            },
            Saw = {
                Damage = 2.25,
                HitAnimation = "Default",
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 5,
                    Time = 0.25
                },
                Stun = {
                    Time = 0.25,
                    Priority = EnumsModule.Stun.Medium
                },
                HitRemotes = v4,
                HitSounds = {
                    Hit = {
                        SoundId = 6849041223,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Saw-PrimaryAbilities",
                    Time = 6
                }
            },
            Pully = {
                Cooldown = {
                    Name = "Laser-PrimaryAbilities",
                    Time = 8
                }
            },
            Laser = {
                Damage = 15,
                HitAnimation = "Default",
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "",
                    Debug = false,
                    Size = Vector3.new(),
                    Offset = CFrame.new()
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 10,
                    Time = 0.25
                },
                Stun = {
                    Time = 0.15,
                    Priority = EnumsModule.Stun.Medium
                },
                HitRemotes = v4,
                HitSounds = {
                    Hit = {
                        SoundId = 6849041223,
                        Volume = 1.5
                    }
                },
                Cooldown = {
                    Name = "Laser-PrimaryAbilities",
                    Time = 8
                }
            }
        }
    }
};