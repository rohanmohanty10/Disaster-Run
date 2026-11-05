  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local v1 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v2 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v3 = {
    SoundId = 13703109883,
    Volume = 1.5
};
local v4 = {
    SoundId = 13703109636,
    Volume = 1.5
};
local v12 = {
    Block = {
        From = "Combat.Block"
    },
    Quickstep = {
        From = "Combat.Quickstep"
    },
    Pose = {
        From = "Combat.Pose"
    },
    Summon = {
        From = "Combat.Summon",
        SummonV2 = true,
        CustomAura = {
            AuraName = "Nocturnus"
        },
        LeaveParts = { "StandHumanoidRootPart", "Trails" },

        OnSummon = function(p5, p6) -- Line: 89, Name: OnSummon
            -- upvalues: ParticleHandler (copy)
            local Character = p5.Character;
            local _ = Character.Humanoid;
            local _ = p5.Animator;
            local v7 = Character:FindFirstChild("Right Claw");
            local v8 = Character:FindFirstChild("Left Claw");
            local v9 = p6 and 1 or 0;
            v7.Transparency = v9;
            v8.Transparency = v9;
            ParticleHandler.EnableParticle(v8, not p6);
            ParticleHandler.EnableParticle(v7, not p6);
        end
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
        Indicators = { {
                Group = "Universal",
                Visible = true
            } },
        AnimationTimed = false,
        MaxCombo = 4,
        ComboTick = 1.5,
        ["LMB-1"] = TableUtil.Reconcile({
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
            HitRemotes = { v1 },
            HitSounds = {
                Hit = v3
            }
        }, BaseStatsModule.Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = v4
            }
        }, BaseStatsModule.Stand_Rush_Attack_Finisher),
        Callbacks = {
            StateChecker = function(p10, p11) -- Line: 182, Name: StateChecker
                -- upvalues: Knit (copy), TableUtil (copy)
                local Stats = p10.Stats;

                if not Knit.CollectionService:HasTag(p10.Character, "Summoned") then
                    Stats = TableUtil.Copy(Stats, true);
                    Stats.CustomPrefix = "StandOff-LMB";
                end;

                return Stats;
            end
        }
    }
};
v12["Rush Attack"] = TableUtil.Reconcile(v12["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v12["Stand Barrage"] = TableUtil.Reconcile({
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        HitRemotes = { v1 },
        HitSounds = {
            Hit = v3
        }
    },
    Finisher = {
        HitRemotes = { v2 },
        HitSounds = {
            Hit = v4
        }
    }
}, BaseStatsModule.Stand_Barrage);
v12["Claw Barrage"] = {
    Active = true,
    Damage = 1.25,
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
        Size = 10,
        Offset = CFrame.new(0, -1.5, -5)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.7,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.1
    },
    Finisher = {
        Damage = 9,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11, 9, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.35,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        }
    }
};
v12["Leash Slash"] = {
    Active = true,
    Cooldown = 10,
    Actionable = {
        Summoned = true,
        Active = true
    },
    First = {
        Damage = 5,
        HitAnimations = "Default",
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Medium
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1 },
        HitSounds = {
            Hit = v3
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "DawnBurn"
            } }
    },
    Second = {
        Damage = 2.5,
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 0.75
        },
        HitRemotes = { v1 },
        HitSounds = {
            Hit = v3
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "DawnBurn"
            } }
    }
};
v12["Crimson Lunge"] = {
    Damage = 25,
    Cooldown = 5,
    Active = true,
    HitAnimations = "Default",
    Actionable = {
        Summoned = true,
        Active = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Stun = {
        Time = 1.15,
        Priority = EnumsModule.Stun.Medium
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "DawnBurn"
        } },
    Hitbox = {
        Size = Vector3.new(15, 15, 30),
        Offset = CFrame.new(0, 0, -15)
    },
    HitRemotes = { v1 },
    Exhaustion = {
        RequiredExhaustion = 0.8,
        ExhaustAmount = 0.2,
        Manual = true
    },
    HitSounds = {
        Hit = v3
    }
};
v12["Gnash Slash"] = {
    Active = true,
    Damage = 25,
    Cooldown = 8,
    HitAnimations = "Default",
    Actionable = {
        Summoned = true,
        Active = true
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v1 },
    HitSounds = {
        Hit = v3
    },
    Throw = {
        Damage = 25,
        Block = {
            Unblockable = true
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "DawnBurn"
            } },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        }
    }
};
v12.Impale = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        Manual = true
    },
    Startup = {
        Damage = 40,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
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
        Priority = EnumsModule.Intangible.Move + 1,
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
v12["Sudden Strike"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    EndFrame = 40,
    AttackFrame = 26,
    Iteration = 5,
    AppearFrame = 10,
    DisappearFrame = 31,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Stun = {
        Time = 1.5,
        Priority = EnumsModule.Stun.Medium
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "StandHumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Debug = false,
        Offset = CFrame.new(0, 0, -6)
    },
    Knockback = {
        RelativePart = "Target",
        Speed = 40,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    HitRemotes = { v2 },
    HitSounds = {
        Hit = v4
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
v12["Claw Blitz"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Stun = {
        Time = 1.5,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Predict = false,
        Offset = CFrame.new(0, 0, -3.5)
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 40,
        Time = 0.1
    },
    HitRemotes = { v1 },
    HitSounds = {
        Hit = v1
    },
    Block = {
        PerfectBlockable = false
    }
};
v12["Feral Scratch"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Stun = {
        Time = 1.5,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Predict = false,
        Offset = CFrame.new(0, 0, -3.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.1
    },
    HitRemotes = { v2 },
    HitSounds = {
        Hit = v4
    },
    Block = {
        PerfectBlockable = false
    }
};
v12["Ground Breaker"] = {
    Active = true,
    Damage = 45,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 35,
        Time = 0.15,
        Velocity = Vector3.new(0, 45, 0)
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 1.8,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.new(0, 0, -4)
    }
};
v12["Crash Slash"] = {
    Active = true,
    Damage = 15,
    Stun = 1.5,
    Cooldown = 15,
    HitAnimations = "Default",
    Actionable = {
        Summoned = true,
        Active = true
    },
    Block = {
        Unblockable = true
    },
    Meter = {
        RequiredLevel = 2
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v1 },
    HitSounds = { v3 },
    Slam = {
        Damage = 15,
        Block = {
            Unblockable = true
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "DawnBurn"
            } }
    }
};
v12["Scarlet Descent"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Startup = {
        Damage = 30,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v2 },
        Block = {
            BlockBreak = true
        }
    },
    Punch = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v1 }
    },
    Slam = {
        Damage = 25,
        Priority = EnumsModule.Intangible.Move
    },
    Impact = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 4
        }
    }
};
v12["Deadly Instinct"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RemoveMeter = true,
        RequiredLevel = 1
    },
    Success = {
        Damage = 40,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 2,
            Priority = EnumsModule.Stun.Heavy
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Shadow_Hit", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Hit",
                        LookAt = "Attacker"
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 134923352135073,
                Volume = 2
            }
        }
    },
    Cooldown = 11
};
v12.Teleport = {
    From = "Combat.Teleport"
};

return {
    Animations = {
        Action = {
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            LeashSlash = 6968510181,
            FlashSlash = 6968512967,
            Stab = 6968516930,
            Grab = 6968514367,
            SwipeUp = 6999600490,
            SwipeDown = 6999582253,
            PoseIdle = 8051172224,
            PoseTransition = 8051125789,
            ["Ground Slam"] = 126286186087100,
            ["StandOn-Deadly Instinct"] = 90379805738097,
            ["StandOff-Deadly Instinct"] = 105371779579091,
            ["Feral Scratch"] = 137418438109014,
            ["Impale Startup"] = 10898048721,
            ["Crimson Lunge"] = 85688848663289,
            Impale = 10898039552,
            ["Impale Target"] = 10898041509,
            ["Claw Barrage"] = 17357644843,
            ["Sudden Strike"] = 119220411960134,
            ["Quick Jabs"] = 115216556848388,
            ["Scarlet Descent"] = 94554371329322,
            ["Scarlet Descent Startup"] = 88414749942946,
            ["Scarlet Descent Target"] = 119660251747668,
            ["Scarlet Descent Camera"] = 106554992699253
        },
        Movement = {
            SummonedWalk = 11753671123,
            SummonedRun = 11753670017,
            Walk = 123995022432977,
            Run = 82227970935291
        },
        Idle = {
            SummonedIdle = 11753669050,
            Idle = 87002947158766
        }
    },
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
            ["Stand Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                MoveCapCount = false
            },
            ["Claw Barrage"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                State = "StandOff",
                Description = "Perform a series of omnidirectional slashes."
            },
            ["Claw Blitz"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Dash forward 3 times, striking a target each time.",
                LevelRequirement = 40
            },
            ["Leash Slash"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "The stand unleashes a couple of slashes using their nails."
            },
            ["Feral Scratch"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Description = "Dash forward & slice with your nails.",
                Unlocked = true
            },
            Impale = {
                DefaultKeybind = "Y",
                State = "StandOn",
                LevelRequirement = 55,
                Description = "The stand pierces a victim before throwing them away."
            },
            ["Crimson Lunge"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Dash forward, slashing anyone in your way.",
                LevelRequirement = 30
            },
            ["Sudden Strike"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                LevelRequirement = 45,
                Description = "The stand teleports behind a target & strikes them."
            },
            ["Ground Breaker"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                LevelRequirement = 50,
                Description = "Kick towards the ground, cracking it up."
            },
            ["Scarlet Descent"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                LevelRequirement = 60,
                Description = "The stand sends a victim up before teleporting and slamming them down again."
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleport in the direction you\'re facing.",
                LevelRequirement = 10
            },
            ["Deadly Instinct"] = {
                DefaultKeybind = "H",
                Description = "Enter a counter-attack state. If you\'re hit, multiple knives spawn behind the target & stab them while you teleport behind the target.",
                LevelRequirement = 60
            }
        }
    },
    Stats = v12,
    Sounds = {
        GroundSlam = {
            SoundId = 10627624630,
            Volume = 2
        },
        ["Sudden Strike SFX"] = {
            SoundId = 11460843027,
            Volume = 3
        },
        PoseMusic = {
            SoundId = "rbxassetid://9992385656",
            Volume = 1.2000000476837158,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
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
        GrabbedVoiceline = {
            SoundId = 11745739169,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 11746104656,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 11746105056,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 11746104748,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 11746104567,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 11746104656,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 11746105056,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 11746104748,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 11746104567,
            Volume = 1
        },
        ["SwingLMB 1-3"] = {
            SoundId = 13703109514,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 13703109781,
            Volume = 2
        },
        ["Summon-SFX"] = {
            SoundId = 13704500865,
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 13704500981,
            Volume = 2
        },
        Barrage = {
            SoundId = 13704588352,
            Volume = 2
        },
        SwingLMB = {
            SoundId = "rbxassetid://6706981173",
            Volume = 1,
            PlaybackSpeed = 0.800000011920929,
            Looped = false,
            TimePosition = 0
        },
        ["Counter Startup"] = {
            SoundId = "rbxassetid://17073997598",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Leash Slash SFX"] = {
            SoundId = "rbxassetid://6978195885",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GrabSFX = {
            SoundId = "rbxassetid://6978461916",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Gnash Slash SFX"] = {
            SoundId = "rbxassetid://7125385558",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Teleport = {
            SoundId = "rbxassetid://6934988582",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Crash Slash Hit"] = {
            SoundId = "rbxassetid://6999891817",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Crash Slash SFX"] = {
            SoundId = "rbxassetid://6796766306",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Flash Slash SFX"] = {
            SoundId = "rbxassetid://6995623570",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        }
    },
    Metadata = {
        Hooks = {
            NocturnusExhaustion = {
                CombatHook = "Attack",
                HookType = "Event",
                HookName = "NocturnusExhaustion",
                Priority = 99,

                HookFunction = function(p13) -- Line: 1215, Name: HookFunction
                    local _ = p13.Stats;

                    if typeof(p13.Attacker) ~= "Instance" then
                        return true;
                    end;

                    local Data = (p13.AttackerPlayer or p13.Attacker):FindFirstChild("Data");

                    return Data == nil and true or (Data.Ability.Value == 502 and true or true);
                end
            },
            NocturnusExhaustionCheck = {
                CombatHook = "Requirement",
                HookType = "Requirement",
                HookName = "NocturnusExhaustion",
                Priority = 105,

                HookFunction = function(p14) -- Line: 1234, Name: HookFunction
                    local MoveData = p14.MoveData;
                    local Stats = MoveData.Stats;
                    local Character = MoveData.Character;

                    if MoveData.AbilityId ~= 502 then
                        return true;
                    end;

                    print("EXHAUSTION GO!!!!");

                    if type(Stats.Exhaustion) ~= "table" then
                        return true;
                    end;

                    local v15 = Character:GetAttribute("NocturnusExhaustion");

                    if Stats.Exhaustion.RequiredExhaustion <= v15 then
                        p14.State.Success = false;

                        return true;
                    end;

                    if Stats.Exhaustion.ExhaustAmount ~= nil and Stats.Exhaustion.Manual ~= true then
                        local RequirementsMet = p14.RequirementsMet;
                        local v16 = {
                            Callback = Character.SetAttribute,
                            CallbackParameters = { Character, "NocturnusExhaustion", (math.clamp(v15 + Stats.Exhaustion.ExhaustAmount, 0, 1)) }
                        };
                        table.insert(RequirementsMet, v16);
                    end;

                    return true;
                end
            }
        },

        CustomAddon = function(p17) -- Line: 1261, Name: CustomAddon
            p17.Character:SetAttribute("NocturnusExhaustion", 0);
        end
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://7006197752",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I can\'t wait to destroy you."
                        } }
                }, {
                    SoundId = "rbxassetid://7006198277",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Did you really think you stood a chance? You fool!"
                        } }
                }, {
                    SoundId = "rbxassetid://7006198967",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You utter fool!"
                        } }
                }, {
                    SoundId = "rbxassetid://7006198708",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Cretin. Stop wasting my time!"
                        } }
                } }
        }
    }
};