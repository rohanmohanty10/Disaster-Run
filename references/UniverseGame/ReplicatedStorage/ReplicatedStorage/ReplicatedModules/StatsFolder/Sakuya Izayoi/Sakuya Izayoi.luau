  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v2 = {
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
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
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
            Particle = u1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(255, 255, 255)
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
                Equipped = false,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Knife Throw"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Throws a knife straight forward."
            },
            ["Wound Sign"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Repeatedly slash an area in front of you finishing by jumping back"
            },
            ["Triple Shot"] = {
                DefaultKeybind = "T",
                LevelRequirement = 25,
                Description = "Jump up and launch multiple knives at nearby targets",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "X",
                LevelRequirement = 90,
                Description = "Stop time for a short duration.",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Knives Burst"] = {
                DefaultKeybind = "G",
                LevelRequirement = 50,
                Description = "Launches multiple knives at once",
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Killing Doll"] = {
                DefaultKeybind = "V",
                LevelRequirement = 70,
                Description = "Choose a target and launch a volley of knives",
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
            PoseTransition = 7834580007,
            PoseIdle = 7834581175,
            ["LMB-1"] = 8634036082,
            ["LMB-2"] = 8634037567,
            ["LMB-3"] = 8634039244,
            ["LMB-4"] = 8634037567,
            ["KnifeThrow-1"] = 7082606732,
            ["KnifeThrow-2"] = 7082580396,
            ["KnifeThrow-3"] = 7082606732,
            ["KnifeThrow-4"] = 7082607070,
            ["Wound Sign"] = 7162168607,
            ["Triple Shot"] = 7188904935,
            ["Knife Burst"] = 7254094754,
            ["Killing Doll"] = 7290282967,
            Timestop = 7083141713
        },
        Idle = {
            Idle = 7082645315
        }
    },
    Stats = {
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            MaxCombo = 4,
            ComboTick = 1.5,
            Damage = 10,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1,
                Sequence = { { 0, "Start" }, { 10, 15, "Attack" }, { 20, "End" } },
                Stun = {
                    Time = 0.75,
                    Priority = EnumsModule.Stun.Medium
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7284996633,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            }, BaseStatsModule.Stand_Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Stun = {
                    Time = 0.3
                },
                HitRemotes = { v3 }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher)
        },
        ["Knife Throw"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            MaxCombo = 4,
            ComboTick = 2,
            Damage = 5,
            Meter = {
                MeterGain = 0
            },
            ["KnifeThrow-1"] = {
                Distance = 5,
                Sequence = {
                    { 0, "Start" },
                    { 0, "PlaySound", "throw" },
                    { 0, "CreateTag", "NoRun" },
                    { 0, "Callback", function(p4, p5, p6) -- Line: 124
                            -- upvalues: TableUtil (copy), u1 (copy)
                            local _ = p5.Player;
                            local AttackStats = p6.AttackStats;
                            local _ = p5.Input;
                            local Character = p5.Character;
                            local HumanoidRootPart = Character.HumanoidRootPart;
                            local v7 = p6.Knit.GetService("ProjectileService");
                            local v8 = TableUtil.Copy(p6.ProjectileTemplate, true);
                            local random = math.random;
                            local v9 = CFrame.new(0, 0, -2) * CFrame.new(random(-10, 10) / 10, random(-10, 10) / 10, random(-10, 10) / 10);
                            v7.Fire(v8, (HumanoidRootPart.CFrame * v9).Position, HumanoidRootPart.CFrame.LookVector, nil, Character, AttackStats, {
                                DisplayProjectile = u1.Projectiles.SKnife
                            });
                        end },
                    { 20, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 6773836020,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            },
            ["KnifeThrow-4"] = {
                Cooldown = 3
            },
            Callbacks = {
                StateChecker = function(p10, p11) -- Line: 159, Name: StateChecker
                    -- upvalues: TableUtil (copy)
                    local v12 = TableUtil.Copy(p10.Stats);
                    v12.CustomPrefix = "KnifeThrow";

                    return v12;
                end
            }
        },
        ["Wound Sign"] = {
            Active = true,
            Cooldown = 40,
            Damage = 0.8,
            Stun = 0.4,
            Actionable = {
                Active = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            HitSounds = { {
                    Hit = {
                        SoundId = 7284996633,
                        Volume = 1
                    }
                } }
        },
        ["Triple Shot"] = {
            Active = true,
            Cooldown = 15,
            Damage = 5,
            Stun = 0.5,
            Distance = 5,
            DistanceHitbox = true,
            Actionable = {
                Active = true
            },
            Meter = {
                MeterGain = 0,
                RequiredLevel = 1
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(50, 50, 50),
                Debug = false,
                Offset = CFrame.identity
            },
            HitSounds = {
                Hit = {
                    SoundId = 6773836020,
                    Volume = 1
                }
            },
            HitRemotes = { v2 }
        },
        ["Knives Burst"] = {
            Active = true,
            Damage = 5,
            Distance = 5,
            Cooldown = 15,
            DistanceHitbox = true,
            Actionable = {
                Active = true
            },
            Meter = {
                RequiredLevel = 2
            },
            HitSounds = {
                Hit = {
                    SoundId = 6773836020,
                    Volume = 1
                }
            },
            HitRemotes = { v2 }
        },
        ["Killing Doll"] = {
            Active = true,
            Damage = 2,
            Distance = 5,
            DistanceHitbox = true,
            Cooldown = 20,
            Actionable = {
                Active = true
            },
            Meter = {
                MeterGain = 0,
                RequiredLevel = 3
            },
            HitSounds = {
                Hit = {
                    SoundId = 7284996633,
                    Volume = 1
                }
            },
            HitRemotes = { v2 }
        },
        Timestop = {
            Active = true,
            Cooldown = 50,
            Actionable = {
                Active = true,
                CanTimestop = true
            },
            Meter = {
                RequiredLevel = 2
            }
        }
    },
    Sounds = {
        stop = {
            SoundId = "rbxassetid://7082964862",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        tick = {
            SoundId = "rbxassetid://7082964778",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        resume = {
            SoundId = "rbxassetid://7082964810",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        throw = {
            SoundId = "rbxassetid://7230828211",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SwingLMB = {
            SoundId = "rbxassetid://7230828748",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB1 = {
            SoundId = "rbxassetid://7230828748",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB2 = {
            SoundId = "rbxassetid://7230828748",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB3 = {
            SoundId = "rbxassetid://7230828748",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB4 = {
            SoundId = "rbxassetid://7230828748",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Flurry = {
            SoundId = "rbxassetid://7175507548",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Triple = {
            SoundId = "rbxassetid://7190395416",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        qchg = {
            SoundId = "rbxassetid://7152152662",
            Volume = 1,
            PlaybackSpeed = 1.5,
            Looped = false,
            TimePosition = 0
        },
        gs = {
            SoundId = "rbxassetid://6853300303",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Knives = {
            SoundId = "rbxassetid://7254048737",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        shetalksOwO = {
            SoundId = "rbxassetid://7255612497",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Htmo = {
            SoundId = "rbxassetid://7254052550",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Knivespain = {
            SoundId = "rbxassetid://7272264914",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DollWindup = {
            SoundId = "rbxassetid://7272947294",
            Volume = 0.699999988079071,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KnifeSpawned = {
            SoundId = "rbxassetid://7272946727",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://14995984243",
            Volume = 2,
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
                    SoundId = "rbxassetid://7254054728",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t think you can escape my knife."
                        } }
                }, {
                    SoundId = "rbxassetid://7254056141",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Your time is also mine."
                        } }
                }, {
                    SoundId = "rbxassetid://7254057485",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Let\'s not play any more games."
                        } }
                } }
        }
    }
};