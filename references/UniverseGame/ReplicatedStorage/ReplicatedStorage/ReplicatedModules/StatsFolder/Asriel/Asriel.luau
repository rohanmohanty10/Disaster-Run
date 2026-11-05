  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local _ = ReplicatedStorage.Remotes.Output;
local _ = ReplicatedStorage["Client Assets"];

local function CreateIndicator(p1) -- Line: 48
    return {
        Group = p1.Group or "Universal",
        Name = p1.Name,
        DisplayName = p1.DisplayName or p1.Name,
        CooldownName = p1.CooldownName or p1.Name,
        ActiveName = p1.ActiveName or p1.Name,
        InputText = p1.InputText or "%s",
        Visible = p1.Visible or true
    };
end;

local function CreateMultiIndicator(p2) -- Line: 60
    local v3 = {};

    for i, v in pairs(p2) do
        if i ~= "Overrides" then
            table.insert(v3, {
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

    if p2.Overrides then
        for _, v in ipairs(v3) do
            for i, v2 in pairs(p2.Overrides) do
                v[i] = v2;
            end;
        end;
    end;

    return v3;
end;

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Moves = {
            F = "Block",
            C = "Quickstep",
            X = "Grab"
        }
    },
    Animations = {
        Action = {},
        Movement = {
            Walk = 13455532611,
            Run = 13455572588
        },
        Idle = {
            Idle = 13455530061
        }
    },
    Stats = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Summoned = false
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            AnimationTimed = false,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 16, 18, "Attack" }, { 19, "End" } },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Light",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 10626698543,
                        Volume = 3
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
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
                        SoundId = 10626763879,
                        Volume = 3
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
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Active = true
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
    Sounds = {
        ["LMB-1"] = {
            SoundId = 114870782762477,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 72274303820564,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 77580227704905,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 97421122961788,
            Volume = 2
        },
        ["LMB-4-Slam"] = {
            SoundId = 107804757778300,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 94362993666765,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 94362993666765,
            Volume = 2
        },
        ["God of Death"] = {
            SoundId = 96026607241461,
            Volume = 2
        },
        ["Death Whisper"] = {
            SoundId = 114665099048124,
            Volume = 2
        },
        ["Death Claws"] = {
            SoundId = 102844130982591,
            Volume = 2
        },
        Remedy = {
            SoundId = 98043775835771,
            Volume = 2
        },
        ["Death\'s Grasp"] = {
            SoundId = 109691324627132,
            Volume = 2
        },
        Ghast = {
            SoundId = 72923957680529,
            Volume = 2
        },
        Nightmare = {
            SoundId = 109297611435137,
            Volume = 2
        },
        Kill = {
            SoundId = 122317462950656,
            Volume = 2
        }
    }
};