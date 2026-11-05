  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v1 = ReplicatedStorage["Client Assets"];
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 14
    -- upvalues: u2 (ref), Knit (copy)
    u2 = Knit.GetService("EffectService");
end);
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
            Particle = v1.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(142, 188, 203)
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
            Particle = v1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(142, 188, 203)
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
            ["Kick Barrage"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Barrage of kicks"
            },
            ["Heavy Punch"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Lunge forward with a punch"
            },
            ["Kick 13"] = {
                DefaultKeybind = "G",
                Unlocked = true,
                Description = "Unleash a flurry of powerful kicks"
            },
            ["Lunar Phase"] = {
                DefaultKeybind = "T",
                Unlocked = true,
                Description = "Close in on your enemies with a vicious spin attack, finishing with a forceful heel kick"
            },
            Starfall = {
                DefaultKeybind = "V",
                LevelRequirement = 25,
                Description = "Focus upon an opponent from mid-air and dive down feet first"
            },
            ["Hell On Earth"] = {
                DefaultKeybind = "Y",
                LevelRequirement = 50,
                Description = "Project the essence of your being into a single blow, directly into the ground."
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 128248707615902,
            ["LMB-2"] = 81830717211924,
            ["LMB-3"] = 129751681807764,
            ["LMB-4"] = 73931549130219,
            ["Hell On Earth Startup"] = 78111120745194,
            ["Hell On Earth Slam"] = 118708067952775,
            KickBarrageStartup = 111794309411735,
            KickBarrageLoop = 91088414887436,
            KickBarrageEnd = 88676723023722,
            Kick13 = 83100885102590,
            HeavyPunch = 109346706889942,
            LunarPhase = 78575284122158,
            ["Starfall Startup"] = 70591282924337,
            ["Starfall Loop"] = 138769807496791,
            Dodge = 5191300871,
            ForwardDash = 10451361960,
            BackwardDash = 10451359576,
            LeftDash = 10451363828,
            RightDash = 10451365211,
            PoseTransition = 98866986360780,
            PoseIdle = 88047087121326
        },
        Movement = {
            Run = 129597745373890,
            Walk = 71278698813415
        },
        Idle = {
            Idle = 76433244807147
        }
    },
    Stats = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ActiveEndlag = 0.15,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.5,
                Stun = {
                    Time = 0.75,
                    Priority = Enums.Stun.Medium
                },
                Sequence = { { 0, "Start" }, { 22, 30, "Attack" } },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 90355207271708,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Speed = 1.25,
                ActiveEndlag = 0.15,
                Sequence = { { 0, "Start" }, { 20, 25, "Attack" }, { 25, "End" } },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 90355207271708,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 1.25,
                ActiveEndlag = 0.15,
                Sequence = { { 0, "Start" }, { 20, 25, "Attack" }, { 25, "End" } },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 90355207271708,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.25,
                ActiveEndlag = 0.15,
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 119079234635342,
                        Volume = 1
                    }
                },
                Sequence = { { 0, "Start" }, { 22, 30, "Attack" }, { 25, "End" } }
            }, BaseStatsModule.Rush_Attack_Finisher)
        },
        ["Kick Barrage"] = TableUtil.Reconcile({
            From = "Combat.Barrage",
            Active = true,
            Stand = false,
            Actionable = {
                Active = true
            },
            Sequence = {
                { 0, "BarrageStart" },
                { 0, function(p5, p6, p7) -- Line: 192
                        -- upvalues: u2 (ref)
                        u2.FireAllClients("HighlightObject", p7.Character, {
                            OutlineTransparency = 0,
                            Tween = true,
                            DepthMode = Enum.HighlightDepthMode.Occluded,
                            FillColor = Color3.fromRGB(142, 188, 203),
                            OutlineColor = Color3.fromRGB(142, 188, 203),
                            Lifetime = 0.4 / p5:GetSpeed()
                        });
                    end },
                { 0, "PlaySound", "KickBarrage-Startup", {
                        Cancelable = true
                    } },
                { 0, "PlayAnim", "KickBarrageStartup" },
                { 20, "PlayAnim", "KickBarrageLoop", {
                        Cancelable = true
                    } },
                { 20, "PlaySound", "KickBarrage-Loop", {
                        Cancelable = true
                    } },
                { 23, "Cancelable", true },
                { 24, "Clashable", true },
                { 24, "Barrage", true },
                { 24, 144, function(p8, p9, p10) -- Line: 210
                        -- upvalues: u2 (ref)
                        if p9 == 24 or p9 % 10 == 0 then
                            u2.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Kick",
                                AutoSerialize = true,
                                Origin = p10.Character:FindFirstChild("Left Leg"),
                                Player = p10.Player,
                                AbilityName = p10.Ability,
                                SkinName = p10.SkinName
                            });
                        end;
                    end },
                { 24, 144, "BarrageAttack", "Hit" },
                { 144, "StopAnim", "KickBarrageLoop" },
                { 144, "PlayAnim", "KickBarrageEnd" },
                { 144, "Cancelable", false },
                { 144, "Barrage", false },
                { 144, "Clashable", false },
                { 144, "StopSound", "KickBarrage-Loop" },
                { 164, "End" }
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hit = {
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 106184529327640,
                        Volume = 1
                    }
                }
            }
        }, BaseStatsModule.Stand_Barrage),
        ["Heavy Punch"] = {
            Active = true,
            Damage = 25,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 13,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 25),
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.new(0, 0, -12.5)
            },
            Block = {
                PerfectBlockable = true,
                BlockBreak = true
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v4 },
            HitSounds = {
                Hit = {
                    SoundId = 74687615536749,
                    Volume = 1
                }
            }
        },
        ["Kick 13"] = {
            Active = true,
            Damage = 5,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Predict = true,
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 106184529327640,
                    Volume = 1
                }
            },
            FinalHit = {
                Damage = 5,
                Block = {
                    Blockable = true,
                    PerfectBlockable = false
                },
                Stun = {
                    Time = 1,
                    Priority = Enums.Stun.Medium
                },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 119783001541040,
                        Volume = 1
                    }
                }
            }
        },
        ["Lunar Phase"] = {
            Active = true,
            Damage = 5,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Predict = true,
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Meter = {
                RequiredAmount = 15
            },
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 106184529327640,
                    Volume = 1
                }
            },
            FinalHit = {
                Damage = 25,
                Block = {
                    PerfectBlockable = false,
                    BlockBreak = true
                },
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = 12,
                    Predict = true,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Stun = {
                    Time = 1,
                    Priority = Enums.Stun.Medium
                },
                Ragdoll = {
                    Time = 1
                },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 106184529327640,
                        Volume = 1
                    }
                }
            }
        },
        ["Hell On Earth"] = {
            Active = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 30,
                AfterMove = true
            },
            Hitbox = {
                Size = 26.25
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 50
            },
            Slam = {
                Damage = 25,
                Stun = {
                    Time = 1.5
                },
                Block = {
                    Unblockable = true,
                    BypassCounter = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 15,
                    Velocity = Vector3.new(0, 10, 0),
                    Time = 0.2
                }
            },
            Explosion = {
                Damage = 40,
                Meter = false,
                Ragdoll = 3,
                Block = {
                    Unblockable = true,
                    BypassCounter = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 25,
                    Velocity = Vector3.new(0, 25, 0),
                    Time = 0.2
                }
            }
        },
        Starfall = {
            Active = true,
            Damage = 20,
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                Size = 15
            },
            ScanHitbox = {
                HitboxType = "ClientHitbox",
                RelativePart = "HumanoidRootPart",
                Size = 25,
                Offset = CFrame.identity
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 15,
                Velocity = Vector3.new(0, 10, 0),
                Time = 0.2
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
        }
    },
    Sounds = {
        ["Kick 13"] = {
            SoundId = 76961418762765,
            Volume = 1
        },
        HeavyPunch = {
            SoundId = 137781623777250,
            Volume = 1
        },
        ["KickBarrage-Startup"] = {
            SoundId = 82925231535780,
            Volume = 1
        },
        ["KickBarrage-Loop"] = {
            SoundId = 75313932858291,
            Volume = 1,
            Looped = true
        },
        BlockSound = {
            SoundId = 648479338,
            Volume = 1
        },
        LunarPhase = {
            SoundId = 74424341534826,
            Volume = 1
        },
        LunarPhaseSlam = {
            SoundId = 87506572382550,
            Volume = 1
        },
        Dodge = {
            SoundId = 453318796,
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
        ["LMB-1"] = {
            SoundId = 140466651430204,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 90986228533075,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 104058776614479,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 84099797933370,
            Volume = 1
        },
        beowulf_starfall_ground_impact_sfx = {
            SoundId = 102438772736998,
            Volume = 2
        },
        beowulf_starfall_voiceline = {
            SoundId = 108116071375502,
            Volume = 2
        },
        beowulf_starfall_startup_sfx = {
            SoundId = 113589910244792,
            Volume = 2
        },
        beowulf_hellonearth_voice = {
            SoundId = 139958635022277,
            Volume = 2
        },
        beowulf_hellonearth_startup_sfx = {
            SoundId = 108209884701537,
            Volume = 2
        },
        beowulf_hellonearth_ground_impact_sfx = {
            SoundId = 76612291293985,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 126624728797068,
            Volume = 1,
            Looped = true
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
                    SoundId = "rbxassetid://126674295145832",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Die..."
                        } }
                }, {
                    SoundId = "rbxassetid://138422893549040",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "How boring."
                        } }
                }, {
                    SoundId = "rbxassetid://116084415036098",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Now I\'m a litte motivated!"
                        } }
                }, {
                    SoundId = "rbxassetid://120769614219204",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What\'s wrong?"
                        } }
                }, {
                    SoundId = "rbxassetid://81298869594593",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You will not forget this devil\'s power."
                        } }
                } }
        }
    }
};