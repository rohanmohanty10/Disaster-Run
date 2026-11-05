  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("CollectionService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local _ = ReplicatedStorage.Remotes.Output;
local _ = ReplicatedStorage["Client Assets"];
local u1 = Knit.GetService("EffectService");
local v2 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v3 = {
    SoundId = 13620822318,
    Volume = 1
};

local function CreateIndicator(p4) -- Line: 61
    local v5 = p4 or {};

    return {
        Group = v5.Group or "Universal",
        Name = v5.Name,
        DisplayName = v5.DisplayName or v5.Name,
        CooldownName = v5.CooldownName or v5.Name,
        ActiveName = v5.ActiveName or v5.Name,
        InputText = v5.InputText or "%s",
        Visible = v5.Visible or true
    };
end;

local function CreateMultiIndicator(p6) -- Line: 75
    local v7 = {};

    for i, v in pairs(p6) do
        if i ~= "Overrides" then
            table.insert(v7, {
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

    if p6.Overrides then
        for _, v in ipairs(v7) do
            for i, v4 in pairs(p6.Overrides) do
                v[i] = v4;
            end;
        end;
    end;

    return v7;
end;

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            },
            StandOn = {
                Visible = true
            },
            StandOff = {
                Visible = true
            }
        },
        Moves = {
            MouseButton1 = "Rush Attack",
            P = "Pose",
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            Q = "Summon"
        }
    },
    Animations = {
        Action = {},
        Movement = {
            Walk = 14099633862,
            Run = 10982240350,
            SummonedWalk = 14099633862,
            SummonedRun = 14112976599
        },
        Idle = {
            Idle = 14098348879,
            SummonedIdle = 14098348879
        }
    },
    Sounds = {},
    Stats = {
        Summon = {
            From = "Combat.Summon",
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
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Active = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            AnimationTimed = false,
            MaxCombo = 4,
            ComboTick = 1,
            ["LMB-1"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 16, 18, "Attack" } },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = v3
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Sequence = {
                    { 0, "Start" },
                    { 16, 18, "Attack" },
                    { 18, function(p8, p9, p10, p11, p12) -- Line: 167
                            p8.Hit[p11.FullName] = {};
                        end },
                    { 32, 34, "Attack" }
                },
                Damage = BaseStatsModule.Rush_Attack.Damage / 2,
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = v3
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 16, 18, "Attack" } },
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
                HitSounds = {
                    Hit = {
                        SoundId = 13620821774,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Stand_Rush_Attack_Finisher)
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
        }
    },

    PostRig = function(p13) -- Line: 306, Name: PostRig
        -- upvalues: u1 (copy)
        u1.FireAllClients("InternalWarOpacity", p13.Character);
    end
};