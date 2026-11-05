  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local Output = game.ReplicatedStorage.Remotes.Output;
local u1 = game.ReplicatedStorage["Client Assets"];
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
            Particle = u1.Yone.Particles.Hit
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
            ["Mortal Steel"] = {
                DefaultKeybind = "Q",
                Unlocked = true,
                Description = "Deliver a strong slash forward. Successful hits grant a stack and at two stacks the move changes."
            },
            ["Spirit Cleave"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Jump up and slam down into the floor, healing yourself for every target hit while damaging them."
            },
            ["Soul Unbound"] = {
                DefaultKeybind = "R",
                Description = "Go into a spirit-like form, splitting yourself from your body temporarily.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            Barrage = {
                DefaultKeybind = "T",
                Description = "Perform multiple consecutive slashes, finishing up with a cleave.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Fate Sealed"] = {
                DefaultKeybind = "G",
                Description = "Charge up, dashing forward at incredible speeds, grabbing everyone in a vicinity along with you.",
                LevelRequirement = 90,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Leg Slice"] = {
                DefaultKeybind = "V",
                Description = "Perform a low sweep, severing the target\'s legs, followed up by a kick.",
                LevelRequirement = 35,
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
            ["LMB-1"] = 8606750324,
            ["LMB-2"] = 8606753706,
            ["LMB-3"] = 8606756630,
            ["Soul LMB-1"] = 9522373089,
            ["Soul LMB-2"] = 9522382074,
            ["Soul LMB-3"] = 9522383480,
            ["Mortal Steel"] = 7500759732,
            ["Mortal Dash"] = 7493811872,
            ["Spirit Cleave"] = 7516879373,
            ["Soul Unbound"] = 7480466114,
            ["Soul Return"] = 7567512894,
            ["Leg Slice"] = 7563917503,
            ["Fate Sealed"] = 7493806549,
            Barrage = 7706260669,
            Grab = 11110729280,
            Throw = 11110730939,
            ThrowVictim = 11110732132,
            PoseTransition = 7853602678,
            PoseIdle = 7853603822
        },
        Movement = {
            Walk = 7472944280,
            Run = 7777523719,
            SoulWalk = 7493825611,
            SoulRun = 7493828786
        },
        Idle = {
            Idle = 7472941768,
            SoulIdle = 7493829831
        }
    },
    Stats = {
        Pose = {
            From = "Combat.Pose"
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
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Damage = 10,
            MaxCombo = 3,
            ComboTick = 1.5,
            Endlag = 0.2,
            Stun = {
                Time = 0.75,
                Priority = EnumsModule.Stun.Medium
            },
            Block = {
                PerfectBlockable = false
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 8,
                Time = 0.1
            },
            HitAnimations = "Default",
            Hitbox = {
                Type = "Region3",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Speed = 1.25,
            Sequence = { { 0, "PlayAnim" }, { 0, "PlaySound" }, { 0, "CreateTag", "NoRun" }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 20, 30, "Attack" }, { 35, "End" } },
            ["LMB-3"] = {
                Damage = 25,
                Cooldown = 1.5,
                Block = {
                    Unblockable = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                }
            },
            ["Soul LMB-3"] = {
                Damage = 25,
                Cooldown = 1.5,
                Block = {
                    Unblockable = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                }
            },
            Texture1 = {
                frames = 15,
                fps = 45,
                rows = 3,
                columns = 5,
                front = "http://www.roblox.com/asset/?id=7943227207",
                back = "http://www.roblox.com/asset/?id=7945726042",
                size = Vector3.new(12, 12, 0),
                color = Color3.new(1, 1, 1),
                part = u1.Misc.slash
            },
            Texture2 = {
                frames = 15,
                fps = 45,
                rows = 3,
                columns = 5,
                front = "http://www.roblox.com/asset/?id=7943227207",
                back = "http://www.roblox.com/asset/?id=7945726042",
                size = Vector3.new(12, 12, 0),
                color = Color3.new(1, 0, 0),
                part = u1.Misc.slash
            },
            HitSounds = {
                Hit = {
                    SoundId = 7577185389,
                    Volume = 3
                }
            },
            HitRemotes = { v2 },
            HitData = {
                Color = Color3.new(1, 1, 1)
            },
            Callbacks = {
                StateChecker = function(p3, p4) -- Line: 160, Name: StateChecker
                    -- upvalues: CollectionService (copy), TableUtil (copy)
                    local _ = p3.Player;
                    local Stats = p3.Stats;
                    local _ = p3.Input;

                    if CollectionService:HasTag(p3.Character, "Soul Unbound") then
                        Stats = TableUtil.Copy(Stats, true);
                        Stats.CustomPrefix = "Soul LMB";
                        Stats.Speed = 1.5;
                    end;

                    return Stats;
                end,

                PreAnim = function(p5, p6) -- Line: 170, Name: PreAnim
                    -- upvalues: TableUtil (copy), Output (copy), ParticleHandler (copy), CollectionService (copy), u1 (copy)
                    local _ = p5.Player;
                    local v7 = TableUtil.Copy(p6.AttackStats, true);
                    local _ = p5.Input;
                    local Character = p5.Character;
                    local HumanoidRootPart = Character.HumanoidRootPart;

                    if p6.MoveState.Count == 2 then
                        p6.CombatService.FetchSound(HumanoidRootPart, p6.FullName .. "-Voiceline" .. "-" .. math.random(6)):Play();
                    end;

                    Output:FireAllClients("FX", "Enable Trails", "Yone", { Character.Sword, Character.Sword2 }, true);
                    local Texture1 = v7.Texture1;
                    local Texture2 = v7.Texture2;
                    Texture1.originalcolor = Texture1.color;
                    Texture2.originalcolor = Texture2.color;
                    Texture1.color = ParticleHandler.TryHSVShift(Texture1.originalcolor, ParticleHandler.GetUnusualHSVData(p5));
                    Texture2.color = ParticleHandler.TryHSVShift(Texture2.originalcolor, ParticleHandler.GetUnusualHSVData(p5));

                    if CollectionService:HasTag(u1, "Soul Unbound") then
                        if p6.MoveState.Count == 1 then
                            Output:FireAllClients("FX", "Create FX", "Slash FX V2", Character, Texture1);

                            return;
                        end;

                        if p6.MoveState.Count == 2 then
                            Texture2.preset = "D_LEFT_DOWN";
                            Output:FireAllClients("FX", "Create FX", "Slash FX V2", Character, Texture2);
                        end;
                    else
                        if p6.MoveState.Count == 2 then
                            Output:FireAllClients("FX", "Create FX", "Slash FX V2", Character, Texture1);

                            return;
                        end;

                        if p6.MoveState.Count == v7.MaxCombo then
                            Texture1.preset = "D_RIGHT_DOWN";
                            Texture2.preset = "D_LEFT_DOWN";
                            Output:FireAllClients("FX", "Create FX", "Slash FX V2", Character, Texture1);
                            Output:FireAllClients("FX", "Create FX", "Slash FX V2", Character, Texture2);
                        end;
                    end;
                end,

                PostAnim = function(p8, p9) -- Line: 201, Name: PostAnim
                    -- upvalues: Output (copy)
                    local _ = p8.Player;
                    local _ = p9.AttackStats;
                    local _ = p8.Input;
                    local Character = p8.Character;
                    Output:FireAllClients("FX", "Enable Trails", "Yone", { Character.Sword, Character.Sword2 }, false);
                end
            }
        },
        ["Mortal Steel"] = {
            Active = true,
            Damage = 10,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Name = "Mortal Steel",
                Manual = true,
                Time = 1.5
            },
            MaxCooldown = {
                Name = "Mortal Steel",
                Manual = true,
                Time = 12
            },
            Properties = {
                Armor = true
            },
            Stun = {
                Time = 0.25,
                Priority = EnumsModule.Stun.Medium
            },
            Meter = {
                MoveMax = 20
            },
            Hitbox = {
                Type = "Region3",
                Size = Vector3.new(5, 5, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            HitSounds = {
                Hit = {
                    SoundId = 7577189384,
                    Volume = 2
                }
            },
            HitData = {
                Color = Color3.new(1, 1, 1)
            }
        },
        ["Spirit Cleave"] = {
            Active = true,
            Damage = 25,
            HealPerHit = 25,
            Cooldown = 16,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Properties = {
                Armor = true
            },
            Stun = {
                Time = 1,
                Priority = EnumsModule.Stun.Medium
            },
            Ragdoll = {
                Time = 1
            },
            Block = {
                Blockable = true,
                PerfectBlockable = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 15,
                Time = 0.25
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = 10,
                Offset = CFrame.new(0, 0, -5)
            },
            HitSounds = {
                Hit = {
                    SoundId = 7181838845,
                    Volume = 0
                }
            },
            HitRemotes = { v2 },
            HitData = {
                Color = Color3.new(1, 1, 1)
            }
        },
        ["Leg Slice"] = {
            Active = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Sword = {
                Damage = 15,
                HitAnimations = "Default",
                Stun = {
                    Time = 0.75,
                    Priority = EnumsModule.Stun.Medium
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    BlockCancel = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(15, 10, 9),
                    Offset = CFrame.new(0, 0, -4.5)
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7731164647,
                        Volume = 2
                    }
                },
                HitRemotes = { v2 },
                HitData = {
                    Color = Color3.new(1, 1, 1)
                }
            },
            Kick = {
                Damage = 15,
                HitAnimations = "Default",
                Stun = {
                    Time = 1.25
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    BlockCancel = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7731165324,
                        Volume = 3
                    }
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5, 5, 9),
                    Offset = CFrame.new(0, 0, -4.5)
                },
                HitRemotes = {
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "HitEffect V3",
                            {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                AutoSerialize = true,
                                LookAt = "Attacker",
                                Particle = u1.Universal.Universal_HitVFX
                            }
                        }
                    }
                },
                HitData = {
                    Color = Color3.new(1, 1, 1)
                }
            },
            Texture1 = {
                frames = 15,
                fps = 60,
                rows = 3,
                columns = 5,
                front = "http://www.roblox.com/asset/?id=7943227207",
                back = "http://www.roblox.com/asset/?id=7945726042",
                size = Vector3.new(12, 12, 0),
                color = Color3.new(1, 1, 1),
                part = u1.Misc.slash
            },
            Texture2 = {
                frames = 15,
                fps = 60,
                rows = 3,
                columns = 5,
                front = "http://www.roblox.com/asset/?id=7943227207",
                back = "http://www.roblox.com/asset/?id=7945726042",
                size = Vector3.new(12, 12, 0),
                color = Color3.new(1, 0, 0),
                part = u1.Misc.slash
            }
        },
        Barrage = {
            Active = true,
            Cooldown = 10,
            Damage = 8,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Stun = {
                Time = 0.6,
                Priority = EnumsModule.Stun.Medium
            },
            Block = {
                PerfectBlockable = false
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Debug = false,
                Offset = CFrame.new(0, 0, -5)
            },
            Texture1 = {
                frames = 15,
                fps = 60,
                rows = 3,
                columns = 5,
                front = "http://www.roblox.com/asset/?id=7943227207",
                back = "http://www.roblox.com/asset/?id=7945726042",
                size = Vector3.new(12, 12, 0),
                color = Color3.new(1, 1, 1),
                part = u1.Misc.slash
            },
            Texture2 = {
                frames = 15,
                fps = 60,
                rows = 3,
                columns = 5,
                front = "http://www.roblox.com/asset/?id=7943227207",
                back = "http://www.roblox.com/asset/?id=7945726042",
                size = Vector3.new(12, 12, 0),
                color = Color3.new(1, 0, 0),
                part = u1.Misc.slash
            },
            HitSounds = {
                Hit = {
                    SoundId = 7577185760,
                    Volume = 2
                }
            },
            HitRemotes = { v2 },
            HitData = {
                Color = Color3.new(1, 1, 1)
            }
        },
        ["Soul Unbound"] = {
            Active = true,
            RepeatDamage = 0.5,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 24,
                AfterMove = true
            },
            Meter = {
                Amount = 0,
                RequiredLevel = 1
            },
            HitSounds = {
                Hit = {
                    SoundId = 7577189384,
                    Volume = 3
                }
            },
            HitRemotes = { v2 },
            HitData = {
                Color = Color3.new(1, 1, 1)
            }
        },
        ["Fate Sealed"] = {
            Active = true,
            Damage = 50,
            Cooldown = 45,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Stun = {
                Time = 2,
                Priority = EnumsModule.Stun.Medium
            },
            Meter = {
                Amount = 0,
                RequiredAmount = 75
            },
            Block = {
                Unblockable = true
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Airborne",
                    AirborneTime = 1.5,
                    AirbornePos = Vector3.new(0, 15, 0)
                } },
            Hitbox = {
                Type = "Region3",
                Size = Vector3.new(20, 20, 50),
                Debug = false,
                Offset = CFrame.identity
            },
            HitSounds = {
                Hit = {
                    SoundId = 7577189384,
                    Volume = 3
                }
            },
            HitRemotes = { v2 },
            HitData = {
                Color = Color3.new(1, 1, 1)
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 7563912616,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 7563914544,
            Volume = 1.2
        },
        ["LMB-3"] = {
            SoundId = 7563929658,
            Volume = 1.2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 7564391669,
            Volume = 1.2
        },
        ["LMB-2-Voiceline-1"] = {
            SoundId = 7564429272,
            Volume = 2
        },
        ["LMB-2-Voiceline-2"] = {
            SoundId = 7564431555,
            Volume = 2
        },
        ["LMB-2-Voiceline-3"] = {
            SoundId = 7564432664,
            Volume = 2
        },
        ["LMB-2-Voiceline-4"] = {
            SoundId = 7564433191,
            Volume = 2
        },
        ["LMB-2-Voiceline-5"] = {
            SoundId = 7564433724,
            Volume = 2
        },
        ["LMB-2-Voiceline-6"] = {
            SoundId = 7564434324,
            Volume = 2
        },
        SteelVoice1 = {
            SoundId = 7564277320,
            Volume = 2
        },
        SteelVoice2 = {
            SoundId = 7564278544,
            Volume = 2
        },
        SteelVoice3 = {
            SoundId = 7564293656,
            Volume = 2
        },
        ChargedSteelVoice1 = {
            SoundId = 7564316730,
            Volume = 2
        },
        ChargedSteelVoice2 = {
            SoundId = 7564314730,
            Volume = 2
        },
        CleaveVoice1 = {
            SoundId = 7564329684,
            Volume = 2
        },
        CleaveVoice2 = {
            SoundId = 7564330280,
            Volume = 2
        },
        GroundSlamCleave = {
            SoundId = 7575606064,
            Volume = 1.5
        },
        CleaveWind = {
            SoundId = 7575604911,
            Volume = 1
        },
        SoulEnter1 = {
            SoundId = 7564345556,
            Volume = 2
        },
        SoulEnter2 = {
            SoundId = 7564349690,
            Volume = 2
        },
        SoulEnter3 = {
            SoundId = 7564351387,
            Volume = 2
        },
        SoulLeave1 = {
            SoundId = 7564361418,
            Volume = 2
        },
        SoulLeave2 = {
            SoundId = 7564361891,
            Volume = 2
        },
        Fate1 = {
            SoundId = 7564374471,
            Volume = 2
        },
        Fate2 = {
            SoundId = 7564376730,
            Volume = 2
        },
        Fate3 = {
            SoundId = 7564377707,
            Volume = 2
        },
        Fate = {
            SoundId = 7575616111,
            Volume = 1.5
        },
        Sealed = {
            SoundId = 7575617840,
            Volume = 0.8
        },
        MortalSteel = {
            SoundId = 7575623770,
            Volume = 0.8
        },
        ["MortalSteel-2"] = {
            SoundId = 8053746452,
            Volume = 1
        },
        ["Max Stacks"] = {
            SoundId = 8053749820,
            Volume = 3
        },
        BarrageSFX = {
            SoundId = 7777068614,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 7777073512,
            Volume = 3
        },
        SpiritStart = {
            SoundId = 7575635391,
            Volume = 2
        },
        SpiritReturn = {
            SoundId = 7575635973,
            Volume = 2
        },
        YasuoKill = {
            SoundId = 7564524584,
            Volume = 2
        },
        YasuoDeath = {
            SoundId = 7564528622,
            Volume = 2
        },
        LegSlice = {
            SoundId = 7731164029,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 8038256094,
            Volume = 5,
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
                    SoundId = "rbxassetid://7564019187",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It\'s too late for you."
                        } }
                }, {
                    SoundId = "rbxassetid://7564009231",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Not enough to stop me."
                        } }
                }, {
                    SoundId = "rbxassetid://7564020292",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "One to cut, one to seal"
                        } }
                }, {
                    SoundId = "rbxassetid://7563987203",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Blink, and you\'ll miss your own death!"
                        } }
                }, {
                    SoundId = "rbxassetid://7563989576",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Forget the past, it only clouds the future."
                        } }
                } }
        }
    }
};