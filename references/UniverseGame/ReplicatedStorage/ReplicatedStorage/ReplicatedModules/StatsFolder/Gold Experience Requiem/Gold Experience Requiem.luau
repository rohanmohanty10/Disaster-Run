  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets["Gold Experience Requiem"];
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local v3 = {
    Moveset = {
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
                Description = "Unleash a devastating barrage of blows."
            },
            ["Strong Punch"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "A strong punch which sends enemies flying back."
            },
            ["Combination Attack"] = {
                DefaultKeybind = "R+",
                State = "StandOn",
                Description = "An uppercut into a combination of powerful blows, knocking the enemy back.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Debris Shot"] = {
                DefaultKeybind = "T",
                State = "Universal",
                Description = "Flick forth a piece of debris instantaneously. Upon connection with a target, it will be transformed into a scorpion that will chase them.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Consecutive Rushdown"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Dash forward to grab a target. Upon being grabbed, pummel the target ruthlessly before slamming them onto the ground.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Nullification = {
                DefaultKeybind = "G",
                State = "Universal",
                Description = "A counter which nullifies the action and will of anyone who touches the user.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Return To Zero"] = {
                DefaultKeybind = "G+",
                State = "Universal",
                Description = "Returns all targets around the user to a position in the past, stunning them and slowing them down heavily.Cancels various other moves, such as Time Stop and Time Erase.",
                LevelRequirement = 120,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Righteous Resolution"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "An incredibly powerful beatdown to pummel those who oppose you into submission.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            Heal = {
                DefaultKeybind = "J",
                State = "Universal",
                Description = "When used in Stand On, Gold Experience Requiem will heal allies with a touch.\nWhen used in Stand Off, the user will heal themselves.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Reversal = {
                DefaultKeybind = "V",
                State = "Universal",
                Description = "Reverses targets around the user to a past position.\nIf the target is already stunned or ragdolled, their inactionability will be extended, allowing this to be used as a combo extender.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Kick Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Description = "Gold Experience Requiem appears directly above a target\'s head, unleashing a fierce kick barrage onto them.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Root Stab"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Description = "Summon a root from the ground to stab forth, knocking anyone caught away.",
                LevelRequirement = 20,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Devastating Force"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Grab someone and drag them across the ground, before throwing them away.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    Metadata = {
        PostRig = function(p1) -- Line: 239, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p1.Player;
            local Character = p1.Character;
            local SkinName = p1.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v2 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v2.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v2;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};
v3.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    LeaveParts = { "StandHumanoidRootPart", "FAKE", "StandAura2" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 70, 200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 150, 255)) })
};
v3.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 7, 14, "Attack" }, { 14, "End" } },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = { v3.Resources.LMB1Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 10, 15, "Attack" }, { 17, "End" } },
        HitSounds = { v3.Resources.LMB2Hit }
    },
    ["LMB-3"] = {
        Damage = 4,
        Speed = 1,
        Sequence = {
            { 0, "Start" },
            { 12, 16, "Attack" },
            { 17, function(p4, p5, p6, p7, p8) -- Line: 328
                    p4.Hit[p7.FullName] = {};
                end },
            { 23, 28, "Attack" },
            { 28, "End" }
        },
        HitSounds = { v3.Resources.LMB3Hit }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 16, 23, "Attack" }, { 32, "End" } },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = { v3.Resources.LMB4Hit }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 1-3" }, { 19, 24, "Attack" }, { 30, "End" } },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = { v3.Resources.LMB1Hit }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.25,
        Cooldown = 1,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 4" }, { 36, 42, "Attack" }, { 48, "End" } },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = { v3.Resources.LMB4Hit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p9, p10) -- Line: 404, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p9.Stats;

            if not Knit.CollectionService:HasTag(p9.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v3.Stats.Block = {
    From = "Combat.Block"
};
v3.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p11) -- Line: 428, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v12 = TableUtil.Copy(p11.Stats, true);

            if Knit.CollectionService:HasTag(p11.Character, "Summoned") then
                v12.PoseMusic = "StandPoseMusic";
                v12.StartAnim = "StandPoseTransition";
                v12.LoopAnim = "StandPoseIdle";
            end;

            return v12;
        end,

        PoseTransition = function(p13) -- Line: 437, Name: PoseTransition
            -- upvalues: Knit (copy), AssetHandler (copy), EnableBirthmark (copy)
            if not Knit.CollectionService:HasTag(p13.Character, "Summoned") then
                local v14 = p13.Trove:Clone(AssetHandler.GetAsset("Particles/ArrowPart", p13));
                local Weld = Instance.new("Weld");
                Weld.Part0 = p13.Character[(p13.SkinName == "U-GER" and "Right" or "Left") .. " Arm"];
                Weld.Part1 = v14;
                Weld.Parent = v14;
                v14.Parent = p13.Character;
            end;

            EnableBirthmark(p13.Character, true);
        end,

        PoseEnd = function(p15, p16) -- Line: 448, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p15.Character, false);
        end
    }
};
v3.Stats.Grab = {
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
v3.Stats.Barrage = TableUtil.Reconcile({
    From = "Combat.Barrage",
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = { v3.Resources.BarrageHitSound }
    },
    Finisher = {
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = { v3.Resources.BarrageFinisherSound }
    },
    ClashHit = {},
    ClashFinisher = {}
}, BaseStatsModule.Stand_Barrage);
v3.Stats["Kick Barrage"] = {
    Active = true,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Name = "Kick Barrage",
        Time = 16,
        Manual = true
    },
    Search = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 24,
        Offset = CFrame.new(0, 0, 0)
    },
    Hit = {
        Damage = 4,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 1.1,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(6, 6, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = { v3.Resources.KickBarrageHit }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 60,
            Time = 0.1
        },
        Ragdoll = {
            Time = 0.75
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(6, 6, 6),
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = { v3.Resources.KickBarrageFinisher }
    }
};
v3.Stats["Root Stab"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 48,
        Velocity = Vector3.new(0, 24, 0),
        Time = 0.1
    },
    Block = {
        BlockBreak = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 22),
        Debug = false,
        Offset = CFrame.new(0, 0, -11)
    },
    HitRemotes = { v3.Resources.HeavyHit },
    HitSounds = { v3.Resources.RootStabHit }
};
v3.Stats["Strong Punch"] = {
    Active = true,
    Damage = 40,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Ragdoll = {
        Time = 0.75
    },
    Stun = {
        Time = 0.15,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 48,
        Time = 0.1
    },
    Block = {
        BlockBreak = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v3.Resources.HeavyHit },
    HitSounds = { v3.Resources.StrongPunchHit }
};
v3.Stats["Combination Attack"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Block = {
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Kick = {
        Damage = 10,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Slam = {
        Damage = 10,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 56,
            Velocity = Vector3.new(0, 16, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v3.Stats["Debris Shot"] = {
    Active = true,
    Homing = false,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Debris = {
        Homing = false,
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 0.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            Unblockable = true,
            BlockCancel = true,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.DebrisHit },
        HitSounds = { v3.Resources.DebrisShotHit }
    },
    Scorpion = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Quickstep,
        Stun = {
            Time = 0.6
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            BypassCounter = true
        },
        HitRemotes = { v3.Resources.DebrisHit }
    }
};
v3.Stats["Devastating Force"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = {}
    },
    Slam = {
        Damage = 20,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Drag = {
        Damage = 1,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 56,
            Velocity = Vector3.new(0, 18, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    }
};
v3.Stats["Consecutive Rushdown"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 14.5),
            Predict = false,
            Offset = CFrame.new(0, 0, -6.9)
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Punch = {
        Damage = 5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Finisher = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Velocity = Vector3.new(0, -24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v3.Stats.Nullification = {
    Active = true,
    DefaultCooldown = 30,
    CounteredCooldown = 18,
    Actionable = {
        Active = true
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        }
    }
};
v3.Stats["Return To Zero"] = {
    Active = true,
    DefaultCooldown = 40,
    StunnedCooldown = 65,
    InfinityBypass = true,
    GoBeyond = true,
    IgnoreTimestop = true,
    IgnoreTimeErasure = true,
    Actionable = {
        Active = true,
        Timestopped = false,
        Stunned = false
    },
    Priority = EnumsModule.Intangible.Move,
    Meter = {
        RequiredAmount = 90,
        RemoveMeter = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true
    }
};
v3.Stats["Righteous Resolution"] = {
    Active = true,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 40,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 3,
        RemoveMeter = true
    },
    Startup = {
        CheckPVPSafe = true,
        Meter = false,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = false
        },
        Stun = {
            Time = 0.65
        }
    },
    Haymaker = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    StandKick = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Launch = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    DoubleAttack = {
        Damage = 20,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Barrage = {
        Damage = 0.5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    StandBarrage = {
        Damage = 0.5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Damage = 20,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Release = {
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 75,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v3.Stats.Reversal = {
    Active = true,
    Actionable = {
        Active = true,
        Stunned = false,
        Ragdolled = false,

        Check = function(p17) -- Line: 1173, Name: Check
            -- upvalues: PathShortcuts (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v18;

            if p17 then
                v18 = p17:GetAttribute("InDomain");
            else
                v18 = p17;
            end;

            local v19 = game.Players:GetPlayerFromCharacter(p17);

            if v18 and v19 then
                UIOutput:FireClient(v19, "CreateMiddleNotification", {
                    NumericalContent = 1,
                    NumericalSuffix = "Gold Experience Requiem",
                    Verb = "",
                    Subject = "You can\'t use this ability during a closed Domain."
                });
                UIOutput:FireClient(v19, "PlaySound", "ope_invalid_move");
            end;

            return not v18;
        end
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30,
        RemoveMeter = true
    },
    Indicators = { {
            Group = "Universal",
            Name = "Reversal",
            InputText = "%s",
            ActiveName = "Reversal",
            CooldownName = "Reversal",
            Visible = true
        } }
};
v3.Stats.Heal = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Self = {
        Heal = 40,
        Cooldown = {
            Time = 35,
            AfterMove = true
        },
        HitRemotes = {},
        HitSounds = { v3.Resources.Heal },
        Meter = {
            RequiredLevel = 2,
            RemoveMeter = true
        }
    },
    Others = {
        Heal = 60,
        Block = {
            Unblockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            FriendlyFire = true,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v3.Resources.HealHit },
        HitSounds = { v3.Resources.Heal }
    }
};

return v3;