  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 21
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local v2 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Passives = {
                Visible = true,
                Priority = 2
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v2.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    ManualMark = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        ManualMark = true,
        Speed = 1.5,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Shadow Mark"
            }, {
                ApplyTo = "Target",
                Name = "Technique 49"
            } },
        Sequence = {
            { 0, "Start" },
            { 22, function(p3, p4, p5) -- Line: 84
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p5.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(0, 0, 0),
                        Character = p5.Character
                    });
                end },
            { 22, 32, "Attack" }
        },
        HitRemotes = { v2.Resources.ParticleInfo.Hit },
        HitSounds = v2.Resources.SoundInfo.LMB
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        ManualMark = true,
        Speed = 1.5,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Shadow Mark"
            }, {
                ApplyTo = "Target",
                Name = "Technique 49"
            } },
        Sequence = {
            { 0, "Start" },
            { 22, function(p6, p7, p8) -- Line: 125
                    -- upvalues: u1 (ref)
                    local Character = p8.Character;
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/LMBPierce",
                        AutoSerialize = true,
                        Origin = p8.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p8.Player,
                        Scale = Character:GetScale()
                    });
                end },
            { 22, 40, "Attack" }
        },
        HitSounds = v2.Resources.SoundInfo.LMB,
        HitRemotes = { v2.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        ManualMark = true,
        Damage = 2.6666666666666665,
        Speed = 2.15,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Shadow Mark"
            }, {
                ApplyTo = "Target",
                Name = "Technique 49"
            } },
        Sequence = {
            { 0, "Start" },
            { 25, function(p9, p10, p11, p12) -- Line: 167
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slashes", p11.Player, {
                        Size = Vector3.new(8.5, 20, 8.5),
                        Duration = 0.5 / p9:GetSpeed(),
                        Color = Color3.fromRGB(0, 0, 0)
                    });
                end },
            { 25, "Attack", {
                    Multiple = true
                } },
            { 35, "Attack", {
                    Multiple = true
                } },
            { 45, "Attack", {
                    Multiple = true
                } }
        },
        HitSounds = v2.Resources.SoundInfo.LMB,
        HitRemotes = { v2.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        ManualMark = true,
        Speed = 1.7,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Shadow Mark"
            }, {
                ApplyTo = "Target",
                Name = "Technique 49"
            } },
        Sequence = {
            { 0, "Start" },
            { 34, function(p13, p14, p15) -- Line: 214
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p15.RootPart,
                        Offset = CFrame.Angles(0, 0, 0.7853981633974483),
                        EndCFrame = CFrame.Angles(0, -1.7453292519943295, 0),
                        Color = Color3.fromRGB(0, 0, 0),
                        Character = p15.Character
                    });
                end },
            { 34, 38, "Attack" },
            { 26, "End" }
        },
        HitSounds = v2.Resources.SoundInfo.LMB,
        HitRemotes = { v2.Resources.ParticleInfo.Hit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2.Stats["Slime Emission"] = {
    Active = true,
    Damage = 10,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7.5,
        Manual = true
    },
    Hitbox = {
        Size = 20,
        Offset = CFrame.new(0, 0, 0)
    },
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.8
    },
    HitRemotes = { v2.Resources.ParticleInfo.Slime }
};
v2.Stats["Atomic: Recovery"] = {
    Active = true,
    Heal = 20,
    MaxHeal = 50,
    DisableMark = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Priority = Enums.Intangible.Move,
    HitRemotes = { v2.Resources.ParticleInfo.Heal },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        FriendlyFire = true,
        Offset = CFrame.identity
    }
};
v2.Stats["Silhouette Slashes"] = {
    Active = true,
    CustomPrefix = "SilhouetteSlashes",
    Frequency = 3,
    Speed = 1.9,
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Actionable = {
        Active = true
    },
    Callbacks = {
        BarrageEffect = function(p16, u17, p18, p19) -- Line: 331, Name: BarrageEffect
            -- upvalues: Knit (copy), u1 (ref)
            local Character = u17.Character;

            if p19 then
                Knit.CollectionService:AddTag(Character, "Barrage");
                u1.FireAllClients("Shadow_BarrageEffect", {
                    Player = u17.Player,
                    SkinName = u17.SkinName
                });
                p18.SequenceTrove:Add(function() -- Line: 342
                    -- upvalues: Knit (ref), Character (copy), u1 (ref), u17 (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barrage");
                    u1.FireAllClients("Shadow_BarrageEffect", {
                        Player = u17.Player
                    });
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barrage");
                u1.FireAllClients("Shadow_BarrageEffect", {
                    Player = u17.Player
                });
            end;

            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        Damage = 0.7,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 9,
            Offset = CFrame.new(0, 0, -2)
        },
        HitRemotes = { v2.Resources.ParticleInfo.Hit },
        HitSounds = v2.Resources.SoundInfo.SilhouetteSlashes
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15,
            Velocity = Vector3.new(0, 30, 0)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 14,
            Offset = CFrame.new(0, -2, -7)
        }
    },
    Search = {
        Size = 20,
        Offset = CFrame.new(0, -2, 0)
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Silhouette Slashes", {
                Cancelable = true
            } },
        { 0, "PlaySound", "Silhouette Slashes Voiceline", {
                Cancelable = true
            } },
        { 0, function(p20, p21, p22) -- Line: 418
                -- upvalues: TableUtil (copy), u1 (ref)
                p22.Stats = TableUtil.Copy(p22.Stats, true);
                p22.Stats.Mark = true;
                u1.FireAllClients("Emit Particle V3", {
                    Path = "Particles/Indicator",
                    Player = p22.Player,
                    Character = p22.Character,
                    AttachTo = {
                        Part = p22.Character.Head
                    }
                });
            end },
        { 32, "Cancelable", true },
        { 32, "Clashable", true },
        { 32, "CreateTag", "MaxWalkSpeed", 8 },
        { 24, function(p23, p24, p25) -- Line: 436
                -- upvalues: PathShortcuts (copy), Knit (copy), u1 (ref)
                local Player = p25.Player;
                local Character = p25.Character;
                local RootPart = p25.RootPart;

                if not Character:GetAttribute("Overdrive") then
                    return;
                end;

                local v26 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
                local v27 = Knit.GetService("PingService");
                local v28 = v26.Hitbox({
                    Caster = Character,
                    Stats = p25.Stats.Search
                });
                local v29;

                if Player then
                    v29 = v27.Get(Player);
                else
                    v29 = Player;
                end;

                local Position = RootPart.Position;

                if v29 then
                    Position = v29.MouseHit.Position;
                end;

                local v30 = {};

                for _, v in v28 do
                    local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");

                    if HumanoidRootPart then
                        table.insert(v30, {
                            Character = v.Character,
                            Part = HumanoidRootPart,
                            Distance = (Position - HumanoidRootPart.Position).Magnitude
                        });
                    end;
                end;

                table.sort(v30, function(p31, p32) -- Line: 473
                    return p31.Distance < p32.Distance;
                end);
                local v33 = v30[1];

                if not v33 then
                    return;
                end;

                local v34 = Vector3.new(RootPart.Position.X, v33.Part.Position.Y, RootPart.Position.Z);
                u1.FireClient(Player, {
                    BoxCameraShake = { "MediumCharge" },
                    ["Vignette Gui"] = {
                        {
                            TweenTime = 0.2,
                            Blur = 25,
                            StartingColor = Color3.fromRGB(124, 0, 2),
                            EndingColor = Color3.fromRGB(62, 12, 13)
                        }
                    }
                });
                u1.FireAllClients({
                    {
                        Name = "Emit Particle V3",
                        Data = {
                            {
                                Path = "Particles/Teleport",
                                AutoSerialize = true,
                                Scale = 1.75,
                                Origin = RootPart.Position,
                                AbilityName = p25.AbilityName,
                                SkinName = p25.SkinName,
                                Player = Player
                            }
                        }
                    },
                    {
                        Name = "Emit Particle V3",
                        Data = {
                            {
                                Path = "Particles/Teleport",
                                AutoSerialize = true,
                                Scale = 1.75,
                                Origin = CFrame.lookAt(v34, v33.Part.Position),
                                AbilityName = p25.AbilityName,
                                SkinName = p25.SkinName,
                                Player = Player
                            }
                        }
                    },
                    {
                        Name = "Afterimage",
                        Data = {
                            {
                                Duration = 1,
                                Speed = 0.5,
                                Brightness = 1,
                                Lifetime = 1,
                                Transparency = 0.5,
                                Whitelist = { Character },
                                Blacklist = { "ParticleEmitter", "Stand" }
                            }
                        }
                    }
                });
                RootPart.CFrame = CFrame.lookAt(v33.Part.Position, v34) * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0);
                v26.PlaySound(Character, "Atomic: Flash");
            end },
        { 33, "Barrage", true },
        { 33, 252, "BarrageAttack", "Hit" },
        { 252, "Cancelable", false },
        { 252, "Clashable", false },
        { 252, "CreateTag", "NoRotate" },
        { 252, "CreateTag", "MaxWalkSpeed", 2 },
        { 252, "BarrageFinisher" },
        { 260, function(p35, p36, p37) -- Line: 554
                -- upvalues: u1 (ref)
                local v38 = 0.6666666666666666 / p35:GetSpeed();
                u1.FireAllClients("UberOni_RagingDemon", {
                    Character = p37.Character,
                    Time = v38
                });
            end },
        { 300, function(p39, p40, p41) -- Line: 563
                -- upvalues: u1 (ref)
                u1.FireClient(p41.Player, { {
                        Name = "TedBlur",
                        Data = { 25, 0.2 }
                    }, {
                        Name = "InvertedLighting",
                        Data = { 0.2, 0.7 }
                    } });
            end },
        { 301, "CreateTag", "MaxWalkSpeed", 0 },
        { 301, "BarrageAttack", "Finisher" },
        { 301, "PlaySound", "Silhouette Slashes Slam" },
        { 301, function(p42, p43, p44, p45) -- Line: 578
                -- upvalues: u1 (ref)
                local v46 = p44.Stats or {};
                local v47 = p44.RootPart.CFrame * v46.Finisher.Hitbox.Offset;
                u1.FireClient(p44.Player, "Impact Frame", {
                    Time = 0.1,
                    Models = { p44.Character }
                });
                u1.FireAllClients({
                    {
                        Name = "Q_RADIAL",
                        Data = {
                            {
                                Distance = 40,
                                Origin = v47,
                                Effect = { {
                                        Effect = "BoxCameraShake",
                                        Arguments = { { "MediumSlam" } }
                                    } }
                            }
                        }
                    },
                    {
                        Name = "Emit Particle V3",
                        Data = {
                            {
                                Path = "Particles/Slam",
                                AutoSerialize = true,
                                Scale = 1,
                                Origin = v47 * CFrame.new(0, -1, 0),
                                Player = p44.Player,
                                AbilityName = p44.AbilityName or "Shadow",
                                SkinName = p44.SkinName
                            }
                        }
                    },
                    {
                        Name = "Rock Debris",
                        Data = {
                            {
                                Lifetime = 2.5,
                                Amount = 23,
                                Origin = v47,
                                Radius = v46.Finisher.Hitbox.Size
                            }
                        }
                    },
                    {
                        Name = "Flying Debris",
                        Data = {
                            {
                                Lifetime = 2.5,
                                Collision = true,
                                Size = 1.5,
                                Force = Vector3.new(30, 42, 30),
                                TweenDelay = 0.9,
                                Origin = v47,
                                Tween = {
                                    Transparency = 1,
                                    Size = Vector3.new(0, 0, 0)
                                }
                            }
                        }
                    }
                });
            end },
        { 340, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v2.Stats["Umbral Charge"] = {
    Mark = true,
    Active = true,
    Stun = 0.4,
    Damage = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        Manual = true
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 10
    },
    Hitbox = {
        Size = Vector3.new(12, 12, 35),
        Offset = CFrame.new(0, 0, 0)
    },
    HitSounds = v2.Resources.SoundInfo.UmbralCharge,
    Block = {
        PerfectBlockable = false,
        Blockable = true
    }
};
v2.Stats["Umbral Smash"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Slice = {
        ManualMark = true,
        Damage = 15,
        Stun = 1,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Shadow Mark"
            } },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        Block = {
            BlockBreak = true
        }
    },
    Kick = {
        ManualMark = true,
        Damage = 5,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Shadow Mark"
            } },
        Priority = Enums.Intangible.Move
    },
    Smash = {
        ManualMark = true,
        Damage = 25,
        Priority = Enums.Intangible.Move
    }
};
v2.Stats["Eidolon Tears"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Projectile = {
        Damage = 2.2222222222222223,
        HomingRadius = 35,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Stun = {
            Time = 0.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 4,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        HitSounds = {},
        HitRemotes = { v2.Resources.ParticleInfo.Slime }
    }
};
v2.Stats["Birdcage Of Darkness"] = {
    Active = true,
    CheckPVPSafe = true,
    DisableMark = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    HitSounds = v2.Resources.SoundInfo.BirdcageOfDarkness,
    Stun = {
        Time = 5
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.identity
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    }
};
v2.Stats["Shadow\'s Retribution"] = {
    Active = true,
    Damage = 30,
    Mark = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Priority = Enums.Intangible.Move,
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Stun = {
        Time = 1.25
    },
    Ragdoll = {
        Time = 1.45
    },
    HitRemotes = { v2.Resources.ParticleInfo.Hit },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.2
    }
};
v2.Stats["Imminent Blink"] = {
    Active = true,
    Armor = true,
    Damage = 2,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Meter = {
        RequiredAmount = 55,
        MeterGain = 0
    },
    HitSounds = v2.Resources.SoundInfo.ImminentBlink,
    Ragdoll = {
        Time = 1
    },
    Hitbox = {
        Size = Vector3.new(25, 25, 65),
        Offset = CFrame.new(0, 0, -40)
    },
    Block = {
        BypassCounter = true,
        Unblockable = true,
        PerfectBlockable = false,
        Blockable = false
    }
};
v2.Stats.Block = {
    From = "Combat.Block"
};
v2.Stats.Highest = {
    Active = true,
    Actionable = {
        Active = true
    },
    Finisher = {
        Damage = 70,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Cooldown = {
            Time = 1,
            AfterMove = true
        },
        Ragdoll = {
            Time = 2.5
        },
        HitRemotes = { v2.Resources.ParticleInfo.Hit },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    },
    Meter = {
        RequiredAmount = 100
    },
    HitSlam = {
        Meter = false,
        Damage = 20,
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    },
    Slam = {
        Damage = 20,
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.15,
            Velocity = Vector3.new(0, 30, 0)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.identity
        }
    },
    Cooldown = {
        Time = 35,
        AfterMove = true
    },
    Startup = {
        Meter = false,
        CheckPVPSafe = true,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(40, 40, 40),
            Offset = CFrame.new(0, -2, 0)
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    }
};
v2.Stats.Overdrive = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 50,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Buffs = {
        Attack = 50,
        Special = 40,
        Defense = 30
    }
};
v2.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p48, p49) -- Line: 1075, Name: PoseTransition
            -- upvalues: u1 (ref), AssetHandler (copy), ParticleHandler (copy)
            local Trove2 = p48.Trove;
            local Character = p48.Character;
            local RootPart = p48.RootPart;
            local u50 = os.clock();
            Character:SetAttribute("AtomicAura", true);
            u1.FireAllClients({
                {
                    Name = "Shadow_AtomicAura",
                    Data = {
                        RootPart,
                        {
                            Wind = true,
                            AbilityName = p48.AbilityName,
                            SkinName = p48.SkinName
                        }
                    }
                },
                {
                    Name = "Enable Particles",
                    Data = {
                        {
                            Enabled = true,
                            Id = u50,
                            Parent = Character:FindFirstChild("Left Arm"),
                            Offset = CFrame.new(0, 1.25, 0),
                            ReferencePart = AssetHandler.GetAsset("Particles/PoseStar", p48),
                            HSVShift = ParticleHandler.GetUnusualHSVData(p48)
                        }
                    }
                }
            });
            Trove2:Add(function() -- Line: 1111
                -- upvalues: u1 (ref), u50 (copy), Character (copy)
                u1.FireAllClients("Enable Particles", {
                    Id = u50
                });
                Character:SetAttribute("AtomicAura", nil);
            end);
        end
    }
};
v2.Stats["\"I am atomic.\""] = {
    Active = true,
    Damage = 2,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        MeterGain = 0,
        RemoveMeter = false,
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 160,
        Global = 80,
        Manual = true
    },
    Priority = Enums.Intangible.Quickstep,
    Hitbox = {
        Size = 200,
        EndSize = 200,
        Offset = CFrame.identity
    },
    Stun = {
        Time = 2
    },
    Ragdoll = {
        Time = 3
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true,
        Unblockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 12,
        Time = 0.1
    }
};
v2.Stats.Shadowstep = {
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
        Time = 1.5,
        Force = true,
        CooldownReduction = false
    },

    Invoke = function(p51) -- Line: 1201, Name: Invoke
        -- upvalues: Knit (copy), TagService (copy), AnimationHandler (copy), Trove (copy)
        local v52 = Knit.GetController("CombatController");
        local v53 = Knit.GetController("PilotController");
        local v54 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        TagService:GetContainer(LocalPlayer);
        local _ = p51.Input;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local u55 = AnimationHandler.Get(Humanoid.Animator);
        local ActivePilot = v53.ActivePilot;

        if ActivePilot then
            Humanoid = ActivePilot:FindFirstChild("Humanoid") or Humanoid;
            HumanoidRootPart = ActivePilot:FindFirstChild("HumanoidRootPart") or HumanoidRootPart;
        end;

        LocalPlayer.Data.Ability:GetAttribute("AbilityName");
        local v56 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        v54:FireInput(p51.RawInput);

        local function Lerp(p57, p58, p59) -- Line: 1230
            return p57 + (p58 - p57) * p59;
        end;

        local v60 = 100;
        local v61 = 12.5;

        if Character:GetAttribute("Overdrive") then
            v60 = v60 * 1.35;
            v61 = v61 * 1.35;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Velocity = v56 * v60;
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Parent = HumanoidRootPart;
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
        AlignOrientation.RigidityEnabled = true;
        AlignOrientation.CFrame = HumanoidRootPart.CFrame;
        AlignOrientation.Parent = HumanoidRootPart;
        local v62 = HumanoidRootPart.CFrame:VectorToObjectSpace(v56);
        local v63 = math.atan2(v62.X, -v62.Z);
        local v64 = math.deg(v63) - 0.5;
        local v65 = math.ceil(v64);
        local v66 = v65 > 45 and v65 < 135 and "Right" or (v65 < -45 and v65 > -135 and "Left" or ((v65 <= -135 or v65 >= 135) and "Backward" or "Forward"));
        local v67;

        if v66 == "Forward" then
            Character:SetAttribute("DashCounter", Character:GetAttribute("DashCounter") == 2 and 1 or (Character:GetAttribute("DashCounter") == 1 and 2 or 1));
            v67 = Character:GetAttribute("DashCounter");
        else
            v67 = "";
        end;

        local u68 = false;
        local v69 = Trove.new();
        local u70 = (ActivePilot and "Pilot" or "") .. v66 .. "Dash" .. v67;
        u55:PlayAnimation(u70, 0.9);
        v69:Add(v52.QuickstepInterrupted:Connect(function() -- Line: 1280
            -- upvalues: u68 (ref), u55 (copy), u70 (copy)
            u68 = true;
            u55:StopAnimation(u70, 0.9);
        end));
        local v71 = os.clock();

        while not u68 and os.clock() - v71 <= 0.35 do
            local v72 = os.clock() - v71;
            local v73 = math.abs(v72) / 0.35;
            local v74 = math.clamp(v73, 0, 1);
            BodyVelocity.Velocity = v56 * math.clamp(v60 + (v61 - v60) * v74, v61, v60);
            task.wait();
        end;

        BodyVelocity:Destroy();
        AlignOrientation:Destroy();

        if u68 then
            local v75 = os.clock() - v71;
            local v76 = math.abs(v75) / 0.35;
            local v77 = math.clamp(v76, 0, 1);
            local v78 = math.lerp(v77, 1, 0.5);
            local v79 = math.min(v78, 1);
            local v80 = math.lerp(v60, v61, v79);
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v56.X * v80, HumanoidRootPart.AssemblyLinearVelocity.Y, v56.Z * v80);
        end;

        v69:Destroy();
    end
};
v2.Stats["Dark Blade"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Impale = {
        ManualMark = true,
        Damage = 15,
        Stun = 1,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Shadow Mark"
            } },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -3)
        },
        HitRemotes = { v2.Resources.ParticleInfo.Impale },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Slice = {
        ManualMark = true,
        Mark = true,
        Damage = 10,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Leg Cut"
            }, {
                ApplyTo = "Target",
                Name = "Shadow Mark"
            } },
        Priority = Enums.Intangible.Move,
        HitRemotes = { v2.Resources.ParticleInfo.Hit },
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
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
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v2.Stats["Atomic: Flash"] = {
    Distance = 30,
    Active = true,
    Actionable = {
        Active = true
    },
    ClientActionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },

    Invoke = function(p81) -- Line: 1426, Name: Invoke
        -- upvalues: Knit (copy)
        local _ = p81.Input;
        local Character = game.Players.LocalPlayer.Character;
        local Stats = p81.Stats;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v82 = Knit.GetService("MoveInputService");

        if Knit.CollectionService:HasTag(Character, "Timestopped") then
            return;
        end;

        local v83 = RaycastParams.new();
        v83.FilterType = Enum.RaycastFilterType.Exclude;
        v83.FilterDescendantsInstances = { Character, workspace.Effects };
        local v84 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local Distance = Stats.Distance;

        if Character:GetAttribute("Overdrive") then
            Distance = Distance * 1.5;
        end;

        local v85 = workspace:Raycast(HumanoidRootPart.Position, v84 * Distance, v83);

        if v85 then
            Distance = (HumanoidRootPart.Position - v85.Position).Magnitude;
        end;

        local _ = HumanoidRootPart.CFrame;
        local u86 = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v84).LookVector.Unit * Distance;
        task.delay(0.2, function() -- Line: 1462
            -- upvalues: HumanoidRootPart (copy), u86 (copy)
            HumanoidRootPart.CFrame = u86;
        end);
        v82:FireInput(p81.RawInput, HumanoidRootPart.CFrame, u86);
        task.wait(0.25);
    end
};
v2.Stats["Atomic: Sword"] = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Cooldown = {
        Time = 21,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Offset = CFrame.identity
    },
    HitSounds = v2.Resources.SoundInfo.AtomicSword,
    Block = {
        PerfectBlockable = true,
        BlockBreak = true,
        BypassCounter = true
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 25,
        Time = 0.15
    },
    HitRemotes = { v2.Resources.ParticleInfo.Hit }
};
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v2;