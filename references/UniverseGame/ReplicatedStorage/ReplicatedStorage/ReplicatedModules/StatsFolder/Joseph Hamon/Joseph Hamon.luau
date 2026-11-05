  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
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

return {
    Stats = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 13, 15, "Attack" }, { 19, "End" } },
                Stun = {
                    Time = 0.75
                },
                HitSounds = {
                    Hit = {
                        SoundId = 13608926453,
                        Volume = 1
                    }
                },
                HitRemotes = { v1 }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 19, 21, "Attack" }, { 24, "End" } },
                Stun = {
                    Time = 0.75
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 8, 10, "Attack" }, { 17, "End" } },
                Stun = {
                    Time = 1
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 17, 19, "Attack" }, { 25, "End" } },
                HitSounds = {
                    Hit = {
                        SoundId = 13608927057,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            }, BaseStatsModule.Rush_Attack_Finisher)
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(p3, p4) -- Line: 133, Name: PoseTransition
                    -- upvalues: EnableBirthmark (copy)
                    EnableBirthmark(p3.Character, true);
                end,

                PoseEnd = function(p5, p6) -- Line: 136, Name: PoseEnd
                    -- upvalues: EnableBirthmark (copy)
                    EnableBirthmark(p5.Character, false);
                end
            }
        },
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Active = true
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
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        ["Ripple Charge"] = {
            Active = true,
            MaxHamon = 4,
            ChargeRate = 0.2,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 1.5,
                AfterMove = true
            }
        },
        ["Brash Hand"] = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Active = true,
            Cooldown = {
                Time = 8.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Damage = 8,
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Stun = {
                Time = 1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitSounds = {
                Hit = {
                    SoundId = 13608885512,
                    Volume = 1
                }
            },
            HitAnimations = "Default",
            HitRemotes = { v1 },
            Finisher = {
                Damage = 18,
                HitAnimations = "Default",
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 45,
                    Time = 0.25
                },
                Stun = {
                    Time = 0.75
                },
                Ragdoll = {
                    Time = 1.5
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = true,
                    BlockBreak = true
                },
                HitSounds = {
                    Hit = {
                        SoundId = 13608886050,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            }
        },
        Uppercut = {
            Active = true,
            Damage = 25,
            HitAnimations = "Default",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 30,
                Time = 0.15,
                Velocity = Vector3.new(0, 25, 0)
            },
            Properties = {
                Armor = true
            },
            Ragdoll = {
                Time = 1
            },
            Stun = {
                Time = 0.4
            },
            Block = {
                PerfectBlockable = true,
                Blockable = true,
                BlockBreak = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 13541794197,
                    Volume = 1
                }
            },
            HitRemotes = { v2 }
        },
        ["Clacker Attack"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Damage = 0.85,
            Knockback = {
                RelativePart = "Attacker",
                Speed = 2,
                Time = 0.1
            },
            Stun = {
                Time = 0.75
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitSounds = {
                Hit = {
                    SoundId = 13561146198,
                    Volume = 1
                }
            },
            HitAnimations = "Default",
            HitRemotes = { v1 },
            Finisher = {
                Damage = 12,
                HitAnimations = "Default",
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 65,
                    Time = 0.25
                },
                Ragdoll = {
                    Time = 0.5
                },
                Stun = {
                    Time = 0.5
                },
                Block = {
                    PerfectBlockable = true,
                    Blockable = true,
                    BlockBreak = true
                },
                HitSounds = {
                    Hit = {
                        SoundId = 13561146198,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            }
        },
        ["Clacker Overdrive"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 18.5,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Properties = {
                Armor = true
            },
            Damage = 20,
            Knockback = {
                RelativePart = "Attacker",
                Speed = 2,
                Time = 0.1
            },
            Stun = {
                Time = 0.85
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 13641280620,
                    Volume = 1
                }
            },
            HitAnimations = "Default",
            HitRemotes = { v2 },
            ["Second Hit"] = {
                Damage = 16,
                HitAnimations = "Default",
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 45,
                    Time = 0.25
                },
                Ragdoll = {
                    Time = 0.85
                },
                Stun = {
                    Time = 0.75
                },
                Block = {
                    PerfectBlockable = false,
                    Blockable = true,
                    BlockBreak = true
                },
                HitSounds = {
                    Hit = {
                        SoundId = 13641280620,
                        Volume = 1
                    }
                },
                HitRemotes = { v2 }
            }
        },
        ["Hamon Overdrive"] = {
            Active = true,
            Damage = 30,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Properties = {
                Armor = true
            },
            Cooldown = {
                Time = 17.5,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 60,
                Time = 0.25
            },
            Ragdoll = {
                Time = 1.5
            },
            Stun = {
                Time = 0.75
            },
            Block = {
                PerfectBlockable = true,
                Blockable = true,
                BlockBreak = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 13611667509,
                    Volume = 1
                }
            },
            HitRemotes = { v2 }
        },
        ["Rebuff Overdrive"] = {
            Active = true,
            Damage = 50,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 25,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 35
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 10
            },
            Properties = {
                Armor = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 70,
                Time = 0.25,
                Velocity = Vector3.new(0, 30, 0)
            },
            Ragdoll = {
                Time = 1.5
            },
            Stun = {
                Time = 1.5
            },
            Block = {
                PerfectBlockable = false,
                Blockable = false,
                BlockBreak = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 13611663461,
                    Volume = 1
                }
            },
            HitRemotes = { v2 }
        },
        ["Sparkling Cola"] = {
            Actionable = {
                Active = true,
                Disabled = true,
                Stunned = true
            },
            Active = true,
            Cooldown = {
                Time = 27.5,
                AfterMove = true
            },
            Damage = 15,
            Ragdoll = {
                Time = 2
            },
            Stun = {
                Time = 1.5
            },
            Block = {
                PerfectBlockable = false,
                Blockable = false,
                BlockBreak = true
            },
            HitSounds = {
                Hit = {}
            },
            HitAnimations = "Default",
            HitRemotes = { v2 },
            Cola_Heal = {
                Heal = 15
            }
        },
        ["Stock Launcher"] = {
            Active = true,
            Damage = 14,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 14,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1,
                Velocity = Vector3.new(0, 35, 0)
            },
            Stun = {
                Time = 0.8
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitSounds = {
                Hit = {
                    SoundId = 13560940007,
                    Volume = 1
                }
            },
            HitRemotes = { v2 }
        },
        ["Pepper Spray"] = {
            Active = true,
            Damage = 1.5,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 18,
                AfterMove = true
            },
            Stun = {
                Time = 0.5
            },
            Block = {
                PerfectBlockable = false,
                Blockable = false,
                BlockBreak = false
            },
            HitSounds = {
                Hit = {
                    SoundId = 13560728336,
                    Volume = 1
                }
            },
            HitRemotes = { v1 }
        },
        ["Slide Tackle"] = {
            Active = true,
            Damage = 12.5,
            HitAnimations = "Default",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 35,
                Time = 0.15
            },
            Stun = {
                Time = 1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = false
            },
            HitSounds = {
                Hit = {
                    SoundId = 13558549474,
                    Volume = 1
                }
            },
            HitRemotes = { v1 }
        },
        ["Secret Technique"] = {
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Cooldown = {
                Time = 35,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 50
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 13522617275,
            ["LMB-2"] = 13522619802,
            ["LMB-3"] = 13522622227,
            ["LMB-4"] = 13522624555,
            ["Hamon Charge Startup"] = 13458191053,
            ["Hamon Charge Loop"] = 13458141882,
            ["Brash Hand 1"] = 13541731749,
            ["Brash Hand 2"] = 13541735277,
            ["Brash Hand 3"] = 13541740143,
            Uppercut = 13533557773,
            ["Clacker Attack"] = 13534507273,
            ["Clacker Overdrive"] = 13631982406,
            ["Hamon Overdrive"] = 13534532839,
            ["Rebuff Overdrive"] = 13534533397,
            ["Sparkling Cola Startup"] = 13672170974,
            ["Sparkling Cola Loop"] = 13672173741,
            ["Sparkling Cola Finish"] = 13672193638,
            ["Stock Launcher"] = 13534535229,
            ["Pepper Spray"] = 13534534118,
            ["Slide Tackle"] = 13534534714,
            ["Secret Technique"] = 13619691824,
            PoseIdle = 13755481720,
            PoseTransition = 13755481063
        },
        Movement = {
            Walk = 13516477473,
            Run = 13516476740
        },
        Idle = {
            Idle = 13516476102
        }
    },
    Sounds = {
        ["Charge Voiceline"] = {
            SoundId = 13609314317,
            Volume = 1
        },
        ["Charge SFX"] = {
            SoundId = 14391965061,
            Volume = 1
        },
        ["Full Charge Voiceline"] = {
            SoundId = 13609312979,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 13609315890,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 13608929795,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 13608927642,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13608930257,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 13608928301,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13608930737,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 13608928831,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13608931556,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 13608929223,
            Volume = 1
        },
        ["Brash Hand 1 SFX"] = {
            SoundId = 13608886514,
            Volume = 1
        },
        ["Brash Hand 1 Voiceline"] = {
            SoundId = 13608884754,
            Volume = 1
        },
        ["Brash Hand 2 SFX"] = {
            SoundId = 14553942427,
            Volume = 1
        },
        ["Brash Hand 2 Voiceline"] = {
            SoundId = 13608882484,
            Volume = 1
        },
        ["Brash Hand 3 SFX"] = {
            SoundId = 14553942989,
            Volume = 1
        },
        ["Brash Hand 3 Voiceline"] = {
            SoundId = 13608882914,
            Volume = 1
        },
        ["Uppercut SFX"] = {
            SoundId = 13541793560,
            Volume = 1
        },
        ["Uppercut Voiceline"] = {
            SoundId = 13541793849,
            Volume = 1
        },
        ["Clacker Attack Voiceline"] = {
            SoundId = 13561146699,
            Volume = 1
        },
        ["Clacker Attack SFX"] = {
            SoundId = 14553942288,
            Volume = 1
        },
        ["Clacker Overdrive Voiceline"] = {
            SoundId = 13641280113,
            Volume = 1
        },
        ["Clacker Overdrive SFX"] = {
            SoundId = 13641281136,
            Volume = 1
        },
        ["Hamon Overdrive SFX"] = {
            SoundId = 13611015849,
            Volume = 1
        },
        ["Hamon Overdrive Voiceline"] = {
            SoundId = 13611015373,
            Volume = 1
        },
        ["Rebuff Overdrive SFX"] = {
            SoundId = 14553942884,
            Volume = 1
        },
        ["Rebuff Overdrive Voiceline"] = {
            SoundId = 13611663925,
            Volume = 1
        },
        ["Sparkling Cola Startup SFX"] = {
            SoundId = 13704695853,
            Volume = 1
        },
        ["Sparkling Cola Startup Voiceline"] = {
            SoundId = 13704695397,
            Volume = 1
        },
        ["Sparkling Cola Charging Loop"] = {
            SoundId = 13704694495,
            Volume = 1
        },
        ["Sparkling Cola Fired SFX"] = {
            SoundId = 13704694107,
            Volume = 1
        },
        ["Sparkling Cola Fired Voiceline"] = {
            SoundId = 13704694896,
            Volume = 1
        },
        ["Stock Launcher Voiceline"] = {
            SoundId = 13560943531,
            Volume = 1
        },
        ["Stock Launcher SFX"] = {
            SoundId = 14553942772,
            Volume = 1
        },
        ["Pepper Spray Voiceline"] = {
            SoundId = 13560725506,
            Volume = 1
        },
        ["Pepper Spray SFX"] = {
            SoundId = 13560727155,
            Volume = 1
        },
        ["Pepper Spray Gunfire"] = {
            SoundId = 13560728619,
            Volume = 1
        },
        ["Pepper Spray Unequip"] = {
            SoundId = 13560726244,
            Volume = 1
        },
        ["Slide Tackle Voiceline"] = {
            SoundId = 13558549026,
            Volume = 1
        },
        ["Slide Tackle SFX"] = {
            SoundId = 13558548651,
            Volume = 1
        },
        ["Secret Technique Voiceline"] = {
            SoundId = 13620055835,
            Volume = 1
        },
        ["Secret Technique SFX"] = {
            SoundId = 13620056609,
            Volume = 1
        },
        ["Secret Technique Loop"] = {
            SoundId = 13620301612,
            Volume = 1,
            Looped = true
        },
        PoseMusic = {
            SoundId = 14969439208,
            Volume = 2,
            Looped = true
        }
    },
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
            ["Ripple Charge"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false,
                Description = "Hold to channel your Hamon to fill meter at a moderate pace."
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
            ["Brash Hand"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Launch a powerful slug punch infused with hamon, can be used three times upon recasting the move in a quick succession, ending with the last punch knocking targets away."
            },
            Uppercut = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Concentrate your hamon into a impactful uppercut, knocking targets away."
            },
            ["Clacker Attack"] = {
                DefaultKeybind = "T",
                Description = "Draw out your clackers and begin to fling them around viciously with the last hit knocking targets away.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Clacker Overdrive"] = {
                DefaultKeybind = "T+",
                Description = "Infuse your clackers with hamon, clashing both clackers into the target, knocking them away.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Hamon Overdrive"] = {
                DefaultKeybind = "Y",
                Description = "Infuse hamon into your hand before overhead smashing targets, knocking them away.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Rebuff Overdrive"] = {
                DefaultKeybind = "Y+",
                Description = "Discharge massive amounts of hamon energy from your body, releasing it in a spherical motion around you, knocking all targets away.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Sparkling Cola"] = {
                DefaultKeybind = "G",
                Description = "Take out a bottle of cola before overloading the cola with hamon to eject the cap, drinking the cola after to heal. Charging the cola will increase the damage and health healed.",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Stock Launcher"] = {
                DefaultKeybind = "H",
                Description = "Promptly pull out a tommy gun and use the butt of the gun to hit your target up in the air.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Pepper Spray"] = {
                DefaultKeybind = "H+",
                Description = "Yank out a tommy gun and begin to unleash a fury of bullets to any direction you aim in front of you.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Slide Tackle"] = {
                DefaultKeybind = "V",
                Description = "Swiftly slide forward, kicking any targets in the shin.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Secret Technique"] = {
                DefaultKeybind = "B",
                Description = "Jojo family secret technique used as a last resort, sprint as fast as you can in any direction. Faster than normal sprinting.",
                LevelRequirement = 85,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
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
                    SoundId = "rbxassetid://14969439377",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Come on, come at me!"
                        } }
                }, {
                    SoundId = "rbxassetid://14969439474",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t mess with me, you country bumpkin!"
                        } }
                }, {
                    SoundId = "rbxassetid://14969439275",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Well, looks like I did it again..."
                        } }
                } }
        }
    }
};