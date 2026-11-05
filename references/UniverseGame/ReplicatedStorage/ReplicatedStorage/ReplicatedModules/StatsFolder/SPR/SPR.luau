  

 

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
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local _ = ReplicatedStorage.Remotes.Output;
local v1 = ReplicatedStorage["Client Assets"];
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
            Particle = v1.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(170, 0, 255)
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
            Particle = v1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(170, 0, 255)
        }
    }
};
({}).Hit = {
    SoundId = 6964550685,
    Volume = 1.5
};
({}).Hit = {
    SoundId = 6964575872,
    Volume = 3
};
local v4 = {
    Summon = {
        From = "Combat.Summon",
        LeaveParts = { "StandHumanoidRootPart" },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 0, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
    },
    Block = {
        From = "Combat.Block"
    },
    Quickstep = {
        From = "Combat.Quickstep"
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
        AnimationTimed = false,
        MaxCombo = 4,
        ComboTick = 1.5,
        ["LMB-1"] = TableUtil.Reconcile({
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB" }, { 16, 18, "Attack" }, { 19, "End" } },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 6899463110,
                    Volume = 1
                }
            }
        }, BaseStatsModule.Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB" }, { 16, 18, "Attack" }, { 19, "End" } },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 6164853733,
                    Volume = 1
                }
            }
        }, BaseStatsModule.Stand_Rush_Attack_Finisher)
    }
};
v4["Rush Attack"] = TableUtil.Reconcile(v4["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v4.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p5, p6) -- Line: 160, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p5.Character, true);
        end,

        PoseEnd = function(p7, p8) -- Line: 163, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p7.Character, false);
        end
    }
};
v4.Teleport = {
    From = "Combat.Teleport"
};
v4["Timestop Movement"] = {
    From = "Combat.Timestop Movement"
};
v4["Ground Slam"] = {
    Active = true,
    Damage = 40,
    Cooldown = 16,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Ragdoll = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Block = {
        BlockBreak = true,
        PerfectBlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 64,
        Time = 0.2
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 15),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    }
};
v4["Star Breaker"] = {
    Active = true,
    Cooldown = 20,
    Damage = 50,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Properties = {
        Armor = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    Ragdoll = {
        Time = 0.5
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.15
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 10),
        Debug = false,
        Offset = CFrame.new(0, 0, -5)
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 6008655188,
            Volme = 6
        }
    }
};
v4["Cursed Punches"] = {
    Active = true,
    Cooldown = 10,
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v2 },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 6964575872,
            Volme = 3
        }
    }
};
v4.Combo = {
    Active = true,
    Cooldown = 20,
    Damage = 7.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 10),
        Debug = false,
        Offset = CFrame.new(0, 0, -5)
    },
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 7253727611,
            Volme = 3
        }
    }
};
v4["Arrow Judgement"] = {
    Active = true,
    Cooldown = 16,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.8,
        Priority = Enums.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 6964550685,
            Volme = 1
        }
    },
    ArrowData = {
        Size = 5,
        StartColor = Color3.fromRGB(100, 100, 185),
        Angle = CFrame.new(),
        EndColor = Color3.fromRGB(100, 100, 185)
    },
    Properties = {
        Armor = true
    }
};
v4["Arrow Throw"] = {
    Active = true,
    Damage = 10,
    Distance = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Name = "Arrow Throw",
        Time = 15,
        Manual = true
    },
    Meter = {
        RequiredLevel = 1
    },
    HitRemotes = { v3 },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 6964550685,
            Volme = 1
        }
    },
    Scan = {
        Hitbox = {
            Size = 40
        }
    }
};
v4["Arrow Prison"] = {
    Active = true,
    Cooldown = 16,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Summoned = true
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 0.625,
        Priority = Enums.Stun.Medium
    },
    Meter = {
        RequiredLevel = 1
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(21.5, 21.5, 21.5),
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 6964575872,
            Volme = 1
        }
    },
    ArrowData = {
        StartOffset = 10,
        EndOffset = 50,
        Size = 3,
        Amount = 10,
        Colors = { Color3.fromRGB(132, 132, 197), Color3.fromRGB(132, 132, 197) }
    }
};
v4.Timestop = {
    Active = true,
    Speed = 0.75,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true,
        CanTimestop = true
    },
    Cooldown = {
        Name = "Timestop",
        Time = 60,
        AfterMove = true
    },
    Sequence = { { 0, "PlayAnim", "Timestop" }, { 0, "PlaySound", "TSVoice" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 54, "Timestop" }, { 95, "End" } },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 6,
        Size = 150,
        StopSounds = { "TSSFX" },
        ResumeSounds = { "TSEndSFX", "TSEndVoice" }
    }
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
            ["Cursed Punches"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly perform a burst combo of punches before unleashing a finishing strike."
            },
            Combo = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Deliver a combo of two punches before swiftly dashing through your opponent to lacerate them with cursed energy."
            },
            ["Arrow Judgement"] = {
                DefaultKeybind = "R+",
                State = "StandOn",
                Description = "Deliver an accursed uppercut to lift your target up into the air before quickly summoning Exploding Shadow Arrows around them.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Arrow Throw"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Fire a tracking Shadow Arrow from your palm to tag your target. Press the input again in a quick succession to pull them to yourself.",
                LevelRequirement = 45,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Arrow Prison"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Call forth massive Shadow Arrows forming a prison as you bring them down with immense force to pierce your target.",
                LevelRequirement = 60,
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
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Star Breaker"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Charge up a heavy blow with great force before unleashing it.",
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
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "B",
                Description = "Your stand briefly stops time in a radius.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "J",
                Description = "Gives you the ability to move during a timestop.",
                LevelRequirement = 80,
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
            ["LMB-1"] = 6579514138,
            ["LMB-2"] = 6761488706,
            ["LMB-3"] = 6579518209,
            ["LMB-4"] = 6579519666,
            GroundSlam = 6754411814,
            ["Cursed Punches"] = 7259578020,
            ["Arrow Judgement"] = 5947659301,
            ["Arrow Prison"] = 7348515492,
            ["Arrow Throw"] = 5957039028,
            Fly = 5960775243,
            ["Star Breaker"] = 5947556573,
            Timestop = 7033584036,
            ["Double Punch"] = 7249001995,
            Zoom = 7249005370,
            PoseTransition = 7772898992,
            PoseIdle = 7772897348
        },
        Movement = {
            Run = 7370961968,
            Walk = 7370960151,
            SummonedRun = 7370961968,
            SummonedWalk = 7370960151
        },
        Idle = {
            Idle = 7248998915,
            SummonedIdle = 7348517142
        }
    },
    Stats = v4,
    Sounds = {
        ArrowsVoiceline = {
            SoundId = "rbxassetid://7395470920",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Blast = {
            SoundId = "rbxassetid://159218913",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://6957501675",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Die = {
            SoundId = "rbxassetid://4780018796",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Dodge = {
            SoundId = "rbxassetid://453318796",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Fire = {
            SoundId = "rbxassetid://5956796766",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FloorHitSFX = {
            SoundId = "rbxassetid://6964548853",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Guard = {
            SoundId = "rbxassetid://648479338",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        H1 = {
            SoundId = "rbxassetid://7253727611",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        H2 = {
            SoundId = "rbxassetid://7253728535",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeavyPunch = {
            SoundId = "rbxassetid://7395466320",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://6008968634",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://6008968634",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://6008968634",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://6008655188",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Music = {
            SoundId = "rbxassetid://9061914424",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://9657528658",
            Volume = 2,
            PlaybackSpeed = 0.669,
            Looped = true,
            TimePosition = 0
        },
        Overwritten = {
            SoundId = "rbxassetid://177162406",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Punch = {
            SoundId = "rbxassetid://177162406",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PunchesSFX = {
            SoundId = "rbxassetid://7395462731",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SlamVC = {
            SoundId = "rbxassetid://7395476466",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        StandJumpSFX = {
            SoundId = "rbxassetid://5872684313",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        StarBreaker = {
            SoundId = "rbxassetid://7395473448",
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonEffects = {
            SoundId = "rbxassetid://7395479009",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://6957500679",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SwingLMB = {
            SoundId = "rbxassetid://6706981173",
            Volume = 0.800000011920929,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSEndSFX = {
            SoundId = "rbxassetid://6575421609",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSEndVoice = {
            SoundId = "rbxassetid://6004687508",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSSFX = {
            SoundId = "rbxassetid://7402430295",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSVoice = {
            SoundId = "rbxassetid://7402410133",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Teleport = {
            SoundId = "rbxassetid://6773724319",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        V1 = {
            SoundId = "rbxassetid://7253720620",
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        V2 = {
            SoundId = "rbxassetid://7253726921",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        VoidWarp = {
            SoundId = "rbxassetid://7034151733",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        W1 = {
            SoundId = "rbxassetid://7253731726",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        W2 = {
            SoundId = "rbxassetid://7253720620",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Arrows = {
            SoundId = "rbxassetid://1837829231",
            Volume = 5,
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
                    SoundId = "rbxassetid://7395484853",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I feel no mercy for you. None at all."
                        } }
                }, {
                    SoundId = "rbxassetid://7395489916",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Sleep it off in the depths of hell."
                        } }
                }, {
                    SoundId = "rbxassetid://7395494451",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m the type of person who gets upset when I\'m mocked."
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p9) -- Line: 1000, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p9.Player;
            local Character = p9.Character;
            local SkinName = p9.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v10 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v10.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v10;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};