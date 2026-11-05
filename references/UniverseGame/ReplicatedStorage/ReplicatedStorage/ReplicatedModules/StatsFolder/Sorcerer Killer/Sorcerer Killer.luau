  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets["Gold Experience Requiem"];
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local u1;

if game:GetService("RunService"):IsServer() then
    local v2 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Sorcerer Killer", true);
    u1 = require(v2.Common);
else
    u1 = nil;
end;

local v4 = {
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 3
            },
            User = {
                Visible = true,
                Priority = 1
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

        PointCap = function(p3) -- Line: 73, Name: PointCap
            return 1;
        end
    }
};
local v5 = {
    Ignore = { "Breakneck Speed" }
};

local function Invoke(p6) -- Line: 85
    -- upvalues: Knit (copy)
    local Input = p6.Input;
    local v7 = Knit.GetController("MoveInputController");
    local v8 = Knit.GetService("MoveInputService");
    local v9 = os.clock();
    local v10 = false;

    while v7.Inputs[Input] do
        if os.clock() - v9 >= 0.2 then
            v10 = true;
            break;
        end;

        task.wait();
    end;

    v8:FireInput(p6.RawInput, v10);
end;

v4.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Active = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ActiveEndlag = 0.2,
    ["SplitSoulKatana-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        ActiveEndlag = 0.15,
        Sequence = { { 0, "Start" }, { 28, 32, "Attack" }, { 34, "End" } },
        Stun = {
            Time = 0.8
        },
        HitRemotes = { v4.Resources.BloodHit },
        HitSounds = { v4.Resources.SplitSoulKatanaRushAttackSFX }
    }, BaseStatsModule.Rush_Attack),
    ["SplitSoulKatana-LMB-2"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 28, 32, "Attack" }, { 34, "End" } },
        HitSounds = { v4.Resources.SplitSoulKatanaRushAttackSFX },
        HitRemotes = { v4.Resources.BloodHit }
    },
    ["SplitSoulKatana-LMB-3"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 30, 34, "Attack" }, { 36, "End" } },
        HitSounds = { v4.Resources.SplitSoulKatanaRushAttackKickSFX },
        HitRemotes = { v4.Resources.LightHit }
    },
    ["SplitSoulKatana-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.75,
        ActiveEndlag = 0.15,
        Sequence = { { 0, "Start" }, { 39, 40, "Attack" }, { 49, "End" } },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.SplitSoulKatanaRushAttackFinisherSFX }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["PlayfulCloud-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.35,
        ActiveEndlag = 0.15,
        Sequence = { { 0, "Start" }, { 22, 26, "Attack" }, { 27, "End" } },
        Stun = {
            Time = 0.8
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.PlayfulCloudRushAttackSFX }
    }, BaseStatsModule.Rush_Attack),
    ["PlayfulCloud-LMB-2"] = {
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 27, 31, "Attack" }, { 31, "End" } },
        HitSounds = { v4.Resources.PlayfulCloudRushAttackSFX }
    },
    ["PlayfulCloud-LMB-3"] = {
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 24, 28, "Attack" }, { 29, "End" } },
        HitSounds = { v4.Resources.PlayfulCloudRushAttackSFX }
    },
    ["PlayfulCloud-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.35,
        ActiveEndlag = 0.15,
        Sequence = { { 0, "Start" }, { 28, 32, "Attack" }, { 33, "End" } },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.PlayfulCloudRushAttackFinisherSFX }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["InvertedSpear-LMB-1"] = TableUtil.Reconcile({
        InfinityBypass = true,
        Speed = 0.6,
        Sequence = { { 0, "Start" }, { 6, 10, "Attack" }, { 13, "End" } },
        Stun = {
            Time = 0.7
        },
        HitRemotes = { v4.Resources.BloodHit },
        HitSounds = { v4.Resources.InvertedSpearRushAttackSFX }
    }, BaseStatsModule.Rush_Attack),
    ["InvertedSpear-LMB-2"] = {
        InfinityBypass = true,
        Speed = 0.6,
        Sequence = { { 0, "Start" }, { 5, 9, "Attack" }, { 11, "End" } },
        HitSounds = { v4.Resources.InvertedSpearRushAttackSFX }
    },
    ["InvertedSpear-LMB-3"] = {
        InfinityBypass = true,
        Speed = 0.6,
        Sequence = { { 0, "Start" }, { 7, 11, "Attack" }, { 14, "End" } },
        HitSounds = { v4.Resources.InvertedSpearRushAttackSFX }
    },
    ["InvertedSpear-LMB-4"] = TableUtil.Reconcile({
        InfinityBypass = true,
        Speed = 0.6,
        Sequence = { { 0, "Start" }, { 8, 12, "Attack" }, { 15, "End" } },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.InvertedSpearRushAttackFinisherSFX }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p11, p12) -- Line: 348, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Stats = p11.Stats;

            if p11.Character:GetAttribute("Weapon") == "SplitSoulKatana" then
                local v13 = TableUtil.Copy(Stats, true);
                v13.CustomPrefix = "SplitSoulKatana-LMB";

                return v13;
            end;

            if p11.Character:GetAttribute("Weapon") ~= "PlayfulCloud" then
                if p11.Character:GetAttribute("Weapon") == "InvertedSpear" then
                    Stats = TableUtil.Copy(Stats, true);
                    Stats.CustomPrefix = "InvertedSpear-LMB";
                end;

                return Stats;
            end;

            local v14 = TableUtil.Copy(Stats, true);
            v14.CustomPrefix = "PlayfulCloud-LMB";

            return v14;
        end
    }
};
v4.Stats["Chain Carving"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        MasteryRank = 3,
        Active = true,
        Summoned = false,

        Check = function(p15) -- Line: 375, Name: Check
            -- upvalues: PathShortcuts (copy)
            local UIOutput = PathShortcuts.RemotesPath:WaitForChild("UIOutput");
            local v16;

            if p15 then
                v16 = p15:GetAttribute("Carnage");
            else
                v16 = p15;
            end;

            local v17 = game.Players:GetPlayerFromCharacter(p15);

            if not v17 or v16 then
                return true;
            end;

            UIOutput:FireClient(v17, "CreateMiddleNotification", {
                NumericalContent = 1,
                Verb = "",
                Subject = "You can\'t use Chain Carving while Carnage is not active.",
                NumericalSuffix = script.Name
            });
            UIOutput:FireClient(v17, "PlaySound", "ope_invalid_move");

            return false;
        end
    },
    Active = true,
    MaxCombo = 4,
    ComboTick = 4,
    ActiveEndlag = 0.2,
    InfinityBypass = true,
    ["RMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Damage = 12,
        InfinityBypass = true,
        ActiveEndlag = 0.15,
        Sequence = {
            { 0, "Start" },
            { 74, 82, "Attack" },
            { 62, function(p18, p19, p20, p21) -- Line: 407
                    -- upvalues: u1 (ref)
                    u1:Step(p20.Character, p20.RootPart, {
                        MaxForce = Vector3.new(100000, 0, 100000),
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 125,
                        EndSpeed = 12,
                        Distance = 6,
                        CollisionGroup = "Map",
                        Turn = true,
                        Character = p20.Character,
                        Time = 0.43333333333333335 / p18:GetSpeed()
                    });
                end },
            { 62, "CreateTag", "MaxWalkSpeed", 0 },
            { 90, "End" }
        },
        Stun = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 12),
            Predict = true,
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v4.Resources.BloodHit },
        HitSounds = { v4.Resources.RMBHit },
        Block = {
            Blockable = true
        }
    }, BaseStatsModule.Rush_Attack),
    ["RMB-2"] = {
        Speed = 1.35,
        InfinityBypass = true,
        Transition = 0.05,
        Sequence = {
            { 0, "Start" },
            { 0, "CreateTag", "MaxWalkSpeed", 0 },
            { 9, function(p22, p23, p24, p25) -- Line: 463
                    -- upvalues: u1 (ref)
                    u1:Step(p24.Character, p24.RootPart, {
                        MaxForce = Vector3.new(100000, 0, 100000),
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 125,
                        EndSpeed = 12,
                        Distance = 6,
                        CollisionGroup = "Map",
                        Turn = true,
                        Character = p24.Character,
                        Time = 0.23333333333333334 / p22:GetSpeed()
                    });
                end },
            { 18, 27, "Attack" },
            { 65, function(p26, p27, p28, p29) -- Line: 477
                    -- upvalues: u1 (ref)
                    p26.Hit[p29.FullName] = {};
                    u1:Step(p28.Character, p28.RootPart, {
                        MaxForce = Vector3.new(100000, 0, 100000),
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 125,
                        EndSpeed = 12,
                        Distance = 6,
                        CollisionGroup = "Map",
                        Turn = true,
                        Character = p28.Character,
                        Time = 0.35 / p26:GetSpeed()
                    });
                end },
            { 77, 83, "Attack" },
            { 77, "End" }
        },
        HitSounds = { v4.Resources.RMBHit }
    },
    ["RMB-3"] = {
        Speed = 1.05,
        InfinityBypass = true,
        Transition = 0.05,
        Sequence = {
            { 0, "Start" },
            { 0, "CreateTag", "MaxWalkSpeed", 0 },
            { 16, 24, "Attack" },
            { 13, function(p30, p31, p32, p33) -- Line: 509
                    -- upvalues: u1 (ref)
                    u1:Step(p32.Character, p32.RootPart, {
                        MaxForce = Vector3.new(100000, 0, 100000),
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 125,
                        EndSpeed = 12,
                        Distance = 6,
                        CollisionGroup = "Map",
                        Turn = true,
                        Character = p32.Character,
                        Time = 0.18333333333333332 / p30:GetSpeed()
                    });
                end },
            { 34, "End" }
        },
        HitSounds = { v4.Resources.RMBHit }
    },
    ["RMB-4"] = TableUtil.Reconcile({
        Speed = 1,
        Damage = 12,
        InfinityBypass = true,
        ActiveEndlag = 0.15,
        Transition = 0.05,
        Sequence = {
            { 0, "Start" },
            { 0, "CreateTag", "MaxWalkSpeed", 0 },
            { 7, 14, "Attack" },
            { 3, function(p34, p35, p36, p37) -- Line: 539
                    -- upvalues: u1 (ref)
                    u1:Step(p36.Character, p36.RootPart, {
                        MaxForce = Vector3.new(100000, 100000, 100000),
                        Normal = Vector3.new(0, 0, -1),
                        Speed = 125,
                        EndSpeed = 12,
                        Distance = 6,
                        CollisionGroup = "Map",
                        Turn = true,
                        Character = p36.Character,
                        Time = 0.15 / p34:GetSpeed()
                    });
                end },
            { 46, function(p38, p39, p40, p41) -- Line: 552
                    -- upvalues: u1 (ref)
                    u1:Step(p40.Character, p40.RootPart, {
                        MaxForce = Vector3.new(100000, 0, 100000),
                        Normal = Vector3.new(0, 0, 1),
                        Speed = 100,
                        EndSpeed = 8,
                        Distance = 6,
                        CollisionGroup = "Map",
                        Turn = true,
                        Character = p40.Character,
                        Time = 0.5166666666666667 / p38:GetSpeed()
                    });
                end },
            { 116, "End" }
        },
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 2
        },
        Cooldown = {
            Time = 10
        },
        Block = {
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 72,
            Time = 0.1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 12),
            Predict = true,
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v4.Resources.BloodHit },
        HitSounds = { v4.Resources.RMBFinisher }
    }, BaseStatsModule.Rush_Attack_Finisher),
    CustomPrefix = "RMB"
};
v4.Stats.Block = {
    From = "Combat.Block"
};
v4.Stats.Breaker = {
    From = "Combat.Breaker"
};
v4.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v4.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p42) -- Line: 632, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v43 = TableUtil.Copy(p42.Stats, true);
            local v44 = p42.Character:GetAttribute("Weapon") or "PlayfulCloud";
            v43.StartAnim = v44 .. "PoseTransition";
            v43.LoopAnim = v44 .. "PoseIdle";

            if p42.Character:GetAttribute("Carnage") then
                v43.PoseMusic = "CarnagePoseMusic";

                return v43;
            end;

            v43.PoseMusic = v44 .. "PoseMusic";

            return v43;
        end
    }
};
v4.Stats.Grab = {
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
v4.Stats["Hidden Inventory"] = {
    Active = true,
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Actionable = {
        Active = true
    }
};
v4.Stats["Breakneck Slice"] = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "E",
            Visible = true
        } },
    Actionable = {
        Active = v5
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Dash = {
        CheckPVPSafe = true,
        HitAnimations = "Default",
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        }
    },
    Slash1 = {
        Damage = 10,
        MinHealth = 1,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.85
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitRemotes = { v4.Resources.BloodHit }
    },
    Slash2 = {
        Damage = 10,
        MinHealth = 1,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.85
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitRemotes = { v4.Resources.BloodHit }
    },
    Slash3 = {
        Damage = 10,
        MinHealth = 1,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.85
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitRemotes = { v4.Resources.BloodHit }
    },
    Finisher = {
        Damage = 15,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 85,
            Time = 0.25
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v4.Resources.BloodHit, v4.Resources.BleedHit }
    }
};
v4.Stats.Assassination = {};
v4.Stats["Assassination (Base)"] = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "T",
            Visible = true
        } },
    Actionable = {
        Active = v5
    },
    Cooldown = {
        Time = 16,
        Name = "Assassination",
        AfterMove = true,
        Client = false
    },
    Startup = {
        Grab = true,
        Damage = 20,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            BlockBreak = true,
            PerfectBlockable = true,
            BlockCancel = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 26),
            Offset = CFrame.new(0, 0, 0)
        },
        HitRemotes = {}
    },
    Rip = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = {},
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = {}
    },
    Kick = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4.Resources.SkullHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = {}
    },
    Release = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v4.Stats["Assassination (Carnage)"] = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "T",
            Visible = true
        } },
    Actionable = {
        Active = v5
    },
    Meter = {
        RequiredAmount = 30
    },
    Cooldown = {
        Time = 16,
        Name = "Assassination",
        AfterMove = true,
        Client = false
    },
    Slash = {
        MinHealth = 1,
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 3
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 20, 50),
            Offset = CFrame.new(0, 0, 0)
        },
        HitRemotes = {}
    },
    DelayedHit = {
        Damage = 45,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            Unblockable = true,
            BypassCounter = true
        },
        HitRemotes = { v4.Resources.BloodHit, v4.Resources.BleedHit }
    }
};
v4.Stats["Unrelenting Assault"] = {
    Active = true,
    Frequency = 1,
    Indicators = { {
            Group = "Katana",
            Input = "H",
            Visible = true
        } },
    Actionable = {
        Active = v5
    },
    Cooldown = {
        Time = 16,
        AfterMove = true,
        Client = false
    },
    Slash = {
        Damage = 35,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(16, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v4.Resources.BloodHit, v4.Resources.BleedHit },
        HitSounds = { v4.Resources.UnrelentingAssaultSFX }
    }
};
v4.Stats["Whirlwind Breaker"] = {
    Active = true,
    InfinityBypass = true,
    Frequency = 1,
    Actionable = {
        MasteryRank = 2,
        Active = v5
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    },
    Slash = {
        InfinityBypass = true,
        Damage = 1.5,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 3,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 11,
            Predict = false,
            Offset = CFrame.new(0, 0, 0)
        },
        HitRemotes = { v4.Resources.BloodHit },
        HitSounds = { v4.Resources.WhirlwindBreaker }
    },
    Finisher = {
        InfinityBypass = true,
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 3,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 11,
            Predict = false,
            Offset = CFrame.new(0, 0, 0)
        },
        HitRemotes = { v4.Resources.BloodHit, v4.Resources.BleedHit },
        HitSounds = { v4.Resources.WhirlwindBreaker }
    }
};
v4.Stats["Swift Stab"] = {
    Active = true,
    Actionable = {
        MasteryRank = 2,
        Active = v5
    },
    Cooldown = {
        Time = 20,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = true
    },
    Startup = {
        Grab = true,
        Damage = 60,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
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
            Size = Vector3.new(9, 9, 14),
            Predict = false,
            Offset = CFrame.new(0, 0, -7)
        },
        HitRemotes = { v4.Resources.BloodHit }
    },
    Withdraw = {
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4.Resources.BloodHit, v4.Resources.BleedHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Kick = {
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Rip = {
        Damage = 5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4.Resources.BloodHit, v4.Resources.BleedHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Stab = {
        Damage = 1.6666666666666667,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4.Resources.BloodHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slash = {
        Damage = 5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4.Resources.BloodHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    FinisherKick = {
        Damage = 5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = {},
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    FinisherRelease = {
        Damage = 10,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 12, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v4.Stats["Assassin Aptitude"] = {
    Active = true,
    Actionable = {
        Active = v5
    },
    Cooldown = {
        Time = 20,
        AfterMove = true,
        Client = false
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(48, 48, 64),
            Offset = CFrame.new(0, 0, -32)
        }
    },
    Projectile = {
        Damage = 10,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.SoftRagdoll,
        Stun = {
            Time = 0.65
        },
        KnockbackData = { {
                Type = "Velocity",
                Speed = 48,
                Time = 0.1,
                RelativeTowards = "Target"
            } },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false
        },
        HitRemotes = { v4.Resources.BloodHit }
    }
};
v4.Stats["Shrapnel Storm"] = {
    Active = true,
    Indicators = { {
            Group = "PlayfulCloud",
            Input = "H",
            Visible = true
        } },
    Actionable = {
        Active = v5
    },
    Cooldown = {
        Time = 30,
        AfterMove = true,
        Client = false
    },
    Meter = {
        Amount = 30,
        RemoveMeter = true
    },
    Slam = {
        Damage = 15,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 15,
            Offset = CFrame.new(0, 0, 0)
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativeTowards = "Target",
                Speed = 6,
                Velocity = Vector3.new(0, 22, 0),
                Time = 0.1
            }, {
                Type = "Force",
                Force = Vector3.new(0, 2000, 0),
                Time = 2.5
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        HitRemotes = { v4.Resources.LightHit }
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 36,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Projectile = {
        Damage = 2.85,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 1
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativeTowards = "Target",
                Speed = 32,
                MaxForce = Vector3.new(100000, 100000, 100000),
                Time = 0.1
            }, {
                Type = "Force",
                Force = Vector3.new(0, 100, 0),
                Time = 1.25
            } },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.ShrapnelStormSFX }
    }
};
v4.Stats["Skull Cracker"] = {
    Active = true,
    Indicators = { {
            Group = "Universal",
            Input = "X",
            Visible = true
        } },
    Actionable = {
        Active = v5
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Startup = {
        CheckPVPSafe = true,
        Grab = true,
        MinHealth = 1,
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
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = {}
    },
    Hit = {
        Damage = 1.3333333333333333,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v4.Resources.SkullHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        HitRemotes = { v4.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v4.Stats["Unwavering Flurry"] = {
    Actionable = {
        MasteryRank = 1
    }
};
v4.Stats["Unwavering Flurry (Base)"] = TableUtil.Reconcile({
    Active = true,
    Actionable = {
        Active = v5
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlayAnim", "UnwaveringFlurry", {
                Cancelable = true
            } }, { 0, "PlaySound", "UnwaveringFlurry", {
                Cancelable = true
            } }, { 0, "PlaySound", "UnwaveringFlurryVoiceline", {
                Cancelable = true
            } }, { 26, "Cancelable", true }, { 26, "Clashable", true }, { 26, "CreateTag", "MaxWalkSpeed", 12 }, { 26, 30, "BarrageAttack", "Start" }, { 93, 156, "BarrageAttack", "Hit" }, { 157, "Cancelable", false }, { 157, "Clashable", false }, { 165, "BarrageFinisher" }, { 165, 170, "BarrageAttack", "Finisher" }, { 219, "End" } },
    ClashSequence = { { 0, "BarrageStart" }, { 0, "StopSound", "BarrageVoiceline" }, { 0, "PlaySound", "ClashVoiceline" }, { 0, "Clashable", false }, { 0, "Clash" }, { 0, "Barrage", true }, { 0, 60, "ClashAttack", "ClashHit" }, { 0, 60, "ClashRotate", true }, { 61, "ClashEnd" }, { 61, "ClashAttack", "ClashFinisher" }, { 64, "End" } },
    Cooldown = {
        Time = 12,
        Name = "Unwavering Flurry",
        AfterMove = true
    },
    Start = {
        Frequency = 360,
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 8.5),
            Offset = CFrame.new(0, 0, -4.25)
        },
        Stun = {
            Time = 1.5,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.UnwaveringFlurrySFX }
    },
    Hit = {
        Damage = 0.5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 8.5),
            Offset = CFrame.new(0, 0, -4.25)
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.UnwaveringFlurrySFX },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        }
    },
    Finisher = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 8.5),
            Offset = CFrame.new(0, 0, -4.25)
        },
        HitRemotes = { v4.Resources.HeavyHit },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        HitSounds = { v4.Resources.UnwaveringFlurryFinisherSFX }
    },
    ClashHit = {},
    ClashFinisher = {
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.25
        }
    }
}, BaseStatsModule.Stand_Barrage);
v4.Stats["Unwavering Flurry (Carnage)"] = TableUtil.Reconcile({
    Active = true,
    Speed = 1.15,
    Actionable = {
        Active = v5
    },
    Cooldown = {
        Time = 12,
        Name = "Unwavering Flurry",
        AfterMove = true,
        Client = false
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlayAnim", "UnwaveringFlurryCarnage", {
                Cancelable = true
            } },
        { 0, "PlaySound", "UnwaveringRampage", {
                Cancelable = true
            } },
        { 0, "PlaySound", "UnwaveringRampageVoiceline", {
                Cancelable = true
            } },
        { 26, "Cancelable", true },
        { 26, "CreateTag", "MaxWalkSpeed", 12 },
        { 26, 30, "BarrageAttack", "Start" },
        { 78, function(p45, p46, p47, p48) -- Line: 1667
                -- upvalues: PathShortcuts (copy), Knit (copy), u1 (ref)
                local u49 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
                local u50 = Knit.GetService("EffectService");
                local _ = p47.Player;
                local Character = p47.Character;
                local _ = p47.Humanoid;
                local RootPart = p47.RootPart;
                local _ = p47.AbilityModel;
                local _ = p47.Tags;
                local _ = p47.Animator;
                local _ = p47.Stats;
                local Trove2 = p47.Trove;
                u1:Step(Character, RootPart, {
                    MaxForce = Vector3.new(100000, 300000, 100000),
                    Normal = Vector3.new(0, 0, -1),
                    Speed = 90,
                    EndSpeed = 48,
                    TimeDelay = 2,
                    Distance = 6,
                    CollisionGroup = "Map",
                    Turn = true,
                    Character = Character,
                    Time = 1.0833333333333333 / p45:GetSpeed()
                });
                Trove2:Add(function() -- Line: 1699
                    -- upvalues: u1 (ref), Character (copy), RootPart (copy)
                    u1:Step(Character, RootPart, {
                        Cancel = true
                    });
                end);
                u50.FireAllClients("MIH_AFTERIMAGES", Character, true, {
                    Distance = false,
                    Time = 0.04,
                    Transparency = 0.75,
                    Attribute = "ASSAULT_AFTERIMAGES",
                    Whitelist = {}
                });
                Trove2:Add(function() -- Line: 1712
                    -- upvalues: u50 (copy), Character (copy)
                    u50.FireAllClients("MIH_AFTERIMAGES", Character, false, {
                        Attribute = "ASSAULT_AFTERIMAGES"
                    });
                end);
                u49.ChangeCollision(Character, "Ghosted");
                Trove2:Add(function() -- Line: 1719
                    -- upvalues: u49 (copy), Character (copy)
                    u49.ChangeCollision(Character, "Default");
                end);
            end },
        { 80, 142, "BarrageAttack", "Hit" },
        { 143, "BarrageFinisher" },
        { 143, function(p51, p52, p53, p54) -- Line: 1725
                -- upvalues: Knit (copy)
                local v55 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Sorcerer Killer", true);
                local Common = require(v55.Common);
                local v56 = Knit.GetService("EffectService");
                Common:Step(p53.Character, p53.RootPart, {
                    MaxForce = Vector3.new(100000, 300000, 100000),
                    Normal = Vector3.new(0, 0, -1),
                    Speed = 48,
                    EndSpeed = 12,
                    TimeDelay = 2,
                    Distance = 6,
                    CollisionGroup = "Map",
                    Turn = true,
                    Character = p53.Character,
                    Time = 0.38333333333333336 / p51:GetSpeed()
                });
                v56.FireAllClients("MIH_AFTERIMAGES", p53.Character, false, {
                    Attribute = "ASSAULT_AFTERIMAGES"
                });
            end },
        { 166, function(p57, p58, p59, p60) -- Line: 1747
                local v61 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Sorcerer Killer", true);
                require(v61.Common):Step(p59.Character, p59.RootPart, {
                    MaxForce = Vector3.new(100000, 300000, 100000),
                    Normal = Vector3.new(0, 0, -1),
                    Speed = 150,
                    EndSpeed = 12,
                    Distance = 6,
                    CollisionGroup = "Map",
                    Turn = true,
                    Character = p59.Character,
                    Time = 0.16666666666666666 / p57:GetSpeed()
                });
            end },
        { 169, 173, "BarrageAttack", "Finisher" },
        { 200, "End" }
    },
    ClashSequence = { { 0, "BarrageStart" }, { 0, "StopSound", "BarrageVoiceline" }, { 0, "PlaySound", "ClashVoiceline" }, { 0, "Clashable", false }, { 0, "Clash" }, { 0, "Barrage", true }, { 0, 60, "ClashAttack", "ClashHit" }, { 0, 60, "ClashRotate", true }, { 61, "ClashEnd" }, { 61, "ClashAttack", "ClashFinisher" }, { 64, "End" } },
    Start = {
        Frequency = 360,
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 8.5),
            Offset = CFrame.new(0, 0, -4.25)
        },
        Stun = {
            Time = 1.5,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.UnwaveringFlurrySFX }
    },
    Hit = {
        Damage = 2.5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 14, 16),
            Offset = CFrame.new(0, 0, -8)
        },
        HitRemotes = { v4.Resources.LightHit },
        Stun = {
            Time = 0.65,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        HitSounds = { v4.Resources.UnwaveringFlurrySFX }
    },
    Finisher = {
        Damage = 22.5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(14, 14, 17),
            Offset = CFrame.new(0, 0, -8.5)
        },
        HitRemotes = { v4.Resources.HeavyHit },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        HitSounds = { v4.Resources.UnwaveringFlurryFinisherSFX }
    },
    ClashHit = {},
    ClashFinisher = {
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.25
        }
    }
}, BaseStatsModule.Stand_Barrage);
v4.Stats["Violent Flourish"] = {
    Active = true,
    Frequency = 1,
    Actionable = {
        MasteryRank = 1,
        Active = v5
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Spin = {
        Damage = 1.8604651162790697,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 9,
            Predict = true,
            Offset = CFrame.new(0, 0, 0)
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.UnwaveringFlurrySFX }
    },
    Finisher = {
        Damage = 40,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Predict = true,
            Offset = CFrame.new(0, 0, -7.5)
        },
        HitRemotes = { v4.Resources.HeavyHit },
        HitSounds = { v4.Resources.UnwaveringFlurryFinisherSFX }
    }
};
v4.Stats["Chain Of A Thousand Miles"] = {
    Active = true,
    InfinityBypass = true,
    Actionable = {
        MasteryRank = 3,
        Active = v5
    },
    Cooldown = {
        Time = 16,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredAmount = 35
    },
    Slash = {
        InfinityBypass = true,
        Damage = 5,
        HitAnimations = "Default",
        Stun = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 72,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(24, 24, 24),
            Predict = true,
            Offset = CFrame.new(0, 0, -12)
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.ChainOfAThousandMilesSFX }
    },
    AoESlash = {
        InfinityBypass = true,
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 72,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Predict = true,
            Offset = CFrame.new(0, 0, -0)
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.ChainOfAThousandMilesSFX }
    },
    Stab = {
        InfinityBypass = true,
        Damage = 20,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 24, 30),
            Predict = true,
            Offset = CFrame.new(0, 0, -15)
        },
        HitRemotes = { v4.Resources.LightHit },
        HitSounds = { v4.Resources.ChainOfAThousandMilesFinisherSFX }
    }
};
v4.Stats["Breakneck Speed"] = {
    Active = true,
    Indicators = { {
            Group = "Universal",
            Input = "V",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        AfterMove = true,
        Client = false
    }
};
v4.Stats.Carnage = {
    Active = true,
    Time = 20,
    Indicators = { {
            Group = "Universal",
            Input = "B",
            Visible = true
        } },
    Actionable = {
        MasteryRank = 4,
        Active = true
    },
    Cooldown = {
        Time = 30,
        Manual = true
    },
    Meter = {
        RequiredLevel = 4,
        RemoveMeter = false
    }
};
v4.Stats["Breakneck Dash"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block" }
        }
    },
    ClientActionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block", "Block_Client" }
        }
    },
    Cooldown = {
        Name = "Breakneck Dash",
        Time = 1.5,
        Force = true,
        CooldownReduction = false,
        Manual = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },

    Invoke = function(p62) -- Line: 2144, Name: Invoke
        -- upvalues: Knit (copy), TagService (copy), AnimationHandler (copy), Trove (copy)
        local v63 = Knit.GetController("CombatController");
        local v64 = Knit.GetController("PilotController");
        local v65 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        TagService:GetContainer(LocalPlayer);
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local u66 = AnimationHandler.Get(Humanoid.Animator);
        local ActivePilot = v64.ActivePilot;

        if ActivePilot then
            Humanoid = ActivePilot:FindFirstChild("Humanoid") or Humanoid;
            HumanoidRootPart = ActivePilot:FindFirstChild("HumanoidRootPart") or HumanoidRootPart;
        end;

        LocalPlayer.Data.Ability:GetAttribute("AbilityName");
        local v67 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        v65:FireInput(p62.RawInput);

        local function Lerp(p68, p69, p70) -- Line: 2172
            return p68 + (p69 - p68) * p70;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Velocity = v67 * 125;
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Parent = HumanoidRootPart;
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
        AlignOrientation.RigidityEnabled = true;
        AlignOrientation.CFrame = HumanoidRootPart.CFrame;
        AlignOrientation.Parent = HumanoidRootPart;
        local v71 = HumanoidRootPart.CFrame:VectorToObjectSpace(v67);
        local v72 = math.atan2(v71.X, -v71.Z);
        local v73 = math.deg(v72) - 0.5;
        local v74 = math.ceil(v73);
        local v75 = ActivePilot and "Pilot" or "";
        local v76 = v74 > 45 and v74 < 135 and "Right" or (v74 < -45 and v74 > -135 and "Left" or ((v74 <= -135 or v74 >= 135) and "Backward" or "Forward"));
        local v77;

        if v76 == "Forward" then
            Character:SetAttribute("DashCounter", Character:GetAttribute("DashCounter") == 2 and 1 or (Character:GetAttribute("DashCounter") == 1 and 2 or 1));
            v77 = Character:GetAttribute("DashCounter");
        else
            v77 = "";
        end;

        u66:StopAnimation(v75 .. "ForwardDash1", 0.1);
        u66:StopAnimation(v75 .. "ForwardDash2", 0.1);
        u66:StopAnimation(v75 .. "Right" .. "Dash" .. v77, 0.1);
        u66:StopAnimation(v75 .. "Left" .. "Dash" .. v77, 0.1);
        u66:StopAnimation(v75 .. "Backward" .. "Dash" .. v77, 0.1);
        local u78 = false;
        local v79 = Trove.new();
        local u80 = v75 .. v76 .. "Dash" .. v77;
        u66:PlayAnimation(u80, 0.9);
        u66:PlayAnimation(v75 .. v76 .. "Dash" .. v77, 0.9);
        v79:Add(v63.QuickstepInterrupted:Connect(function() -- Line: 2225
            -- upvalues: u78 (ref), u66 (copy), u80 (copy)
            u78 = true;
            u66:StopAnimation(u80, 0.9);
        end));
        local v81 = os.clock();

        while not u78 and os.clock() - v81 <= 0.35 do
            local v82 = os.clock() - v81;
            local v83 = math.abs(v82) / 0.35;
            local v84 = 125 + -112.5 * math.clamp(v83, 0, 1);
            BodyVelocity.Velocity = v67 * math.clamp(v84, 12.5, 125);
            task.wait();
        end;

        BodyVelocity:Destroy();
        AlignOrientation:Destroy();

        if u78 then
            local v85 = os.clock() - v81;
            local v86 = math.abs(v85) / 0.35;
            local v87 = math.clamp(v86, 0, 1);
            local v88 = math.lerp(v87, 1, 0.5);
            local v89 = math.min(v88, 1);
            local v90 = math.lerp(125, 12.5, v89);
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v67.X * v90, HumanoidRootPart.AssemblyLinearVelocity.Y, v67.Z * v90);
        end;
    end
};

return v4;