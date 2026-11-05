  

 

game:GetService("RunService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v1 = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local v2 = {};
local u3 = nil;
local u4 = nil;
local u5 = nil;
Knit.OnStart():andThen(function() -- Line: 25
    -- upvalues: u3 (ref), Knit (copy), u4 (ref), PathShortcuts (copy), u5 (ref)
    u3 = Knit.GetService("MoveInputService");
    u4 = Knit.GetService("EffectService");
    u5 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
({
    Name = "Output"
}).Arguments = {
    "FX",
    "HitEffect V2",
    "__Legacy",
    {
        AutoSerialize = true,
        Particle = v1.Gura.LightHit
    }
};
local v6 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V2",
        "__Legacy",
        {
            AutoSerialize = true,
            Particle = v1.Gura.HeavyHit
        }
    }
};
v2["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 18, function(p7, p8, p9) -- Line: 64
                    -- upvalues: u4 (ref)
                    u4.FireAllClients("Cutlass LMB", p9);
                end },
            { 19, 21, "Attack" },
            { 31, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 14448219007,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.25,
        HitSounds = {
            Hit = {
                SoundId = 14448218250,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2.Block = {
    From = "Combat.Block"
};
v2.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Pose = {
    From = "Combat.Pose"
};
v2.Grab = {
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
v2.EMove = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Hitbox = {
        Size = Vector3.new(12, 12, 36),
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 55,
        Velocity = Vector3.new(0, 27, 0),
        Time = 0.12
    },
    Stun = {
        Time = 1.2
    },
    Ragdoll = {
        Time = 1.2
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    HitRemotes = { v6 },
    HitSounds = {
        Hit = {
            SoundId = 15948723585,
            Volume = 1
        }
    }
};

return {
    Stats = v2,
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Moves = {
            MouseButton1 = "Rush Attack",
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            E = "EMove"
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 15893095975,
            ["LMB-2"] = 15893097662,
            ["LMB-3"] = 15893099285,
            ["LMB-4"] = 15893100909,
            Pierce = 15893213179
        },
        Movement = {
            Walk = 15893086984,
            Run = 15899337323
        },
        Idle = {
            Idle = 15893074440
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 15948722821,
            Volume = 1.75
        },
        ["LMB-2"] = {
            SoundId = 15948723316,
            Volume = 1.75
        },
        ["LMB-3"] = {
            SoundId = 15948723083,
            Volume = 1.75
        },
        ["LMB-4"] = {
            SoundId = 15948723316,
            Volume = 1.75
        },
        ["Pierce SFX"] = {
            SoundId = 15948723434,
            Volume = 1.75
        }
    }
};