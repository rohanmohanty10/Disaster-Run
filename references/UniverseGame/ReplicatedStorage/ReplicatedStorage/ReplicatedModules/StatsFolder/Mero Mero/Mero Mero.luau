  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage.Remotes;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local _ = ReplicatedStorage["Client Assets"];
game:GetService("CollectionService");
game:GetService("ServerStorage");
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(ReplicatedModules.Animations);
local Enums = require(ReplicatedModules.Enums);

local function MeroTrailConfig(p2, p3) -- Line: 21
    if p3[1] == "Left" then
        for _, child in pairs(p2["Left Leg"]:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p3[2];
            end;
        end;

        return;
    end;

    if p3[1] == "Right" then
        for _, child in pairs(p2["Right Leg"]:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p3[2];
            end;
        end;

        return;
    end;

    if p3[1] == "Both" then
        for _, child in pairs(p2["Left Leg"]:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p3[2];
            end;
        end;

        for _, child in pairs(p2["Right Leg"]:GetChildren()) do
            if child:IsA("Trail") then
                child.Enabled = p3[2];
            end;
        end;
    end;
end;

v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Summoned = false
    },
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
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    Callbacks = {
        PreAnim = function(p4, p5) -- Line: 100, Name: PreAnim
            -- upvalues: MeroTrailConfig (copy)
            local Character = p4.Character;
            local Count = p5.MoveState.Count;
            MeroTrailConfig(Character, { ({ "Left", "Right", "Left", "Both" })[Count], true });
            Character:FindFirstChild("LMB-" .. Count .. " SFX", true):Play();
        end,

        PostAnim = function(p6, p7) -- Line: 114, Name: PostAnim
            -- upvalues: MeroTrailConfig (copy)
            MeroTrailConfig(p6.Character, { "Both", false });
        end
    },
    ["LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        Speed = 1.3,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 19, 22, "Attack" }, { 27, "End" } },
        Stun = {
            Time = 0.45,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8573524302,
                Volume = 1.5
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.3,
        Sequence = { { 0, "Start" }, { 16, 18, "Attack" }, { 19, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8573524302,
                Volume = 1.5
            }
        }
    },
    ["LMB-3"] = {
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 17, 19, "Attack" }, { 23, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8573524302,
                Volume = 1.5
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.3,
        Cooldown = 0.75,
        Damage = 21,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 22, 24, "Attack" }, { 26, "End" } },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8573524653,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1["Petrification Aroma"] = {
    Active = true,
    Length = 3,
    Damage = 0.8,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 8,
        Debug = false,
        Offset = CFrame.identity
    },
    Stun = {
        Time = 0.6,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 3.5,
        Time = 0.1
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Charm"
        } },
    Block = {
        PerfectBlockable = false
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 8589788229,
            Volume = 2
        }
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    }
};
v1["Grand Petrification Aroma"] = {
    Active = true,
    Damage = 30,
    Cooldown = 9,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9.5, 9.5, 9.5),
        Debug = false,
        Offset = CFrame.identity
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 0.5,
        Priority = Enums.Stun.Medium
    },
    Ragdoll = {
        Time = 0.5
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
        } },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    HitSounds = {
        Hit = {
            SoundId = 8752839738,
            Volume = 2
        }
    }
};
v1.Heartbreaker = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Properties = {
        Armor = true
    },
    Trip = {
        Damage = 20,
        Stun = {
            Time = 0.8,
            Priority = Enums.Stun.Medium
        },
        Block = {
            Unblockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8720835105,
                Volume = 1.5
            }
        }
    },
    Stomp = {
        Priority = 60,
        Damage = 17.5,
        Stun = {
            Time = 0.8,
            Priority = Enums.Stun.Medium
        },
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 45,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.3
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
            } },
        HitSounds = {
            Hit = {
                SoundId = 8720835954,
                Volume = 1.5
            }
        },
        Ragdoll = {
            Time = 0.8
        }
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    }
};
v1["Machine Gun Kiss"] = {
    Active = true,
    Damage = 2,
    HitAnimations = "Default",
    Amount = 25,
    TotalTime = 1,
    Startup = 0.5,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Stun = {
        Time = 0.5,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
        } },
    Block = {
        PerfectBlockable = false
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    }
};
v1["Hardening Sin"] = {
    Active = true,
    Length = 3,
    Damage = 2.5,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 20),
        Debug = false,
        Offset = CFrame.new(0, 0, -10)
    },
    Stun = {
        Time = 0.5,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 6,
        Time = 0.1
    },
    Block = {
        PerfectBlockable = false
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    }
};
v1["Pistol Kiss"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Mero Mero Hit Effect", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 8752839738,
            Volume = 1,
            PlaybackSpeed = 1.35
        }
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Charm"
        } },
    Cooldown = {
        Time = 13,
        AfterMove = true
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
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
                Equipped = false,
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
            ["Petrification Aroma"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Drop to a hand-stand and spin around, kicking in all directions"
            },
            ["Grand Petrification Aroma"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Perform a love-imbued flying side kick"
            },
            ["Pistol Kiss"] = {
                DefaultKeybind = "T",
                Description = "Kiss your finger and shoot a heart shaped projectile with it",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Machine Gun Kiss"] = {
                DefaultKeybind = "Y",
                Description = "Send out many projectiles in a fast, quick burst",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Heartbreaker = {
                DefaultKeybind = "G",
                Description = "Perform a takedown kick and send enemies flying",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Hardening Sin"] = {
                DefaultKeybind = "H",
                Description = "Send out a constant barrage of hearts with big range",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["Eat Fruit"] = 8541951813,
            ["LMB-1"] = 8553461932,
            ["LMB-2"] = 8553466608,
            ["LMB-3"] = 8553469369,
            ["LMB-4"] = 8553476508,
            ["Hardening Sin Start"] = 8563711919,
            ["Hardening Sin Loop"] = 8563721544,
            ["Petrification Aroma"] = 10881095387,
            ["Grand Petrification Aroma"] = 8564731199,
            ["Pistol Kiss Aim"] = 8573835767,
            ["Pistol Kiss Shoot"] = 8573839521,
            ["Heartbreaker Use"] = 8602310890,
            ["Heartbreaker Hit"] = 8602313394,
            ["Heartbreaker Victim"] = 8602326715,
            ["Heartbreaker Victim KB"] = 8602328663,
            ["Easy Lover"] = 8614818815,
            ["Machine Gun Kiss"] = 8614831163,
            Grab = 11110729280,
            Throw = 11110730939,
            ThrowVictim = 11110732132,
            PoseTransition = 10405294780,
            PoseIdle = 10405298544
        },
        Idle = {
            Idle = 8531590159
        }
    },
    Stats = v1,
    Sounds = {
        ["HardeningSin Voiceline"] = {
            SoundId = "rbxassetid://14525355081",
            Volume = 1
        },
        ["HardeningSin SFX"] = {
            SoundId = "rbxassetid://14525354604",
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://14525355572",
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://14525356136",
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://14525356216",
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://14525356313",
            Volume = 1
        },
        ["LMB-1 SFX"] = {
            SoundId = "rbxassetid://14525356038",
            Volume = 1
        },
        ["LMB-2 SFX"] = {
            SoundId = "rbxassetid://14525355777",
            Volume = 1
        },
        ["LMB-3 SFX"] = {
            SoundId = "rbxassetid://14525355884",
            Volume = 1
        },
        ["LMB-4 SFX"] = {
            SoundId = "rbxassetid://14525355946",
            Volume = 1
        },
        ["Petrification Aroma SFX"] = {
            SoundId = "rbxassetid://14525355652",
            Volume = 1
        },
        ["Petrification Aroma Voiceline"] = {
            SoundId = "rbxassetid://14525355503",
            Volume = 1
        },
        ["Grand Petrification Aroma SFX"] = {
            SoundId = "rbxassetid://14525355188",
            Volume = 1
        },
        ["Grand Petrification Aroma Voiceline"] = {
            SoundId = "rbxassetid://14525355301",
            Volume = 1
        },
        ["HeartbreakerStartup SFX"] = {
            SoundId = "rbxassetid://14525354497",
            Volume = 1
        },
        ["HeartbreakerStartup Voiceline"] = {
            SoundId = "rbxassetid://14525354706",
            Volume = 1
        },
        ["MachineGunKiss SFX"] = {
            SoundId = "rbxassetid://14525354906",
            Volume = 1
        },
        ["MachineGunKiss Voiceline"] = {
            SoundId = "rbxassetid://14525354793",
            Volume = 1
        },
        ["PistolKiss SFX"] = {
            SoundId = "rbxassetid://14525354989",
            Volume = 1
        },
        ["PistolKiss Voiceline"] = {
            SoundId = "rbxassetid://14525355406",
            Volume = 1
        }
    }
};