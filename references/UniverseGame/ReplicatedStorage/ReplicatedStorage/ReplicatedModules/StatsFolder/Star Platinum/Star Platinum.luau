  

 

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
local _ = ReplicatedStorage["Client Assets"];
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 24
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
end);
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
                DefaultConsoleKeybind = "ButtonX",
                DefaultDPadDirection = 0,
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                DefaultConsoleKeybind = "ButtonL1",
                DefaultDPadDirection = 0,
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                DefaultConsoleKeybind = "ButtonR1",
                DefaultDPadDirection = 0,
                Equipped = true,
                MoveCapCount = false
            },
            Summon = {
                DefaultKeybind = "Q",
                DefaultConsoleKeybind = "ButtonY",
                DefaultDPadDirection = 1,
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
            ["Grab Slam"] = {
                DefaultKeybind = "E",
                DefaultConsoleKeybind = "ButtonX+",
                DefaultDPadDirection = 0,
                State = "StandOff",
                Description = "The user summons Star Platinum to slam the target down before knocking them away.",
                Unlocked = true
            },
            Barrage = {
                DefaultKeybind = "E",
                DefaultConsoleKeybind = "ButtonX+",
                DefaultDPadDirection = 0,
                State = "StandOn",
                Description = "Star Platinum unleashes multiple blows, knocking the target away on the final hit.",
                Unlocked = true
            },
            ["Lock Kick"] = {
                DefaultKeybind = "R",
                DefaultConsoleKeybind = "ButtonB",
                DefaultDPadDirection = 0,
                State = "StandOff",
                Description = "The user pulls out a lock and hits the target with it before knocking them away.",
                Unlocked = true
            },
            ["Star Breaker"] = {
                DefaultKeybind = "R",
                DefaultConsoleKeybind = "ButtonB",
                DefaultDPadDirection = 0,
                State = "StandOn",
                Description = "Star Platinum performs a strong punch, knocking the target away.",
                Unlocked = true
            },
            ["Evil Spirit"] = {
                DefaultKeybind = "T",
                DefaultConsoleKeybind = "ButtonY",
                DefaultDPadDirection = 0,
                State = "StandOff",
                Description = "The user pulls out a revolver and shoots in a straight line.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Star Finger"] = {
                DefaultKeybind = "T",
                DefaultConsoleKeybind = "ButtonY",
                DefaultDPadDirection = 0,
                State = "StandOn",
                Description = "Star Platinum extends his fingers to pierce the target.",
                LevelRequirement = 20,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Inhale = {
                DefaultKeybind = "Y",
                DefaultConsoleKeybind = "ButtonY+",
                DefaultDPadDirection = 0,
                State = "StandOn",
                Description = "Star Platinum inhales air in, while pulling targets closer to him.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Ora Slam"] = {
                DefaultKeybind = "G",
                DefaultConsoleKeybind = "ButtonB+",
                DefaultDPadDirection = 0,
                State = "StandOn",
                Description = "Star Platinum unleashes a strong punch to the ground.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "H",
                DefaultConsoleKeybind = "ButtonY+",
                DefaultDPadDirection = 4,
                State = "StandOn",
                Description = "Star Platinum briefly stops time in a radius.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "J",
                DefaultConsoleKeybind = "ButtonY",
                DefaultDPadDirection = 4,
                Description = "Gives you the ability to move during a timestop.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Brute Force"] = {
                DefaultKeybind = "Z",
                DefaultConsoleKeybind = "ButtonB+",
                DefaultDPadDirection = 4,
                State = "StandOn",
                Description = "Star Platinum performs a small beatdown on the target.",
                LevelRequirement = 70,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Destructive Combination"] = {
                DefaultKeybind = "B",
                DefaultConsoleKeybind = "ButtonB",
                DefaultDPadDirection = 4,
                State = "StandOn",
                Description = "Star Platinum unleashes a devastating cutscene beatdown on the target.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            Teleport = {
                DefaultKeybind = "V",
                DefaultConsoleKeybind = "ButtonR1+",
                DefaultDPadDirection = 0,
                Description = "Teleports you a short distance.",
                LevelRequirement = 10,
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
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 11371980872,
            ["StandOff-LMB-2"] = 11371981731,
            ["StandOff-LMB-3"] = 11371982707,
            ["StandOff-LMB-4"] = 11371983463,
            StandBlock = 10808688837,
            StandBlockHit1 = 10808692075,
            StandBlockHit2 = 10808695355,
            StandBlockHit3 = 10808697696,
            StandBlockBreak = 10808701329,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            Grab = 10906128504,
            Throw = 10906131878,
            ThrowVictim = 10906132668,
            ["Star Breaker"] = 10603603515,
            ["Star Finger"] = 10604735658,
            ["Evil Spirit"] = 10824269024,
            ["Inhale Startup"] = 10627518398,
            ["Inhale Looped"] = 10627522140,
            Timestop = 10619893836,
            ["Ora Slam"] = 10604996457,
            AttackPoseTransition = 6568465045,
            AttackPoseLooped = 6568461661,
            Drink = 10615944161,
            GroundSlam = 6647782995,
            ["Brute Force Attempt"] = 10629787650,
            ["Brute Force Hit"] = 10629797095,
            ["Brute Force Target"] = 10629800082,
            Beatdown_Startup = 11320522791,
            Beatdown_Camera = 11320552981,
            Beatdown_UserSuccessful = 11320555645,
            Beatdown_Target = 11320554701,
            Lock_Kick = 11352124336,
            ["Grab Slam Startup"] = 11352494189,
            ["Grab Slam User"] = 11352496815,
            ["Grab Slam Target"] = 11352499254,
            PoseIdle = 10179278620,
            PoseTransition = 10179275232,
            ["Quote-1"] = 10976621202,
            ["Quote-2"] = 10976662892,
            ["Quote-3"] = 10976663588
        },
        Movement = {
            Walk = 10629833287,
            Run = 88267173546743,
            SummonedWalk = 10629833287,
            SummonedRun = 88267173546743,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 10636699829,
            Idle = 10636697572
        }
    },
    Stats = {
        Summon = {
            From = "Combat.Summon",
            LeaveParts = { "StandHumanoidRootPart" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Summoned = false
            },
            AnimationTimed = false,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 10626698543,
                        Volume = 3
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 10626763879,
                        Volume = 3
                    }
                }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher),
            ["StandOff-LMB-1"] = TableUtil.Reconcile({
                Endlag = 0.2,
                ActiveEndlag = 0.1,
                Speed = 1.5,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 1-3" }, { 19, 24, "Attack" }, { 30, "End" } },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 8,
                    Time = 0.1
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 5.5, 6),
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 10626698543,
                        Volume = 3
                    }
                }
            }, BaseStatsModule.Stand_Rush_Attack),
            ["StandOff-LMB-4"] = TableUtil.Reconcile({
                Speed = 2.25,
                Cooldown = 1,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingStandOff-LMB 4" }, { 36, 42, "Attack" }, { 48, "End" } },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 10626763879,
                        Volume = 3
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                StateChecker = function(p5, p6) -- Line: 187, Name: StateChecker
                    -- upvalues: Knit (copy), TableUtil (copy)
                    local Stats = p5.Stats;

                    if not Knit.CollectionService:HasTag(p5.Character, "Summoned") then
                        Stats = TableUtil.Copy(Stats, true);
                        Stats.CustomPrefix = "StandOff-LMB";
                    end;

                    return Stats;
                end
            }
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
        Quote = {
            From = "Combat.Quote"
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(p7, p8) -- Line: 235, Name: PoseTransition
                    -- upvalues: EnableBirthmark (copy)
                    EnableBirthmark(p7.Character, true);
                end,

                PoseEnd = function(p9, p10) -- Line: 238, Name: PoseEnd
                    -- upvalues: EnableBirthmark (copy)
                    EnableBirthmark(p9.Character, false);
                end
            }
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        ["Grab Slam"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            CheckPVPSafe = true,
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 10),
                Offset = CFrame.new(0, 0, -5)
            },
            Stun = {
                Time = 1.35
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.05
            },
            Block = {
                Blockable = false,
                PerfectBlockable = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 10969901513,
                    Volme = 5
                }
            },
            HitRemotes = { v3 },
            Slam = {
                Damage = 35,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                }
            },
            Throw = {
                Priority = Enums.Intangible.Move,
                Ragdoll = {
                    Time = 1
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
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                }
            }
        },
        Barrage = TableUtil.Reconcile({
            From = "Combat.Barrage",
            Active = true,
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hit = {
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 10626812045,
                        Volume = 3
                    }
                }
            },
            Finisher = {
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 10725853580,
                        Volume = 2
                    }
                }
            },
            ClashHit = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 10626812045,
                        Volume = 3
                    }
                }
            },
            ClashFinisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 10725853580,
                        Volume = 2
                    }
                }
            }
        }, BaseStatsModule.Stand_Barrage),
        ["Star Breaker"] = {
            Active = true,
            Damage = 30,
            HitAnimations = "Default",
            Properties = {
                Armor = true
            },
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 7,
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
            Knockback = {
                RelativePart = "Attacker",
                Speed = 60,
                Time = 0.1
            },
            Ragdoll = {
                Time = 0.75
            },
            HitSounds = {
                Hit = {
                    SoundId = 10626951281,
                    Volme = 5
                }
            },
            HitRemotes = { v4 }
        },
        ["Lock Kick"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 9,
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
            Damage = 10,
            Stun = {
                Time = 0.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.05
            },
            HitAnimations = "Default",
            HitSounds = {
                Hit = {
                    SoundId = 11381734960,
                    Volme = 5
                }
            },
            HitRemotes = { v3 },
            Finisher = {
                Damage = 30,
                HitAnimations = "Default",
                Block = {
                    BlockBreak = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 60,
                    Time = 0.1
                },
                Ragdoll = {
                    Time = 0.75
                },
                HitSounds = {
                    Hit = {
                        SoundId = 11381734908,
                        Volme = 5
                    }
                },
                HitRemotes = { v4 }
            }
        },
        ["Star Finger"] = {
            Active = true,
            Damage = 25,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 16.75),
                Offset = CFrame.new(0, 0, -8.25)
            },
            Stun = {
                Time = 1.5
            },
            Knockback = {
                RelativeTowards = "Attacker",
                Speed = 5,
                Time = 0.05
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 10976696419,
                    Volme = 5
                }
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/FingerHitVFX",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } }
        },
        ["Evil Spirit"] = {
            Active = true,
            Damage = 40,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Block = {
                PerfectBlockable = false,
                BlockBreak = true
            },
            CollisionSounds = {
                Default = {
                    ID = 7172258964,
                    Props = {
                        Volume = 3,
                        RollOffMaxDistance = 60
                    }
                }
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 36,
                Time = 0.1
            },
            Ragdoll = {
                Time = 0.75
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/GunHitVFX",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } },
            HitSounds = {
                Hit = {
                    SoundId = 10626900537,
                    Volme = 3
                }
            }
        },
        Inhale = {
            MinSpeed = 0,
            Speed = 15,
            MaxDistance = 7.5,
            Active = true,
            CheckPVPSafe = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 15),
                Offset = CFrame.new(0, 0, -7.5)
            },
            Stun = {
                Time = 0.6
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true
            },
            Knockback = {
                RelativeTowards = "Attacker",
                Time = 0.1
            }
        },
        Timestop = {
            Active = true,
            Speed = 0.65,
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
            Sequence = {
                { 0, "PlayAnim", "Timestop" },
                { 0, function(p11, p12, p13) -- Line: 738
                        -- upvalues: u1 (ref)
                        local v14 = p13.TimestopData.Character.Humanoid.Health <= p13.TimestopData.Character.Humanoid.MaxHealth / 3;
                        local v15 = u1.GetSound(p13.TimestopData.Character, "Timestop Voiceline (Low)");

                        if v14 and v15 then
                            v15:Play();

                            return;
                        end;

                        u1.PlaySound(p13.TimestopData.Character, "Timestop Voiceline");
                    end },
                { 0, "CreateTag", "MaxWalkSpeed", 0 },
                { 0, "CreateTag", "MaxJumpPower", 0 },
                { 54, "Timestop" },
                { 95, "End" }
            },
            Meter = {
                RequiredLevel = 2,
                RemoveMeter = false
            },
            Timestop = {
                Time = 6,
                Size = 150,
                StopSounds = { "Timestop SFX" },
                ResumeSounds = { "Timestop End SFX", "Timestop End Voiceline" }
            }
        },
        ["Timestop Movement"] = {
            From = "Combat.Timestop Movement"
        },
        ["Ora Slam"] = {
            Active = true,
            Damage = 45,
            HitAnimations = "Default",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = true
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 9,
                Offset = CFrame.new(0, 0, -6)
            },
            Block = {
                BlockBreak = true
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 35,
                Time = 0.1,
                Velocity = Vector3.new(0, 40, 0)
            },
            Ragdoll = {
                Time = 1
            },
            HitSounds = {
                Hit = {
                    SoundId = 10627143930,
                    Volme = 3
                }
            },
            HitRemotes = { v3 }
        },
        Drink = {
            Active = true,
            Heal = 25,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = false
            },
            Cooldown = {
                Time = 30,
                AfterMove = true
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Attacker",
                            Path = "Particles/SPHeal",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } }
        },
        ["Destructive Combination"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Meter = {
                RequiredLevel = 3,
                MeterGain = 0
            },
            Active = true,
            CheckPVPSafe = true,
            Cooldown = {
                Time = 60,
                AfterMove = true
            },
            Hitbox = {
                Size = Vector3.new(6, 6, 7.5),
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                Unblockable = true
            },
            Hit = {
                Damage = 1.5,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v3 }
            },
            FinalHit = {
                Damage = 1.5,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v3 }
            },
            Heavy = {
                Damage = 21.5,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v4 }
            },
            Head = {
                Damage = 20,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/HeadHit",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    } }
            },
            Finisher = {
                Priority = Enums.Intangible.Move,
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
                    Time = 1
                },
                Block = {
                    Unblockable = true
                },
                HitRemotes = { v4 }
            }
        },
        ["Brute Force"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Active = true,
            CheckPVPSafe = true,
            Cooldown = {
                Time = 18.25,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 6, 6),
                Offset = CFrame.new(0, 0, -4.25)
            },
            Block = {
                Blockable = false,
                PerfectBlockable = true
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.True
            },
            Hit = {
                Damage = 13.5,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                },
                HitRemotes = { v3 }
            },
            Finisher = {
                Damage = 20,
                Priority = Enums.Intangible.Move,
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 60,
                    Time = 0.1,
                    Velocity = Vector3.new(0, 40, 0)
                },
                Ragdoll = {
                    Time = 1
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                },
                HitRemotes = { v4 }
            }
        },
        Teleport = {
            From = "Combat.Teleport"
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 10627025313,
            Volume = 2
        },
        SummonSound = {
            SoundId = 10627024672,
            Volume = 2
        },
        Desummon = {
            SoundId = 10919859486,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 10626679838,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 10626680300,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 10626680773,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 10626764348,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 10626679838,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 10626680300,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 10626680773,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 10626764348,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        Teleport = {
            SoundId = 6773724319,
            Volume = 1
        },
        Grab = {
            SoundId = 10906275061,
            Volume = 2
        },
        Grabbed = {
            SoundId = 10906275262,
            Volume = 2
        },
        Throw = {
            SoundId = 10906545315,
            Volume = 2
        },
        ThrowVoiceline = {
            SoundId = 10626951737,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 10824345295,
            Volume = 1.25
        },
        Barrage = {
            SoundId = 10835571201,
            Volume = 1.25
        },
        ClashVoiceline = {
            SoundId = 10891682269,
            Volume = 0.85
        },
        Clash = {
            SoundId = 10891681787,
            Volume = 0.65
        },
        LockDiscard = {
            SoundId = 10626951737,
            Volume = 0
        },
        ["Star Breaker Voiceline"] = {
            SoundId = 10626951737,
            Volume = 2
        },
        ["Star Breaker Whoosh"] = {
            SoundId = 10626952420,
            Volume = 2
        },
        ["Star Finger Voiceline"] = {
            SoundId = 10627078121,
            Volume = 2
        },
        ["Star Finger Whoosh"] = {
            SoundId = 10627078565,
            Volume = 2
        },
        ["Evil Spirit Voiceline"] = {
            SoundId = 10626883212,
            Volume = 2
        },
        ["Evil Spirit Equip"] = {
            SoundId = 10626883951,
            Volume = 2
        },
        ["Evil Spirit Shoot"] = {
            SoundId = 10626885285,
            Volume = 2
        },
        Inhale = {
            SoundId = 10725855039,
            Volume = 2
        },
        ["Inhale Voiceline"] = {
            SoundId = 10725854283,
            Volume = 2
        },
        ["Timestop Voiceline"] = {
            SoundId = 10636575952,
            Volume = 2
        },
        ["Timestop End Voiceline"] = {
            SoundId = 10636576633,
            Volume = 2
        },
        ["Timestop SFX"] = {
            SoundId = 10920655014,
            Volume = 3
        },
        ["Timestop End SFX"] = {
            SoundId = 10920655226,
            Volume = 2
        },
        ["Ora Slam Voiceline"] = {
            SoundId = 10627143116,
            Volume = 2
        },
        ["Ora Slam Whoosh"] = {
            SoundId = 10627144734,
            Volume = 2
        },
        ["Ora Slam SFX"] = {
            SoundId = 10627624630,
            Volume = 2
        },
        ["Brute Force Grab"] = {
            SoundId = 10725855893,
            Volume = 2
        },
        ["Brute Force Grab Voiceline"] = {
            SoundId = 10725855533,
            Volume = 2
        },
        ["Brute Force"] = {
            SoundId = 10725856287,
            Volume = 2
        },
        ["Brute Force Voiceline"] = {
            SoundId = 10725856568,
            Volume = 2
        },
        ["Can Open"] = {
            SoundId = 10627730232,
            Volume = 2
        },
        ["Can Voiceline"] = {
            SoundId = 10627730933,
            Volume = 2
        },
        ["Drink Sound"] = {
            SoundId = 3637899507,
            Volume = 1.5
        },
        ["Drink Heal"] = {
            SoundId = 10627731562,
            Volume = 2
        },
        BeatdownAttempt = {
            SoundId = 11320643652,
            Volume = 2
        },
        Beatdown = {
            SoundId = 11320643845,
            Volume = 2
        },
        GrabSlamVoice = {
            SoundId = 11372208033,
            Volume = 2
        },
        GrabSlamWoosh = {
            SoundId = 11372207952,
            Volume = 2
        },
        GrabSlam = {
            SoundId = 11372208149,
            Volume = 2
        },
        GrabSlamVoicelineHit = {
            SoundId = 11372208254,
            Volume = 2
        },
        LockKickWoosh = {
            SoundId = 11381734994,
            Volume = 2
        },
        LockKickVoice = {
            SoundId = 11381741912,
            Volume = 2
        },
        LockKickDiscard = {
            SoundId = 11381735025,
            Volume = 2
        },
        DeathSound = {
            SoundId = 6717175820,
            Volume = 3
        },
        BarrageSFX = {
            SoundId = 6720651784,
            Volume = 1,
            PlaybackSpeed = 1
        },
        MeterUp3 = {
            SoundId = 10927465503,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 10927466258,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 9061921498,
            Volume = 2
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
                    SoundId = "rbxassetid://7259089971",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I told you I\'d fight, and I\'m a man of my word."
                        } }
                }, {
                    SoundId = "rbxassetid://10976696873",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You really ticked me off."
                        } }
                }, {
                    SoundId = "rbxassetid://7259114233",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Good grief."
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p16) -- Line: 1802, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p16.Player;
            local Character = p16.Character;
            local SkinName = p16.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v17 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v17.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v17;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};