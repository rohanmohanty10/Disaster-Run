  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ClientModulesPath.TweenModule);
Knit.OnStart():await();
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Fusion = require(game.ReplicatedStorage.ClientLibrary.Fusion);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local u2 = Knit.GetService("EffectService");
local u3 = Middleware.GetMiddleware("CombatService");
Knit.GetService("AnimationService");
local u4;

if game:GetService("RunService"):IsServer() then
    local v5 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    u4 = require(v5.Common);
else
    u4 = nil;
end;

local v6 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Common/Light",
                AutoSerialize = true
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Common/Heavy",
                AutoSerialize = true
            } }
    },
    ["Blood Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Common/BloodHit",
                AutoSerialize = true
            } }
    },
    ["Blood Splatter"] = {
        Name = "Output",
        Arguments = {
            "FX",
            "Blood Rays",
            {
                Part = "__Target",
                SearchPart = "HumanoidRootPart",
                TrailRange = NumberRange.new(2, 3)
            }
        }
    }
};
local v7 = {
    Name = "Bleed",
    Stats = {
        Damage = 2,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        }
    }
};
local v8 = {
    LightHit = {
        SoundId = 11713885181,
        Volume = 1.35
    },
    HeavyHit = {
        SoundId = 11585296808,
        Volume = 2
    },
    BarrageLight = {
        SoundId = "rbxassetid://119447882525727",
        Volume = 0.9
    },
    BarrageHeavy = {
        SoundId = "rbxassetid://132510902628786",
        Volume = 1.35
    },
    M1Light = {
        SoundId = "rbxassetid://119281369143642",
        Volume = 0.9
    },
    M1Heavy = {
        SoundId = "rbxassetid://109590786411609",
        Volume = 1.35
    },
    ReaverLight = {
        SoundId = "rbxassetid://133170157351393",
        Volume = 0.9
    },
    ReaverHeavy = {
        SoundId = "rbxassetid://79800883699072",
        Volume = 1.35
    },
    StandOffM1Light = {
        SoundId = "rbxassetid://109066596318125",
        Volume = 0.9
    },
    StandOffM1Heavy = {
        SoundId = "rbxassetid://82325362195141",
        Volume = 1.35
    },
    PiercingLunge = {
        SoundId = "rbxassetid://106830041079696",
        Volume = 1.35
    },
    CrystallineVolley = {
        SoundId = "rbxassetid://94139117396955",
        Volume = 0.9
    },
    VisceralStrike1 = {
        SoundId = "rbxassetid://107567479356117",
        Volume = 1.15
    },
    VisceralStrike2 = {
        SoundId = "rbxassetid://125159372129753",
        Volume = 1.15
    },
    Puncture = {
        SoundId = "rbxassetid://89884116486791",
        Volume = 0.8
    },
    PrismaticLance = {
        SoundId = "rbxassetid://84627336095143",
        Volume = 1
    }
};
v1.summon = {
    StandAura = false,
    From = "Combat.Summon",
    SkipTransparency = true,
    Indicators = { {
            Group = "Universal",
            Name = "Summon",
            InputText = "%s",
            Visible = true
        } },
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso", "Handle", "BladeVisual", "GemVisual", "Blade", "Glow", "GreataxeHandle", "Detail" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 43, 47)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 204, 0)) }),

    OnSummon = function(p9, p10) -- Line: 205, Name: OnSummon
        -- upvalues: u4 (ref), u2 (copy)
        local Character = p9.Character;
        local _ = Character.Humanoid;
        local Animator = p9.Animator;
        local Stand = Character:FindFirstChild("Stand");

        if p10 then
            Animator:GetAnimation("Summon"):Play();
            u4:SetStandVisible(Character, 0, 0.25);
            u4:SetWeaponVisible(Character, 1, 0.25);

            return;
        end;

        Animator:GetAnimation("Desummon"):Play();
        local Handle = Stand:FindFirstChild("Handle");

        if Handle then
            u2.FireAllClients("Emit Particle V3", {
                Path = "Particles/Fissure Rupture/AxeGlow",
                AutoSerialize = true,
                Scale = 0.75,
                ScaleLifetime = 1.5,
                AttachTo = {
                    Part = Handle:FindFirstChild("Gem")
                },
                Character = Character
            });
        end;

        u4:SetStandVisible(Character, 1, 0.25);
        u4:SetWeaponVisible(Character, 0, 0.25);
    end
};
v1["rush attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Endlag = 0.2,
        ActiveEndlag = 0.075,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1" }, { 20, 23, "Attack" }, { 29, "End" } },
        HitRemotes = { v6["Light Hit"] },
        HitSounds = {
            Hit = v8.M1Light
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 2" }, { 20, 23, "Attack" }, { 29, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 3" }, { 20, 23, "Attack" }, { 29, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 20, 23, "Attack" }, { 25, "End" } },
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = v8.M1Heavy
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "StandOff-SwingLMB 1" },
            { 22, function(p11, p12, p13, p14) -- Line: 355
                    -- upvalues: u2 (copy)
                    local _ = p13.Character;
                    local Player = p13.Player;
                    u2.FireAllClientsUnreliable("Emit Particle V3", {
                        Path = "Particles/Common/AxeSlash",
                        AutoSerialize = true,
                        Scale = 0.8,
                        AttachTo = {
                            Part = p13.RootPart,
                            Offset = CFrame.new(
                                0.0491333008,
                                -0.0528717041,
                                0.229370117,
                                0.872686505,
                                -0.443377674,
                                0.204534754,
                                0.482104301,
                                0.848824799,
                                -0.216960505,
                                -0.0774187297,
                                0.287945598,
                                0.954512298
                            )
                        },
                        Player = Player
                    });
                end },
            { 25, 28, "Attack" },
            { 30, "End" }
        },
        HitRemotes = { v6["Light Hit"] },
        Stun = {
            Time = 0.55
        },
        HitSounds = {
            Hit = v8.StandOffM1Light
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "StandOff-SwingLMB 2" },
            { 21, function(p15, p16, p17, p18) -- Line: 388
                    -- upvalues: u2 (copy)
                    local _ = p17.Character;
                    local Player = p17.Player;
                    u2.FireAllClientsUnreliable("Emit Particle V3", {
                        Path = "Particles/Common/AxeSlash",
                        AutoSerialize = true,
                        Scale = 0.8,
                        AttachTo = {
                            Part = p17.RootPart,
                            Offset = CFrame.new(-0.24029541, 0.000588178635, 0.000305175781, 0, 0, -1, 0, -1, 0, -1, 0, 0)
                        },
                        Player = Player
                    });
                end },
            { 21, 24, "Attack" },
            { 29, "End" }
        },
        HitRemotes = { v6["Light Hit"] }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-3"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "StandOff-SwingLMB 3" },
            { 19, function(p19, p20, p21, p22) -- Line: 422
                    -- upvalues: u2 (copy)
                    local _ = p21.Character;
                    local Player = p21.Player;
                    u2.FireAllClientsUnreliable("Emit Particle V3", {
                        Path = "Particles/Common/AxeSlash",
                        AutoSerialize = true,
                        Scale = 0.8,
                        AttachTo = {
                            Part = p21.RootPart,
                            Offset = CFrame.new(
                                -0.24029541,
                                0.779388428,
                                0.000671386719,
                                0,
                                0,
                                -1,
                                0.766044438,
                                -0.642787635,
                                0,
                                -0.642787635,
                                -0.766044438,
                                -0
                            )
                        },
                        Player = Player
                    });
                end },
            { 21, 24, "Attack" },
            { 27, "End" }
        },
        HitRemotes = { v6["Light Hit"] }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.35,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 29, "Attack" },
            { 0, "PlaySound", "StandOff-SwingLMB 4" },
            { 29, function(p23, p24, p25, p26) -- Line: 458
                    -- upvalues: u3 (copy), u2 (copy)
                    local Character = p25.Character;
                    local Player = p25.Player;
                    local v27 = u3.GetMetadata(Character);
                    u2.FireAllClients("CRYSTAL_SummonCrystal", {
                        Origin = v27.CFrame * CFrame.new(0, -4, -6),
                        Radius = p26.AttackStats.Hitbox.Size,
                        Player = Player,
                        Sound = u3.FetchSound(Character, "StandOff-LMB Crystal"),
                        ReturnSound = u3.FetchSound(Character, "Crystal Return")
                    });
                end },
            { 45, "End" }
        },
        HitRemotes = { v6["Heavy Hit"] },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 6,
            Offset = CFrame.new(0, -1, -4.5)
        },
        HitSounds = {
            Hit = v8.StandOffM1Heavy
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p28, p29) -- Line: 493, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p28.Stats;

            if not Knit.CollectionService:HasTag(p28.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v1["axe reaver"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        AwakenedMode = true
    },
    AnimationTimed = true,
    MaxCombo = 5,
    ComboTick = 1.5,
    CustomPrefix = "Reaver",
    ["Reaver-1"] = TableUtil.Reconcile({
        Speed = 1.425,
        Damage = 10,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "Reaver 1" }, { 52, "CreateArmor" }, { 53, 63, "Attack" }, { 76, "End" } },
        HitRemotes = { v6["Light Hit"] },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8.5, 8, 9.5),
            Predict = true,
            Offset = CFrame.new(0, 0, -4.75)
        },
        HitSounds = {
            Hit = v8.ReaverLight
        }
    }, BaseStatsModule.Rush_Attack),
    ["Reaver-2"] = TableUtil.Reconcile({
        Speed = 1.25,
        Damage = 10,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "Reaver 2" }, { 40, "CreateArmor" }, { 41, 52, "Attack" }, { 65, "End" } },
        HitRemotes = { v6["Light Hit"] },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 11),
            Predict = true,
            Offset = CFrame.new(0, 0, -5.5)
        },
        HitSounds = {
            Hit = v8.ReaverHeavy
        }
    }, BaseStatsModule.Rush_Attack),
    ["Reaver-3"] = TableUtil.Reconcile({
        Speed = 1.4,
        Damage = 10,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "Reaver 3" }, { 39, "CreateArmor" }, { 40, 50, "Attack" }, { 59, "End" } },
        HitRemotes = { v6["Light Hit"] },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 8, 11),
            Predict = true,
            Offset = CFrame.new(0, 0, -5.5)
        },
        HitSounds = {
            Hit = v8.ReaverLight
        }
    }, BaseStatsModule.Rush_Attack),
    ["Reaver-4"] = TableUtil.Reconcile({
        Speed = 1.25,
        Damage = 7,
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "Reaver 4" },
            { 31, "CreateArmor" },
            { 32, 38, function(p30, p31, p32, p33) -- Line: 615
                    -- upvalues: u3 (copy)
                    local Character = p32.Character;
                    local _ = p32.Player;
                    local u34 = p30:GetCache();

                    if not u34.Hit1 then
                        u34.Hit1 = {};
                    end;

                    for _, v in u3.Hitbox({
                        Caster = Character,
                        Stats = p33.AttackStats
                    }) do
                        if not (u34.Hit1 and u34.Hit1[v.Character]) then
                            u3.Attack({
                                Attacker = Character,
                                Target = v.Character,
                                Stats = p33.AttackStats
                            }):andThen(function(p35) -- Line: 637
                                -- upvalues: u34 (copy), v (copy)
                                if p35 and (p35.State and p35.State.Success) then
                                    u34.Hit1[v.Character] = true;
                                end;
                            end);
                        end;
                    end;
                end },
            { 69, 77, function(p36, p37, p38, p39) -- Line: 644
                    -- upvalues: u3 (copy)
                    local Character = p38.Character;
                    local _ = p38.Player;
                    local u40 = p36:GetCache();

                    if not u40.Hit2 then
                        u40.Hit2 = {};
                    end;

                    for _, v in u3.Hitbox({
                        Caster = Character,
                        Stats = p39.AttackStats
                    }) do
                        if not (u40.Hit2 and u40.Hit2[v.Character]) then
                            u3.Attack({
                                Attacker = Character,
                                Target = v.Character,
                                Stats = p39.AttackStats.Secondary
                            }):andThen(function(p41) -- Line: 666
                                -- upvalues: u40 (copy), v (copy)
                                if p41 and (p41.State and p41.State.Success) then
                                    u40.Hit2[v.Character] = true;
                                end;
                            end);
                        end;
                    end;
                end },
            { 88, "End" }
        },
        HitRemotes = { v6["Light Hit"] },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8.5, 8, 9.5),
            Predict = true,
            Offset = CFrame.new(0, 0, -4.75)
        },
        HitSounds = {
            Hit = v8.ReaverHeavy
        },
        Secondary = {
            Damage = 7,
            HitRemotes = { v6["Light Hit"] },
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 1
            },
            HitSounds = {
                Hit = v8.ReaverLight
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["Reaver-5"] = {
        Cooldown = 2,
        Speed = 1.45,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, "PlaySound", "Reaver 5" },
            { 17, "CreateArmor" },
            { 18, function(p42, p43, p44, p45) -- Line: 723
                    -- upvalues: u3 (copy)
                    local Character = p44.Character;
                    local _ = p44.Player;

                    for _, v in u3.Hitbox({
                        Caster = Character,
                        Stats = p45.AttackStats.Hit
                    }) do
                        u3.Attack({
                            Attacker = Character,
                            Target = v.Character,
                            Stats = p45.AttackStats.Hit
                        });
                    end;
                end },
            { 55, function(p46, p47, p48, p49) -- Line: 741
                    -- upvalues: u3 (copy), u2 (copy)
                    local Character = p48.Character;
                    local Player = p48.Player;
                    local v50 = u3.GetMetadata(Character);
                    u2.FireAllClients("CRYSTAL_SummonCrystal", {
                        CrystalScale = 1.1,
                        RadiusScale = 0.7,
                        DebrisScale = 1.1,
                        UseCoil = true,
                        Origin = v50.CFrame * CFrame.new(0, -4, -7.85),
                        Radius = p49.AttackStats.Crystal.Hitbox.Size,
                        Player = Player,
                        Sound = u3.FetchSound(Character, "Reaver Crystal"),
                        ReturnSound = u3.FetchSound(Character, "Crystal Return")
                    });

                    for _, v in u3.Hitbox({
                        Caster = Character,
                        Stats = p49.AttackStats.Crystal
                    }) do
                        u3.Attack({
                            Attacker = Character,
                            Target = v.Character,
                            Stats = p49.AttackStats.Crystal
                        });
                    end;
                end },
            { 92, "End" }
        },
        HitRemotes = { v6["Heavy Hit"] },
        Block = {
            PerfectBlockable = false
        },
        Hit = TableUtil.Reconcile({
            Damage = 9,
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8.5, 8, 9.5),
                Predict = true,
                Offset = CFrame.new(0, 0, -4.75)
            },
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 1
            },
            HitSounds = {
                Hit = v8.StandOffM1Heavy
            }
        }, BaseStatsModule.Rush_Attack),
        Crystal = TableUtil.Reconcile({
            Damage = 25,
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 10,
                Predict = true,
                Offset = CFrame.new(0, -1, -7)
            },
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 0.6
            }
        }, BaseStatsModule.Rush_Attack_Finisher),
        HitSounds = {
            Hit = v8.ReaverHeavy
        }
    },
    Callbacks = {
        StateChecker = function(p51, p52) -- Line: 833, Name: StateChecker
            return p51.Stats;
        end
    }
};
v1.fortify = {
    Active = true,
    ShieldPerShard = 5,
    DisableDuration = 3,
    MaxShield = 150,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 3,
        Manual = true
    }
};
v1.block = {
    From = "Combat.Block",
    Callbacks = {
        Transformer = function(p53, p54) -- Line: 862, Name: Transformer
            if p53.Character:GetAttribute("AwakenedMode") then
                p54.CustomPrefix = "Awakened";
            end;

            return p54;
        end
    }
};
v1.quickstep = {
    From = "Combat.Quickstep"
};
local New = Fusion.New;
v1.pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p55) -- Line: 882, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v56 = TableUtil.Copy(p55.Stats, true);
            v56.PoseMusic = "Pose";

            if not p55.Character:GetAttribute("AwakenedMode") then
                if not Knit.CollectionService:HasTag(p55.Character, "Summoned") then
                    v56.StartAnim = "StandOffPoseTransition";
                    v56.LoopAnim = "StandOffPoseIdle";
                end;

                return v56;
            end;

            v56.StartAnim = "AwakenPoseTransition";
            v56.LoopAnim = "AwakenPoseIdle";
            v56.PoseMusic = "AwakenPose";

            return v56;
        end,

        PoseTransition = function(p57, p58) -- Line: 898, Name: PoseTransition
            -- upvalues: New (copy), u3 (copy), ParticleHandler (copy), u4 (ref), u2 (copy)
            local Character = p57.Character;
            local Trove = p57.Trove;
            Trove:AttachToInstance(Character);
            local Model = Instance.new("Model");
            Model.Name = "Crystal_Vis";
            local v59 = New("Part")({
                Transparency = 1,
                Size = Vector3.new(40, 40, 40),
                Anchored = true,
                CastShadow = false,
                CanCollide = false,
                CanQuery = false,
                CanTouch = false,
                Name = "Attach",
                Shape = Enum.PartType.Ball,
                Parent = Model
            });
            local SoundId = u3.FetchSound(Character, p58.NewStats.PoseMusic).SoundId;
            local v60 = New("AudioPlayer")({
                Looping = true,
                Volume = 3,
                Asset = SoundId,
                Parent = v59
            });
            local v61 = New("AudioAnalyzer")({
                WindowSize = Enum.AudioWindowSize.Large,
                Parent = v59
            });
            local v62 = New("AudioEmitter")({
                Parent = v59
            });
            v62:SetDistanceAttenuation({
                [0] = 0.3,
                [100] = 0
            });
            New("Wire")({
                SourceInstance = v60,
                TargetInstance = v61,
                Parent = v61
            });
            New("Wire")({
                SourceInstance = v60,
                TargetInstance = v62,
                Parent = v62
            });
            ParticleHandler.AttachTo(v59, {
                UseMotor6D = true,
                Part = p57.RootPart
            });
            Model.Parent = workspace.Effects;
            u4:ToggleBasePartCollisions(Character, false);
            Trove:Add(Model);
            Trove:Add(function() -- Line: 961
                -- upvalues: u4 (ref), Character (copy), u2 (ref)
                u4:ToggleBasePartCollisions(Character);
                task.defer(function() -- Line: 963
                    -- upvalues: u2 (ref), Character (ref)
                    u2.FireAllClients("CRYSTAL_ShardRing", Character);
                end);
            end);
            v60:Play();
            task.wait(0.03333333333333333);
            u2.FireAllClients("CRYSTAL_Pose", {
                Reference = Model,
                Character = Character
            });
        end
    }
};
v1.grab = {
    From = "Combat.Grab",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
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
};
v1.barrage = TableUtil.Reconcile({
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        HitAnimations = "Default",
        HitRemotes = { v6["Light Hit"] },
        HitSounds = {
            Hit = v8.BarrageLight
        }
    },
    Finisher = {
        Frequency = 360,
        HitAnimations = "Default",
        CinnabarCrystallineInfliction = true,
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = v8.BarrageHeavy
        }
    },
    ClashHit = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Stand_Barrage_Clash", "__Attacker", "__Target" }
            } }
    },
    ClashFinisher = {
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.15
        },
        Block = {
            BlockBreak = true
        }
    }
}, BaseStatsModule.Stand_Barrage);
v1["shining surge"] = {
    Speed = 40,
    Duration = 4,
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 2.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.25,
        Velocity = Vector3.new(0, 30, 0)
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 25
    },
    Ragdoll = {
        Time = 2.5
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 10
    },
    HitRemotes = { v6["Heavy Hit"] },
    Cooldown = {
        Time = 4,
        AfterMove = true
    }
};
v1.Retaliation = {
    Normal = {
        MinHealth = 1,
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            Size = 10
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.2,
            Velocity = Vector3.new(0, 3, 0)
        },
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = v8.HeavyHit
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false
        }
    },
    Buffed = {
        Damage = 7,
        HitAnimations = "Default",
        Hitbox = {
            Size = 15
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 32,
            Time = 0.2,
            Velocity = Vector3.new(0, 10, 0)
        },
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = v8.HeavyHit
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false,
            BlockBreak = true
        }
    }
};
v1.dismember = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Light = {
        Damage = 8,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 9),
            Predict = false,
            Offset = CFrame.new(0, 0, -4.75)
        },
        Stun = {
            Time = 0.45
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 2,
            Time = 0.1
        },
        HitRemotes = { v6["Light Hit"] },
        HitSounds = {
            Hit = v8.StandOffM1Light
        }
    },
    Heavy = {
        Damage = 13,
        CinnabarCrystallineInfliction = true,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        Stun = {
            Time = 0.7
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.25
        },
        StatusEffects = { v7 },
        Block = {
            BlockBreak = true,
            PerfectBlockBreak = true
        },
        HitRemotes = { v6["Heavy Hit"], v6["Blood Splatter"] },
        HitSounds = {
            Hit = v8.StandOffM1Heavy
        }
    }
};
v1["piercing lunge"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17,
        AfterMove = true
    },
    Lunge = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 8, 7),
            HitboxType = "ClientHitbox",
            Tolerance = 1.5,
            Offset = CFrame.new(0, 0, -2.95)
        },
        Stun = {
            Time = 0.7
        },
        Block = {
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 52.5,
            Time = 0.25
        },
        HitRemotes = { v6["Light Hit"] },
        HitSounds = {
            Hit = v8.PiercingLunge
        }
    },
    Slam = {
        Damage = 30,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 2.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.25,
            Velocity = Vector3.new(0, 30, 0)
        },
        Ragdoll = {
            Time = 2.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12.5
        },
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = v8.M1Heavy
        }
    }
};
v1["crystalline volley"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Meter = {
        RequiredAmount = 15
    },
    Cooldown = {
        Time = 14
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 9),
        Predict = true,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Damage = 20,
    Stun = {
        Time = 0.7
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.2
    },
    HitRemotes = { v6["Light Hit"] },
    HitSounds = {
        Hit = v8.StandOffM1Light
    },
    HitAnimations = "Default",
    Projectile = {
        Damage = 7,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(4.5, 4.5, 4.5)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        StatusEffects = { v7 },
        Stun = {
            Time = 0.5
        },
        HitRemotes = { v6["Light Hit"] },
        HitSounds = {
            Hit = v8.CrystallineVolley
        }
    }
};
v1["fissure rupture"] = {
    Active = true,
    CrackSegments = 8,
    CrackRange = 70,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 45
    },
    Quake = {
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(10, 2, 12)
        },
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.5
        },
        HitRemotes = { v6["Light Hit"] }
    },
    Rupture = {
        Damage = 45,
        CinnabarCrystallineInfliction = true,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(10, 2, 12)
        },
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 0.6
        },
        StatusEffects = { {
                Name = "CrystallineInfliction",
                ApplyTo = "Target"
            } },
        HitRemotes = { v6["Light Hit"] },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 65, 0),
                Speed = 0,
                Time = 0.15
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(6, 0, 6),
                Time = 0.2
            } }
    },
    Cooldown = {
        Time = 25
    }
};
v1["prismatic lance"] = {
    Active = true,
    RayBounces = 2,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Ray = {
        Damage = 5,
        Block = {
            PerfectBlockable = false
        }
    },
    Impact = {
        Damage = 25,
        TrueDamage = 15,
        CinnabarCrystallineInfliction = true,
        Stun = {
            Time = 0.5
        },
        Block = {
            PerfectBlockable = false
        },
        StatusEffects = { {
                Name = "CrystallineInfliction",
                ApplyTo = "Target"
            } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Prismatic Lance/Hit",
                        AutoSerialize = true
                    } }
            } },
        HitSounds = {
            Hit = v8.PrismaticLance
        },
        HitAnimations = { 10506585922 }
    },
    Reflection = {
        Damage = 15,
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.5
        }
    },
    Cooldown = {
        Time = 16
    }
};
v1["burrowing quake"] = {
    Active = true,
    Range = 65,
    Actionable = {
        Active = true
    },
    ClientActonable = {
        Ground = true
    },
    Meter = {
        RequiredAmount = 15,
        RemoveMeter = false
    },
    Detect = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 7, 0),
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Quake = {
        Damage = 35,
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 14,
            Predict = true
        },
        Block = {
            BlockBreak = true
        },
        Ragdoll = {
            Time = 0.9,
            Intangible = false
        },
        Stun = {
            Time = 1.25
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 28, 0),
                Speed = 8,
                Time = 0.15
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(2, 0, 2),
                Time = 0.2
            } },
        HitSounds = {
            Hit = v8.M1Heavy
        }
    },
    Cooldown = {
        Time = 14
    }
};
v1.groundbreaker = {
    Active = true,
    Actionable = {
        Active = true
    },
    Attempt = {
        Segments = 4,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 5, 2.85),
            Offset = CFrame.new(0, 0, 0)
        },
        Primary = {
            Damage = 10,
            Stun = {
                Time = 0.6
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Velocity = Vector3.new(0, 15, 0),
                Time = 0.15
            },
            HitRemotes = { v6["Light Hit"] },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BypassCounter = true
            },
            Priority = EnumsModule.Intangible.Ragdoll
        },
        Secondary = {
            Damage = 10,
            Stun = {
                Time = 0.35
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BypassCounter = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = -15,
                Velocity = Vector3.new(0, 40, 0),
                Time = 0.25
            },
            HitRemotes = { v6["Light Hit"] },
            Priority = EnumsModule.Intangible.Ragdoll
        }
    },
    Grab = {
        Priority = EnumsModule.Intangible.Move,
        HeavySlam = {
            Damage = 15,
            MinHealth = 1,
            Priority = EnumsModule.Intangible.Move,
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BypassCounter = true
            },
            HitRemotes = { v6["Blood Hit"], v6["Blood Splatter"] }
        },
        Slam = {
            Damage = 10,
            MinHealth = 1,
            Priority = EnumsModule.Intangible.Move,
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BypassCounter = true
            },
            HitRemotes = { v6["Blood Hit"], v6["Blood Splatter"] }
        },
        Kick = {
            Damage = 15,
            Priority = EnumsModule.Intangible.Move,
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BypassCounter = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 45,
                Time = 0.2,
                Velocity = Vector3.new(0, 5, 0)
            },
            Ragdoll = {
                Time = 2
            },
            HitRemotes = { v6["Heavy Hit"] },
            HitSounds = {
                Hit = {
                    SoundId = 86975994522528,
                    Volume = 1.75
                }
            }
        }
    },
    Cooldown = {
        Time = 18
    }
};
v1["visceral strikes"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Slash = {
        Damage = 20,
        CinnabarCrystallineInfliction = true,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 8, 9),
            Offset = CFrame.new(0, 0, -4.5)
        },
        Stun = {
            Time = 0.55
        },
        StatusEffects = { v7 },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.15
        },
        HitRemotes = { v6["Heavy Hit"], v6["Blood Splatter"] },
        HitSounds = {
            Hit = v8.VisceralStrike1
        },
        Block = {
            BlockBreak = true
        }
    },
    Followup = {
        CinnabarCrystallineInfliction = true,
        Damage = 25,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 8, 9.5),
            Offset = CFrame.new(0, 0, -4.75)
        },
        Stun = {
            Time = 0.6
        },
        StatusEffects = { v7 },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15
        },
        HitRemotes = { v6["Heavy Hit"], v6["Blood Splatter"] },
        HitSounds = {
            Hit = v8.VisceralStrike2
        },
        Ragdoll = {
            Time = 0.5
        },
        Block = {
            BlockBreak = true
        }
    },
    Cooldown = {
        Time = 12
    }
};
v1["crystal reprisal"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    ClientActonable = {
        Ground = true
    },
    Crystal = {
        Damage = 35,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Predict = true
        },
        Stun = {
            Time = 0.5
        },
        Ragdoll = {
            Time = 0.6
        },
        HitRemotes = { v6["Light Hit"] },
        HitSounds = {
            Hit = v8.M1Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 50, 0),
                RelativePart = "Attacker",
                Speed = 25,
                Time = 0.15
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(6, 0, 6),
                Time = 0.2
            } },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true,
            BypassCounter = true
        }
    },
    Cooldown = {
        Time = 19
    }
};
v1.puncture = {
    Active = true,
    Distance = 115,
    Actionable = {
        Active = true
    },
    Charge = {
        Damage = 30,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.85, 8, 6),
            HitboxType = "ClientHitbox",
            Tolerance = 2.35,
            Offset = CFrame.new(0, 0, -4.5)
        },
        Stun = {
            Time = 0.9
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.25
        },
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = v8.Puncture
        }
    },
    WallImpact = {
        Damage = 45,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 14,
            Offset = CFrame.new(0, 0, 0)
        },
        Priority = EnumsModule.Intangible.Quickstep,
        Stun = {
            Time = 1.1
        },
        Ragdoll = {
            Time = 0.6
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 35, 0),
                Speed = 20,
                Time = 0.15
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(3, 2, 3),
                Time = 0.2
            } },
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = v8.HeavyHit
        }
    },
    Cooldown = {
        Time = 16
    }
};
v1["radiant meltdown"] = {
    Active = true,
    Duration = 2,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Explosion = {
        Damage = 25,
        CinnabarCrystallineInfliction = true,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Quickstep,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 18,
            Predict = true
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Stun = {
            Time = 0.5
        },
        Ragdoll = {
            Time = 0.6
        },
        StatusEffects = { {
                Name = "CrystallineInfliction",
                ApplyTo = "Target"
            } },
        HitRemotes = { v6["Heavy Hit"] },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 35, 0),
                RelativeTowards = "Target",
                Speed = 35,
                Time = 0.15
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(6, 0, 6),
                Time = 0.2
            } }
    },
    Pull = {
        Damage = 0,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 22,
            Predict = true
        },
        Priority = EnumsModule.Intangible.Ragdoll,
        Block = {
            BypassCounter = true,
            PerfectBlockable = false
        }
    },
    Cooldown = {
        Time = 25
    }
};
v1["adamant slash"] = {
    Active = true,
    CinnabarCrystallineInfliction = true,
    Actionable = {
        Active = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(14, 14, 35),
        HitboxType = nil,
        Offset = CFrame.new(0, 0, -17.5)
    },
    Initial = {
        Damage = 40,
        CinnabarCrystallineInfliction = true,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.1
        },
        Stun = {
            Time = 1.25
        },
        Ragdoll = {
            Time = 0.6
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        StatusEffects = { v7 },
        HitSounds = {
            Hit = v8.M1Heavy
        }
    },
    Projectile = {
        Damage = 35,
        HitAnimations = "Default",
        CinnabarCrystallineInfliction = true,
        Hitbox = {
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, 0)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        Priority = EnumsModule.Intangible.Ragdoll,
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 140620990397082,
                Volume = 1.5
            }
        }
    },
    Cooldown = {
        Time = 12
    }
};
v1["unrelenting impact"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Crystals = {
        Damage = 50,
        CinnabarCrystallineInfliction = true,
        HitAnimations = "Default",
        Stun = {
            Time = 2.5
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 70, 0),
                RelativeTowards = "Target",
                Speed = 10,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(6, 0, 6),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1.5
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 9
        },
        HitRemotes = { v6["Heavy Hit"] },
        HitSounds = {
            Hit = v8.HeavyHit
        },
        Priority = EnumsModule.Intangible.Quickstep
    },
    Impact = {
        Damage = 50,
        TrueDamage = 35,
        HitAnimations = "Default",
        Stun = {
            Time = 2.5,
            Priority = EnumsModule.Stun.Heavy
        },
        Ragdoll = {
            Time = 1.5
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 18
        },
        HitRemotes = { v6["Heavy Hit"] },
        Priority = EnumsModule.Intangible.Quickstep
    },
    Shockwave = {
        Damage = 0,
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Medium
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 0, 0),
                RelativeTowards = "Target",
                Speed = 25,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(3, 3, 3),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 0.3,
            Stack = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 5,
            EndSize = 85
        },
        Priority = EnumsModule.Intangible.Quickstep
    },
    Cooldown = {
        Time = 22
    }
};
v1.crystallized = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Roar = {
        Damage = 40,
        HitAnimations = "Default",
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Stun = {
            Time = 1.75
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 10, 0),
                RelativeTowards = "Target",
                Speed = 25,
                Time = 0.15
            } },
        Ragdoll = {
            Time = 0.8
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 14
        },
        HitRemotes = { v6["Heavy Hit"] },
        Priority = EnumsModule.Intangible.Ragdoll
    },
    Cooldown = {
        Time = 60,
        Manual = true
    }
};
v1["cycle gemstone"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 2
    }
};
v1["infuse gemstone"] = {
    Active = true,
    Duration = 20,
    Actionable = {
        Active = true,

        Check = function(p63) -- Line: 2461, Name: Check
            return p63:GetAttribute("InfusedGemstone") == nil;
        end
    },
    Cooldown = {
        Time = 10,
        Manual = true
    }
};

return {
    Stats = v1,
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 5
            },
            ["Status Effects"] = {
                Visible = true,
                Priority = 4.5
            },
            Universal = {
                Visible = true,
                Priority = 1
            },
            StandOff = {
                Visible = true,
                Priority = 2
            },
            StandOn = {
                Visible = false,
                Priority = 3
            },
            Rampage = {
                Visible = false,
                Priority = 4
            }
        },
        MovesInfo = {
            ["silicate composition"] = {
                State = "Passive",
                Description = "Your biological composition is altered into a <font color=\"#D2B48C\">silicate-based</font> structure. Due to this, <font color=\"#bf0000\"><b>life-steal</b></font> attacks that hit you no longer heal the attacker and you\'re immune to <font color=\"#bf0000\"><b>bleeding</b></font>. Your <b>blocking strength</b> is also amplified.",
                Equipped = true
            },
            ["sharp retaliation"] = {
                State = "Passive",
                Description = "Consecutive hits on you may cause a burst of <font color=\"#e322c5\">crystalline</font> shards to break off of you and damage nearby targets.",
                Equipped = true
            },
            ["crystal shards"] = {
                State = "Passive",
                Description = "You passively generate <font color=\"#e322c5\">crystalline</font> shards that orbit you. These shards will increase the amount of shield gained by <b>fortify</b> (5/shard) and the damage of <b>sharp retaliation</b> (5 damage/shard).",
                Equipped = true
            },
            ["Crystalline Infliction"] = {
                State = "Status Effects",
                Description = "Stackable DoT effect dealing burn damage (3.5 + 0.5/stack). At 2+ stacks, the target will receive a 50% heal reduction. Upon reaching the 4th stack, unleashes an explosion which inflicts true damage and transfers this effect on nearby targets. After this triggered, the target will be momentarily immune to this status effect.",
                Equipped = true
            },
            Intimidation = {
                State = "Status Effects",
                Description = "Disables sprinting, preventing your foes from fleeing.",
                Equipped = true
            },
            ["rush attack"] = {
                DefaultKeybind = "MouseButton1",
                State = "Universal",
                Equipped = true,
                MoveCapCount = false
            },
            fortify = {
                DefaultKeybind = "MouseButton2",
                State = "Universal",
                Equipped = true,
                Description = "Consume all active crystal shards to gain shield based on how many used. Only goes up to 150 shield."
            },
            block = {
                DefaultKeybind = "F",
                State = "Universal",
                Equipped = true,
                MoveCapCount = false
            },
            quickstep = {
                DefaultKeybind = "C",
                State = "Universal",
                Equipped = true,
                MoveCapCount = false
            },
            groundbreaker = {
                DefaultKeybind = "X",
                State = "Universal",
                Description = "Perform a ground shattering stomp, summoning a wave of <font color=\"#e322c5\">crystalline</font> pillars in front of you. These pillars will launch the closest target they hit towards you, starting a powerful beatdown.",
                Equipped = true
            },
            summon = {
                DefaultKeybind = "Q",
                State = "Universal",
                Equipped = true,
                Description = "Switch between the different forms of <font color=\"#FFA500\">crystallized</font>."
            },
            pose = {
                DefaultKeybind = "P",
                State = "Universal",
                Equipped = true
            },
            ["cycle gemstone"] = {
                DefaultKeybind = "B+",
                State = "Universal",
                LevelRequirement = 50,
                Description = "Cycle between your available gemstones.<br /><b><font color=\"#9c6eff\">Amethyst</font></b>: Block strength increased to 90%, <b>crystal shards</b> buildup cooldown reduced (3 > 2), 20% damage resistance, hits needed to trigger <b>sharp retaliation</b> reduced (5 > 4).<br /><b><font color=\"#ff5347\">Cinnabar</font></b>: 15% damage increase, several new moves (and moves that inflict bleed) now inflict <b><font color=\"#e322c5\">Crystalline Infliction</font> </b> + if a move would inflict the effect by default, it will inflict 2 stacks at once instead."
            },
            ["infuse gemstone"] = {
                DefaultKeybind = "B",
                State = "Universal",
                LevelRequirement = 50,
                Description = "Infuse yourself with the power of the selected gemstone."
            },
            ["crystal reprisal"] = {
                DefaultKeybind = "Z",
                State = "Universal",
                LevelRequirement = 35,
                Description = "Enter a counter stance, punishing any attacker by summoning a crystal below them."
            },
            ["burrowing quake"] = {
                DefaultKeybind = "V",
                State = "Universal",
                LevelRequirement = 25,
                Description = "You and <font color=\"#FFA500\">crystallized</font> swiftly drill into the aimed direction. Upon resurfacing, releases a quake that deals slight damage and trips over targets."
            },
            barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Equipped = true,
                Description = "Perform a barrage of punches with <font color=\"#FFA500\">crystallized</font>."
            },
            ["visceral strikes"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Equipped = true,
                Description = "<font color=\"#FFA500\">crystallized</font> performs a powerful slash, breaking the enemies guard and inflicting bleed. If quickly recasted, follow up with another, stronger slash."
            },
            puncture = {
                DefaultKeybind = "R+",
                State = "StandOn",
                LevelRequirement = 10,
                Description = "Shortly wind up before bashing forwards with <font color=\"#FFA500\">crystallized</font>, impaling and moving along any targets in your way."
            },
            ["prismatic lance"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                LevelRequirement = 60,
                Description = "<font color=\"#FFA500\">crystallized</font> charges a powerful projectile of pure light, bouncing off of surfaces and leaving a damaging trail of energy."
            },
            ["radiant meltdown"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                LevelRequirement = 75,
                Description = "Holdable. Charge up a powerful AoE attack which knocks targets away and inflicts <font color=\"#e322c5\">Crystalline Infliction</font>. Damage and range scale with duration held. At 50%+ hold duration, create an inwards pulling force shortly before the explosion."
            },
            crystallized = {
                DefaultKeybind = "H",
                State = "StandOn",
                LevelRequirement = 150,
                Description = "Awakening. You fuse with <font color=\"#FFA500\">crystallized</font>, granting you its armor and summoning a bigger, more powerful version of its axe form. In this mode, you are granted powerful new attacks. Additionally, you gain 10% damage & stun resistance and attacks from you inflict <b>Intimidation</b>, disabling sprinting for targets temporarily. The mode has an indicator showing how long it lasts and the duration can be increased by dealing damage. Duration decrement scales quickly with elapsed time."
            },
            dismember = {
                DefaultKeybind = "E",
                State = "StandOff",
                Equipped = true,
                Description = "Perform a swift combo of strikes with <font color=\"#FFA500\">crystallized</font>\'s axe form. Last hit severs an arm on the target and inflicts bleed."
            },
            ["piercing lunge"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                LevelRequirement = 10,
                Description = "Perform a swift windup before lunging forwards with your axe. If the lunge hit a target, follow up by summoning a crystal in front of you, dealing moderate damage and knocking away your targets."
            },
            ["crystalline volley"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                LevelRequirement = 25,
                Description = "Stomp the ground and summon a <font color=\"#e322c5\">crystalline</font> chunk in front of you. Using your axe, shatter the chunk and send sharp crystal fragments flying forwards, each dealing mediocre damage. Effective at close range."
            },
            ["fissure rupture"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                LevelRequirement = 35,
                Description = "Using your axe, perform a powerful downwards cleave, causing a crack to form along the ground, which also slows down targets near it. Follow up by slamming the ground, causing a rupture along the crack, knocking targets upwards and applying <font color=\"#e322c5\">Crystalline Infliction</font>."
            },
            ["axe reaver"] = {
                DefaultKeybind = "MouseButton1",
                State = "Rampage",
                Equipped = true,
                MoveCapCount = false,
                Description = "A slower but deadlier version of your rush attack. Also gains some armor."
            },
            ["adamant slash"] = {
                DefaultKeybind = "R",
                State = "Rampage",
                Equipped = true,
                MoveCapCount = false,
                Description = "Charge a powerful dashing cleave, inflicting bleed to any targets in your path and sending forwards a slashing projectile."
            },
            ["unrelenting impact"] = {
                DefaultKeybind = "G",
                State = "Rampage",
                MoveCapCount = false,
                LevelRequirement = 160,
                Description = "After a brief windup, jump high into the air before crashing down with your axe, causing a very powerful ground slam, sending ripples outwards in a spiral pattern and releasing a massive shockwave which slows targets down."
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 75550482007724,
            ["LMB-2"] = 131513761524593,
            ["LMB-3"] = 94417575047175,
            ["LMB-4"] = 107752358968847,
            ["StandOff-LMB-1"] = 79805424955074,
            ["StandOff-LMB-2"] = 93077136358465,
            ["StandOff-LMB-3"] = 95026268805772,
            ["StandOff-LMB-4"] = 138125191233155,
            Block = 139170786415581,
            BlockHit1 = 103275116086492,
            BlockHit2 = 127262553709555,
            BlockHit3 = 112164343992050,
            AwakenedBlock = 81597123743337,
            AwakenedBlockHit1 = 81597123743337,
            AwakenedBlockHit2 = 81597123743337,
            AwakenedBlockHit3 = 81597123743337,
            Summon = 17025308131,
            Desummon = 17025300672,
            BarrageStartup = 14559675296,
            Barrage = 14559676130,
            BarrageFinisher = 14559677108,
            BarrageClashEnd = 10839831781,
            Dismember = 73844159292602,
            ["Piercing Lunge"] = 132706866541171,
            ["Piercing Lunge Followup"] = 104117565016705,
            ["Crystalline Volley"] = 125111516347570,
            ["Fissure Rupture"] = 117147824435034,
            Groundbreaker = 90814813488902,
            ["Groundbreaker User"] = 107057116576554,
            ["Groundbreaker Victim"] = 117227540391013,
            ["Prismatic Lance"] = 98391544322914,
            Burrow = 115503629633677,
            ["Burrow Exit"] = 130270341345974,
            ["Visceral Strikes"] = 98433241850940,
            ["Visceral Strikes Followup"] = 116302445414806,
            ["Crystal Reprisal Attempt"] = 121838265459105,
            ["Crystal Reprisal"] = 93662975067945,
            ["Infuse Gemstone"] = 84717489885144,
            Puncture = 101135192723983,
            ["Radiant Meltdown"] = 101683758916861,
            ["Radiant Meltdown Start"] = 125778806649239,
            ["Radiant Meltdown Charge"] = 132319297799734,
            Awaken = 85556268525392,
            ["Awaken Camera"] = 85775962831649,
            ["Adamant Slash"] = 127482110852968,
            ["Unrelenting Impact"] = 111341451722342,
            ["Reaver-1"] = 139873523340810,
            ["Reaver-2"] = 87961728886591,
            ["Reaver-3"] = 119797002900928,
            ["Reaver-4"] = 92734790938479,
            ["Reaver-5"] = 73772132007337,
            StandOffPoseTransition = 98852331688339,
            StandOffPoseIdle = 105626189127158,
            PoseTransition = 137793417041637,
            PoseIdle = 94271477716717,
            AwakenPoseTransition = 75988709848166,
            AwakenPoseIdle = 87984616544063
        },
        Movement = {
            Walk = 17025489938,
            Run = 17025503315,
            AwakenedWalk = 100589598790683,
            AwakenedRun = 81298844019478,
            SummonedWalk = 17025497693,
            SummonedRun = 17025512648,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            AwakenedIdle = 97623285224752,
            SummonedIdle = 17025271872,
            Idle = 17025292522
        }
    },
    Sounds = {
        ["SwingLMB 1"] = {
            SoundId = "rbxassetid://108015421256084",
            Volume = 0.75
        },
        ["SwingLMB 2"] = {
            SoundId = "rbxassetid://72772109538695",
            Volume = 0.75
        },
        ["SwingLMB 3"] = {
            SoundId = "rbxassetid://124638984168122",
            Volume = 0.75
        },
        ["SwingLMB 4"] = {
            SoundId = "rbxassetid://120429080211346",
            Volume = 0.75
        },
        ["StandOff-SwingLMB 1"] = {
            SoundId = "rbxassetid://72351788555910",
            Volume = 0.6
        },
        ["StandOff-SwingLMB 2"] = {
            SoundId = "rbxassetid://120396781761913",
            Volume = 0.6
        },
        ["StandOff-SwingLMB 3"] = {
            SoundId = "rbxassetid://87282823286223",
            Volume = 0.6
        },
        ["StandOff-SwingLMB 4"] = {
            SoundId = "rbxassetid://79700745046413",
            Volume = 0.6
        },
        ["StandOff-LMB Crystal"] = {
            SoundId = "rbxassetid://131530647398164",
            Volume = 0.6
        },
        ["Reaver 1"] = {
            SoundId = "rbxassetid://106417359943685",
            Volume = 0.75
        },
        ["Reaver 2"] = {
            SoundId = "rbxassetid://99253371698348",
            Volume = 0.75
        },
        ["Reaver 3"] = {
            SoundId = "rbxassetid://77478753776577",
            Volume = 0.75
        },
        ["Reaver 4"] = {
            SoundId = "rbxassetid://78483844508253",
            Volume = 0.75
        },
        ["Reaver 5"] = {
            SoundId = "rbxassetid://114851282230415",
            Volume = 0.75
        },
        ["Reaver Crystal"] = {
            SoundId = "rbxassetid://129507865657105",
            Volume = 0.8
        },
        Barrage = {
            SoundId = "rbxassetid://135250070037685",
            Volume = 1
        },
        Pose = {
            SoundId = 92934606705010,
            Volume = 1
        },
        AwakenPose = {
            SoundId = 71660698696839,
            Volume = 1
        },
        ["Crystal Return"] = {
            SoundId = "rbxassetid://71090629347080",
            Volume = 0.75
        },
        SummonEffects = {
            SoundId = 136412029030717,
            Volume = 1
        },
        Desummon = {
            SoundId = 104619741121501,
            Volume = 1
        },
        ["Piercing Lunge"] = {
            SoundId = "rbxassetid://125043961259239",
            Volume = 0.75
        },
        ["Piercing Lunge Followup"] = {
            SoundId = "rbxassetid://97593274291367",
            Volume = 1.25
        },
        ["Piercing Lunge Crystal"] = {
            SoundId = "rbxassetid://137092859470287",
            Volume = 0.75
        },
        Dismember = {
            SoundId = "rbxassetid://92619849154944",
            Volume = 0.75
        },
        ["Fissure Rupture"] = {
            SoundId = "rbxassetid://112286342245731",
            Volume = 0.75
        },
        ["Fissure Rupture Quake"] = {
            SoundId = "rbxassetid://75214022115114",
            Volume = 0.75
        },
        ["Fissure Rupture Explode"] = {
            SoundId = "rbxassetid://135356251919464",
            Volume = 0.4
        },
        ["Crystalline Volley"] = {
            SoundId = "rbxassetid://137043156026525",
            Volume = 0.75
        },
        ["Visceral Strikes 1"] = {
            SoundId = "rbxassetid://71001674652612",
            Volume = 1.5
        },
        ["Visceral Strikes 2"] = {
            SoundId = "rbxassetid://108718485735293",
            Volume = 1.5
        },
        Puncture = {
            SoundId = "rbxassetid://82430987363109",
            Volume = 1.5
        },
        ["Prismatic Lance Charge"] = {
            SoundId = "rbxassetid://132435658527427",
            Volume = 1
        },
        ["Prismatic Lance Shoot"] = {
            SoundId = "rbxassetid://137661276636006",
            Volume = 1
        },
        ["Prismatic Lance Ricochet"] = {
            SoundId = "rbxassetid://131053171626199",
            Volume = 1.5
        },
        ["Radiant Meltdown"] = {
            SoundId = "rbxassetid://88568952828092",
            Volume = 1
        },
        ["Radiant Meltdown Explosion"] = {
            SoundId = "rbxassetid://123594156399293",
            Volume = 2,
            RollOffMaxDistance = 150
        },
        ["Radiant Meltdown Movement"] = {
            SoundId = "rbxassetid://79922029329380",
            Volume = 1.2
        },
        ["Radiant Meltdown Pull"] = {
            SoundId = "rbxassetid://81627037698271",
            Volume = 1.75
        },
        ["Crystal Reprisal"] = {
            SoundId = "rbxassetid://134639398697156",
            Volume = 0.75
        },
        ["Crystal Reprisal Followup"] = {
            SoundId = "rbxassetid://130422080386699",
            Volume = 0.75
        },
        ["Crystal Reprisal Crystal"] = {
            SoundId = "rbxassetid://115691186085213",
            Volume = 0.75
        },
        ["Burrowing Quake"] = {
            SoundId = "rbxassetid://116383539642323",
            Volume = 0.75
        },
        ["Burrowing Quake Movement"] = {
            SoundId = "rbxassetid://118952436126977",
            Volume = 1
        },
        ["Burrowing Quake Resurface"] = {
            SoundId = "rbxassetid://111384986395148",
            Volume = 0.75
        },
        Groundbreaker = {
            SoundId = "rbxassetid://131614577036622",
            Volume = 1
        },
        ["Groundbreaker Hit"] = {
            SoundId = "rbxassetid://137890246910026",
            Volume = 1.25
        },
        Fortify = {
            SoundId = "rbxassetid://125873150500097",
            Volume = 1
        },
        ["Crystal Shard Ambience"] = {
            SoundId = "rbxassetid://93829437736516",
            Looped = true,
            Volume = 0.2
        },
        ["Crystal Shard Spawn"] = {
            SoundId = "rbxassetid://100091365701555",
            Volume = 0.2
        },
        Retaliation = {
            SoundId = "rbxassetid://123872635243040",
            Volume = 1.35
        },
        ["Cycle Gemstone"] = {
            SoundId = "rbxassetid://135182767161810",
            Volume = 1
        },
        ["Infuse Gemstone"] = {
            SoundId = "rbxassetid://74590479321788",
            Volume = 1
        },
        ["Cinnabar Ambience"] = {
            SoundId = "rbxassetid://73597866142277",
            Looped = true,
            Volume = 0.25
        },
        ["Amethyst Ambience"] = {
            SoundId = "rbxassetid://110151176135354",
            Looped = true,
            Volume = 0.25
        },
        Crystallized = {
            SoundId = "rbxassetid://133041676557082",
            Volume = 0.95
        },
        ["Adamant Slash"] = {
            SoundId = "rbxassetid://104625515141846",
            Volume = 1.25
        },
        ["Adamant Slash Shoot"] = {
            SoundId = "rbxassetid://74667643892806",
            Volume = 1
        },
        ["Unrelenting Impact"] = {
            SoundId = "rbxassetid://89515303670716",
            Volume = 1.125
        },
        ["Unrelenting Impact Slam"] = {
            SoundId = "rbxassetid://73734028413839",
            Volume = 1.65,
            RollOffMaxDistance = 220
        },
        MeterUp2 = {
            SoundId = "rbxassetid://102194552182758",
            Volume = 1.5
        },
        MeterUp4 = {
            SoundId = "rbxassetid://103507780091846",
            Volume = 1.5
        }
    },
    Metadata = {
        PostRig = function(p64) -- Line: 3186, Name: PostRig
            -- upvalues: ParticleHandler (copy)
            local Player = p64.Player;
            local Character = p64.Character;
            local _ = p64.SkinName;

            if Player:IsA("Player") then
                local _ = Player.Data.Skin.Value;
            end;

            local v65 = Color3.fromRGB(240, 119, 214);
            Character:SetAttribute("MeterColor", (ParticleHandler.TryHSVShift(v65, ParticleHandler.GetUnusualHSVData({
                Character = Character
            }))));
        end
    }
};