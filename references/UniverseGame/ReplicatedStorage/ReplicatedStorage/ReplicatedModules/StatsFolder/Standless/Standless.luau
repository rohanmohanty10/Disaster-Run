  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v1 = ReplicatedStorage["Client Assets"];
local v2 = {};
local v3 = {
    Blockable = false,
    PerfectBlockable = false
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
                DefaultConsoleKeybind = "ButtonX",
                DefaultDPadDirection = 0,
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                DefaultConsoleKeybind = "ButtonR1",
                DefaultDPadDirection = 0,
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                DefaultConsoleKeybind = "ButtonL1",
                DefaultDPadDirection = 0,
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
            ["Stylish Sweeps"] = {
                DefaultKeybind = "E",
                DefaultConsoleKeybind = "ButtonB",
                DefaultDPadDirection = 0,
                Unlocked = true,
                Description = "Perform three dash attacks"
            },
            ["Drop Kick"] = {
                DefaultKeybind = "R",
                DefaultConsoleKeybind = "ButtonB+",
                DefaultDPadDirection = 0,
                Unlocked = true,
                Description = "Charge up before doing a drop kick"
            },
            ["Invitation to Hell"] = {
                DefaultKeybind = "T",
                DefaultConsoleKeybind = "ButtonY",
                DefaultDPadDirection = 0,
                Description = "Shoot two bullets",
                LevelRequirement = 45,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Dragon Bite"] = {
                DefaultKeybind = "Y",
                DefaultConsoleKeybind = "ButtonB",
                DefaultDPadDirection = 4,
                Description = "Grab the target and slam them down before finishing with a step on their chest",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Asphalt Connoisseur"] = {
                DefaultKeybind = "G",
                DefaultConsoleKeybind = "ButtonB+",
                DefaultDPadDirection = 4,
                Description = "Grab the target then knee them",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Way of the Yakuza"] = {
                DefaultKeybind = "H",
                DefaultConsoleKeybind = "ButtonY",
                DefaultDPadDirection = 2,
                LevelRequirement = 90,
                Description = "Awaken and gain some buffs",
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Brawler\'s Instinct"] = {
                DefaultKeybind = "V",
                DefaultConsoleKeybind = "ButtonB",
                DefaultDPadDirection = 2,
                Description = "Enter a counter and slam the attacker",
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
            ["LMB-1"] = 7118119983,
            ["LMB-2"] = 7118134818,
            ["LMB-3"] = 7118155115,
            ["LMB-4"] = 7118194438,
            ["Bite Attempt"] = 7118590427,
            ["Bite Success"] = 7118711342,
            ["Bite Victim"] = 7118710416,
            ["Stylish Sweeps"] = 7118819267,
            ["Way of the Yakuza"] = 7118739515,
            Dodge = 5191300871,
            ["Asphalt Attempt"] = 7113256345,
            ["Asphalt Success"] = 7113253353,
            ["Asphalt Victim"] = 7113252192,
            ["Brawler\'s Instinct Attempt"] = 7118272773,
            ["Brawler\'s Instinct Success"] = 7118415607,
            ["Brawler\'s Instinct Victim"] = 7118416385,
            ["Drop Kick"] = 7118274633,
            ["Invitation to Hell"] = 7117836119,
            ForwardDash = 10451361960,
            BackwardDash = 10451359576,
            LeftDash = 10451363828,
            RightDash = 10451365211,
            PoseTransition = 7124468256,
            PoseIdle = 7124511681,
            ["Revelation Camera"] = 89042738506043
        },
        Idle = {
            Idle = 7473308966
        }
    },
    Stats = {
        Breaker = {
            From = "Combat.Breaker"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 20, "Attack" }, { 24, "End" } },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 13582330537,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.25,
                HitRemotes = { v5 },
                HitSounds = {
                    Hit = {
                        SoundId = "rbxassetid://15518178265",
                        Volume = 1
                    }
                },
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 18, "Attack" }, { 23, "End" } }
            }, BaseStatsModule.Rush_Attack_Finisher)
        },
        ["Stylish Sweeps"] = {
            Distance = 17.5,
            Active = true,
            Damage = 11.25,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(11, 11, 11),
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.new(0, 0, -5.5)
            },
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 45,
                Time = 0.2,
                Velocity = Vector3.new(0, 10, 0)
            },
            HitRemotes = { v5 },
            HitSounds = {
                Hit = {
                    SoundId = 13582329788,
                    Volume = 1
                }
            }
        },
        ["Drop Kick"] = {
            Distance = 35,
            Duration = 0.8,
            Active = true,
            Damage = 30,
            HitAnimations = "Default",
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(11, 11, 11),
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.new(0, 0, -5.5)
            },
            Ragdoll = {
                Time = 1
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BlockBreak = true
            },
            Stun = {
                Time = 0.75,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 60,
                Time = 0.3,
                Velocity = Vector3.new(0, 25, 0)
            },
            HitRemotes = { v5 },
            HitSounds = {
                Hit = {
                    SoundId = 13582330095,
                    Volume = 1
                }
            }
        },
        ["Invitation to Hell"] = {
            Active = true,
            Damage = 35,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Meter = {
                MeterGain = 0,
                RequiredLevel = 1
            },
            Block = v3,
            Stun = {
                Time = 0.25,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 25,
                Time = 0.15
            },
            HitRemotes = { v5 }
        },
        ["Dragon Bite"] = {
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Active = true,
            CheckPVPSafe = true,
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Attempt = {
                Damage = 15,
                Block = v2,
                Stun = {
                    Time = 0.5,
                    Priority = Enums.Stun.Medium
                },
                HitRemotes = { v4 }
            },
            Success = {
                Damage = 45,
                Priority = Enums.Intangible.Move,
                Block = v2,
                Stun = {
                    Time = 0.5,
                    Priority = Enums.Stun.Medium
                },
                Ragdoll = {
                    Time = 0.9
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 35,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 25, 0)
                },
                HitRemotes = { v5 }
            }
        },
        ["Asphalt Connoisseur"] = {
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Active = true,
            CheckPVPSafe = true,
            Meter = {
                MeterGain = 0,
                RequiredAmount = 25
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Attempt = {
                Damage = 5,
                Block = v3,
                Stun = {
                    Time = 0.75,
                    Priority = Enums.Stun.Medium
                },
                HitRemotes = { v4 }
            },
            Slam = {
                Damage = 15,
                Priority = Enums.Intangible.Move,
                Block = v2,
                HitRemotes = { v5 }
            },
            Success = {
                Damage = 30,
                Priority = Enums.Intangible.Move,
                Block = v2,
                Stun = {
                    Time = 0.75,
                    Priority = Enums.Stun.Medium
                },
                Ragdoll = {
                    Time = 1
                },
                HitRemotes = { v5 }
            }
        },
        ["Way of the Yakuza"] = {
            Duration = 30,
            Active = true,
            Actionable = {
                Active = true
            },
            Meter = {
                RequiredAmount = 10
            },
            Cooldown = {
                Time = 60,
                AfterMove = true
            }
        },
        ["Brawler\'s Instinct"] = {
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Active = true,
            Success = {
                Damage = 50,
                Priority = Enums.Intangible.Move,
                Block = v2,
                Stun = {
                    Time = 0.5,
                    Priority = Enums.Stun.Medium
                },
                Ragdoll = {
                    Time = 1
                },
                HitRemotes = { v5 }
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose"
        },
        Grab = {
            From = "Combat.Grab",
            Indicators = { {
                    Group = "Universal",
                    InputText = "%s",
                    Visible = true
                } },
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
        Breaker = {
            From = "Combat.Breaker"
        }
    },
    Sounds = {
        AsphaltSuccessVoice = {
            SoundId = "rbxassetid://15518180910",
            Volume = 1
        },
        BiteAttempt = {
            SoundId = "rbxassetid://15518179803",
            Volume = 1
        },
        BiteSFX = {
            SoundId = "rbxassetid://15518179346",
            Volume = 1
        },
        BiteVoice = {
            SoundId = "rbxassetid://15518179221",
            Volume = 1
        },
        BlockSound = {
            SoundId = 648479338,
            Volume = 1
        },
        CounterActivated = {
            SoundId = "rbxassetid://13582569418",
            Volume = 1
        },
        CounterCrash = {
            SoundId = 7118786611,
            Volume = 1
        },
        CounterSFX = {
            SoundId = "rbxassetid://15518180795",
            Volume = 1
        },
        CounterVoice = {
            SoundId = "rbxassetid://15518183011",
            Volume = 1
        },
        CrashSFX = {
            SoundId = 13582330394,
            Volume = 1
        },
        Dodge = {
            SoundId = 453318796,
            Volume = 1
        },
        DropKickHit = {
            SoundId = "rbxassetid://15518179582",
            Volume = 1
        },
        DropKickSFX = {
            SoundId = "rbxassetid://15518177714",
            Volume = 1
        },
        DropKickVoice = {
            SoundId = "rbxassetid://15518543699",
            Volume = 1
        },
        EquipGunSFX = {
            SoundId = 7118178976,
            Volume = 1
        },
        EquipGunVoice = {
            SoundId = 7118177415,
            Volume = 1
        },
        GrabVoice = {
            SoundId = 7117750899,
            Volume = 1
        },
        GroundSlam = {
            SoundId = 7119101794,
            Volume = 1
        },
        Guard = {
            SoundId = 648479338,
            Volume = 1
        },
        GunshotSFX = {
            SoundId = 7118179567,
            Volume = 1
        },
        KickComboVoice = {
            SoundId = "rbxassetid://15518178939",
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://15518183661",
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://15518183451",
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://15518183336",
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://15518183223",
            Volume = 1
        },
        PoseMusic = {
            SoundId = 10393875699,
            Volume = 1
        },
        StylishSweepsSFX = {
            SoundId = "rbxassetid://15518178486",
            Volume = 1
        },
        ["SwingLMB 1-3"] = {
            SoundId = "rbxassetid://15518181170",
            Volume = 1
        },
        ["SwingLMB 4"] = {
            SoundId = "rbxassetid://15518181030",
            Volume = 1
        },
        TossVoice = {
            SoundId = "rbxassetid://15518182898",
            Volume = 1
        },
        YakuzaSFX = {
            SoundId = 7118813832,
            Volume = 1
        },
        YakuzaTaunt1 = {
            SoundId = 13582329397,
            Volume = 1
        },
        YakuzaTaunt2 = {
            SoundId = 14934717187,
            Volume = 1
        },
        YakuzaTheme1 = {
            SoundId = 15518526357,
            Volume = 1
        },
        YakuzaTheme2 = {
            SoundId = 14934717124,
            Volume = 1
        },
        YakuzaTheme3 = {
            SoundId = 15518181444,
            Volume = 1
        },
        YakuzaTheme4 = {
            SoundId = 15518182216,
            Volume = 1
        },
        YakuzaTheme5 = {
            SoundId = 18491578475,
            Volume = 1
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
                    SoundId = "rbxassetid://7117631162",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re an eyesore."
                        } }
                }, {
                    SoundId = "rbxassetid://15518545395",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hey. Stand up."
                        } }
                }, {
                    SoundId = "rbxassetid://7117632768",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re wasting my time."
                        } }
                } }
        }
    }
};