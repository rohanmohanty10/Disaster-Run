  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
require(Knit.Util.Trove);
require(Knit.Util.Promise);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnableTrail = require(script.EnableTrail);
local v1 = ClientAssets["Base Hamon"];
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Global.Light
        }
    }
};
local v3 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Global.Heavy
        }
    }
};
local v4 = {};
local u5 = {};
v4["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 12, 16, "Attack" }, { 22, "End" } },
        Stun = {
            Time = 0.8
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 6.5, 6.5),
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = {
            Hit = {
                SoundId = 14101786105,
                Volume = 1
            }
        },
        HitRemotes = { v2 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 14, 16, "Attack" }, { 22, "End" } },
        Stun = {
            Time = 0.8
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 6.5, 6.5),
            Offset = CFrame.new(0, 0, -4)
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 21, 24, "Attack" }, { 26, "End" } },
        Stun = {
            Time = 1
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 6.5, 6.5),
            Offset = CFrame.new(0, 0, -4)
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 24, "Attack" }, { 42, "End" } },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6.5, 6.5, 8.5),
            Offset = CFrame.new(0, 0, -5)
        },
        HitSounds = {
            Hit = {
                SoundId = 14101786491,
                Volume = 1
            }
        },
        HitRemotes = { v3 }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p6, p7) -- Line: 152, Name: PreAnim
            -- upvalues: EnableTrail (copy), u5 (copy), ClientAssets (copy)
            local _ = p6.Player;
            local Character = p6.Character;
            local _ = p6.Stats;
            local _ = Character.Humanoid;
            local _ = Character.HumanoidRootPart;
            local _ = Character.Stand;
            local Count = p7.MoveState.Count;

            if Count == 1 then
                EnableTrail(Character, { "Left", true });

                return;
            end;

            if Count == 2 then
                EnableTrail(Character, { "Right", true });

                return;
            end;

            if Count == 3 then
                EnableTrail(Character, { "Left", true });

                return;
            end;

            if Count == 4 then
                if u5[Character] then
                    return;
                end;

                local v8 = ClientAssets["Base Hamon"].FakeArm:Clone();
                v8.FakeArm.Part0 = Character["Right Arm"];
                v8.FakeArm.Parent = Character["Right Arm"];
                v8.Color = Character["Right Arm"].Color;
                v8.CFrame = Character["Right Arm"].CFrame;
                local Motor6D = Instance.new("Motor6D");
                Motor6D.Part0 = Character["Right Arm"];
                Motor6D.Part1 = v8;
                Motor6D.Parent = v8;
                v8.Parent = Character;
                u5[Character] = v8;
                Character["Right Arm"].Transparency = 1;
                EnableTrail(Character, { "Right", true });
            end;
        end,

        PostAnim = function(p9, p10) -- Line: 195, Name: PostAnim
            -- upvalues: EnableTrail (copy), u5 (copy)
            local _ = p9.Player;
            local Character = p9.Character;
            local _ = p9.Stats;
            local _ = Character.Humanoid;
            local _ = Character.HumanoidRootPart;
            local _ = Character.Stand;
            EnableTrail(Character, { "Both", false });

            if p10.MoveState.Count == 4 then
                if not u5[Character] then
                    return;
                end;

                local v11 = u5[Character];
                u5[Character] = nil;
                v11:Destroy();
                Character["Right Arm"].Transparency = 0;
            end;
        end
    }
};
v4.Block = {
    From = "Combat.Block"
};
v4.Quickstep = {
    From = "Combat.Quickstep"
};
v4.Grab = {
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
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v4.Pose = {
    From = "Combat.Pose"
};
v4.Breaker = {
    From = "Combat.Breaker"
};
v4["Ripple Charge"] = {
    Active = true,
    MaxHamon = 4,
    ChargeRate = 0.125,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v4.Overdrive = {
    Active = true,
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 13.5,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 14.5),
        Offset = CFrame.new(0, 0, -6.5)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 2.5,
        Time = 0.1
    },
    Stun = {
        Time = 1.15
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14103206756,
            Volume = 1
        }
    },
    HitRemotes = { v3 }
};
v4["Ripple Driver"] = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Active = true,
    CheckPVPSafe = true,
    Properties = {
        Armor = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6, 6, 6),
        Offset = CFrame.new(0, 0, 0)
    },
    Stun = {
        Time = 1.15
    },
    Hit = {
        Damage = 14,
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 2.5,
            Time = 0.1
        },
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 1.5
        },
        Block = {
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14103209486,
                Volume = 1
            }
        },
        HitRemotes = { v3 }
    }
};
v4["Depth Charge"] = {
    Active = true,
    Damage = 1.15,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 6.5),
        Offset = CFrame.new(0, 0, -4)
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14103209872,
            Volume = 1
        }
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "HitEffect V3",
                {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    AutoSerialize = true,
                    LookAt = "Attacker",
                    Particle = v1["Depth Charge"].Hit
                }
            }
        }
    }
};
v4["Solar Strike"] = {
    Active = true,
    Damage = 27.5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 6.5),
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 20,
        Time = 0.3,
        Velocity = Vector3.new(0, -20, 0)
    },
    Stun = {
        Time = 1
    },
    Ragdoll = {
        Time = 1.5
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    HitSounds = {
        Hit = {
            SoundId = 14103211632,
            Volume = 1
        }
    },
    HitRemotes = { v3 }
};
v4["Charged Overdrive"] = {
    Active = true,
    Damage = 2.5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Meter = {
        RequiredLevel = 1.5
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 6.5),
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 2.5,
        Time = 0.1
    },
    Stun = {
        Time = 1
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14103211632,
            Volume = 1
        }
    },
    HitRemotes = { v2 }
};
v4["Ripple Kenpo"] = {
    Active = true,
    Damage = 22.5,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Meter = {
        RequiredLevel = 2
    },
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(6.5, 6.5, 8),
        Offset = CFrame.new(0, 0, -2)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3
    },
    Ragdoll = {
        Time = 1.15
    },
    Stun = {
        Time = 1.15
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    HitSounds = {
        Hit = {
            SoundId = 14103213122,
            Volume = 1
        }
    },
    HitRemotes = { v2 }
};

return {
    Stats = v4,
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
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            ["Ripple Charge"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false,
                Description = "Hold to continuously charge meter at a slow pace"
            },
            Overdrive = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Send out your arm to do a long range attack"
            },
            ["Ripple Driver"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Charge forward with force"
            },
            ["Depth Charge"] = {
                DefaultKeybind = "T",
                Description = "Throw out electricity with your hands",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Solar Strike"] = {
                DefaultKeybind = "Y",
                Description = "Imbue Hamon and slam the ground",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Charged Overdrive"] = {
                DefaultKeybind = "G",
                Description = "Repeatedly punch forward",
                LevelRequirement = 85,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Ripple Kenpo"] = {
                DefaultKeybind = "H",
                Description = "Simple overhead fist strike",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 14077503343,
            ["LMB-2"] = 14077504690,
            ["LMB-3"] = 14077511697,
            ["LMB-4"] = 14077520348,
            ["Hamon Charge Startup"] = 14034237580,
            ["Hamon Charge Loop"] = 14034238865,
            Overdrive = 14034248269,
            ["Ripple Driver"] = 14034557399,
            ["Depth Charge"] = 14034262637,
            PoseIdle = 15600749145,
            PoseTransition = 15600749145,
            ["Solar Strike"] = 14034266621,
            ["Charged Overdrive"] = 14034271629,
            ["Ripple Kenpo"] = 14034276743
        },
        Movement = {
            Walk = 14009219359,
            Run = 14009221598
        },
        Idle = {
            Idle = 14001176954
        }
    },
    Sounds = {
        ["Charge SFX"] = {
            SoundId = 14391964787,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 108334939630174,
            Volume = 3,
            Looped = true
        },
        ["LMB-1"] = {
            SoundId = 14101784388,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14101784750,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14101785182,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14101785493,
            Volume = 1
        },
        ["Overdrive SFX"] = {
            SoundId = 14553943267,
            Volume = 1
        },
        ["Ripple Driver SFX"] = {
            SoundId = 14103207179,
            Volume = 1
        },
        ["Depth Charge SFX"] = {
            SoundId = 14553943106,
            Volume = 1
        },
        ["Solar Strike SFX"] = {
            SoundId = 14553942669,
            Volume = 1
        },
        ["Charged Overdrive SFX"] = {
            SoundId = 14103211971,
            Volume = 1
        },
        ["Ripple Kenpo SFX"] = {
            SoundId = 14553942588,
            Volume = 1
        }
    }
};