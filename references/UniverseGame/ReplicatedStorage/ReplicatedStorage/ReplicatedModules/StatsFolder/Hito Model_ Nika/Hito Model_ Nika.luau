  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ClientModulesPath.TweenModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = PathShortcuts.ClientAssets;
local u1;

if game:GetService("RunService"):IsServer() then
    AbilityModule = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Name, true);
    u1 = require(AbilityModule.Common);
else
    u1 = nil;
end;

local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
Knit.OnStart():andThen(function() -- Line: 21
    -- upvalues: u2 (ref), Knit (copy), u6 (ref), u3 (ref), u5 (ref), PathShortcuts (copy), u4 (ref)
    u2 = Knit.GetService("MoveInputService");
    u6 = Knit.GetService("HakiService");
    u3 = Knit.GetService("EffectService");
    u5 = Knit.GetService("TagService");
    u4 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v7 = {
    Hit = {
        SoundId = 18724624260,
        Volume = 1
    }
};
local v8 = {
    Hit = {
        SoundId = 18743627269,
        Volume = 1
    }
};
local v9 = {
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
            Base = {
                Visible = true,
                Priority = 1
            },
            ["Gear 5"] = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v9.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 10, function(p10, p11, p12) -- Line: 92
                    -- upvalues: u1 (ref)
                    u1.CreateGomuLimb({
                        Limb = "Right Arm",
                        SetTransparent = true,
                        Character = p12.Character,
                        MoveData = p12
                    });
                end },
            { 12, 15, "Attack" },
            { 16, "End" },
            { 28, function(p13, p14, p15) -- Line: 104
                    -- upvalues: u3 (ref), u1 (ref)
                    local Character = p15.Character;
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/Return",
                                    AutoSerialize = true,
                                    Origin = Character["Right Arm"].CFrame,
                                    Player = p15.Player,
                                    Character = Character,
                                    AttachTo = {
                                        Part = Character["Right Arm"]
                                    }
                                }
                            }
                        }
                    });
                    u1.CleanupGomuLimbs(Character);
                end }
        },
        Stun = {
            Time = 0.75
        },
        HitSounds = v7,
        HitRemotes = { v9.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 23, 25, "Attack" }, { 27, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 24, 26, "Attack" }, { 27, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = {
            { 0, "Start" },
            { 28, 30, "Attack" },
            { 28, function(p16, p17, p18, p19) -- Line: 171
                    -- upvalues: u4 (ref), u3 (ref)
                    local _ = p19.AttackStats;
                    local Player = p18.Player;
                    local Character = p18.Character;
                    local RootPart = p18.RootPart;
                    u4.PlaySound(Character, "LMB-4 Slam");
                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/LMBSlam",
                                    AutoSerialize = true,
                                    Origin = RootPart.CFrame * CFrame.new(0, -3, -1),
                                    Player = Player,
                                    Character = Character
                                }
                            }
                        },
                        {
                            Name = "Rock Debris",
                            Data = {
                                {
                                    Lifetime = 3,
                                    Radius = 10,
                                    Amount = 15,
                                    Size = Vector3.new(2, 1, 1.5),
                                    Origin = RootPart.CFrame * CFrame.new(0, 0, -0.5)
                                }
                            }
                        }
                    });
                    u3.FireClient(Player, "Camera Shake Preset", "Explosion");
                end },
            { 32, "End" }
        },
        HitRemotes = { v9.Resources.HeavyHit },
        HitSounds = v8
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v9.Stats.Block = {
    From = "Combat.Block"
};
v9.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v9.Stats.Soru = {
    Active = true,
    Speed = 70,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block" }
        }
    },
    Cooldown = {
        Time = 8.15,
        Manual = true,
        CooldownReduction = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } }
};
v9.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(u20, p21) -- Line: 259, Name: PoseTransition
            -- upvalues: Knit (copy), u1 (ref), u4 (ref), u3 (ref)
            local _ = u20.Stats;
            local _ = u20.Player;
            local Character = u20.Character;
            local RootPart = u20.RootPart;
            local v22 = p21.Trove or u20.Trove;
            local _ = u20.Tags;
            local _ = u20.Animator;

            if not Knit.CollectionService:HasTag(Character, "Gear 5") then
                return;
            end;

            u1.CreateGomuLimb({
                SetTransparent = true,
                Character = Character,
                MoveData = u20,
                Limb = { "Right Arm", "Left Arm", "Left Leg", "Right Leg" }
            });
            u4.SoftStopSound(Character, "Liberation Ambience", 0.8);
            task.delay(6.666666666666667, function() -- Line: 284
                -- upvalues: u1 (ref), Character (copy)
                u1.CleanupGomuLimbs(Character);
            end);
            local u23 = false;
            v22:Add(function() -- Line: 290
                -- upvalues: u1 (ref), Character (copy), u23 (ref), u4 (ref)
                u1.CleanupGomuLimbs(Character);
                u23 = true;
                u4.SoftPlaySound(Character, "Liberation Ambience", 0.8);
            end);
            local v24 = { 88, 119, 148, 249 };

            for i = 1, #v24 do
                task.delay(v24[i] / 60, function() -- Line: 299
                    -- upvalues: u23 (ref), Character (copy), u3 (ref), u20 (copy)
                    if u23 then
                        return;
                    end;

                    u3.FireAllClients({
                        {
                            Name = "Emit Particle V3",
                            Data = {
                                {
                                    Path = "Particles/PoseVFX/SmokeFX",
                                    AutoSerialize = true,
                                    Origin = CFrame.new(Character.Torso.Position) * CFrame.new(0, -2, 0),
                                    Player = u20.Player,
                                    Character = u20.Character
                                }
                            }
                        }
                    });
                end);
            end;

            task.delay(4.3, function() -- Line: 319
                -- upvalues: u23 (ref), u3 (ref), RootPart (copy), u20 (copy)
                if u23 then
                    return;
                end;

                u3.FireAllClients({
                    {
                        Name = "Emit Particle V3",
                        Data = {
                            {
                                Path = "Particles/PoseVFX/EmitonPose",
                                AutoSerialize = true,
                                Origin = RootPart.CFrame * CFrame.new(0, 0, 0),
                                Player = u20.Player,
                                Character = u20.Character
                            }
                        }
                    }
                });
            end);
        end,

        Transformer = function(p25, p26) -- Line: 339, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v27 = TableUtil.Copy(p25.Stats, true);

            if Knit.CollectionService:HasTag(p25.Character, "Gear 5") then
                v27.StartAnim = "G5PoseTransition";
                v27.LoopAnim = "G5PoseIdle";
                v27.PoseMusic = math.random(100) < 95 and "PoseMusicG5" or "PoseMusic";
            end;

            return v27;
        end
    }
};
v9.Stats.Breaker = {
    From = "Combat.Breaker"
};
v9.Stats["Hawk Gatling"] = {
    Active = true,
    Speed = 1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Sequence = {
        { 0, function(p28, p29, p30, p31) -- Line: 369
                -- upvalues: u1 (ref)
                u1.CreateBusoVFX(p30.Player, p31.Trove or p30.Trove);
            end },
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Hawk Gatling", {
                Cancelable = true
            } },
        { 24, "Cancelable", true },
        { 24, "Clashable", true },
        { 24, "Barrage", true },
        { 24, function(p32, p33, p34) -- Line: 380
                -- upvalues: u3 (ref), AssetHandler (copy)
                local RootPart = p34.RootPart;
                local Trove = p34.Trove;
                local v35 = os.clock();
                local v36 = p32:GetCache();
                v36.Id = v35;
                u3.FireAllClients({
                    {
                        Name = "Enable Particles",
                        Data = {
                            {
                                Enabled = true,
                                Parent = RootPart,
                                Offset = CFrame.new(0, 0, -2) * CFrame.Angles(0, 3.141592653589793, 0),
                                ReferencePart = AssetHandler.GetAsset("Particles/HawkGatlingFX/BarrageFX", p34),
                                Id = v35
                            }
                        }
                    }
                });
                local u37 = {
                    {
                        Id = v36.Id
                    }
                };
                v36.DisableData = u37;
                Trove:Add(function() -- Line: 407
                    -- upvalues: u3 (ref), u37 (copy)
                    u3.FireAllClients({
                        {
                            Name = "Enable Particles",
                            Data = u37
                        }
                    });
                end);
            end },
        { 24, 136, "BarrageAttack", "Hit" },
        { 136, "Cancelable", false },
        { 136, "Clashable", false },
        { 136, "Barrage", false },
        { 136, function(p38, p39, p40, p41) -- Line: 418
                -- upvalues: u3 (ref)
                local DisableData = p38:GetCache().DisableData;

                if DisableData then
                    u3.FireAllClients({
                        {
                            Name = "Enable Particles",
                            Data = DisableData
                        }
                    });
                end;
            end },
        { 136, "BarrageFinisher" },
        { 136, function(p42, p43, u44, p45) -- Line: 429
                -- upvalues: u1 (ref), u3 (ref)
                local v46 = p45.Trove or u44.Trove;
                u1.CreateGomuLimb({
                    SetTransparent = true,
                    Character = u44.Character,
                    MoveData = u44,
                    Limb = { "Right Arm", "Left Arm" }
                });
                v46:Add(function() -- Line: 439
                    -- upvalues: u1 (ref), u44 (copy)
                    u1.CleanupGomuLimbs(u44.Character);
                end);
                u3.FireClient(u44.Player, {
                    {
                        Name = "FOV Modifier",
                        Data = {
                            {
                                View = 45,
                                TweenInformation = {
                                    Speed = 0.5 / p42:GetSpeed(),
                                    EasingStyle = Enum.EasingStyle.Cubic
                                }
                            }
                        }
                    },
                    {
                        Name = "Camera Shake Preset",
                        Data = { "MediumCharge" }
                    }
                });
            end },
        { 150, "CreateTag", "NoRotate" },
        { 150, "CreateTag", "MaxWalkSpeed", 4 },
        { 176, "BarrageAttack", "Finisher" },
        { 176, function(p47, p48, p49) -- Line: 465
                -- upvalues: u3 (ref)
                local RootPart = p49.RootPart;
                u3.FireClient(p49.Player, {
                    {
                        Name = "Impact Frame",
                        Data = {
                            {
                                Time = 0.1,
                                Models = { p49.Character }
                            }
                        }
                    },
                    {
                        Name = "FOV Modifier",
                        Data = {
                            {
                                View = 90,
                                TweenInformation = {
                                    Speed = 0.2 / p47:GetSpeed(),
                                    EasingStyle = Enum.EasingStyle.Cubic
                                }
                            }
                        }
                    },
                    {
                        Name = "Camera Shake Preset",
                        Data = { "Explosion" }
                    },
                    {
                        Name = "TedBlur",
                        Data = { 30, 0.2 }
                    },
                    {
                        Name = "InvertedLighting",
                        Data = { 0.2, 0.5 }
                    }
                });
                u3.FireAllClients({
                    {
                        Name = "Emit Particle V3",
                        Data = {
                            {
                                Path = "Particles/HawkGatlingFX/BazookaBurst",
                                AutoSerialize = true,
                                Origin = RootPart.CFrame * CFrame.new(0, 0, -1.5),
                                Player = p49.Player,
                                Character = p49.Character
                            }
                        }
                    },
                    {
                        Name = "Rock Trail",
                        Data = {
                            {
                                Offset = 3.5,
                                Distance = 19,
                                Amount = 12,
                                Size = 2,
                                Duration = 1.5,
                                DurationOffset = 0.025,
                                Down = true,
                                Origin = RootPart.CFrame,
                                LookVector = RootPart.CFrame.LookVector
                            }
                        }
                    }
                });
            end },
        { 209, function(p50, p51, p52) -- Line: 536
                -- upvalues: u3 (ref)
                u3.FireClient(p52.Player, {
                    {
                        Name = "FOV Modifier",
                        Data = {
                            {
                                TweenInformation = {
                                    Speed = 0.15 / p50:GetSpeed(),
                                    EasingStyle = Enum.EasingStyle.Cubic
                                }
                            }
                        }
                    }
                });
            end },
        { 244, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    Hit = TableUtil.Reconcile({
        Damage = 1.2,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -5),
            PilotData = {
                RelativePart = "Stand.StandHumanoidRootPart",
                Offset = CFrame.new(0, 0, -3.5)
            }
        },
        Stun = {
            Time = 0.8,
            Barrage = true,
            Priority = EnumsModule.Stun.Medium
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 19),
        Offset = CFrame.new(0, 0, -9),
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        Ragdoll = {
            Time = 2
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false,
            Unblockable = true
        }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher,
    Callbacks = {
        BarrageEffect = function(p53, p54, p55, p56) -- Line: 605, Name: BarrageEffect
            -- upvalues: Knit (copy), u3 (ref)
            local Character = p54.Character;

            if p56 then
                Knit.CollectionService:AddTag(Character, "Barraging");
                u3.FireAllClients("Gomu_Gatling", Character);
                p55.SequenceTrove:Add(function() -- Line: 612
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barraging");
            end;

            return true;
        end
    }
};
v9.Stats.Gatling = {
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
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -5.5)
    },
    Damage = 1,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Stun = {
        Time = 0.9
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = v7,
    HitAnimations = "Default",
    HitRemotes = {},
    Finisher = {
        Damage = 8.5,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 11),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5,
            Intangible = true
        },
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = v8,
        HitRemotes = {}
    }
};
v9.Stats.Rifle = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 40
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -3)
    },
    Damage = 15,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.3
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = v8,
    HitAnimations = "Default",
    HitRemotes = {},
    ["Rifle Launch"] = {
        Damage = 25,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 3
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Character Rock Trail", {
                        State = true,
                        Duration = 3,
                        Attribute = "GomuRifleTargetRocks",
                        Character = "__Target"
                    } }
            } },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 80,
            Time = 0.7
        }
    }
};
v9.Stats["War Axe"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.new(0, -2, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.2,
        Velocity = Vector3.new(0, 20, 0)
    },
    Stun = {
        Time = 0.8
    },
    Ragdoll = {
        Time = 1.5
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = v8,
    HitRemotes = { v9.Resources.HeavyHit }
};
v9.Stats.Bazooka = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 19),
        Offset = CFrame.new(0, 0, -9)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = v8,
    HitRemotes = {}
};
v9.Stats.Mallet = {
    Actionable = {
        Active = true
    },
    Active = true,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Offset = CFrame.new(0, 0, -5)
    },
    Damage = 10,
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    HitRemotes = { v9.Resources.HeavyHit },
    Headslam = {
        Damage = 35,
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1,
            Velocity = Vector3.new(0, 20, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = true
        },
        Ragdoll = {
            Time = 2
        },
        HitRemotes = {}
    },
    Headslam_AOE = {
        Damage = 35,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1,
            Velocity = Vector3.new(0, 20, 0)
        },
        Ragdoll = {
            Time = 1.5
        },
        HitRemotes = { v9.Resources.HeavyHit }
    }
};
v9.Stats["Hawk Pistol"] = {
    Active = true,
    Damage = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Stun = {
        Time = 1.35
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 15),
        Offset = CFrame.new(0, 0, -7.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 20,
        Time = 0.2
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 2.5,
            Overrides = {
                Lifetime = 5,
                Rate = 0.5
            }
        } },
    HitSounds = v9.Resources.HawkPistol
};
v9.Stats["Red Hawk"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 2
        },
        HitRemotes = { v9.Resources.LightHit },
        Block = {
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = true
        }
    },
    Hawk = {
        Damage = 25,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.2
        },
        Ragdoll = {
            Time = 2
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                Damage = 2.5,
                Overrides = {
                    Lifetime = 5,
                    Rate = 0.5
                }
            } },
        HitSounds = v9.Resources.HawkHit,
        Stun = {
            Time = 2
        },
        Block = {
            Unblockable = true
        }
    }
};
v9.Stats["Drums Of Liberation"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 100,
        Manual = true,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 2,
        Manual = true
    },
    MeterColor = Color3.fromRGB(255, 255, 255)
};
v9.Stats["Red Roc"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        Manual = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 32,
        Offset = CFrame.new(0, 0, 0)
    },
    Damage = 1.25,
    Stun = {
        Time = 0.75
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    HitRemotes = {},
    HitAnimations = "Default",
    Explosion = {
        Damage = 15,
        HitAnimations = "Default",
        Knockback = {
            RelativeTowards = "Target",
            Speed = 40,
            Time = 0.4,
            Velocity = Vector3.new(0, 35, 0)
        },
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockBreak = false
        },
        HitRemotes = {}
    }
};
v9.Stats.Kaminari = {
    Active = true,
    Damage = 60,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Block = {
        Blockable = false,
        Unblockable = true,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 2
    },
    Stun = {
        Time = 2
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.2,
        Velocity = Vector3.new(0, 50, 0)
    },
    Hitbox = {
        Size = 40
    }
};
v9.Stats.Gigant = {
    Active = true,
    Damage = 40,
    Height = 280,
    MaxScale = 2.4,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Ragdoll = {
        Time = 2
    },
    Stun = {
        Time = 2
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.2,
        Velocity = Vector3.new(0, 50, 0)
    },
    Hitbox = {
        Size = 50
    },
    Cooldown = {
        Time = 20,
        Manual = true
    }
};
v9.Stats["Giant Pistol"] = {
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Active = true,
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    ["First Hit"] = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 34),
            Offset = CFrame.new(0, 0, -20.5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        Stun = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {},
        HitRemotes = {}
    },
    ["Second Hit"] = {
        Damage = 40,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.new(0, 0, -25)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 20,
            Time = 0.3,
            Velocity = Vector3.new(0, 50, 0)
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            Unblockable = true
        },
        HitSounds = {},
        HitRemotes = {}
    }
};
v9.Stats["Mole Pistol"] = {
    Active = true,
    Damage = 35,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 16,
        Manual = true
    },
    Hitbox = {
        Size = Vector3.new(15, 30, 15)
    },
    Knockback = {
        RelativePart = "Target",
        Speed = 10,
        Time = 0.2,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 2
    },
    HitRemotes = { v9.Resources.Gear5Hit },
    Block = {
        PerfectBlockable = true,
        Blockable = false,
        BlockBreak = true
    }
};
v9.Stats["Star Gun"] = {
    Active = true,
    Frequency = 3,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Whirl = {
        Damage = 0.6,
        Meter = false,
        Stun = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Target",
            Time = 0.175,
            Speed = 0,
            Velocity = Vector3.new(0, 3, 0)
        },
        HitSounds = v9.Resources.StarGunWhirl
    },
    Punch = {
        Damage = 30,
        Meter = false,
        Stun = {
            Time = 2
        },
        Ragdoll = {
            Time = 2
        },
        Block = {
            BlockBreak = true
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 20,
            Time = 0.2
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(13, 8, 33),
            Offset = CFrame.new(0, 0, -16.5)
        },
        HitRemotes = { v9.Resources.Gear5Hit },
        HitSounds = v9.Resources.StarGunPunch
    },
    Pull = {
        Damage = 20,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2
        },
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = -20,
            Time = 0.2
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(13, 8, 33),
            Offset = CFrame.new(0, 0, -16.5)
        },
        HitRemotes = { v9.Resources.Gear5Hit },
        HitSounds = v9.Resources.StarGunPunch
    }
};
v9.Stats["Dawn Gatling"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Punch = {
        Damage = 6,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 25, 20),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, -5, 0)
        },
        Priority = EnumsModule.Intangible.Ragdoll,
        HitRemotes = { v9.Resources.Gear5Hit },
        HitSounds = v7,
        Ragdoll = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Slam = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            Size = 20
        },
        Knockback = {
            RelativePart = "HumanoidRootPart",
            Velocity = Vector3.new(0, 20, 0),
            Speed = 40,
            Time = 0.1
        },
        HitRemotes = { v9.Resources.Gear5Hit },
        Ragdoll = {
            Time = 1
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        }
    },
    Barrage = {
        Damage = 0.3,
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 25, 20),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, -5, 0)
        },
        Ragdoll = {
            Time = 1
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    }
};
v9.Stats["Bajrang Gun"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Lock = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 50,
            Offset = CFrame.identity
        }
    },
    Punch = {
        Damage = 150,
        Priority = EnumsModule.Intangible.Move,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 150,
            Offset = CFrame.identity
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 3
        },
        Knockback = {
            RelativePart = "HumanoidRootPart",
            Velocity = Vector3.new(0, 120, 0),
            Speed = 70,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BypassCounter = true
        }
    }
};
v9.Stats["Rock Volley"] = {
    Active = true,
    Damage = 3,
    Stun = 1,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        Manual = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitRemotes = { v9.Resources.Gear5Hit },
    HitSounds = v7
};

return v9;