  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("CollectionService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Enums = require(game.ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local _ = ReplicatedStorage.Remotes.Output;
local _ = ReplicatedStorage["Client Assets"];
local v1 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v2 = {
    SoundId = 14556904573,
    Volume = 1
};

local function CreateMultiIndicator(p3) -- Line: 74
    local v4 = {};

    for i, v in pairs(p3) do
        if i ~= "Overrides" then
            table.insert(v4, {
                InputText = "%s",
                Visible = true,
                Group = i,
                Name = v,
                DisplayName = v,
                CooldownName = v,
                ActiveName = v
            });
        end;
    end;

    if p3.Overrides then
        for _, v in ipairs(v4) do
            for i, v3 in pairs(p3.Overrides) do
                v[i] = v3;
            end;
        end;
    end;

    return v4;
end;

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
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
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Summon = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Slide = {
                DefaultKeybind = "E",
                Unlocked = true
            },
            ["Freezing Force"] = {
                DefaultKeybind = "R",
                Unlocked = true
            },
            ["Ice Missiles"] = {
                DefaultKeybind = "T",
                Unlocked = true
            },
            ["Cryokinetic Regeneration"] = {
                DefaultKeybind = "Y",
                Unlocked = true
            },
            ["Arctic Smite"] = {
                DefaultKeybind = "G",
                Unlocked = true
            },
            ["Sinking Iceberg"] = {
                DefaultKeybind = "G",
                Unlocked = true
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 12483102391,
            ["LMB-2"] = 12483106270,
            ["LMB-3"] = 12483107424,
            ["LMB-4"] = 12483108580,
            ["StandOn-Grab"] = 11110729280,
            ["StandOn-Throw"] = 11110730939,
            ["StandOn-ThrowVictim"] = 11110732132,
            Move1 = 14557369739,
            Summon = 14555657321
        },
        Movement = {
            Walk = 13246609642,
            Run = 10344441371
        },
        Idle = {
            Idle = 13938333253,
            SummonedIdle = 13938331975
        }
    },
    Sounds = {},
    Stats = {
        Summon = {
            From = "Combat.Summon",
            SummonV2 = true,
            Indicators = { {
                    Group = "Universal",
                    Name = "Summon",
                    DisplayName = "Summon",
                    CooldownName = "Summon",
                    ActiveName = "Summon",
                    InputText = "%s",
                    Visible = true
                } },
            LeaveParts = { "StandHumanoidRootPart" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(108, 172, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(108, 172, 255)) }),

            OnSummon = function(p5, p6) -- Line: 128, Name: OnSummon
                local Animator = p5.Animator;

                if p6 then
                    Animator:PlayAnimation("Summon");
                end;
            end
        },
        ["Rush Attack"] = {
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
            ["LMB-1"] = {
                Damage = 8,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 15, "Attack" }, { 21, "End" } },
                Stun = {
                    Time = 0.5,
                    Priority = Enums.Stun.Medium
                },
                Block = {
                    PerfectBlockable = false
                },
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = { v1 },
                HitSounds = { v2 }
            },
            ["LMB-3"] = {
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 18, "Attack" }, { 25, "End" } }
            },
            ["LMB-4"] = {
                Cooldown = 1,
                Damage = 21,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 18, "Attack" }, { 23, "End" } },
                Stun = {
                    Time = 0.3
                },
                Block = {
                    Unblockable = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Heavy",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    } },
                HitSounds = { {
                        SoundId = 14556904480,
                        Volume = 1
                    } }
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose"
        },
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = false
            },
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
        Move1 = {
            Spike = {
                Amount = 8,
                Length = 5,
                Interval = 0.125
            },
            Actionable = {
                Active = true
            },
            Active = true,
            Indicators = { ((function(p7) -- Line: 60, Name: CreateIndicator
                    local v8 = p7 or {};

                    return {
                        Group = v8.Group or "Universal",
                        Name = v8.Name,
                        DisplayName = v8.DisplayName or v8.Name,
                        CooldownName = v8.CooldownName or v8.Name,
                        ActiveName = v8.ActiveName or v8.Name,
                        InputText = v8.InputText or "%s",
                        Visible = v8.Visible or true
                    };
                end)()) },
            Cooldown = {
                Time = 5
            },
            Hitbox = {
                Size = 52
            },
            Projectile = {
                Damage = 2.5,
                HitAnimations = "Default",
                Hitbox = {
                    Size = Vector3.new(4.5, 4.5, 4.5)
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = false
                },
                Stun = {
                    Time = 0.75
                },
                HitRemotes = { v1 },
                HitSounds = {
                    Hit = v2
                }
            }
        }
    }
};