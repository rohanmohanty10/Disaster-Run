  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u2 = nil;
local u3 = nil;
local u4 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Knit.OnStart():andThen(function() -- Line: 19
    -- upvalues: u2 (ref), Knit (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("ProjectileService");
end);
local v5 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Universal/LightHit",
                AutoSerialize = true,
                LookAt = "Attacker"
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
    }
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose",
    MusicAmount = 2
};
v1.Block = {
    From = "Combat.Block"
};
v1.Grab = {
    From = "Combat.Grab"
};

local function Shoot(p6, u7, u8) -- Line: 79
    -- upvalues: u4 (copy), Knit (copy), AssetHandler (copy), ParticleHandler (copy), u3 (ref), u2 (ref)
    local _ = p6.Player;
    local Character = p6.Character;
    local _ = p6.Humanoid;
    local RootPart = p6.RootPart;
    local _ = p6.Tags;
    local AttackStats = u7.AttackStats;
    local v9 = u4.GetMetadata(Character);
    local v10 = v9.CFrame * CFrame.new(0, 0, -1);
    local LookVector = v9.CFrame.LookVector;
    local Bearing = Knit.ServerLibrary.ProjectileData.Abilities["Crazy Diamond"].Bearing;
    local v11 = AssetHandler.CloneAsset("Particles/MagicBullet", p6);
    ParticleHandler.ScaleParticle(v11, v9.Scale or 1);
    ParticleHandler.Unusualify(v11, {
        Character = Character
    });
    v11.Size = v11.Size * (v9.Scale or 1);
    v11.Parent = workspace.Effects;
    v11.Anchored = true;
    local v12 = u3.Fire(Bearing, v10.Position, LookVector, nil, {
        Velocity = 200,
        MoveStats = AttackStats.Projectile,
        Caster = Character,
        Object = v11,
        MaxDistance = Character:GetAttribute("NPC") and 60 or 30
    });
    u2.FireAllClients("Emit Particle V3", {
        Path = "Particles/Phantasmal Bullets/BulletSummon",
        AutoSerialize = true,
        AttachTo = {
            Part = RootPart,
            Offset = CFrame.new(0, 0, 3)
        },
        Scale = AttackStats.Explosion.Hitbox.Size / 8 + 0.7,
        Character = Character
    });

    function v12.Termination(p13) -- Line: 118
        -- upvalues: ParticleHandler (ref), AttackStats (copy), u2 (ref), u4 (ref), Character (copy), u8 (copy), u7 (copy)
        local CosmeticBullet = p13.CosmeticBullet;
        CosmeticBullet.Transparency = 1;

        if CosmeticBullet then
            ParticleHandler.EnableAllParticles(CosmeticBullet, false);
            task.delay(0.1, CosmeticBullet.Destroy, CosmeticBullet);
        end;

        AttackStats.Explosion.Hitbox.Origin = CFrame.new(p13:GetPosition());
        AttackStats.Explosion.Knockback.Origin = p13:GetPosition();
        u2.FireAllClients({
            {
                Name = "Play Sound At",
                Data = {
                    {
                        Object = u4.FetchSound(Character, "LMB Projectile Explosion"),
                        Origin = CFrame.new(p13:GetPosition())
                    }
                }
            },
            {
                Name = "Emit Particle V3",
                Data = {
                    {
                        Path = "Particles/Explosion",
                        AutoSerialize = true,
                        Origin = CFrame.new(p13:GetPosition()),
                        Scale = AttackStats.Explosion.Hitbox.Size / 8 * 0.85,
                        Character = Character
                    }
                }
            }
        });

        for _, v in u4.Hitbox({
            Caster = Character,
            Stats = AttackStats.Explosion
        }) do
            u4.Attack({
                Attacker = Character,
                Target = v.Character,
                Stats = AttackStats.Explosion
            }):andThen(function(p14) -- Line: 176
                -- upvalues: u8 (ref), u7 (ref), v (copy)
                if p14.State.Success then
                    if not u8.Hit then
                        u8.Hit = {};
                    end;

                    if not u8.Hit[u7.FullName] then
                        u8.Hit[u7.FullName] = {};
                    end;

                    u8.Hit[u7.FullName][v.Character] = true;
                end;
            end);
        end;
    end;
end;

v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 3,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 37, function(p15, p16, p17, p18, p19) -- Line: 202
                    -- upvalues: Shoot (copy)
                    local _ = p17.Character;
                    local _ = p17.Player;
                    Shoot(p17, p18, p15);
                end },
            { 35, 39, "Attack" },
            { 50, "End" }
        },
        HitRemotes = { v5["Light Hit"] },
        Stun = {
            Time = 0.65
        },
        HitSounds = {
            Hit = {
                SoundId = 11713885181,
                Volume = 2
            }
        },
        Projectile = {
            Damage = 0,
            HitAnimations = "Default",
            Hitbox = {
                Size = Vector3.new(4.5, 4.5, 4.5)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitRemotes = { v5["Light Hit"] }
        },
        Explosion = {
            Damage = 6,
            Hitbox = {
                Size = 7
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 10,
                Time = 0.1
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Stun = {
                Time = 0.65
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 33, function(p20, p21, p22, p23) -- Line: 277
                    -- upvalues: Shoot (copy)
                    local _ = p22.Character;
                    local _ = p22.Player;
                    Shoot(p22, p23, p20);
                end },
            { 31, 35, "Attack" },
            { 44, "End" }
        },
        HitRemotes = { v5["Light Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 11713885181,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.35,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 44, "Attack" },
            { 44, function(p24, p25, p26, p27) -- Line: 333
                    -- upvalues: Shoot (copy)
                    local _ = p26.Character;
                    local _ = p26.Player;
                    p27.Scale = 1.45;
                    Shoot(p26, p27, p24);
                end },
            { 55, "End" }
        },
        HitRemotes = { v5["Heavy Hit"] },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7, 7, 7.5),
            Offset = CFrame.new(0, -1, -3.75)
        },
        HitSounds = {
            Hit = {
                SoundId = 11713885288,
                Volume = 2
            }
        },
        Projectile = {
            Damage = 0,
            HitAnimations = "Default",
            Hitbox = {
                Size = Vector3.new(4.5, 4.5, 4.5)
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            HitRemotes = { v5["Light Hit"] }
        },
        Explosion = {
            Damage = 12,
            Hitbox = {
                Size = 10
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 15,
                Time = 0.14
            },
            Stun = {
                Time = 0.7
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {}
};
v1.DeathPreventionBurst = {
    Damage = 25,
    HitAnimations = "Default",
    Hitbox = {
        Size = 12,
        Offset = CFrame.new(0, 0, 0)
    },
    Stun = {
        Time = 0.35
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Knockback = {
        RelativeTowards = "Attacker",
        Speed = -20,
        Time = 0.15,
        Velocity = Vector3.new(0, 5, 0)
    },
    HitRemotes = { v5["Light Hit"] }
};
v1.Revitalization = {
    Damage = 35,
    WeakenDuration = 6,
    HitAnimations = "Default",
    Active = true,
    Actionable = {
        Active = true
    },
    Hitbox = {
        Size = 23,
        Offset = CFrame.new(0, -1, 0)
    },
    Support = {
        HealPercent = 0.1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 23,
            FriendlyFire = true,
            Offset = CFrame.new(0, -1, 0)
        },
        Priority = EnumsModule.Intangible.Move
    },
    Stun = {
        Time = 0.7
    },
    Ragdoll = {
        Time = 1.5,
        Intangible = false
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Knockback = {
        RelativeTowards = "Attacker",
        Speed = -15,
        Time = 0.15,
        Velocity = Vector3.new(0, 7, 0)
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    HitRemotes = { v5["Light Hit"] },
    Cooldown = {
        Time = 8,
        AfterMove = true
    }
};
v1["Phantasmal Bullets"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Detect = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 30, 60),
            Offset = CFrame.new(0, 10, -30)
        }
    },
    Projectile = {
        Damage = 5,
        ProcCoefficient = 0,
        HitAnimations = "Default",
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.7
        },
        HitRemotes = { v5["Light Hit"] }
    },
    Explosion = {
        Damage = 15,
        ProcCoefficient = 2,
        Hitbox = {
            Size = 12
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.15
        },
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Heavy
        }
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    }
};
v1["Corrupt Ray"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Beam = {
        Damage = 2.5,
        ProcCoefficient = 0.3,
        Range = 45,
        Hitbox = {
            Size = Vector3.new(7, 7, 45),
            Predict = true
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 6,
            Time = 0.07
        },
        Stun = {
            Time = 0.8,
            Priority = EnumsModule.Stun.Heavy
        }
    },
    Meter = {
        RequiredAmount = 40
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    }
};
v1["Pulse Shatter"] = {
    Active = true,
    MaxTargets = 4,
    Actionable = {
        Active = true
    },
    Burst = {
        Damage = 45,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(18, 40, 18),
            Offset = CFrame.new(0, 0, -0)
        },
        Stun = {
            Time = 1.45,
            Priority = EnumsModule.Stun.Heavy
        },
        Ragdoll = {
            Time = 0.85
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 60, 0),
                Speed = 15,
                Time = 0.15
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(6, 0, 6),
                Time = 0.2
            } }
    },
    Meter = {
        RequiredAmount = 25
    },
    Detect = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 40,
            Offset = CFrame.new(0, 0, -0)
        }
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    }
};

return {
    Stats = v1,
    Moveset = {
        DefaultMoveState = "Universal",
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
        MovesInfo = {
            ["Resonant Lock"] = {
                State = "Passive",
                Description = "When an ally near you takes a lethal strike, they will be saved from death. You can only have this effect trigger on a specific entity once. Has a cooldown after triggering.",
                Equipped = true
            },
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                Description = "Perform a series of projectile-shooting casts."
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true
            },
            ["Corrupt Ray"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = "Perform a wind-up with your staff before unleashing a ray of energy forwards, dealing significant chip damage."
            },
            ["Pulse Shatter"] = {
                DefaultKeybind = "G",
                Equipped = true,
                Description = "Raise your staff, marking up to 4 different targets in range. Upon slamming the staff to the ground, volatile energy bursts will strike at the marked target locations."
            },
            ["Phantasmal Bullets"] = {
                DefaultKeybind = "T",
                Equipped = true,
                Description = "Raise your staff, performing a brief charge and summoning 3 magical bullets that home towards up to 3 targets."
            },
            Revitalization = {
                DefaultKeybind = "R",
                Equipped = true,
                Description = "Perform a wind-up and slam the ground with high force, creating a shockwave of energy which knocks over foes and heals allies. Struck foes will temporarily have reduced healing and damage output."
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 112120156474790,
            Volume = 1.5
        },
        ["LMB-2"] = {
            SoundId = 88534064241798,
            Volume = 1.5
        },
        ["LMB-3"] = {
            SoundId = 72361910375035,
            Volume = 1.5
        },
        ["LMB Projectile Explosion"] = {
            SoundId = 74814713467035,
            Volume = 1.5
        },
        ["Corrupt Ray"] = {
            SoundId = 98345823032318,
            Volume = 1.5
        },
        ["Pulse Shatter"] = {
            SoundId = 116889032136463,
            Volume = 1.5
        },
        ["Pulse Shatter Burst"] = {
            SoundId = 133322349876120,
            Volume = 1.5
        },
        ["Pulse Shatter Warning"] = {
            SoundId = 94734079816185,
            Volume = 1.5
        },
        ["Phantasmal Bullets"] = {
            SoundId = 109286386745829,
            Volume = 1.5
        },
        ["Phantasmal Bullets Explosion"] = {
            SoundId = 124528245282988,
            Volume = 1.5
        },
        Revitalization = {
            SoundId = 80379058397722,
            Volume = 1.5
        },
        ["Revitalization Slam"] = {
            SoundId = 103920423394640,
            Volume = 1.5
        },
        DeathPrevention = {
            SoundId = 106418343340544,
            Volume = 1.35
        },
        PassiveSigil = {
            SoundId = 108769487702101,
            Volume = 0.125,
            Looped = true
        },
        ["PoseMusic-1"] = {
            SoundId = 95015812817533,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-2"] = {
            SoundId = 136714706692667,
            Volume = 2,
            Looped = true
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 79013399788893,
            ["LMB-2"] = 73551795062923,
            ["LMB-3"] = 105030821293744,
            ["Corrupt Ray"] = 71236823865849,
            ["Phantasmal Bullets"] = 101740294869812,
            Revitalization = 79625711412637,
            ["Pulse Shatter"] = 127689742674572,
            PoseIdle = 136453199914593,
            PoseTransition = 100512376517818
        },
        Movement = {
            Walk = 88033531341458,
            Run = 97443946240082,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            Idle = 92388035492230
        }
    }
};