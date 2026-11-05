  

 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5;

if game:GetService("RunService"):IsServer() then
    local v6 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Dragon Knight", true);
    u5 = require(v6.Common);
    require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
else
    u5 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 37
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);
local v7 = {
    SwordcastHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "EtherealSwordcast/Hit",
                AutoSerialize = true
            } }
    }
};

return {
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(u8, p9) -- Line: 64, Name: PoseTransition
                    -- upvalues: u3 (ref), u5 (ref)
                    local Trove = p9.Trove;
                    Trove:Add(u3:Add(u8.Tags, "NoRotate"));
                    print(u8);
                    u5:ManageAura({
                        IncludeHead = true,
                        Enabled = true,
                        MoveData = u8
                    });
                    Trove:Add(function() -- Line: 78
                        -- upvalues: u5 (ref), u8 (copy)
                        u5:ManageAura({
                            IncludeHead = true,
                            Enabled = false,
                            MoveData = u8
                        });
                    end);
                end
            }
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            MaxCombo = 4,
            ComboTick = 1,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p10, p11, p12) -- Line: 100
                            -- upvalues: u2 (ref)
                            local Character = p12.Character;
                            u2.FireAllClients("DK Slashes", Character, {
                                Orientation = CFrame.Angles(-10, 60, -180),
                                SkinName = p12.SkinName,
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.17453292519943295, 1.0471975511965976, -3.141592653589793)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v7["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p13, p14, p15) -- Line: 130
                            -- upvalues: u2 (ref)
                            local Character = p15.Character;
                            u2.FireAllClients("DK Slashes", Character, {
                                SkinName = p15.SkinName,
                                Orientation = CFrame.Angles(-20, -20, 0),
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.3490658503988659, -0.3490658503988659, 0)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v7["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p16, p17, p18) -- Line: 160
                            -- upvalues: u2 (ref)
                            local Character = p18.Character;
                            u2.FireAllClients("DK Slashes", Character, {
                                SkinName = p18.SkinName,
                                Orientation = CFrame.Angles(-20, 45, -180),
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.3490658503988659, 0.7853981633974483, -3.141592653589793)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v7["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 14, function(p19, p20, p21) -- Line: 190
                            -- upvalues: u2 (ref)
                            local Character = p21.Character;
                            local v22 = p21.RootPart or Character:FindFirstChild("HumanoidRootPart");
                            u2.FireAllClients("Emit Particle V3", {
                                Path = "Particles/LMBPierce",
                                AutoSerialize = true,
                                Origin = v22.CFrame * CFrame.new(0, 0, -3.4) * CFrame.Angles(1.5707963267948966, 0, 0),
                                Player = p21.Player,
                                Scale = Character:GetScale()
                            });
                        end },
                    { 14, 30, "Attack" },
                    { 32, "End" }
                },
                HitRemotes = { v7["Heavy Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196902660,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                PreAnim = function(p23) -- Line: 219, Name: PreAnim
                    -- upvalues: u5 (ref)
                    u5:ManageAura({
                        Enabled = true,
                        Trails = false,
                        Character = p23.Character
                    });
                end,

                PostAnim = function(p24) -- Line: 227, Name: PostAnim
                    -- upvalues: u5 (ref)
                    u5:ManageAura({
                        Enabled = false,
                        Trails = false,
                        Character = p24.Character
                    });
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
            Indicators = { {
                    Group = "Universal",
                    InputText = "%s",
                    Visible = true
                } },
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
        ["Rise \'n\' Shine"] = {
            Active = true,
            Damage = 20,
            InitialOffset = 5,
            OffsetIteration = 14,
            Actionable = {
                Active = true
            },
            Hitbox = {
                Size = Vector3.new(13, 100, 13)
            },
            Cooldown = {
                Time = 8.5,
                AfterMove = true
            },
            Ragdoll = {
                Time = 1.5
            },
            Stun = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Target",
                Time = 0.135,
                Speed = 0,
                Velocity = Vector3.new(0, 50, 0)
            }
        },
        ["Prismatic Beam"] = {
            Active = true,
            Damage = 2,
            Actionable = {
                Active = true
            },
            Hitbox = {
                Size = Vector3.new(13, 100, 13)
            },
            Cooldown = {
                Time = 8.5,
                AfterMove = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 4
            }
        },
        ["Dash of Light"] = {
            Active = true,
            Damage = 35,
            Actionable = {
                Active = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart"
            },
            ProjectileHitbox = {
                RelativePart = "HumanoidRootPart"
            },
            Cooldown = {
                Time = 8.5,
                AfterMove = true
            },
            Block = {
                Unblockable = true
            },
            Ragdoll = {
                Time = 0.8
            },
            Stun = {
                Time = 1.5
            },
            Projectile = {
                Damage = 5,
                HitSounds = {
                    Hit = {
                        SoundId = 17612934655,
                        Volume = 1
                    }
                }
            },
            HitSounds = {
                Hit = {
                    SoundId = 17612934883,
                    Volume = 1
                }
            }
        },
        ["Ethereal Swordcast"] = {
            Active = true,
            Damage = 10,
            Actionable = {
                Active = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart"
            },
            Cooldown = {
                Time = 8.5,
                AfterMove = true
            },
            HitRemotes = { v7.SwordcastHit }
        },
        ["Flare Burst"] = {
            Active = true,
            Damage = 40,
            Actionable = {
                Active = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 100
            },
            BeamHitbox = {
                Size = Vector3.new(12, 100, 12)
            },
            Cooldown = {
                Time = 8.5,
                AfterMove = true
            },
            Block = {
                Unblockable = true
            }
        }
    },
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Passive = {
                Visible = true,
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
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true
            },
            ["Rise \'n\' Shine"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = ""
            },
            ["Prismatic Beam"] = {
                DefaultKeybind = "G",
                Equipped = true,
                Description = ""
            },
            ["Dash of Light"] = {
                DefaultKeybind = "R",
                Equipped = true,
                Description = ""
            },
            ["Ethereal Swordcast"] = {
                DefaultKeybind = "T",
                Equipped = true,
                Description = ""
            },
            ["Flare Burst"] = {
                DefaultKeybind = "H",
                Equipped = true,
                Description = ""
            }
        }
    },
    Sounds = {
        Explosion = {
            SoundId = 17196824177,
            Volume = 3
        },
        PoseMusic = {
            Looped = true,
            SoundId = 17231105694,
            Volume = 3
        },
        MeterUp3 = {
            SoundId = 17214063440,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 17214063768,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 17196914918,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 17196915702,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 17196915345,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 17196915909,
            Volume = 2
        },
        DashOfLight = {
            SoundId = 17612934339,
            Volume = 1
        },
        SwordcastStartup = {
            SoundId = 17612931736,
            Volume = 1
        },
        SwordcastShoot = {
            SoundId = 17612931736,
            Volume = 1
        },
        FlareBurstStartup = {
            SoundId = 17612933892,
            Volume = 1
        },
        FlareBurstPillarIndicator = {
            SoundId = 17612932413,
            Volume = 1
        },
        RiseNShineStartup = {
            SoundId = 17612932097,
            Volume = 1
        },
        RiseNShinePillars = {
            SoundId = 17612935204,
            Volume = 1
        },
        PrismaticBeam = {
            SoundId = 17612933611,
            Volume = 1
        }
    },
    Animations = {
        Action = {
            Lunge = 17084004215,
            Fireball = 17084696185,
            Slam = 17084207683,
            Roar = 17161317682,
            Leap = 17183554069,
            ["Flame Pillar"] = 17084457888,
            ["Dragon\'s Fury"] = 17164265857,
            ["Draconic Shield"] = 17183293615,
            Rebirth = 17182678850,
            ["Inferno Beam Startup"] = 17184521021,
            ["Inferno Beam Loop"] = 17184524159,
            ["LMB-1"] = 17083452478,
            ["LMB-2"] = 17087038533,
            ["LMB-3"] = 17087045810,
            ["LMB-4"] = 17087049883,
            PoseTransition = 17231016843,
            PoseIdle = 17231005858
        },
        Movement = {
            Walk = 17083946566,
            Run = 17083923265
        },
        Idle = {
            Idle = 17083790464
        }
    }
};