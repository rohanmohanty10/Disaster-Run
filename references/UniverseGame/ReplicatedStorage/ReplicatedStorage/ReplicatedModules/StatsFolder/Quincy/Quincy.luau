  

 

game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("RunService");
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
Knit.OnStart():andThen(function() -- Line: 24
    -- upvalues: u1 (ref), Knit (copy), u2 (ref)
    u1 = Knit.GetService("EffectService");
    u2 = Knit.GetService("ProjectileService");
end);
local v4 = {
    Moveset = require(script.Moves),
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    MasteryData = {
        MaxMasteryRank = 10,

        PointCap = function(p3) -- Line: 38, Name: PointCap
            return p3 < 1 and 1 or p3 * 5;
        end
    }
};
local v5 = { {
        SoundId = 78881557341328,
        Volume = 1
    } };
local v6 = { {
        SoundId = 85012067763000,
        Volume = 1
    } };
v4.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        SequenceSpeed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 22, function(p7, p8, p9) -- Line: 81
                    -- upvalues: u1 (ref)
                    local v10 = table.clone(p9);
                    v10.AbilityName = "Sternritter A: Antithesis";
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/ArrowMeele",
                        Origin = v10.RootPart.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(1.5707963267948966, 0, 0),
                        Player = v10.Player
                    });
                end },
            { 22, 32, "Attack" }
        },
        HitSounds = v6
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        SequenceSpeed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 22, function(p11, p12, p13) -- Line: 100
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p13.RootPart,
                        Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                        EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                        Color = Color3.fromRGB(78, 178, 255),
                        Character = p13.Character
                    });
                end },
            { 22, 25, "Attack" }
        },
        HitSounds = v6
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        SequenceSpeed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 22, function(p14, p15, p16) -- Line: 121
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p16.RootPart,
                        Offset = CFrame.Angles(0, -0.8726646259971647, 0),
                        EndCFrame = CFrame.Angles(0, 2.443460952792061, 0),
                        Color = Color3.fromRGB(78, 178, 255),
                        Character = p16.Character
                    });
                end },
            { 22, 25, "Attack" }
        },
        HitSounds = v6
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        SequenceSpeed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 22, function(p17, p18, p19) -- Line: 142
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Slash", {
                        Time = 0.25,
                        Size = Vector3.new(8.5, 20, 8.5),
                        SurfaceDirection = "Bottom",
                        Origin = p19.RootPart,
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
                        Character = p19.Character
                    });
                end },
            { 24, 25, "Attack" }
        },
        HitSounds = v5
    }, BaseStatsModule.Rush_Attack_Finisher)
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
v4.Stats.Grab = {
    From = "Standless.Grab"
};
v4.Stats["Triple Strike"] = {
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
            Size = 10,
            Offset = CFrame.identity
        },
        HitSounds = v6
    },
    SecondStage = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 1.25
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.identity
        },
        HitSounds = v6
    },
    ThirdStage = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 1.5
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.identity
        },
        HitSounds = v6
    },
    Projectile = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            Size = 10,
            Offset = CFrame.identity
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
        },
        HitSounds = v6
    },
    ProjectileQuery = {
        Hitbox = {
            Size = Vector3.new(40, 40, 40),
            Offset = CFrame.identity
        }
    }
};
v4.Stats["Dash Strike"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Stun = {
        Time = 1
    },
    Hitbox = {
        Size = Vector3.new(15, 15, 50),
        Offset = CFrame.new(0, 0, -25)
    },
    HitSounds = v5
};
v4.Stats.Pierce = {
    Active = true,
    Damage = 25,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 25),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -12.5)
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    HitSounds = v5
};
v4.Stats["Double Slash"] = {
    Active = true,
    Damage = 10,
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
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitSounds = v6
};
v4.Stats["Auswählen"] = {
    Active = true,
    Range = 25,
    Meter = false,
    Damage = 120,
    Actionable = {
        MasteryRank = 2,
        Active = true
    },
    Cooldown = {
        Time = 5
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.15,
        Vector = Vector3.new(0, 50, 0)
    },
    Ragdoll = {
        Intangible = false,
        Time = 10
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = true
    },
    Hitbox = {
        Size = 100
    }
};

return v4;