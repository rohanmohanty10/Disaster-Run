  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
Knit.OnStart():andThen(function() -- Line: 17
    -- upvalues: PathShortcuts (copy), u2 (ref), u6 (ref), Knit (copy), u8 (ref), u3 (ref), u4 (ref), u7 (ref), u5 (ref)
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u6 = Knit.GetController("CombatController");
    u8 = Knit.GetService("MoveInputService");
    u3 = require(PathShortcuts.ReplicatedModules.Independent.TagService);
    u4 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
    u7 = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
    u5 = require(PathShortcuts.ReplicatedModules.StatsHandler);
end);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local v9 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Light",
            LookAt = "Attacker"
        } }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Active = true
    },
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        Damage = 45,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",

    Invoke = function(p10) -- Line: 101, Name: Invoke
        -- upvalues: Knit (copy)
        local v11 = Knit.GetService("MoveInputService");
        local Character = game.Players.LocalPlayer.Character;
        local Humanoid = Character:WaitForChild("Humanoid");
        Character:WaitForChild("HumanoidRootPart");
        local v12 = Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall;
        v11:FireInput(p10.RawInput, v12);
    end,

    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 0, "PlaySound", "LMB1-Voiceline" }, { 15, 19, "Attack" }, { 37, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665760078,
                Volume = 1.5
            }
        },
        HitRemotes = { v9 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 0, "PlaySound", "LMB2-Voiceline" }, { 9, 16, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759862,
                Volume = 1.5
            }
        },
        HitRemotes = { v9 }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 0, "PlaySound", "LMB3-Voiceline" }, { 17, 21, "Attack" }, { 33, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759570,
                Volume = 1.5
            }
        },
        HitRemotes = { v9 }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 0, "PlaySound", "LMB4-Voiceline" }, { 23, 27, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759370,
                Volume = 1.5
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Misc/Heavy",
                        LookAt = "Attacker"
                    } }
            } }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p13, p14) -- Line: 213, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local v15 = Knit.GetService("EffectService");
            local Count = p13.CharacterState["Rush Attack"].Count;
            local Character = p13.Character;
            local v16 = TableUtil.Copy(p13.Stats, true);
            v15.FireAllClients("Demon LMB", {
                Player = p13.Player,
                Character = Character,
                Count = Count,
                Speed = v16["LMB-" .. Count].Speed or (v16["LMB-1"].Speed or 1)
            });

            return v16;
        end
    }
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1["Demonic Shriek"] = {
    Active = true,
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Tick = {
        Damage = 3,
        Hitbox = {
            Size = 15
        },
        Knockback = {
            RelativePart = "Target",
            Time = 0.15,
            Speed = 0,
            Velocity = Vector3.new(0, 6, 0)
        },
        Stun = {
            Time = 0.25,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        }
    },
    Burst = {
        Damage = 10,
        Ragdoll = {
            Time = 2
        },
        Hitbox = {
            Size = 15
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 30,
            Time = 0.1,
            Velocity = Vector3.new(0, 12, 0)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false
        }
    }
};
v1["Fusillade of Claws"] = {
    Active = true,
    Damage = 2,
    Speed = 55,
    Frequency = 5,
    Duration = 5,
    Endlag = 10,
    Actionable = {
        Active = true
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Tolerance = 25,
        Offset = CFrame.new(0, 0, -3)
    }
};
v1["Incarnadine Blow"] = {
    Active = true,
    Damage = 42,
    Distance = 22,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(14, 14, 28)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Velocity = Vector3.new(0, 27, 0),
        Time = 0.12
    },
    Ragdoll = {
        Time = 1.2
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = false
    }
};
v1["Crimson Mae"] = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = false
    },
    Hitbox = {
        Size = 12
    },
    Ragdoll = {
        Time = 1.4
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 48,
        Time = 0.1,
        Velocity = Vector3.new(0, 25, 0)
    }
};
v1["Flesh Mending"] = {
    Active = true,
    Heal = 2,
    Actionable = {
        Active = true,

        Check = function(p17) -- Line: 391, Name: Check
            return p17.Humanoid.Health < p17.Humanoid.MaxHealth;
        end
    }
};
v1.Bloodborne = {
    Active = true,
    Distance = 15,
    Actionable = {
        Active = true
    },
    Grab = {
        Damage = 5,
        Hitbox = {
            Size = Vector3.new(8, 8, 10),
            Offset = CFrame.new(0, 0, -4.5)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        }
    },
    Slam = {
        Damage = 7.5,
        Priority = EnumsModule.Intangible.Move
    },
    Finisher = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 48,
            Time = 0.1,
            Velocity = Vector3.new(0, 25, 0)
        }
    }
};
v1.Severance = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5, 5, 15),
        Offset = CFrame.new(0, 0, -7)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    Ragdoll = {
        Time = 0.65
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.15
    }
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
            ["Fusillade of Claws"] = {
                DefaultKeybind = "E",
                Unlocked = true
            },
            ["Incarnadine Blow"] = {
                DefaultKeybind = "R",
                Unlocked = true
            },
            Severance = {
                DefaultKeybind = "T"
            },
            ["Crimson Mae"] = {
                DefaultKeybind = "Y"
            },
            Bloodborne = {
                DefaultKeybind = "G"
            },
            ["Demonic Shriek"] = {
                DefaultKeybind = "H"
            },
            ["Flesh Mending"] = {
                DefaultKeybind = "Q"
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 86263293281275,
            PoseIdle = 106241549830171,
            ["LMB-1"] = 78246699365553,
            ["LMB-2"] = 121879677483397,
            ["LMB-3"] = 90306501797619,
            ["LMB-4"] = 96216882826005,
            ["Demonic Shriek"] = 138105245582459,
            ["Crimson Mae"] = 139683388695754,
            ["Incarnadine Blow"] = 97915930074736,
            ["Flesh Mending"] = 109459750593924,
            ["Fusillade of Claws Start"] = 131146641295991,
            ["Fusillade of Claws"] = 90218653711486,
            ["Bloodborne Start"] = 79220659364406,
            ["Bloodborne Attacker"] = 107975447289218,
            ["Bloodborne Victim"] = 136698699150070,
            Severance = 93778273311499,
            ["Severance Arm"] = 90344188802012
        },
        Movement = {
            Walk = 75953743601272,
            Run = 122469943905685
        },
        Idle = {
            Idle = 81272981217491
        }
    },
    Stats = v1,
    Sounds = {},
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {}
        }
    }
};