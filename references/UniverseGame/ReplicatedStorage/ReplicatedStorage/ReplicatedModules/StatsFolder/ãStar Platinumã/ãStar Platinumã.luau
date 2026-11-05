  

 

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

if game:GetService("RunService"):IsServer() then
    Knit.OnStart():andThen(function() -- Line: 24
        -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy), u2 (ref)
        u1 = Knit.GetService("EffectService");
        u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    end);
end;

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
            ["Grab Slam"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Description = "The user summons Star Platinum to slam the target down before knocking them away.",
                Unlocked = true
            },
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Description = "Star Platinum unleashes multiple blows, knocking the target away on the final hit.",
                Unlocked = true
            },
            ["Lock Kick"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Description = "The user pulls out a lock and hits the target with it before knocking them away.",
                Unlocked = true
            },
            ["Star Breaker"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Description = "Star Platinum performs a strong punch, knocking the target away.",
                Unlocked = true
            },
            ["Evil Spirit"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "The user pulls out a revolver and shoots in a straight line.",
                Unlocked = true
            },
            ["Star Finger"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Star Platinum extends his fingers to pierce the target.",
                Unlocked = true
            },
            Inhale = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Star Platinum inhales air in, while pulling targets closer to him.",
                Unlocked = true
            },
            ["Ora Slam"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Star Platinum unleashes a strong punch to the ground.",
                Unlocked = true
            },
            Timestop = {
                DefaultKeybind = "H",
                State = "StandOn",
                Description = "Star Platinum briefly stops time in a radius.",
                Unlocked = true
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "J",
                Description = "Gives you the ability to move during a timestop.",
                Unlocked = true
            },
            ["Brute Force"] = {
                DefaultKeybind = "Z",
                State = "StandOn",
                Description = "Star Platinum performs a small beatdown on the target.",
                Unlocked = true
            },
            ["Destructive Combination"] = {
                DefaultKeybind = "B",
                State = "StandOff",
                Description = "Star Platinum unleashes a devastating cutscene beatdown on the target.",
                Unlocked = true
            },
            ["Raging Demon"] = {
                DefaultKeybind = "B+",
                State = "StandOff",
                Description = "Star Platinum\'s User unleashes a devastating cutscene beatdown on the target. Never seen before!",
                Unlocked = true
            },
            ["Star Drink"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Star Platinum flavored Drink!",
                Unlocked = true
            },
            ["Imaginary Technique: Purple"] = {
                DefaultKeybind = "H+",
                State = "StandOff",
                Description = "Star Platinum unleashes the Imaginary Technique.",
                Unlocked = true
            },
            ["Ora Beatdown"] = {
                DefaultKeybind = "B",
                State = "StandOn",
                Description = "Star Platinum unleashes a devastating cutscene beatdown on the target, doesn\'t get more creative than that!",
                Unlocked = true
            },
            ["SPTW Beatdown"] = {
                DefaultKeybind = "B+",
                State = "StandOn",
                Description = "Star Platinum unleashes a devastating cutscene beatdown on the target, how original!",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "\"Ugly Watch..\""
                }
            },
            ["Skull Crusher"] = {
                DefaultKeybind = "V+",
                Description = "Star Platinum teleports behind the target to deliver a heavy punch into their head.",
                Unlocked = true
            },
            ["Platinum Slam"] = {
                DefaultKeybind = "T+",
                State = "StandOn",
                Description = "Star Platinum uses the strength of his entire body to slam the ground.",
                Unlocked = true
            },
            ["Kick Barrage"] = {
                DefaultKeybind = "G+",
                Description = "Star Platinum unleashes a swift flurry of kicks.",
                Unlocked = true
            },
            ["YBA Essence"] = {
                DefaultKeybind = "H+",
                State = "StandOn",
                Description = "Star Platinum awakens its true potential.",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Consuming Flames"
                }
            },
            ["Palm Reversal"] = {
                DefaultKeybind = "H",
                State = "StandOff",
                Description = "Star Platinum prepares a devastating open palm counter.",
                Unlocked = true
            },
            ["Heaven\'s Judgement"] = {
                DefaultKeybind = "Z+",
                Description = "Star Platinum engolves itself in its pure speed.",
                Unlocked = true
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleports you a short distance.",
                Unlocked = true
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
            Drink = 6473199424,
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
            ["Quote-3"] = 10976663588,
            ["Plat Slam"] = 105537763651304,
            ["Plat Judgement"] = 129587685751727,
            ["Plat Kick Barrage"] = 134764531103333,
            ["Plat Awakening"] = 86316987361680,
            ["Plat BD Start"] = 95430576200561,
            ["Plat BD User"] = 121522508064672,
            ["Plat BD Target"] = 89263277675827,
            ["Plat BD Camera"] = 129268903530340,
            BeatdownUser = 6718445417,
            BeatdownVictim = 6718397667,
            BeatdownPunch = 10446639889,
            ["Raging Demon Startup"] = 13319340708,
            ["Raging Demon Success"] = 13319335609,
            ["Raging Demon Target"] = 13319333146,
            ["Raging Demon Camera"] = 13319334137,
            HollowPurpleStartup = 15577277893,
            HollowPurpleLoop = 15568321058,
            HollowPurpleFire = 15568309187,
            Counter = 13260823303,
            CounterAttack = 13260823908,
            CounterVictim = 13260824530
        },
        Movement = {
            Walk = 10629833287,
            Run = 7331835388,
            SummonedWalk = 10629833287,
            SummonedRun = 7331835388,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            SummonedIdle = 120289012305370,
            Idle = 10636697572
        }
    },
    Stats = {
        Summon = {
            From = "Combat.Summon",
            LeaveParts = { "StandHumanoidRootPart" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 39, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(56, 169, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            Callbacks = {
                Summon = function(p5) -- Line: 74, Name: Summon
                    -- upvalues: u2 (ref)
                    p5.Character.Stand.StandAura.Adornee = p5.Character.Stand;
                    p5.Character.Stand.StandAura.Enabled = true;

                    if p5.Character:GetAttribute("StarMode") then
                        for _, descendant in p5.Character.Stand:GetDescendants() do
                            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and (descendant.Name == "AwakeningVFX" or descendant.Parent.Name == "AwakeningVFX") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end;

                    if u2 then
                        u2.PlaySound(p5.Character, "AwakeningAura-" .. (p5.Character:GetAttribute("StarMode") and "On" or "Off"));
                    end;
                end,

                Desummon = function(p6) -- Line: 90, Name: Desummon
                    -- upvalues: u2 (ref)
                    p6.Character.Stand.StandAura.Adornee = nil;
                    p6.Character.Stand.StandAura.Enabled = false;

                    if p6.Character:GetAttribute("StarMode") then
                        for _, descendant in p6.Character.Stand:GetDescendants() do
                            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and (descendant.Name == "AwakeningVFX" or descendant.Parent.Name == "AwakeningVFX") then
                                descendant.Enabled = false;
                            end;
                        end;
                    end;

                    if u2 then
                        u2.StopSound(p6.Character, "AwakeningAura-Off");
                        u2.StopSound(p6.Character, "AwakeningAura-On");
                    end;
                end
            }
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
                TrueDamage = true,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 4096811583,
                        Volume = 2
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                TrueDamage = true,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 4096811583,
                        Volume = 2,
                        PlaybackSpeed = 1.25
                    }
                }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher),
            ["StandOff-LMB-1"] = TableUtil.Reconcile({
                Endlag = 0.2,
                ActiveEndlag = 0.1,
                Speed = 1.5,
                TrueDamage = true,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 19, 24, "Attack" }, { 30, "End" } },
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
                        SoundId = 4096811583,
                        Volume = 2,
                        PlaybackSpeed = 1.25
                    }
                }
            }, BaseStatsModule.Stand_Rush_Attack),
            ["StandOff-LMB-4"] = TableUtil.Reconcile({
                Speed = 2.25,
                Cooldown = 1,
                TrueDamage = true,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 36, 42, "Attack" }, { 48, "End" } },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 4096811583,
                        Volume = 2,
                        PlaybackSpeed = 0.8
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                StateChecker = function(p7, p8) -- Line: 235, Name: StateChecker
                    -- upvalues: Knit (copy), TableUtil (copy)
                    local Stats = p7.Stats;

                    if not Knit.CollectionService:HasTag(p7.Character, "Summoned") then
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
            TrueDamage = true,
            Grab = {
                TrueDamage = true,
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
                    } }
            },
            Throw = {
                TrueDamage = true,
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 4096811583,
                        Volume = 2,
                        PlaybackSpeed = 0.8
                    }
                }
            }
        },
        Quote = {
            From = "Combat.Quote"
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(p9, p10) -- Line: 294, Name: PoseTransition
                    -- upvalues: EnableBirthmark (copy), u2 (ref)
                    EnableBirthmark(p9.Character, true);

                    if u2 and p9.Character:GetAttribute("StarMode") then
                        u2.StopSound(p9.Character, "AwakeningMusic");
                    end;
                end,

                Transformer = function(p11) -- Line: 301, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v12 = TableUtil.Copy(p11.Stats, true);
                    v12.PoseMusic = "PoseMusic" .. (Knit.CollectionService:HasTag(p11.Character, "Summoned") and "" or "-Off");

                    return v12;
                end,

                PoseEnd = function(p13, p14) -- Line: 307, Name: PoseEnd
                    -- upvalues: EnableBirthmark (copy), u2 (ref)
                    EnableBirthmark(p13.Character, false);

                    if u2 and p13.Character:GetAttribute("StarMode") then
                        u2.PlaySound(p13.Character, "AwakeningMusic");
                    end;
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
            TrueDamage = true,
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
                Blockable = false
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
                TrueDamage = true,
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
            TrueDamage = true,
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hit = {
                TrueDamage = true,
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 4096811583,
                        Volume = 2
                    }
                }
            },
            Finisher = {
                TrueDamage = true,
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 4096811583,
                        Volume = 2,
                        PlaybackSpeed = 0.9
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
            TrueDamage = true,
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
                    SoundId = 2319521125,
                    Volme = 5.5
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
            TrueDamage = true,
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
                    SoundId = 4096811583,
                    Volume = 2,
                    PlaybackSpeed = 0.9
                }
            },
            HitRemotes = { v3 },
            Finisher = {
                Damage = 30,
                TrueDamage = true,
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
                        SoundId = 4096811583,
                        Volume = 2,
                        PlaybackSpeed = 1.2
                    }
                },
                HitRemotes = { v4 }
            }
        },
        ["Star Finger"] = {
            Active = true,
            Damage = 20,
            TrueDamage = true,
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
                Size = Vector3.new(8, 8, 14),
                Offset = CFrame.new(0, 0, -7)
            },
            Stun = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.05
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 4134502335,
                    Volme = 6
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
            TrueDamage = true,
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
                Time = 0.45
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
                Summoned = true
            },
            Cooldown = {
                Name = "Timestop",
                Time = 60,
                AfterMove = true
            },
            Sequence = { { 0, "PlayAnim", "Timestop" }, { 0, "PlaySound", "Timestop Voiceline" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 54, "Timestop" }, { 95, "End" } },
            Meter = {
                RequiredLevel = 2,
                RemoveMeter = false
            },
            Timestop = {
                Time = 8,
                Size = 150,
                StopSounds = { "Timestop SFX" },
                ResumeSounds = { "Timestop End SFX", "Timestop End Voiceline" },
                Callbacks = {
                    Stop = function(p15, p16) -- Line: 843, Name: Stop
                        -- upvalues: u1 (ref), u2 (ref)
                        u1.FireClient(p15.Player, "PlaySoundGlobal", u2.FetchSound(p15.Character, "TimeStopTicking"), { p15.Player }, p16.Time * 3);
                    end,

                    Resume = function(p17, p18) -- Line: 846, Name: Resume
                        -- upvalues: u1 (ref), u2 (ref)
                        u1.FireClient(p17.Player, "StopSoundGlobal", u2.FetchSound(p17.Character, "TimeStopTicking"), { p17.Player });
                    end,

                    CharacterStopped = function(p19, p20, p21) -- Line: 849, Name: CharacterStopped
                        -- upvalues: u1 (ref), u2 (ref)
                        local v22 = game:GetService("Players"):GetPlayerFromCharacter(p19);
                        u1.FireClient(v22, "PlaySoundGlobal", u2.FetchSound(p20.Character, "TimeStopTicking"), { v22 }, p21.Time * 3);
                    end,

                    CharacterResumed = function(p23, p24, p25) -- Line: 854, Name: CharacterResumed
                        -- upvalues: u1 (ref), u2 (ref)
                        local v26 = game:GetService("Players"):GetPlayerFromCharacter(p23);
                        u1.FireClient(v26, "StopSoundGlobal", u2.FetchSound(p24.Character, "TimeStopTicking"), { v26 });
                    end
                }
            }
        },
        ["Timestop Movement"] = {
            From = "Combat.Timestop Movement"
        },
        ["Ora Slam"] = {
            Active = true,
            Damage = 45,
            TrueDamage = true,
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
                Speed = 50,
                Time = 0.1,
                Velocity = Vector3.new(0, 25, 0)
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
        ["Destructive Combination"] = {
            Actionable = {
                Active = true,
                Summoned = false
            },
            Meter = {
                RequiredLevel = 2,
                MeterGain = 0
            },
            Active = true,
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
                Damage = 2,
                TrueDamage = true,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v3 }
            },
            Heavy = {
                Damage = 20,
                TrueDamage = true,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v4 }
            },
            Head = {
                Damage = 17.5,
                TrueDamage = true,
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
                TrueDamage = true,
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
        ["Ora Beatdown"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Meter = {
                RequiredLevel = 3,
                MeterGain = 0
            },
            Active = true,
            Cooldown = {
                Time = 60,
                AfterMove = true
            },
            Hitbox = {
                Size = Vector3.new(6, 6, 10),
                Offset = CFrame.new(0, 0, -6)
            },
            Block = {
                Unblockable = true
            },
            Hit = {
                Damage = 1.1,
                TrueDamage = true,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 10626698543,
                        Volume = 2.5
                    }
                }
            },
            Starter = {
                Damage = 5,
                TrueDamage = true,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 10976696419,
                        Volume = 2
                    }
                }
            },
            Heavy = {
                Damage = 18,
                TrueDamage = true,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 2319521125,
                        Volume = 2
                    }
                }
            },
            Finisher = {
                Damage = 35,
                TrueDamage = true,
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
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 10626763879,
                        Volume = 3
                    }
                }
            }
        },
        ["Brute Force"] = {
            Actionable = {
                Active = true,
                Summoned = true
            },
            Active = true,
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
            Stun = {
                Time = 1,
                Priority = Enums.Stun.True
            },
            Hit = {
                Damage = 13.5,
                TrueDamage = true,
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
                TrueDamage = true,
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
        ["Skull Crusher"] = {
            Active = true,
            Damage = 30,
            TrueDamage = true,
            Priority = Enums.Intangible.Quickstep,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                Manual = true
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 25,
                RemoveMeter = false
            },
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 0.75,
                Priority = Enums.Stun.Medium
            },
            Ragdoll = {
                Time = 0.75
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            HitRemotes = { v4 },
            HitSounds = {
                Hit = {
                    SoundId = 14343736313,
                    Volume = 2
                }
            },
            Mini = {
                Block = {
                    PerfectBlockable = false,
                    Unblockable = true,
                    BypassCounter = true,
                    BlockCancel = true
                },
                Stun = {
                    Time = 0.15,
                    Priority = Enums.Stun.Medium
                }
            },
            Detect = {
                Hitbox = {
                    Type = "Magnitude",
                    Size = 32.5
                },
                Block = {
                    PerfectBlockable = false,
                    BypassCounter = true,
                    Unblockable = true
                }
            }
        },
        ["Heaven\'s Judgement"] = {
            Active = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1,
                MeterGain = 0
            },
            Dash = {
                Damage = 5,
                TrueDamage = true,
                Block = {
                    PerfectBlockable = true,
                    Blockable = true
                },
                Stun = {
                    Time = 1.5,
                    Priority = Enums.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Target",
                    Time = 0.1,
                    Speed = 0,
                    Velocity = Vector3.new(0, 2, 0)
                },
                Hitbox = {
                    Size = Vector3.new(45, 45, 45)
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 4134502335,
                        Volume = 1
                    }
                }
            },
            Finale = {
                Damage = 21.5,
                TrueDamage = true,
                Hitbox = {
                    Size = Vector3.new(25, 25, 100)
                },
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 100,
                    Time = 0.2,
                    Velocity = Vector3.new(0, 40, 0)
                },
                Block = {
                    PerfectBlockable = false,
                    Unblockable = true
                },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 4134502335,
                        Volume = 1
                    }
                }
            }
        },
        ["Platinum Slam"] = {
            Active = true,
            Damage = 30,
            TrueDamage = true,
            HitAnimations = "Default",
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 9,
                Offset = CFrame.new(0, 0, -5)
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = true
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 40,
                Time = 0.15,
                Velocity = Vector3.new(0, 40, 0)
            },
            Ragdoll = {
                Time = 1
            },
            HitSounds = {
                Hit = {
                    SoundId = 168586621,
                    Volme = 1.5
                }
            },
            HitRemotes = { v3 }
        },
        ["Star Drink"] = {
            Active = true,
            Heal = 50,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = false
            },
            Cooldown = {
                Time = 25,
                AfterMove = true
            }
        },
        ["Kick Barrage"] = {
            Active = true,
            Actionable = {
                Active = true,
                Summoned = false
            },
            Cooldown = {
                Time = 9,
                AfterMove = true
            },
            Hitbox = {
                Size = Vector3.new(8, 8, 9.5),
                Offset = CFrame.new(0, 0, -4.5)
            },
            Hit = {
                TrueDamage = true,
                Damage = 2.5,
                HitRemotes = { v3 },
                Block = {
                    Blockable = true,
                    PerfectBlockable = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 3.5,
                    Time = 0.05
                },
                HitSounds = {
                    Hit = {
                        SoundId = 4096811583,
                        Volume = 2,
                        PlaybackSpeed = 1.1
                    }
                },
                Stun = {
                    Time = 0.6,
                    Priority = Enums.Stun.Medium
                }
            },
            Finisher = {
                TrueDamage = true,
                Damage = 20,
                HitRemotes = { v4 },
                Block = {
                    BlockBreak = true,
                    PerfectBlockable = false
                },
                HitSounds = {
                    Hit = {
                        SoundId = 2319521125,
                        Volme = 5
                    }
                },
                Stun = {
                    Time = 0.3
                },
                Ragdoll = {
                    Time = 0.3
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                }
            }
        },
        ["SPTW Beatdown"] = {
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = true
            },
            Cooldown = {
                Time = 60,
                AfterMove = true
            },
            Meter = {
                MeterGain = 0,
                RequiredLevel = 2
            },
            Grab = {
                TrueDamage = true,
                Damage = 5,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Offset = CFrame.new(0, 0, -4)
                },
                Block = {
                    Unblockable = true
                }
            },
            Hit = {
                TrueDamage = true,
                Damage = 1.5,
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7243326637,
                        Volme = 1
                    }
                },
                HitRemotes = { v3 }
            },
            Throw = {
                TrueDamage = true,
                Damage = 15,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.3
                },
                KnockbackData = { {
                        Type = "Velocity",
                        RelativePart = "Attacker",
                        Velocity = Vector3.new(0, 35, 0),
                        Speed = 85,
                        Time = 0.3
                    }, {
                        Type = "AngularVelocity",
                        RelativePart = "Attacker",
                        RelativeVelocity = Vector3.new(12, 0, 0),
                        Time = 0.3
                    } },
                Ragdoll = {
                    Time = 1
                },
                Block = {
                    Unblockable = true
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7243326637,
                        Volme = 5
                    }
                }
            }
        },
        ["YBA Essence"] = {
            Active = true,
            Actionable = {
                Active = true,
                Summoned = true
            },
            Cooldown = {
                Time = 0.1,
                Manual = true
            }
        },
        Teleport = {
            From = "Combat.Teleport"
        },
        ["Raging Demon"] = {
            Priority = Enums.Intangible.Ragdoll,
            Frequency = 4,
            Meter = {
                RequiredAmount = 50
            },
            Actionable = {
                Active = true,
                Summoned = false
            },
            Active = true,
            Cooldown = {
                Time = 60,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 12),
                HitboxType = "ClientHitbox",
                Offset = CFrame.new(0, 0, -6)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitRemotes = { v3 },
            Hit = {
                TrueDamage = true,
                Damage = 1.5,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v3 }
            },
            Impact = {
                TrueDamage = true,
                Damage = 1.5,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = {
                    v4,
                    {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Impact",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    }
                }
            },
            Finisher = {
                TrueDamage = true,
                Damage = 31,
                Priority = Enums.Intangible.Move,
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 55,
                    Time = 0.15
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                HitRemotes = { v4 }
            }
        },
        ["Imaginary Technique: Purple"] = {
            Active = true,
            Actionable = {
                Active = true,
                Summoned = false
            },
            Meter = {
                RequiredLevel = 4,
                RemoveMeter = true
            },
            Cooldown = {
                Time = 60,
                AfterMove = true
            },
            Projectile = {
                TrueDamage = true,
                Damage = 200,
                HitAnimations = "Default",
                Meter = false,
                Priority = Enums.Intangible.Quickstep,
                Stun = {
                    Time = 2
                },
                Ragdoll = {
                    Time = 2.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    BypassCounter = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 100,
                    Time = 0.1
                }
            }
        },
        ["Palm Reversal"] = {
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = false
            },
            Cooldown = {
                Time = 18,
                AfterMove = true
            },
            Countered = {
                HitAnimations = "Default",
                Stun = {
                    Time = 0.75,
                    Priority = Enums.Stun.Medium
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    BlockCancel = true,
                    PerfectBlockCancel = true
                }
            },
            Attack = {
                TrueDamage = true,
                Damage = 35,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 0.3,
                    Priority = Enums.Stun.Medium
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    BlockCancel = true,
                    PerfectBlockCancel = true
                },
                HitRemotes = { v4 },
                HitSounds = {
                    Hit = {
                        SoundId = 4096811583,
                        Volume = 2,
                        PlaybackSpeed = 0.9
                    }
                }
            },
            Release = {
                Priority = Enums.Intangible.Move,
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 52,
                    Time = 0.1
                },
                Ragdoll = {
                    Time = 1.25,
                    Override = true
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    BlockCancel = true,
                    PerfectBlockCancel = true
                }
            }
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 10627025313,
            Volume = 2
        },
        SummonSound = {
            SoundId = 14343734745,
            Volume = 0.9
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
            SoundId = 4096810926,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 4096810926,
            Volume = 2,
            PlaybackSpeed = 0.9
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
            SoundId = 3477214701,
            Volume = 2
        },
        ["Star Breaker Whoosh"] = {
            SoundId = 231731980,
            Volume = 1.5
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
            SoundId = "",
            Volume = 0
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
            SoundId = 4751215000,
            Volume = 3.5
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
            SoundId = 134955973358561,
            Volume = 3,
            Looped = true,
            PlaybackSpeed = 1.444,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 109.9),
            LoopRegion = NumberRange.new(45.35, 109.9)
        },
        ["PoseMusic-Off"] = {
            SoundId = 78037838976767,
            Volume = 3,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(1, 117),
            LoopRegion = NumberRange.new(1, 117)
        },
        ["Awakening-SFX"] = {
            SoundId = 6029007237,
            Volume = 4.5
        },
        ["Awakening-Voiceline"] = {
            SoundId = 4842298860,
            Volume = 4.5
        },
        ["Awakening-Voiceline2"] = {
            SoundId = 565208983,
            Volume = 1
        },
        ["AwakeningAura-On"] = {
            SoundId = 85709562960303,
            Looped = true,
            Volume = 1.25
        },
        ["AwakeningAura-Off"] = {
            SoundId = 131792210419754,
            Looped = true,
            Volume = 0.35
        },
        AwakeningMusic = {
            SoundId = 9061921498,
            Volume = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(139, 293.5),
            LoopRegion = NumberRange.new(139.6, 293.5)
        },
        ["BD Ora"] = {
            SoundId = 5585054247,
            Volume = 2,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.1, 600000)
        },
        ["BD Yare"] = {
            SoundId = 3052256550,
            Volume = 2,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.85, 600000)
        },
        ["BD Callout"] = {
            SoundId = 6186240927,
            Volume = 2,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.25, 600000)
        },
        ["BD Barrage"] = {
            SoundId = 4632123987,
            Volume = 6
        },
        ["BD Finisher"] = {
            SoundId = 5867741895,
            Volume = 2
        },
        ["Judgement Bass"] = {
            SoundId = 6240870847,
            Volume = 2.5
        },
        ["Judgement Startup"] = {
            SoundId = 6240870544,
            Volume = 2
        },
        ["Judgement End"] = {
            SoundId = 6240871814,
            Volume = 2
        },
        ["Skull Crusher SFX"] = {
            SoundId = 4725629903,
            Volume = 3.5
        },
        ["Skull Crusher Voiceline"] = {
            SoundId = 6032844827,
            Volume = 3.25
        },
        ["Kick Barrage Voiceline"] = {
            SoundId = 7217914447,
            Volume = 2
        },
        ["Kick Barrage TP"] = {
            SoundId = 6995341122,
            PlaybackSpeed = 1.15,
            Volume = 1
        },
        ["Kick Barrage Swoosh"] = {
            SoundId = 231731980,
            PlaybackSpeed = 0.5,
            Volume = 1.5
        },
        ["Platinum Slam SFX"] = {
            SoundId = 4817069589,
            Volume = 2
        },
        ["SPTW Beatdown"] = {
            SoundId = 14343735971,
            Volume = 1
        },
        ["SPTW Beatdown Voiceline"] = {
            SoundId = 14343735649,
            Volume = 1
        },
        Drink = {
            SoundId = 3637899507,
            Volume = 5
        },
        DrinkVoiceline = {
            SoundId = 6470652524,
            Volume = 3
        },
        CanOpen = {
            SoundId = 6470651681,
            Volume = 5
        },
        HealSound = {
            SoundId = 5608190766,
            Volume = 4,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0.12, 600000)
        },
        ["Raging Demon"] = {
            SoundId = 13328806126,
            Volume = 2
        },
        ["Raging Demon Voiceline"] = {
            SoundId = 13328805793,
            Volume = 2
        },
        ["Raging Demon Cutscene"] = {
            SoundId = 13328804935,
            Volume = 2
        },
        ["Raging Demon Voiceline Cutscene"] = {
            SoundId = 13328805593,
            Volume = 2
        },
        HollowPurpleStartup = {
            SoundId = 15577389062,
            Volume = 2
        },
        HollowPurpleShoot = {
            SoundId = 15577447374,
            Volume = 2
        },
        HollowPurpleLoop = {
            SoundId = 15282657490,
            RollOffMaxDistance = 10000,
            RollOffMinDistance = 36,
            Volume = 2
        },
        HollowPurpleVoiceline = {
            SoundId = 15577496510,
            Volume = 3.75
        },
        CounterStartup = {
            SoundId = 13288866997,
            Volume = 2
        },
        CounterStartupVoiceline = {
            SoundId = 6863633231,
            Volume = 2,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 1)
        },
        CounterSFX = {
            SoundId = 6706982465,
            Volume = 2
        },
        CounterVoicelineHit = {
            SoundId = 6541267000,
            Volume = 3
        },
        CounterVoiceline = {
            SoundId = 14343735649,
            Volume = 2,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(10.9, 11.5)
        },
        TimeStopTicking = {
            SoundId = 9160455871,
            Volume = 8.5,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 6),
            LoopRegion = NumberRange.new(0, 6),
            SoundEffects = {
                DistortionSoundEffect = {
                    Level = 0.2,
                    Priority = 1
                },
                ReverbSoundEffect = {
                    WetLevel = 7,
                    Priority = 2,
                    DecayTime = 20,
                    Density = 1,
                    Diffusion = 1,
                    DryLevel = 10
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
            Universal = {
                {
                    SoundId = "rbxassetid://7259089971",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I told you I\'d fight, and I\'m a man of my word."
                        } }
                },
                {
                    SoundId = "rbxassetid://10976696873",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You really ticked me off."
                        } }
                },
                {
                    SoundId = "rbxassetid://7259114233",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Good grief."
                        } }
                },
                {
                    SoundId = "rbxassetid://10614899351",
                    SoundVolume = 5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "🗿"
                        } }
                },
                {
                    SoundId = "rbxassetid://13528416394",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "FOUR OF A KIND"
                        } }
                },
                {
                    SoundId = "rbxassetid://15170336435",
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Through-out heaven and earth...",
                            ScaleTime = 0.2691121014741173
                        }, {
                            Quote = " I alone am the honored one.",
                            ScaleTime = 0.2949948577305451
                        } }
                }
            }
        }
    },
    Metadata = {
        PostRig = function(p27) -- Line: 2930, Name: PostRig
            -- upvalues: AssetHandler (copy), u2 (ref)
            local Player = p27.Player;
            local Character = p27.Character;
            local SkinName = p27.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v28 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v28.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v28;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
            local u29 = game:GetService("TweenService"):Create(Character.Stand.StandAura, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                OutlineTransparency = 0.95,
                FillTransparency = 0.7,
                OutlineColor = Color3.new(1, 1, 1)
            });
            u29:Play();
            Character.Destroying:Once(function() -- Line: 2960
                -- upvalues: u29 (copy)
                u29:Cancel();
                u29:Destroy();
            end);

            if u2 then
                u2.AttackHook:Unhook("Inbound", "StarBuffs" .. Player.Name);
            end;
        end
    }
};