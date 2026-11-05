  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("UserInputService");
local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local v4 = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local v5 = {};
local v6 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v4.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
local v7 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v4.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
v5["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 12, 15, "Attack" }, { 16, "End" } },
        Stun = {
            Time = 0.75,
            StunDecay = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14264218162,
                Volume = 1
            }
        },
        HitRemotes = { v6 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 18, 20, "Attack" }, { 22, "End" } },
        Stun = {
            Time = 0.75,
            StunDecay = true
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 24, 26, "Attack" }, { 27, "End" } },
        Stun = {
            Time = 1,
            StunDecay = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14264218560,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 19, 21, "Attack" }, { 28, "End" } },
        HitRemotes = { v7 },
        HitSounds = {
            Hit = {
                SoundId = 14264217850,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v5.Block = {
    From = "Combat.Block"
};
v5.Quickstep = {
    From = "Combat.Quickstep"
};
v5.Pose = {
    From = "Combat.Pose"
};
v5["Brain Freeze"] = {
    Active = true,
    Damage = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(9, 9, 9),
        Offset = CFrame.new(0, 0, -4.5)
    },
    Block = {
        PerfectBlockable = true,
        Blockable = false
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/BrainFreeze/Grabbed",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    Freeze = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Block = {
            PerfectBlockable = false,
            Blockable = false
        }
    },
    Punch = {
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3
        },
        Ragdoll = {
            Time = 0.85
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false
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
            } }
    }
};
v5["Vostok Celsius"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50
    }
};
v5.Icebreaker = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    HitSounds = {
        Hit = {
            SoundId = 74401430943429,
            Volume = 1
        }
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.new(0, 0, -5)
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 1
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.1
    }
};
v5["Ice Stomp"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Regular = {
        Damage = 27,
        Hitbox = {
            Size = Vector3.new(26, 16, 35),
            Offset = CFrame.new(0, 8, -17.5)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true
        },
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 45,
            Velocity = Vector3.new(0, 16, 0),
            Time = 0.12
        }
    },
    Awakened = {
        Damage = 40,
        Hitbox = {
            Size = Vector3.new(38, 23, 61),
            Offset = CFrame.new(0, 11.5, -30)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.15
        }
    }
};
v5["Pheasant Beak"] = {
    Active = true,
    Damage = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 20
    },
    HitSounds = {
        Hit = {
            SoundId = 130405221996568,
            Volume = 1
        }
    },
    Hitbox = {
        Size = Vector3.new(24, 6.5, 24)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.75
    }
};
v5["Ice Partisans"] = {
    Spike = {
        Amount = 8,
        Length = 5,
        Interval = 0.125
    },
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 20
    },
    Hitbox = {
        Size = 50
    },
    Projectile = {
        Damage = 2.5,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(4.5, 4.5, 4.5)
        },
        HitSounds = {
            Hit = {
                SoundId = 130405221996568,
                Volume = 1
            }
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.75
        }
    }
};
v5["Freezing Thrust"] = {
    Active = true,
    Damage = 40,
    Distance = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 15
    },
    HitSounds = {
        Hit = {
            SoundId = 113181154745471,
            Volume = 1
        }
    },
    Hitbox = {
        Size = Vector3.new(14, 14, 34),
        Offset = CFrame.new(0, 0, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Velocity = Vector3.new(0, 27, 0),
        Time = 0.12
    },
    Stun = {
        Time = 1.2
    },
    Ragdoll = {
        Time = 1.2
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    }
};
v5["Ice Age"] = {
    Active = true,
    Damage = 60,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Hitbox = {
        Size = 45
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Freeze",
            Overrides = {
                Lifetime = 5
            }
        } }
};
v5.Soru = {
    From = "Rokushiki.Soru"
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
            Soru = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            ["Brain Freeze"] = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Vostok Celsius"] = {
                DefaultKeybind = "Q",
                LevelRequirement = 50
            },
            ["Ice Stomp"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Unlocked = true
            },
            Icebreaker = {
                DefaultKeybind = "R",
                Equipped = true,
                Unlocked = true
            },
            ["Pheasant Beak"] = {
                DefaultKeybind = "T",
                LevelRequirement = 30
            },
            ["Ice Partisans"] = {
                DefaultKeybind = "G",
                LevelRequirement = 20
            },
            ["Freezing Thrust"] = {
                DefaultKeybind = "Y",
                LevelRequirement = 15
            },
            ["Ice Age"] = {
                DefaultKeybind = "H",
                LevelRequirement = 85
            }
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
                    SoundId = "rbxassetid://100393654666708",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "If you\'re here, I\'m going to sleep. Wake me up when you\'re done."
                        } }
                }, {
                    SoundId = "rbxassetid://95879340378394",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Was it right or wrong to let you live? Will you show me the answer from now on?"
                        } }
                }, {
                    SoundId = "rbxassetid://115072975864393",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Haahh... Looks like I won\'t be able to relax with you around."
                        } }
                }, {
                    SoundId = "rbxassetid://74469471596546",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Oh my, isn\'t this some sort of mistake?"
                        } }
                } }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 133368846189845,
            PoseIdle = 120743190150831,
            ["LMB-1"] = 14097643973,
            ["LMB-2"] = 14097646338,
            ["LMB-3"] = 14097650394,
            ["LMB-4"] = 14097653050,
            Awaken = 108637182797159,
            ["Ice Age"] = 138731397558049,
            ["Ice Age Camera"] = 109864131474796,
            ["Brain Freeze Startup"] = 106744700569435,
            ["Brain Freeze Attacker"] = 90747293295986,
            ["Brain Freeze Victim"] = 100367237927090,
            Icebreaker = 77317834651325,
            ["Ice Partisans"] = 74863861894409,
            ["Ice Stomp"] = 138756269688872,
            ["Charged Ice Stomp"] = 111408810749078,
            Pheasant = 127713937973878,
            ["Pheasant Beak"] = 129700123033283,
            ForwardDash1 = 16731260577,
            ForwardDash2 = 16731262071,
            BackwardDash = 16731258517,
            LeftDash = 16731263558,
            RightDash = 16731264589,
            ["Freezing Thrust"] = 103249214910744
        },
        Movement = {
            AwakenedWalk = 120447501952379,
            AwakenedRun = 138112672369438,
            Walk = 83029155394712,
            Run = 108215358718853
        },
        Idle = {
            AwakenedIdle = 118868798228365,
            Idle = 80842239669540
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 80144325688509,
            Volume = 2,
            Looped = true
        },
        ["LMB-1"] = {
            SoundId = 14264217693,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14264218397,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14264217981,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14264218732,
            Volume = 1
        },
        ["Soru Start"] = {
            SoundId = 105257198777350,
            Volume = 1
        },
        ["Soru End"] = {
            SoundId = 130067222760176,
            Volume = 1
        },
        ["Brain Freeze Voiceline"] = {
            SoundId = 123796313215128,
            Volume = 1
        },
        ["Brain Freeze Startup"] = {
            SoundId = 77154661725447,
            Volume = 1
        },
        ["Brain Freeze"] = {
            SoundId = 127836066478447,
            Volume = 1
        },
        ["Freezing Thrust Voiceline"] = {
            SoundId = 110576212244933,
            Volume = 1
        },
        ["Freezing Thrust"] = {
            SoundId = 125840372961105,
            Volume = 1
        },
        ["Pheasant Beak"] = {
            SoundId = 122535555925666,
            Volume = 1
        },
        ["Pheasant Beak Voiceline"] = {
            SoundId = 109625372780092,
            Volume = 1
        },
        ["Ice Stomp"] = {
            SoundId = 137886969690642,
            Volume = 1
        },
        ["Ice Stomp Windup"] = {
            SoundId = 132667303276363,
            Volume = 1
        },
        Icebreaker = {
            SoundId = 103146799204772,
            Volume = 1
        },
        ["Ice Partisans Voiceline"] = {
            SoundId = 139010235177170,
            Volume = 1
        },
        ["Ice Partisans Summon"] = {
            SoundId = 71079747906192,
            Volume = 1
        },
        ["Ice Partisans"] = {
            SoundId = 95035804104483,
            Volume = 1
        },
        Awaken = {
            SoundId = 124941607708492,
            Volume = 1
        },
        ["Awaken End"] = {
            SoundId = 130329582115934,
            Volume = 1
        },
        ["Ice Age Voiceline"] = {
            SoundId = 109799449007643,
            Volume = 1
        },
        ["Ice Age"] = {
            SoundId = 129155095612433,
            Volume = 1
        }
    },
    Stats = v5
};