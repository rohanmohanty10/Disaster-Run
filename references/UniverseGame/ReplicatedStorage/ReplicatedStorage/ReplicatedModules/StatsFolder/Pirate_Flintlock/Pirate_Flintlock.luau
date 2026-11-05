  

 

local RunService = game:GetService("RunService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v1 = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local v2 = {};
Knit.GetService("MoveInputService");
Knit.GetService("EffectService");
local u3 = Middleware.GetMiddleware("CombatService");
local u4 = Knit.GetService("ProjectileService");
local u5;

if RunService:IsServer() then
    u5 = require(game:GetService("ServerScriptService"):WaitForChild("Startup").CustomServices.NpcService.NpcService);
else
    u5 = nil;
end;

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
({
    Name = "Output"
}).Arguments = {
    "FX",
    "HitEffect V2",
    "__Legacy",
    {
        AutoSerialize = true,
        Particle = v1.Gura.HeavyHit
    }
};
v2["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Damage = 6,
        Sequence = {
            { 0, "Start" },
            { 20, "PlaySound", "LMB Shoot" },
            { 20, function(p6, p7, p8, p9) -- Line: 68
                    -- upvalues: u3 (copy), u5 (ref), ParticleHandler (copy), u4 (copy), Knit (copy)
                    local Character = p8.Character;
                    local AttackStats = p9.AttackStats;
                    local v10 = u3.GetMetadata(Character);
                    local LookVector = v10.CFrame.LookVector;
                    local v11 = u5.GetNpcObject(Character);

                    if v11 then
                        local Goal = v11.Goal;

                        if Goal and (Goal:IsDescendantOf(game) and (Goal:IsA("Model") and (Goal ~= Character and Goal:FindFirstChild("HumanoidRootPart")))) then
                            LookVector = (Goal.HumanoidRootPart.Position - v10.CFrame.Position).Unit;
                        end;
                    end;

                    local Weapon = Character:FindFirstChild("Weapon");

                    if Weapon then
                        ParticleHandler.Emit(Weapon, ParticleHandler.GenerateEmitInfo(Weapon));
                    end;

                    u4.Fire(Knit.ServerLibrary.ProjectileData.Abilities.Pirates.PirateBullet, v10.Position, LookVector, nil, Character, AttackStats);
                end },
            { 34, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 15948724776,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Damage = 8,
        HitSounds = {
            Hit = {
                SoundId = 15948724776,
                Volume = 1
            }
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2["Rush Attack"]["LMB-1"].Stun = nil;
v2["Rush Attack"]["LMB-1"].Knockback = nil;
v2["Rush Attack"]["LMB-4"].Stun = nil;
v2["Rush Attack"]["LMB-4"].Knockback = nil;
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
    Damage = 30,
    RedirectTime = 0.1,
    Priority = Enums.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 42,
        Time = 0.12,
        Velocity = Vector3.new(0, 24, 0)
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 15,
        Debug = false
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
            ["LMB-1"] = 15898359581,
            ["LMB-2"] = 15898362192,
            ["LMB-3"] = 15898363839,
            ["LMB-4"] = 15898365321,
            ["Homing Shot"] = 15898349250
        },
        Movement = {
            Walk = 15898357770,
            Run = 15899339793
        },
        Idle = {
            Idle = 15898356042
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 15948722911,
            Volume = 1.75
        },
        ["LMB-2"] = {
            SoundId = 15948722911,
            Volume = 1.75
        },
        ["LMB-3"] = {
            SoundId = 15948723784,
            Volume = 1.75
        },
        ["LMB-4"] = {
            SoundId = 15948723917,
            Volume = 1.75
        },
        ["LMB Shoot"] = {
            SoundId = 15948724141,
            Volume = 1.75
        },
        ["Homing Shot Windup"] = {
            SoundId = 15948724323,
            Volume = 1.75
        },
        ["Homing Shot Shoot"] = {
            SoundId = 15948724471,
            Volume = 1.75
        },
        ["Homing Shot Explosion"] = {
            SoundId = 15948724624,
            Volume = 1.75
        }
    }
};