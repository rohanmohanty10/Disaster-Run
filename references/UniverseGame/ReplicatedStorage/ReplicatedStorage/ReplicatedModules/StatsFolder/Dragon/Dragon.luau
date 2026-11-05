  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage["Client Assets"];
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Common = require(script.Common);
local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u4 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u4 = Knit.GetService("LevelService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local Step2 = require(PathShortcuts.ReplicatedModules.EffectsFolder.Devs.Boojie.Combat.Step);

function Step(p5, p6, p7)
    -- upvalues: u2 (ref), Step2 (copy)
    local v8 = game.Players:GetPlayerFromCharacter(p5);

    if v8 then
        u2.FireClient(v8, "Step", p6, p7);

        return;
    end;

    Step2(p6, p7);
end;

local v10 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Passive = {
                Visible = true,
                Priority = 5
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 4,

        PointCap = function(p9) -- Line: 67, Name: PointCap
            return 1;
        end
    }
};
v10.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Check = function(p11) -- Line: 77, Name: Check
            return not p11:GetAttribute("M1Locked");
        end
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p12, p13, p14) -- Line: 91
                    -- upvalues: Common (copy)
                    local Character = p14.Character;
                    Character:SetAttribute("LMB", 1);
                    Common.EnableTrail(Character, "Left Arm", true);
                end },
            { 11, 12, "Attack" },
            { 28, function(p15, p16, p17) -- Line: 98
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p17.Character, false);
                end },
            { 28, "End" }
        },
        Stun = {
            Time = 0.7
        },
        HitSounds = {
            Hit = {
                SoundId = 92735601930079,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p18, p19, p20) -- Line: 126
                    -- upvalues: Common (copy)
                    local Character = p20.Character;
                    Character:SetAttribute("LMB", 2);
                    Common.EnableTrail(Character, "Right Arm", true);
                end },
            { 11, 12, "Attack" },
            { 28, function(p21, p22, p23) -- Line: 134
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p23.Character, false);
                end },
            { 28, "End" }
        },
        Stun = {
            Time = 0.7
        },
        HitSounds = {
            Hit = {
                SoundId = 114110166218770,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p24, p25, p26) -- Line: 161
                    -- upvalues: Common (copy)
                    local Character = p26.Character;
                    Character:SetAttribute("LMB", 3);
                    Common.EnableTrail(Character, "Left Arm", true);
                end },
            { 12, 13, "Attack" },
            { 26, function(p27, p28, p29) -- Line: 169
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p29.Character, false);
                end },
            { 26, "End" }
        },
        Stun = {
            Time = 0.7
        },
        HitSounds = {
            Hit = {
                SoundId = 114276651069916,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.2,
        Damage = 8,
        Sequence = {
            { 0, "Start" },
            { 0, function(p30, p31, p32) -- Line: 196
                    -- upvalues: Common (copy)
                    local Character = p32.Character;
                    Character:SetAttribute("LMB", 4);
                    Common.EnableTrail(Character, "Right Leg", true);
                end },
            { 16, 18, "Attack" },
            { 28, function(p33, p34, p35) -- Line: 205
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p35.Character, false);
                end },
            { 28, "End" }
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 89968970114744,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v10.Stats["Rush Attack Finishers"] = {
    Actionable = {
        Active = {
            Ignore = { "Rush Attack Endlag" }
        },

        Check = function(p36) -- Line: 243, Name: Check
            -- upvalues: Players (copy), u4 (ref), UIOutput (copy)
            local v37 = Players:GetPlayerFromCharacter(p36);

            if not v37 then
                return true;
            end;

            if p36:GetAttribute("RMB") ~= 1 or u4.GetMasteryInfo(v37, 1500).Rank >= 2 then
                return true;
            end;

            UIOutput:FireClient(v37, "CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "Dragon",
                Verb = "",
                Subject = "Failed Mastery Rank 2 Required"
            });

            return false;
        end
    },
    Active = true,
    Cooldown = {
        Time = 1,
        Manual = true
    },
    ComboTick = 1.25,
    ["RMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p38, p39, p40) -- Line: 281
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p40.Character, "Right Arm", true);
                end },
            { 21, function(p41, p42, p43) -- Line: 287
                    local Character = p43.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 15,
                        EndSpeed = 15,
                        Turn = true,
                        Character = Character,
                        Time = 0.13333333333333333 * p41:GetSpeed()
                    });
                end },
            { 25, 26, "Attack" },
            { 30, function(p44, p45, p46) -- Line: 303
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p46.Character, false);
                end },
            { 30, "End" }
        },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 82097429230443,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["RMB2-1"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = {
            { 0, "Start" },
            { 0, function(p47, p48, p49) -- Line: 332
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p49.Character, "Left Arm", true);
                end },
            { 21, function(p50, p51, p52) -- Line: 338
                    local Character = p52.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 15,
                        EndSpeed = 15,
                        Turn = true,
                        Character = Character,
                        Time = 0.13333333333333333 * p50:GetSpeed()
                    });
                end },
            { 21, 24, "Attack" },
            { 50, function(p53, p54, p55) -- Line: 354
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p55.Character, false);
                end },
            { 50, "End" }
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 107837149065196,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["RMB-2"] = TableUtil.Reconcile({
        Speed = 1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p56, p57, p58) -- Line: 396
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p58.Character, "Right Arm", true);
                end },
            { 21, function(p59, p60, p61) -- Line: 402
                    local Character = p61.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 15,
                        EndSpeed = 15,
                        Turn = true,
                        Character = Character,
                        Time = 0.13333333333333333 * p59:GetSpeed()
                    });
                end },
            { 25, 26, "Attack" },
            { 29, function(p62, p63, p64) -- Line: 418
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p64.Character, false);
                end },
            { 29, "End" }
        },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 84863351595655,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack),
    ["RMB2-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p65, p66, p67) -- Line: 447
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p67.Character, "Right Leg", true);
                end },
            { 21, function(p68, p69, p70) -- Line: 453
                    local Character = p70.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 25,
                        EndSpeed = 25,
                        Turn = true,
                        Character = Character,
                        Time = 0.13333333333333333 * p68:GetSpeed()
                    });
                end },
            { 25, 26, "Attack" },
            { 60, function(p71, p72, p73) -- Line: 469
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p73.Character, false);
                end },
            { 60, "End" }
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 101871041972126,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["RMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p74, p75, p76) -- Line: 514
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p76.Character, "Right Arm", true);
                end },
            { 31, 33, "Attack" },
            { 37, function(p77, p78, p79) -- Line: 522
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p79.Character, false);
                end },
            { 37, "End" }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 1,
            Time = 0.1,
            Velocity = Vector3.new(0, 25, 0)
        },
        Ragdoll = {
            Time = 1.5
        },
        HitSounds = {
            Hit = {
                SoundId = 133748088611870,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack),
    ["RMB2-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = {
            { 0, "Start" },
            { 0, function(p80, p81, p82) -- Line: 560
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p82.Character, { "Left Arm", "Right Arm" }, true);
                end },
            { 31, 33, "Attack" },
            { 60, function(p83, p84, p85) -- Line: 568
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p85.Character, false);
                end },
            { 60, "End" }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 1,
            Time = 0.1,
            Velocity = Vector3.new(0, 20, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Ragdoll = {
            Time = 1.5
        },
        HitSounds = {
            Hit = {
                SoundId = 112724070190760,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["RMB-4"] = {
        Speed = 1.15,
        Damage = 8,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = {
            { 0, "Start" },
            { 0, function(p86, p87, p88) -- Line: 613
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p88.Character, "Left Leg", true);
                end },
            { 17, function(p89, p90, p91) -- Line: 619
                    local Character = p91.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 15,
                        EndSpeed = 15,
                        Turn = true,
                        Character = Character,
                        Time = 0.21666666666666667 * p89:GetSpeed()
                    });
                end },
            { 31, 33, "Attack" },
            { 39, function(p92, p93, p94) -- Line: 636
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p94.Character, false);
                end },
            { 39, "End" }
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.3
        },
        HitSounds = {
            Hit = {
                SoundId = 89883274402924,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    },
    ["RMB2-4"] = TableUtil.Reconcile({
        Speed = 1,
        Damage = 8,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = {
            { 0, "Start" },
            { 0, function(p95, p96, p97) -- Line: 681
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p97.Character, "Right Leg", true);
                end },
            { 12, function(p98, p99, p100) -- Line: 687
                    local Character = p100.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 40,
                        Turn = true,
                        Character = Character,
                        Time = 0.26666666666666666 * p98:GetSpeed()
                    });
                end },
            { 27, 30, "Attack" },
            { 50, function(p101, p102, p103) -- Line: 704
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p103.Character, false);
                end },
            { 50, "End" }
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1,
            Velocity = Vector3.new(0, 20, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 140700015862665,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v10.Stats.Block = {
    From = "Combat.Block"
};
v10.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v10.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p104, p105) -- Line: 754, Name: PoseTransition
            -- upvalues: u2 (ref), u3 (ref)
            local _ = p104.Stats;
            local Player = p104.Player;
            local Character = p104.Character;
            u2.FireClient(Player, "PoseRevelation");
            p104.Trove:Construct(u3.CreateSequence, Character, {
                SequenceV2 = true,
                Frames = {
                    { 91, function(p106) -- Line: 766
                            -- upvalues: u2 (ref), Player (copy)
                            u2.FireClient(Player, "PoseRevelation", "Main");
                        end }
                }
            }):Play();
        end,

        PoseLoop = function(p107, p108) -- Line: 775, Name: PoseLoop
            local _ = p107.Stats;
            local _ = p107.Player;
            local _ = p107.Character;
        end,

        PoseEnd = function(p109, p110) -- Line: 783, Name: PoseEnd
            -- upvalues: u2 (ref)
            local _ = p109.Stats;
            local _ = p109.Character;
            u2.FireClient(p109.Player, "PoseRevelation", "Clean");
        end
    }
};
v10.Stats.Taunt = {
    Active = true,
    AddHeat = 15,
    RecoveryHeal = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    }
};
v10.Stats["Tojo Hold"] = {
    Active = true,
    Damage = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 2.5
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/TojoHold/GrabVFX",
                    LookAt = "Attacker"
                } }
        } },
    Victim_Throw = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 70,
            Time = 0.3,
            Velocity = Vector3.new(0, 10, 0)
        },
        Ragdoll = {
            Time = 1.5
        }
    },
    Victim_Hitbox = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.3
        },
        HitSounds = {
            Hit = {
                SoundId = 97260185512115,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }
};
v10.Stats["Fists of Fury"] = {
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
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Damage = 1.5,
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.01
    },
    HitSounds = {
        Hit = {
            SoundId = 130957222356923,
            Volume = 1
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/FistsOfFury/HitVFX",
                    LookAt = "Attacker"
                } }
        } },
    HitAnimations = "Default",
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 10),
            Offset = CFrame.new(0, 0, -3.5)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 45,
            Time = 0.3
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/FistsOfFury/HeavyHit",
                        LookAt = "Attacker"
                    } }
            } },
        HitSounds = {
            Hit = {
                SoundId = 114223780345309,
                Volume = 1
            }
        }
    }
};
v10.Stats["Dragon Kick"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9.5, 9.5, 12.5),
        Offset = CFrame.new(0, 0, -4.5)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.3
    },
    HitRemotes = { v10.Resources.HeavyHit },
    HitSounds = {
        Hit = {
            SoundId = 86576336627761,
            Volume = 1
        }
    }
};
v10.Stats["Bicycle Mayhem"] = {
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
        Size = Vector3.new(8.5, 8.5, 8.5),
        Offset = CFrame.new(0, 0, -4)
    },
    Meter = {
        RequiredAmount = 20
    },
    Swing = {
        Damage = 7.5,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        Stun = {
            Time = 0.9,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.1
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/BicycleMayhem/HitVFX",
                        LookAt = "Attacker"
                    } }
            } },
        HitSounds = {
            Hit1 = {
                SoundId = 77805813828176,
                Volume = 1
            },
            Hit2 = {
                SoundId = 74605976646414,
                Volume = 1
            }
        }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Medium
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.3,
            Velocity = Vector3.new(0, -20, 0)
        },
        HitRemotes = { v10.Resources.HeavyHit },
        HitSounds = {
            Hit1 = {
                SoundId = 77805813828176,
                Volume = 1
            },
            Hit2 = {
                SoundId = 74605976646414,
                Volume = 1
            }
        }
    }
};
v10.Stats["Rising Sweep"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9.5, 8, 9.5),
        Offset = CFrame.new(0, 0, -2.5)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    Stun = {
        Time = 1.15,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    HitSounds = {
        Hit = {
            SoundId = 89968970114744,
            Volume = 1
        }
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/RisingSweep/LegHitVFX",
                    LookAt = "Attacker"
                } }
        } }
};
v10.Stats["Dragon of Dojima"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Damage = 10,
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    HitSounds = {},
    HitRemotes = { v10.Resources.LightHit },
    HitAnimations = "Default",
    ["Head Grab"] = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit }
    },
    ["Knee Smash"] = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        HitRemotes = {
            v10.Resources.HeavyHit,
            {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/DragonOfDojima/KneeSmackHit",
                        LookAt = "Attacker"
                    } }
            }
        }
    }
};
v10.Stats["Dragon of Dojima 88"] = {
    Actionable = {
        Active = true,
        MasteryRank = 3
    },
    Active = true,
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Damage = 15,
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    HitSounds = {},
    HitRemotes = { v10.Resources.LightHit },
    HitAnimations = "Default",
    Punch = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit }
    },
    ["Head Grab"] = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit }
    },
    ["Knee Smash"] = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        HitRemotes = {
            v10.Resources.HeavyHit,
            {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/DragonOfDojima/KneeSmackHit",
                        LookAt = "Attacker"
                    } }
            }
        }
    }
};
v10.Stats["Essence of Remembrance"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 90
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Damage = 15,
    MinHealth = 1,
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    HitSounds = {},
    HitRemotes = { v10.Resources.HeavyHit },
    FirstSecondHit = {
        MinHealth = 1,
        Damage = 25,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit }
    },
    Finisher = {
        Damage = 30,
        MinHealth = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit }
    },
    Aftermath = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3
        },
        Ragdoll = {
            Time = 4
        }
    }
};
v10.Stats["Dragon\'s Resurgence"] = {
    Active = true,
    Duration = 15,
    Actionable = {
        Active = true,

        Check = function(p111) -- Line: 1549, Name: Check
            return not p111:GetAttribute("DragonsResurgence");
        end
    },
    Meter = {
        RequiredAmount = 50
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v10.Stats["Fist Reversal"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Punch = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit }
    },
    ["Ground Slam"] = {
        Damage = 25,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2.5
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }
};
v10.Stats["Tiger Drop"] = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        MasteryRank = 4
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.3
    },
    HitRemotes = { v10.Resources.HeavyHit },
    HitSounds = {}
};
v10.Stats["Essence of Sumo Slap"] = {
    Actionable = {
        Active = true,
        MasteryRank = 1
    },
    Active = true,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 25.5),
        Offset = CFrame.new(0, 0, -13.5)
    },
    Damage = 10,
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    HitSounds = {},
    HitRemotes = { v10.Resources.HeavyHit },
    FirstSecondHit = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SumoSlap/BloodHit",
                        PartName = "Head"
                    } }
            } }
    },
    Finisher = {
        Damage = 25,
        Priority = Enums.Intangible.Move,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/SumoSlap/BloodHit",
                        PartName = "Head"
                    } }
            } }
    },
    Aftermath = {
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2.5
        }
    }
};

return v10;