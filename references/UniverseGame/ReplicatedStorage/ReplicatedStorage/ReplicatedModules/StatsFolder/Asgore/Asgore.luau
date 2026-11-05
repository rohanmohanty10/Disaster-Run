  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("CollectionService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = nil;
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Enums = require(game.ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 23
    -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy), u2 (ref)
    u1 = Knit.GetService("EffectService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local _ = ReplicatedStorage.Remotes.Output;
local _ = ReplicatedStorage["Client Assets"];
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v4 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v5 = {
    SoundId = 13620822318,
    Volume = 1
};
local v6 = {
    SoundId = 13620821774,
    Volume = 1
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
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
            ["Royal Grasp"] = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Indomitable Resolve"] = {
                DefaultKeybind = "Q",
                State = "Universal",
                Description = "Throw your spear forward, before summoning it back.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Sovereign Reckoning"] = {
                DefaultKeybind = "E",
                State = "Universal",
                Unlocked = true,
                Description = "Perform a devastating series of slashes, ending it off with a finishing blow."
            },
            Swiftdraw = {
                DefaultKeybind = "R",
                State = "Universal",
                Unlocked = true,
                Description = "A fierce slash, knocking away anyone caught."
            },
            ["Final Stance"] = {
                DefaultKeybind = "T",
                State = "Universal",
                Description = "Smash the ground, casting away anyone immediately near you.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Flaring Pierce"] = {
                DefaultKeybind = "Y",
                State = "Universal",
                Description = "Stab forward. Upon connection with a target, they will be brutally twisted into the ground right before being slammed back into it.",
                LevelRequirement = 55,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Ruler Retribution"] = {
                DefaultKeybind = "G",
                State = "Universal",
                Description = "Summon a devastating row of flame pillars out.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Monarch Resonance"] = {
                DefaultKeybind = "H",
                State = "Universal",
                Description = "An incredibly powerful AOE slam, dealing high damage to anyone caught by it.",
                LevelRequirement = 120,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Blazing Fury"] = {
                DefaultKeybind = "V",
                State = "Universal",
                Description = "Cast flames down from above, burning and scathing anyone who is in front of you.",
                LevelRequirement = 105,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 13455447697,
            ["LMB-2"] = 13455449058,
            ["LMB-3"] = 13455449956,
            ["LMB-4"] = 13455450699,
            ["Indomitable Resolve"] = 13631847240,
            ["Sovereign Reckoning"] = 13620907197,
            Swiftdraw = 13628087544,
            ["Final Stance"] = 13628226256,
            ["Flaring Pierce"] = 13622374964,
            ["Flaring Pierce Success"] = 13622380089,
            ["Flaring Pierce Target"] = 13622381665,
            ["Royal Grasp"] = 13623024123,
            ["Royal Grasp Success"] = 13623024910,
            ["Royal Grasp Target"] = 13623025417,
            ["Ruler Retribution"] = 13633258296,
            ["Blazing Fury"] = 13633821688,
            PoseTransition = 13643847191,
            PoseIdle = 13643848301,
            ["Monarch Resonance"] = 13644017793
        },
        Movement = {
            Walk = 13447097062,
            Run = 13447098358
        },
        Idle = {
            Idle = 13447095941
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 13620822470,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13620822470,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13620821955,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13620822210,
            Volume = 1
        },
        ["Sovereign Reckoning"] = {
            SoundId = 13621535563,
            Volume = 1
        },
        Swiftdraw = {
            SoundId = 13628117086,
            Volume = 1
        },
        ["Final Stance"] = {
            SoundId = 13622250122,
            Volume = 1
        },
        ["Flaring Pierce"] = {
            SoundId = 13620822032,
            Volume = 1
        },
        ["Flaring Pierce Success"] = {
            SoundId = 13623077368,
            Volume = 1
        },
        ["Royal Grasp"] = {
            SoundId = 13623128982,
            Volume = 1
        },
        ["Royal Grasp Success"] = {
            SoundId = 13623128867,
            Volume = 1
        },
        ["Indomitable Resolve"] = {
            SoundId = 13620822659,
            Volume = 1
        },
        ["Ruler Retribution"] = {
            SoundId = 13643536143,
            Volume = 1
        },
        ["Monarch Resonance"] = {
            SoundId = 13620821877,
            Volume = 1
        },
        ["Blazing Fury"] = {
            SoundId = 13641396645,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 13744498687,
            Volume = 3
        },
        ChromaPoseMusic = {
            SoundId = 71305174745079,
            Volume = 3
        }
    },
    Stats = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Summoned = false
            },
            AnimationTimed = false,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p7, p8, p9) -- Line: 90
                            -- upvalues: u1 (ref)
                            local Character = p9.Character;

                            if p9.SkinName == "Mohg" then
                                u1.FireAllClients("DK Slashes", Character, {
                                    Speed = 1.25,
                                    Player = p9.Player,
                                    Color = Color3.fromRGB(2550, 86, 34),
                                    DoWeld = {
                                        Attach = Character.HumanoidRootPart,
                                        Offset = CFrame.Angles(0, -0.2617993877991494, 0)
                                    },
                                    EndCFrame = CFrame.Angles(0, 2.6179938779914944, 0)
                                });
                            end;
                        end },
                    { 16, 18, "Attack" },
                    { 19, "End" }
                },
                Stun = {
                    Time = 0.65
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = v5
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p10, p11, p12) -- Line: 127
                            -- upvalues: u1 (ref)
                            local Character = p12.Character;

                            if p12.SkinName == "Mohg" then
                                u1.FireAllClients("DK Slashes", Character, {
                                    Speed = 1.25,
                                    Player = p12.Player,
                                    Color = Color3.fromRGB(2550, 86, 34),
                                    DoWeld = {
                                        Attach = Character.HumanoidRootPart,
                                        Offset = CFrame.Angles(0, 0, -3.141592653589793)
                                    },
                                    EndCFrame = CFrame.Angles(0, -3.141592653589793, -3.141592653589793)
                                });
                            end;
                        end },
                    { 16, 18, "Attack" },
                    { 19, "End" }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 0.85,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p13, p14, p15) -- Line: 153
                            -- upvalues: u1 (ref)
                            local Character = p15.Character;

                            if p15.SkinName == "Mohg" then
                                u1.FireAllClients("DK Slashes", Character, {
                                    Speed = 1.25,
                                    Player = p15.Player,
                                    Color = Color3.fromRGB(2550, 86, 34),
                                    DoWeld = {
                                        Attach = Character.HumanoidRootPart,
                                        Offset = CFrame.Angles(0, 0, 0)
                                    },
                                    EndCFrame = CFrame.Angles(0, 3.0892327760299634, 0)
                                });
                            end;
                        end },
                    { 16, 18, "Attack" },
                    { 21, "End" }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Sequence = {
                    { 0, "Start" },
                    { 16, function(p16, p17, p18) -- Line: 178
                            -- upvalues: u2 (ref), u1 (ref), AssetHandler (copy)
                            local Character = p18.Character;
                            local _ = Character.HumanoidRootPart;
                            local v19 = u2.GetMetadata(Character);
                            u1.FireAllClients({
                                {
                                    Name = "Emit Particle V3",
                                    Data = {
                                        {
                                            AutoSerialize = true,
                                            Origin = v19.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(1.5707963267948966, 0, 0),
                                            Particle = AssetHandler.GetAsset("Particles/LMBPierce", p18),
                                            Scale = Character:GetScale()
                                        }
                                    }
                                }
                            });
                        end },
                    { 16, 18, "Attack" },
                    { 19, "End" }
                },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = v6
                }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher),
            Callbacks = {
                PreAnim = function(p20) -- Line: 211, Name: PreAnim
                    for _, child in pairs(p20.AbilityModel.Trident.Trails:GetChildren()) do
                        if child:IsA("Trail") then
                            child.Enabled = true;
                        end;
                    end;
                end,

                PostAnim = function(p21) -- Line: 221, Name: PostAnim
                    for _, child in pairs(p21.AbilityModel.Trident.Trails:GetChildren()) do
                        if child:IsA("Trail") then
                            child.Enabled = false;
                        end;
                    end;
                end
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        ["Indomitable Resolve"] = {
            Active = true,
            Damage = 25,
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 25
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            Ragdoll = {
                Time = 1
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 35,
                Time = 0.15
            },
            HitSounds = {
                Hit = {
                    SoundId = 13620822723,
                    Volume = 2
                }
            },
            HitRemotes = { v4 }
        },
        ["Sovereign Reckoning"] = {
            Frequency = 6,
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                PerfectBlockable = false
            },
            Damage = 2.5,
            Stun = {
                Time = 1
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5.5,
                Time = 0.15
            },
            HitSounds = {
                Hit = v5
            },
            HitRemotes = { v3 },
            HitAnimations = "Default",
            Finisher = {
                Damage = 25,
                Block = {
                    Unblockable = true
                },
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 50,
                    Time = 0.15
                },
                HitSounds = {
                    Hit = v6
                },
                HitRemotes = { v4 }
            }
        },
        Swiftdraw = {
            Active = true,
            Damage = 30,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                BlockBreak = true
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 55,
                Time = 0.15
            },
            HitRemotes = { v4 },
            HitSounds = {
                Hit = v6
            }
        },
        ["Final Stance"] = {
            Active = true,
            Damage = 30,
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 9,
                Offset = CFrame.new(0, -1, -3.5)
            },
            Block = {
                BlockBreak = true
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 55,
                Time = 0.15,
                Velocity = Vector3.new(0, 30, 0)
            }
        },
        ["Flaring Pierce"] = {
            Frequency = 6,
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                Unblockable = true
            },
            Damage = 5,
            HitSounds = {
                Hit = v5
            },
            HitRemotes = { v3 },
            Slam = {
                Damage = 10,
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                }
            },
            Hit = {
                Damage = 2,
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                HitRemotes = { v3 }
            },
            Finisher = {
                Damage = 10,
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 55,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 35, 0)
                }
            }
        },
        ["Royal Grasp"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                Unblockable = true
            },
            Damage = 5,
            HitSounds = {
                Hit = v5
            },
            HitRemotes = { v3 },
            Finisher = {
                Damage = 25,
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 50,
                    Time = 0.15
                },
                HitSounds = {
                    Hit = {
                        SoundId = 13623128932,
                        Volume = 1
                    }
                },
                HitRemotes = { v4 }
            }
        },
        ["Ruler Retribution"] = {
            Active = true,
            Damage = 35,
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 25
            },
            Hitbox = {
                Size = 10.5
            },
            Block = {
                Unblockable = true
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 45,
                Time = 0.15,
                Velocity = Vector3.new(0, 25, 0)
            }
        },
        ["Monarch Resonance"] = {
            Active = true,
            Damage = 80,
            Priority = Enums.Intangible.Quickstep,
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
                RelativePart = "HumanoidRootPart",
                Size = 18,
                Offset = CFrame.new(0, -0.5, 0)
            },
            Block = {
                Unblockable = true
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 65,
                Time = 0.15,
                Velocity = Vector3.new(0, 35, 0)
            }
        },
        ["Blazing Fury"] = {
            Active = true,
            Damage = 35,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 25
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(20, 20, 20),
                Offset = CFrame.new(0, 0, -13.5)
            },
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 1.25
            }
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p22) -- Line: 740, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v23 = p22.Character:GetAttribute("ChromaUnusual");
                    local v24 = TableUtil.Copy(p22.Stats, true);

                    if v23 then
                        v24.PoseMusic = "ChromaPoseMusic";

                        return v24;
                    end;

                    v24.PoseMusic = "PoseMusic";

                    return v24;
                end
            }
        }
    }
};