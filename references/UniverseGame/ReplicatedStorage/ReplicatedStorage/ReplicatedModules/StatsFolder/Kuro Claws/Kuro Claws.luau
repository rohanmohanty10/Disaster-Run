  

 

game:GetService("CollectionService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts2 = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit2 = require(PathShortcuts2.KnitPath.Knit);
local _ = PathShortcuts2.ClientAssets;
require(Knit2.Util.Trove);
require(Knit2.Util.Promise);
local TableUtil = require(Knit2.Util.TableUtil);
local u1 = nil;
local u2 = nil;
Knit2.OnStart():andThen(function() -- Line: 25
    -- upvalues: u1 (ref), Knit2 (copy), u2 (ref)
    u1 = Knit2.GetService("TagService");
    u2 = Knit2.GetService("EffectService");
end);

local function CreateIndicator(p3) -- Line: 41
    local v4 = p3 or {};

    return {
        Group = v4.Group or "Universal",
        Name = v4.Name,
        DisplayName = v4.DisplayName or v4.Name,
        CooldownName = v4.CooldownName or v4.Name,
        ActiveName = v4.ActiveName or v4.Name,
        InputText = v4.InputText or "%s",
        Visible = v4.Visible or true
    };
end;

local function CreateMultiIndicator(p5) -- Line: 55
    local v6 = {};

    for i, v in pairs(p5) do
        if i ~= "Overrides" then
            table.insert(v6, {
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

    if p5.Overrides then
        for _, v in ipairs(v6) do
            for i, v2 in pairs(p5.Overrides) do
                v[i] = v2;
            end;
        end;
    end;

    return v6;
end;

local v7 = {
    Hit = {
        SoundId = 14448219007,
        Volume = 1
    }
};
local v8 = {
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
            Stun = {
                Time = 0.65
            },
            HitSounds = v7
        }, BaseStatsModule.Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 16, 18, "Attack" }, { 19, "End" } },
            HitSounds = v7
        }, BaseStatsModule.Stand_Rush_Attack_Finisher)
    }
};
v8["Rush Attack"] = TableUtil.Reconcile(v8["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v8.Block = {
    From = "Combat.Block"
};
v8.Quickstep = {
    From = "Combat.Quickstep"
};
v8.Grab = {
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
v8["Claw Barrage"] = {
    Active = true,
    Damage = 1.25,
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
        Size = 10,
        Offset = CFrame.new(0, -1.5, -5)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.7,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Time = 0.1
    },
    Finisher = {
        LightDancer = true,
        Damage = 9,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11, 9, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.35,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        }
    },
    HitSounds = v7
};
v8["Razor Swipe"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Stun = {
        Time = 0.75
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Velocity = Vector3.new(0, 20, 0),
        Time = 0.13
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    HitSounds = {
        Hit = {
            SoundId = 17364768555,
            Volume = 1
        }
    }
};
v8.Shakushi = {
    Active = true,
    Damage = 3.5714285714285716,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(50, 50, 50),
        Offset = CFrame.identity
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1.5
    },
    Meter = {
        RequiredAmount = 50
    },
    HitSounds = v7
};
v8["Flash Dash"] = {
    Active = true,
    MaxDistance = 20,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    }
};
v8.Twister = {
    Active = true,
    Damage = 3.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 1,
        Time = 0.1
    },
    Stun = {
        Time = 1.15
    },
    Meter = {
        RequiredAmount = 25
    },
    HitSounds = {
        Hit = {
            SoundId = 17364768555,
            Volume = 0.5
        }
    },
    Hitbox = {
        Size = 12.5,
        Offset = CFrame.identity
    }
};
v8["Unpredictable Speeds"] = {
    Active = true,
    Duration = 15,
    AnimatorMultiplier = 3,
    Actionable = {
        Active = true,

        Check = function(p9) -- Line: 402, Name: Check
            return not p9:FindFirstChild("Kuro Passive");
        end
    },
    Cooldown = {
        Time = 45,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
    }
};
v8["Rampage Rush"] = {
    Active = true,
    Damage = 5,
    Distance = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Stun = {
        Time = 0.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 20,
        Time = 0.13
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    Finisher = {
        Damage = 20,
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 20, 0),
            Time = 0.15
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Hitbox = {
            Size = 12.5,
            Offset = CFrame.new(0, 0, -4)
        }
    }
};
v8.Breaker = {
    From = "Combat.Breaker"
};
v8.Pose = {
    From = "Combat.Pose"
};

return {
    Moveset = {
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
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Claw Barrage"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Perform a series of omnidirectional slashes."
            },
            ["Razor Swipe"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Lunge forward and perform a 3 pronged slash."
            },
            Shakushi = {
                DefaultKeybind = "G",
                Unlocked = false,
                LevelRequirement = 30,
                Description = "Charge up a large barrage of slashes targeting all angles."
            },
            Twister = {
                DefaultKeybind = "T",
                Unlocked = false,
                LevelRequirement = 15,
                Description = "Spin 360 degrees and strike all areas within a given radius."
            },
            ["Rampage Rush"] = {
                DefaultKeybind = "Y",
                Unlocked = false,
                LevelRequirement = 20,
                Description = "Drag your claws forward into the ground, swiping up with immense force."
            },
            ["Flash Dash"] = {
                DefaultKeybind = "V",
                Unlocked = false,
                LevelRequirement = 10,
                Description = "Dash with great speeds to the nearest target."
            },
            ["Unpredictable Speeds"] = {
                DefaultKeybind = "H",
                Unlocked = false,
                LevelRequirement = 55,
                Description = "Greatly enhance your speed."
            }
        }
    },
    Animations = {
        Action = {
            ["StandOff-LMB-1"] = 17364961951,
            ["StandOff-LMB-2"] = 17364963038,
            ["StandOff-LMB-3"] = 17364963904,
            ["StandOff-LMB-4"] = 17364964963,
            Shakushi = 17358403773,
            ["Claw Barrage"] = 17357644843,
            ["Flash Dash"] = 14324703321,
            ["Razor Swipe"] = 17358116182,
            Twister = 17363784819,
            ["Unpredictable Speeds"] = 17364050315,
            ["Rampage Rush"] = 17364341116,
            PoseTransition = 17850982639,
            PoseIdle = 17850989686
        },
        Movement = {
            Walk = 17332552561,
            Run = 17332554520
        },
        Idle = {
            Idle = 17332548800
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 17891523709,
            Volume = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.34
                }
            }
        },
        ["StandOff-LMB-1"] = {
            SoundId = 17373802436,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 17373801613,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 17373801854,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 17373802115,
            Volume = 1
        },
        ["Flash Dash SFX"] = {
            SoundId = 17364768667,
            Volume = 1
        },
        ["Unpredictable Speeds SFX"] = {
            SoundId = 17364768821,
            Volume = 1
        },
        ["Unpredictable Speeds Active SFX"] = {
            SoundId = 17364769698,
            Volume = 1
        },
        ["Shakushi SFX"] = {
            SoundId = 17364768976,
            Volume = 1.5
        },
        ["Shakushi Voiceline"] = {
            SoundId = 17364769830,
            Volume = 1
        },
        ["Twister SFX"] = {
            SoundId = 17364769081,
            Volume = 1
        },
        ["Claw Barrage SFX"] = {
            SoundId = 17364769200,
            Volume = 1
        },
        ["Razor Swipe SFX"] = {
            SoundId = 17364769282,
            Volume = 1
        },
        ["Rampage Rush SFX"] = {
            SoundId = 17364769456,
            Volume = 1
        }
    },
    Stats = v8
};