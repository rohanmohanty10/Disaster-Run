  

 

game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local _ = PathShortcuts.ClientAssets;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 24
    -- upvalues: u1 (ref), Knit (copy), u4 (ref), RunService (copy), u2 (ref), u3 (ref)
    u1 = Knit.GetService("EffectService");
    u4 = Knit.GetService("ProjectileService");

    if RunService:IsServer() then
        u2 = require(Knit.ServerLibrary.ProjectileData.Abilities[script.Name].Arrow);
        u2.MaxDistance = 75;
        u2.Velocity = 250;

        u3 = function(p5, p6, p7, p8) -- Line: 33
            -- upvalues: u4 (ref), u2 (ref)
            u4.Fire(u2, p7.RootPart.Position, p7.RootPart.CFrame.LookVector, nil, p7.Character, p7.Stats[p8.FullName], {
                {
                    SkinName = p7.SkinName,
                    AbilityName = p7.AbilityName
                }
            });
        end;
    end;
end);
local v10 = {
    Moveset = require(script.Moves),
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 5,

        PointCap = function(p9) -- Line: 54, Name: PointCap
            return 1;
        end
    }
};
local v11 = { {
        SoundId = 123111875320359,
        Volume = 1
    } };
local v12 = { {
        SoundId = 106200323144036,
        Volume = 0.5
    } };
local v13 = { {
        SoundId = 91883728508901,
        Volume = 1
    } };
local v14 = { {
        SoundId = 137702101356202,
        Volume = 1
    } };
v10.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["BowLMB-1"] = TableUtil.Reconcile({
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 6.5, 10),
            Offset = CFrame.new(0, 2, -7)
        },
        Sequence = {
            { 0, "Start" },
            { 22, function(p15, p16, p17) -- Line: 112
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/ArrowMeele",
                        Origin = p17.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p17.Player
                    });
                end },
            { 22, u3 }
        },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["BowLMB-2"] = TableUtil.Reconcile({
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 6.5, 10),
            Offset = CFrame.new(0, 2, -7)
        },
        Sequence = {
            { 0, "Start" },
            { 22, function(p18, p19, p20) -- Line: 132
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/ArrowMeele",
                        Origin = p20.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p20.Player
                    });
                end },
            { 22, u3 }
        },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["BowLMB-3"] = TableUtil.Reconcile({
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 6.5, 10),
            Offset = CFrame.new(0, 2, -7)
        },
        Sequence = {
            { 0, "Start" },
            { 22, function(p21, p22, p23) -- Line: 152
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/ArrowMeele",
                        Origin = p23.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p23.Player
                    });
                end },
            { 22, u3 }
        },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["BowLMB-4"] = TableUtil.Reconcile({
        Sequence = {
            { 0, "Start" },
            { 18, function(p24, p25, p26) -- Line: 167
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p26.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(78, 178, 255),
                        Character = p26.Character
                    });
                end },
            { 24, 25, "Attack" }
        },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["SwordLMB-1"] = TableUtil.Reconcile({
        SequenceSpeed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 22, function(p27, p28, p29) -- Line: 188
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/ArrowMeele",
                        Origin = p29.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = p29.Player
                    });
                end },
            { 22, 32, "Attack" }
        },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["SwordLMB-2"] = TableUtil.Reconcile({
        SequenceSpeed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 22, function(p30, p31, p32) -- Line: 204
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p32.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(78, 178, 255),
                        Character = p32.Character
                    });
                end },
            { 22, 25, "Attack" }
        },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["SwordLMB-3"] = TableUtil.Reconcile({
        SequenceSpeed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 22, function(p33, p34, p35) -- Line: 225
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p35.RootPart,
                        Offset = CFrame.Angles(0, -0.8726646259971647, 0),
                        EndCFrame = CFrame.Angles(0, 2.443460952792061, 0),
                        Color = Color3.fromRGB(78, 178, 255),
                        Character = p35.Character
                    });
                end },
            { 22, 25, "Attack" }
        },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["SwordLMB-4"] = TableUtil.Reconcile({
        SequenceSpeed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 22, function(p36, p37, p38) -- Line: 246
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p38.RootPart,
                        Offset = CFrame.new(
                            -0.100006104,
                            0.200012207,
                            -0.5,
                            0,
                            -0.866024911,
                            -0.49999997,
                            0,
                            0.499999523,
                            -0.86602509,
                            0.999998927,
                            0,
                            0
                        ),
                        EndCFrame = CFrame.Angles(0, 2.443460952792061, 0),
                        Color = Color3.fromRGB(78, 178, 255),
                        Character = p38.Character
                    });
                end },
            { 24, 25, "Attack" }
        },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["VolLMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 22, 32, "Attack" } },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["VolLMB-2"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 22, 25, "Attack" } },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["VolLMB-3"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 22, 25, "Attack" } },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack),
    ["VolLMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 24, 25, "Attack" } },
        HitSounds = v11
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p39, p40) -- Line: 296, Name: StateChecker
            -- upvalues: TableUtil (copy), CollectionService (copy)
            local v41 = TableUtil.Copy(p39.Stats, true);

            if CollectionService:HasTag(p39.Character, "Vollständig") then
                v41.CustomPrefix = "VolLMB";
            elseif CollectionService:HasTag(p39.Character.Stand, "Sword") then
                v41.CustomPrefix = "SwordLMB";
            else
                v41.CustomPrefix = "BowLMB";
            end;

            p40.CombatService.PlaySound(p39.Character, (`LMB-{p40.MoveState.Count}-Voiceline`));

            return v41;
        end
    }
};
v10.Stats.Block = {
    From = "Combat.Block"
};
v10.Stats.Breaker = {
    From = "Combat.Breaker"
};
v10.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v10.Stats.Grab = {
    From = "Standless.Grab"
};
v10.Stats["Stance Switch"] = {
    Active = true,
    Actionable = {
        Active = true
    }
};
v10.Stats["Licht Regen"] = {
    Active = true,
    Damage = 2,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Stun = {
        Time = 1
    },
    HitSounds = v11
};
v10.Stats["Licht Hagel"] = {
    Active = true,
    Damage = 2,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Stun = {
        Time = 1
    },
    HitSounds = v12
};
v10.Stats["Heilig Pfeil"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    FirstStage = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(5, 6, 8),
            Offset = CFrame.new(0, 0, -4)
        }
    },
    SecondStage = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 1.25
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 5, 8),
            Offset = CFrame.new(0, 0, -4)
        }
    },
    ThirdStage = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 1.5
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 8, 10),
            Offset = CFrame.new(0, 0, -5)
        }
    },
    Projectile = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.4
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.15
        }
    },
    ProjecilteQuery = {
        Hitbox = {
            Size = Vector3.new(40, 40, 40),
            Offset = CFrame.identity
        }
    }
};
v10.Stats["Enhanced Heilig Pfeil"] = {
    Active = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Rain = {
        Damage = 20,
        Hitbox = {
            Size = 15
        },
        Stun = {
            Time = 1
        }
    },
    ResidualHeal = {
        Heal = 5,
        Hitbox = {
            Size = 15,
            CanQueryCaster = true,
            FriendlyFire = true
        }
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    }
};
v10.Stats["Quincy Arrow"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 5
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    InitalShot = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 3
        },
        HitSounds = v11
    },
    FinalShot = {
        Damage = 25,
        Ragdoll = 1.25,
        Stun = 1.25,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.15
        },
        HitSounds = v11
    }
};
v10.Stats["Lichtschärpe"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Stun = {
        Time = 1
    },
    Hitbox = {
        Size = Vector3.new(15, 15, 50),
        Offset = CFrame.new(0, 0, -25)
    }
};
v10.Stats["Composite Heilig Pfeil"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 5
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Shot = {
        Damage = 25,
        Ragdoll = 1.25,
        Stun = 1.25,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.15
        },
        HitSounds = v13
    }
};
v10.Stats["Schwert Werfen"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 5
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Stun = {
        Time = 1.25
    },
    HitSounds = v13
};
v10.Stats["Schwert Detonieren"] = {
    Active = true,
    Damage = 20,
    Ragdoll = 2,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 2
    },
    Knockback = {
        Speed = 50,
        Time = 0.25,
        Velocity = Vector3.new(0, 25, 0)
    },
    HitSounds = v14
};
v10.Stats.Verwerfen = {
    Active = true,
    Max = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 2,
        AfterMove = true
    }
};
v10.Stats.Falle = {
    Active = true,
    Max = 5,
    MaxDuration = 10,
    Actionable = {
        Active = true
    },
    VerwerfenCooldown = {
        Time = 10
    },
    Explosion = {
        Damage = 30,
        HitAnimations = "Default",
        Stun = {
            Time = 1
        },
        Hitbox = {
            Size = 6,
            Offset = CFrame.identity
        },
        Block = {
            Unblockable = true
        },
        Knockback = {
            Speed = 50,
            Time = 0.25
        },
        HitSounds = v14
    },
    Tick = {
        Damage = 1,
        HitAnimations = "Default",
        Stun = {
            Time = 0.25,
            Priority = EnumsModule.Stun.Light
        },
        Block = {
            Unblockable = true
        },
        HitSounds = v12
    }
};
v10.Stats.Sternenstaub = {
    Active = true,
    Damage = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Stun = {
        Time = 1.25
    },
    Hitbox = {
        Size = Vector3.new(5, 5, 80),
        Offset = CFrame.new(0, 0, -40)
    }
};
v10.Stats["A for Antithesis"] = {
    Active = true,
    Duration = 20,
    Actionable = {
        MasteryRank = 5,
        Active = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    }
};
v10.Stats["Letzt Stil"] = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Stun = {
        Time = 1.25
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(30, 20, 30),
        Offset = CFrame.new(0, -5, -15)
    },
    HitSounds = v13
};
v10.Stats.Federzwinger = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 5
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Stun = {
        Time = 1.2
    },
    Explosion = {
        Damage = 50,
        HitAnimations = "Default",
        Ragdoll = 3,
        Stun = {
            Time = 3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.15
        },
        HitSounds = { {
                SoundId = 80762444691103,
                Volume = 1
            } }
    }
};
v10.Stats["Vollständig"] = {
    Active = true,
    Duration = 20,
    Actionable = {
        MasteryRank = 1,
        Active = true
    },
    Cooldown = {
        Time = 60,
        Manual = true
    }
};
v10.Stats.Skate = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        Manual = true
    },
    Drain = {
        Tick = 0.1,
        Amount = 1
    }
};
v10.Stats.Fly = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        Manual = true
    },
    Drain = {
        Tick = 0.1,
        Amount = 1
    }
};
v10.Stats["Spiritual Pressure"] = {
    Active = true,
    Damage = 10,
    Meter = false,
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Check = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Offset = CFrame.identity
        }
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Cooldown = {
        Time = 100,
        AfterMove = true
    },
    BuffRagdoll = {
        Time = 2,
        Intangible = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Block = {
        Unblockable = true
    },
    Stun = {
        Time = 0.25
    },
    Hitbox = {
        Size = 9
    },
    HitAnimations = { 10046328617 }
};

return v10;