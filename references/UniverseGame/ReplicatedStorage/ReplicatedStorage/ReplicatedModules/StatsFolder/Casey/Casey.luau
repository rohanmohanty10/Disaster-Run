  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
require(PathShortcuts.BaseStatsModule);
local v1 = { {
        Name = "Output",
        Arguments = { "FX", "HitEffect", "__Legacy" }
    } };
local v2 = { {
        Name = "Output",
        Arguments = { "FX", "HeavyEffect", "__Legacy" }
    } };

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
            Bonk = {
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
            ["Bonk Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Repeatedly swing your bat."
            },
            ["Triple Bonk"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Swing your bat three times."
            },
            ["Bonk Awakening"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Enter an awakened state that boosts the user.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Bonk Beatdown"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Perform a beatdown on the target.",
                LevelRequirement = 200
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 12947370476,
            ["LMB-2"] = 12947370476,
            ["LMB-3"] = 12947370476,
            ["LMB-4"] = 12947370476,
            SwingTransition = 5842787243,
            Swing = 5842788141,
            Awakening = 7071178699,
            PoseTransition = 5842947612,
            PoseIdle = 5842946044,
            CaseyBeatdownInitiator = 102038232421181,
            CaseyBeatdownCamera = 88698554089447,
            CaseyBeatdownUser = 86067779397222,
            CaseyBeatdownVictim = 125750218975839,
            ["Stand-Block"] = 12499353550
        },
        Core = {
            SummonedIdle = 100254001808511
        }
    },
    Stats = {
        Summon = {
            From = "Combat.Summon"
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose",
            Actionable = {
                Active = true,
                Summoned = true
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
        Bonk = {
            Active = true,
            MinHoldTime = 0.275,
            MaxHoldTime = 180,
            ChargeTime = 3,
            Endlag = 0.4,
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Name = "Bonk",
                Manual = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            NormalStats = {
                Damage = 8,
                Cooldown = {
                    Time = 0.5
                },
                Block = {
                    PerfectBlockable = false,
                    BlockBreak = false
                },
                Stun = {
                    Time = 0.175,
                    Priority = EnumsModule.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 25,
                    Time = 0.15
                },
                HitRemotes = v1
            },
            ChargedStats = {
                Damage = 25,
                Cooldown = {
                    Time = 1.6
                },
                Block = {
                    PerfectBlockable = true,
                    BlockBreak = true
                },
                Stun = {
                    Time = 0.325,
                    Priority = EnumsModule.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 375,
                    Time = 0.25
                },
                Ragdoll = {
                    Time = 0.35
                },
                HitRemotes = v2
            },
            HitSounds = {
                Hit = {
                    SoundId = 5842621008,
                    Volume = 1.5
                }
            }
        },
        ["Bonk Barrage"] = {
            Active = true,
            Duration = 3.5,
            Damage = 1.25,
            HitAnimation = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Stun = {
                Time = 0.6,
                Priority = EnumsModule.Stun.Medium
            },
            HitSounds = {
                Hit = {
                    SoundId = 5842621008,
                    Volume = 1.5
                }
            },
            HitRemotes = v1
        },
        ["Triple Bonk"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Active = true,
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Damage = 15,
            Stun = {
                Time = 0.6,
                Priority = EnumsModule.Stun.Medium
            },
            HitAnimation = "Default",
            HitSounds = {
                Hit = {
                    SoundId = 5842621008,
                    Volume = 1.5
                }
            },
            HitRemotes = v1,
            ["Final Hit"] = {
                Damage = 10,
                HitAnimations = "Default",
                Stun = {
                    Time = 0.6,
                    Priority = EnumsModule.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 100,
                    Time = 0.4
                },
                HitSounds = {
                    Hit = {
                        SoundId = 5842621008,
                        Volume = 1.5
                    }
                },
                HitRemotes = v2,
                Block = {
                    BlockBreak = true
                }
            }
        },
        ["Bonk Awakening"] = {
            Active = true,
            Duration = 30,
            Actionable = {
                Active = true,
                Summoned = true
            },
            Meter = {
                RequiredLevel = 2
            },
            Cooldown = {
                Time = 30,
                AfterMove = true
            }
        },
        ["Bonk Beatdown"] = {
            Active = true,
            CheckPVPSafe = true,
            Actionable = {
                Active = true,
                Summoned = true
            },
            Meter = {
                RequiredLevel = 3
            },
            Cooldown = {
                Time = 30,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                PerfectBlockable = true
            },
            Barrage = {
                Damage = 1.5,
                MinHealth = 1,
                Priority = EnumsModule.Intangible.Move,
                HitSounds = {
                    Hit = {
                        SoundId = 5842621008,
                        Volume = 0.4
                    }
                },
                HitRemotes = v1
            },
            FinalHit = {
                Damage = 30,
                Priority = EnumsModule.Intangible.Move,
                HitSounds = {
                    Hit = {
                        SoundId = 5842621008,
                        Volume = 0.4
                    }
                },
                HitRemotes = v2
            },
            KnockbackHit = {
                Damage = 0.1,
                Priority = EnumsModule.Intangible.True,
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 100,
                    Time = 0.4
                },
                Ragdoll = {
                    Time = 1
                }
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = "rbxassetid://5842619957",
            Volume = 1
        },
        BonkPrepare = {
            SoundId = "rbxassetid://5842619957",
            Volume = 1
        },
        BonkCharge = {
            SoundId = "rbxassetid://5842620471",
            Volume = 1
        },
        BonkSwing = {
            SoundId = "rbxassetid://5842620693",
            Volume = 1
        },
        Beatdown = {
            SoundId = "rbxassetid://119940775902153",
            Volume = 2.5
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://5842620471",
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://5842620693",
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://5842621008",
            Volume = 1
        },
        Dash1 = {
            SoundId = "rbxassetid://5842352655",
            Volume = 2
        },
        Dash2 = {
            SoundId = "rbxassetid://5842352655",
            Volume = 2
        },
        PoseMusic = {
            SoundId = "rbxassetid://9584673386",
            Volume = 2
        }
    }
};