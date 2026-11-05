  

 

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

Knit.OnStart():andThen(function() -- Line: 36
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u4 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u4 = Knit.GetService("LevelService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
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
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p12, p13, p14) -- Line: 91
                    -- upvalues: Common (copy)
                    local Character = p14.Character;
                    Character:SetAttribute("LMB", 1);
                    Common.EnableTrail(Character, "Right Leg", true);
                end },
            { 5, function(p15, p16, p17) -- Line: 98
                    local Character = p17.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 15,
                        EndSpeed = 15,
                        Turn = true,
                        Character = Character,
                        Time = 0.16666666666666666 * p15:GetSpeed()
                    });
                end },
            { 14, 17, "Attack" },
            { 25, function(p18, p19, p20) -- Line: 113
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p20.Character, false);
                end },
            { 25, "End" }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.2
        },
        Stun = {
            Time = 0.75
        },
        HitSounds = {
            Hit = {
                SoundId = 133051281371049,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p21, p22, p23) -- Line: 147
                    -- upvalues: Common (copy)
                    local Character = p23.Character;
                    Character:SetAttribute("LMB", 2);
                    Common.EnableKnifeTrail(Character, true);
                end },
            { 11, 15, "Attack" },
            { 16, "ResetHits" },
            { 11, function(p24, p25, p26) -- Line: 156
                    local Character = p26.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 20,
                        EndSpeed = 20,
                        Turn = true,
                        Character = Character,
                        Time = 0.4166666666666667 * p24:GetSpeed()
                    });
                end },
            { 37, 40, "Attack" },
            { 45, function(p27, p28, p29) -- Line: 171
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p29.Character, false);
                end },
            { 45, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 78897279017458,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p30, p31, p32) -- Line: 193
                    -- upvalues: Common (copy)
                    local Character = p32.Character;
                    Character:SetAttribute("LMB", 3);
                    Common.EnableTrail(Character, "Left Leg", true);
                end },
            { 14, 16, "Attack" },
            { 26, function(p33, p34, p35) -- Line: 202
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p35.Character, false);
                end },
            { 26, "End" }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 8
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 139238258571280,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = {
            { 0, "Start" },
            { 0, function(p36, p37, p38) -- Line: 235
                    -- upvalues: Common (copy)
                    local Character = p38.Character;
                    Character:SetAttribute("LMB", 4);
                    Common.EnableKnifeTrail(Character, true);
                end },
            { 14, function(p39, p40, p41) -- Line: 242
                    local Character = p41.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 15,
                        EndSpeed = 15,
                        Turn = true,
                        Character = Character,
                        Time = 0.16666666666666666 * p39:GetSpeed()
                    });
                end },
            { 22, 23, "Attack" },
            { 45, function(p42, p43, p44) -- Line: 259
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p44.Character, false);
                end },
            { 45, "End" }
        },
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitSounds = v10.Resources.LMB4HitSFX,
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v10.Stats["Rush Attack Finishers"] = {
    Actionable = {
        Active = {
            Ignore = { "Rush Attack Endlag" }
        },

        Check = function(p45) -- Line: 292, Name: Check
            -- upvalues: Players (copy), u4 (ref), UIOutput (copy)
            local v46 = Players:GetPlayerFromCharacter(p45);

            if not v46 then
                return true;
            end;

            if p45:GetAttribute("RMB") ~= 1 or u4.GetMasteryInfo(v46, 1501).Rank >= 2 then
                return true;
            end;

            UIOutput:FireClient(v46, "CreateMiddleNotification", {
                NumericalContent = 1,
                NumericalSuffix = "Mad Dog",
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
    Meter = {
        MeterGain = 0
    },
    ComboTick = 2,
    ["RMB-1"] = TableUtil.Reconcile({
        Speed = 1.15,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = {
            { 0, "Start" },
            { 0, function(p47, p48, p49) -- Line: 335
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p49.Character, "Right Leg", true);
                end },
            { 24, 26, "Attack" },
            { 48, function(p50, p51, p52) -- Line: 356
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p52.Character, false);
                end },
            { 48, "End" }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 106267613574928
            }
        },
        HitRemotes = { v10.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["RMB2-1"] = TableUtil.Reconcile({
        Speed = 1.15,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = {
            { 0, "Start" },
            { 0, function(p53, p54, p55) -- Line: 390
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p55.Character, true);
                end },
            { 15, function(p56, p57, p58) -- Line: 395
                    local Character = p58.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 35,
                        Turn = true,
                        Character = Character,
                        Time = 0.65 * p56:GetSpeed()
                    });
                end },
            { 26, 29, "Attack" },
            { 54, function(p59, p60, p61) -- Line: 411
                    local Character = p61.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 10,
                        Turn = false,
                        Character = Character,
                        Time = 0.9333333333333333 * p59:GetSpeed()
                    });
                end },
            { 96, function(p62, p63, p64) -- Line: 425
                    local Character = p64.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Cancel = true,
                        Character = Character
                    });
                end },
            { 101, function(p65, p66, p67) -- Line: 435
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p67.Character, false);
                end },
            { 101, "End" }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 12.5),
            Offset = CFrame.new(0, 0, -3.5)
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
        HitSounds = v10.Resources.LMB4HitSFX,
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["RMB-2"] = TableUtil.Reconcile({
        Speed = 1,
        Damage = 4,
        Sequence = {
            { 0, "Start" },
            { 0, function(p68, p69, p70) -- Line: 476
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p70.Character, { "Right Leg", "Left Leg" }, true);
                end },
            { 9, function(p71, p72, p73) -- Line: 481
                    local Character = p73.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, 1),
                        Speed = 10,
                        EndSpeed = 10,
                        Turn = true,
                        Character = Character,
                        Time = 0.3333333333333333 * p71:GetSpeed()
                    });
                end },
            { 9, "Attack", {
                    Multiple = true
                } },
            { 18, "Attack", {
                    Multiple = true
                } },
            { 46, function(p74, p75, p76) -- Line: 498
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p76.Character, false);
                end },
            { 46, "End" }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 1
        },
        HitSounds = {
            Hit = {
                SoundId = 78897279017458,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["RMB2-2"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = {
            { 0, "Start" },
            { 0, function(p77, p78, p79) -- Line: 534
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p79.Character, true);
                end },
            { 4, function(p80, p81, p82) -- Line: 539
                    local Character = p82.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 35,
                        Turn = true,
                        Character = Character,
                        Time = 0.5 * p80:GetSpeed()
                    });
                end },
            { 15, 19, "Attack" },
            { 34, function(p83, p84, p85) -- Line: 555
                    local Character = p85.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 10,
                        Turn = false,
                        Character = Character,
                        Time = 0.9333333333333333 * p83:GetSpeed()
                    });
                end },
            { 84, function(p86, p87, p88) -- Line: 569
                    local Character = p88.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Cancel = true,
                        Character = Character
                    });
                end },
            { 90, function(p89, p90, p91) -- Line: 579
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p91.Character, false);
                end },
            { 90, "End" }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 12.5),
            Offset = CFrame.new(0, 0, -3.5)
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
        HitSounds = v10.Resources.LMB4HitSFX,
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["RMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Damage = 2.6666666666666665,
        Sequence = {
            { 0, "Start" },
            { 0, function(p92, p93, p94) -- Line: 620
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p94.Character, { "Right Leg", "Left Leg" }, true);
                end },
            { 14, "Attack", {
                    Multiple = true
                } },
            { 44, "Attack", {
                    Multiple = true
                } },
            { 57, "Attack", {
                    Multiple = true
                } },
            { 78, function(p95, p96, p97) -- Line: 629
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p97.Character, false);
                end },
            { 78, "End" }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        Stun = {
            Time = 1.15
        },
        HitSounds = {
            Hit1 = {
                SoundId = 131608095481529,
                Volume = 1
            },
            Hit2 = {
                SoundId = 122629012547812,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack),
    ["RMB2-3"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = {
            { 0, "Start" },
            { 0, function(p98, p99, p100) -- Line: 669
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p100.Character, true);
                end },
            { 3, function(p101, p102, p103) -- Line: 674
                    local Character = p103.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 35,
                        Turn = true,
                        Character = Character,
                        Time = 0.5833333333333334 * p101:GetSpeed()
                    });
                end },
            { 15, 19, "Attack" },
            { 34, function(p104, p105, p106) -- Line: 690
                    local Character = p106.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 10,
                        Turn = false,
                        Character = Character,
                        Time = 0.9333333333333333 * p104:GetSpeed()
                    });
                end },
            { 72, function(p107, p108, p109) -- Line: 704
                    local Character = p109.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Cancel = true,
                        Character = Character
                    });
                end },
            { 80, function(p110, p111, p112) -- Line: 714
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p112.Character, false);
                end },
            { 80, "End" }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 12.5),
            Offset = CFrame.new(0, 0, -3.5)
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
        HitSounds = v10.Resources.LMB4HitSFX,
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["RMB-4"] = TableUtil.Reconcile({
        Speed = 1.15,
        Damage = 4,
        Sequence = {
            { 0, "Start" },
            { 0, function(p113, p114, p115) -- Line: 755
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p115.Character, { "Right Leg", "Left Leg" }, true);
                end },
            { 5, function(p116, p117, p118) -- Line: 760
                    local Character = p118.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, 1),
                        Speed = 10,
                        EndSpeed = 10,
                        Turn = true,
                        Character = Character,
                        Time = 0.4 * p116:GetSpeed()
                    });
                end },
            { 9, "Attack", {
                    Multiple = true
                } },
            { 14, "Attack", {
                    Multiple = true
                } },
            { 44, function(p119, p120, p121) -- Line: 777
                    -- upvalues: Common (copy)
                    Common.EnableTrail(p121.Character, false);
                end },
            { 44, "End" }
        },
        Stun = {
            Time = 1.15
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitSounds = {
            Hit = {
                SoundId = 97760133917891,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack),
    ["RMB2-4"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = {
            { 0, "Start" },
            { 0, function(p122, p123, p124) -- Line: 817
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p124.Character, true);
                end },
            { 13, function(p125, p126, p127) -- Line: 822
                    local Character = p127.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 35,
                        Turn = true,
                        Character = Character,
                        Time = 0.5833333333333334 * p125:GetSpeed()
                    });
                end },
            { 15, 19, "Attack" },
            { 41, function(p128, p129, p130) -- Line: 838
                    local Character = p130.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 40,
                        EndSpeed = 10,
                        Turn = false,
                        Character = Character,
                        Time = 0.9333333333333333 * p128:GetSpeed()
                    });
                end },
            { 84, function(p131, p132, p133) -- Line: 852
                    local Character = p133.Character;
                    Step(Character, Character.HumanoidRootPart, {
                        Cancel = true,
                        Character = Character
                    });
                end },
            { 87, function(p134, p135, p136) -- Line: 862
                    -- upvalues: Common (copy)
                    Common.EnableKnifeTrail(p136.Character, false);
                end },
            { 87, "End" }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 12.5),
            Offset = CFrame.new(0, 0, -3.5)
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
        HitSounds = v10.Resources.LMB4HitSFX,
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
        PoseTransition = function(p137, p138) -- Line: 910, Name: PoseTransition
            -- upvalues: u2 (ref), u3 (ref)
            local _ = p137.Stats;
            local Player = p137.Player;
            local Character = p137.Character;
            u2.FireClient(Player, "PoseRevelation");
            p137.Trove:Construct(u3.CreateSequence, Character, {
                SequenceV2 = true,
                Frames = {
                    { 50, function(p139) -- Line: 922
                            -- upvalues: u2 (ref), Player (copy)
                            u2.FireClient(Player, "PoseRevelation", "Main");
                        end }
                }
            }):Play();
        end,

        PoseLoop = function(p140, p141) -- Line: 931, Name: PoseLoop
            local _ = p140.Stats;
            local _ = p140.Player;
            local _ = p140.Character;
        end,

        PoseEnd = function(p142, p143) -- Line: 939, Name: PoseEnd
            -- upvalues: u2 (ref)
            local _ = p142.Stats;
            local _ = p142.Character;
            u2.FireClient(p142.Player, "PoseRevelation", "Clean");
        end
    }
};
v10.Stats["Neck Snap"] = {
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Damage = 15,
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    Meter = {
        MeterGain = 0
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    HitSounds = {},
    HitRemotes = { v10.Resources.LightHit },
    Snap = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/NeckSnap/SnapHit",
                        LookAt = "Attacker"
                    } }
            } }
    },
    Aftermath = {
        Damage = 0.001,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 1.75
        }
    }
};
v10.Stats.Taunt = {
    Active = true,
    HealOverTime = 25,
    MeterOverTime = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 10
    }
};
v10.Stats["Hannya Frenzy"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9.5, 9.5, 9.5),
        Offset = CFrame.new(0, 0, 0)
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
            SoundId = 78897279017458,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    HitRemotes = { v10.Resources.LightHit },
    Finisher = {
        Damage = 12.5,
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
        HitSounds = {
            Hit = {
                SoundId = 97250350836283,
                Volume = 1
            }
        },
        HitRemotes = { v10.Resources.HeavyHit }
    }
};
v10.Stats["Demon Lunge"] = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 20),
        Offset = CFrame.new(0, 0, -5)
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = false
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
            SoundId = 97250350836283,
            Volume = 1
        }
    },
    HitRemotes = { v10.Resources.HeavyHit },
    StatusEffects = { v10.Resources.Bleed }
};
v10.Stats["Shin Sweep"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Offset = CFrame.new(0, 0, -2.5)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.01
    },
    HitSounds = {
        Hit = {
            SoundId = 136783185217388,
            Volume = 1
        }
    },
    HitRemotes = { v10.Resources.LightHit }
};
v10.Stats["Hannya Fang"] = {
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
    Meter = {
        RequiredAmount = 15
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -2.5)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    Ragdoll = {
        Time = 1.4
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3
    },
    HitSounds = v10.Resources.LMB4HitSFX,
    HitRemotes = { v10.Resources.HeavyHit }
};
v10.Stats["Air Breaker"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 0.5,
        AfterMove = true
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Offset = CFrame.new(0, 0, 0)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3
    },
    HitSounds = {},
    HitRemotes = { v10.Resources.HeavyHit }
};
v10.Stats["Dagger Kick"] = {
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
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3
    },
    HitSounds = {
        Hit = {
            SoundId = 97157845586510,
            Volume = 1
        }
    },
    HitRemotes = { v10.Resources.HeavyHit }
};
v10.Stats["Blade Kill"] = {
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
        CheckPVPSafe = true,
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Predict = true,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Stun = {
        Time = 1.5
    },
    ["Fake Damage"] = {
        Damage = 0.001,
        Priority = Enums.Intangible.Move
    },
    ["Victim Hit"] = {
        Damage = 50,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 97250350836283,
                Volume = 1
            }
        }
    },
    ["Fly Slash"] = {
        MinHealth = 1,
        Damage = 25,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit }
    },
    ["Final Hit"] = {
        Damage = 75,
        Priority = Enums.Intangible.Move,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/BladeKill/FinalHit",
                        LookAt = "Attacker"
                    } }
            } }
    },
    ["After Ragdoll"] = {
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2.5
        },
        StatusEffects = { v10.Resources.Bleed }
    }
};
v10.Stats["Demon Chomp"] = {
    Active = true,
    Damage = 45,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 31),
        Offset = CFrame.new(0, 0, -17.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.3
    },
    Stun = {
        Time = 0.75
    },
    Ragdoll = {
        Time = 1.3
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 97250350836283,
            Volume = 1
        }
    },
    HitRemotes = { v10.Resources.HeavyHit }
};
v10.Stats.Demonfire = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Stab = {
        Damage = 30,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit }
    },
    Aftermath = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 15,
            Time = 0.1
        },
        Ragdoll = {
            Time = 2.5
        },
        HitRemotes = { v10.Resources.HeavyHit },
        StatusEffects = { v10.Resources.Bleed }
    }
};
v10.Stats["Mad Dog Maul"] = {
    Actionable = {
        Active = true,
        MasteryRank = 3
    },
    CheckPVPSafe = true,
    Active = true,
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40,
        MeterGain = 0
    },
    Hitbox = {
        CheckPVPSafe = true,
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Offset = CFrame.new(0, 0, -3)
    },
    Stun = {
        Time = 1.5
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    Slash = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        HitRemotes = { v10.Resources.LightHit }
    },
    Punch = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        HitRemotes = { v10.Resources.LightHit }
    },
    Finisher = {
        Damage = 15,
        Priority = Enums.Intangible.Move,
        Meter = {
            MeterGain = 0
        },
        HitRemotes = { v10.Resources.HeavyHit }
    },
    ["Knife Out"] = {
        Priority = Enums.Intangible.Move,
        HitRemotes = { v10.Resources.HeavyHit },
        Meter = {
            MeterGain = 0
        },
        StatusEffects = { v10.Resources.Bleed }
    },
    ["After Ragdoll"] = {
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        }
    }
};
v10.Stats["Hannya Dance"] = {
    Actionable = {
        Active = true,
        MasteryRank = 1
    },
    Active = true,
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Offset = CFrame.new(0, 0, -3)
    },
    Damage = 15,
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = { v10.Resources.LightHit },
    HitSounds = {
        Hit = {
            SoundId = 127390667213004,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    Beginning = {
        Stun = {
            Time = 1
        }
    },
    ["Stronger Slash"] = {
        Damage = 5,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitRemotes = { v10.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 118832740250966,
                Volume = 1
            }
        }
    },
    ["Stronger Hit"] = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitRemotes = { v10.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 112153236984801,
                Volume = 1
            }
        }
    },
    Finisher = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitRemotes = { v10.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 109677418101364,
                Volume = 1
            }
        }
    }
};
v10.Stats["Loose Dog"] = {
    Active = true,
    Duration = 15,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        MasteryRank = 4
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 20),
        Offset = CFrame.new(0, 0, -5)
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
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.3
    },
    HitSounds = {
        Hit = {
            SoundId = 97250350836283,
            Volume = 1
        }
    },
    HitRemotes = { v10.Resources.HeavyHit },
    StatusEffects = { v10.Resources.Bleed }
};

return v10;