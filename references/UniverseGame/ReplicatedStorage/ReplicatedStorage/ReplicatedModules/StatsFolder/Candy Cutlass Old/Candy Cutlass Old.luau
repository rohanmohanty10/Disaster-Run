  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u1 = ReplicatedStorage["Client Assets"];
local v2 = {
    {
        Name = "Output",
        Arguments = {
            "FX",
            "HitEffect V2",
            "__Legacy",
            {
                AutoSerialize = true,
                LookAt = "Attacker",
                Particle = u1["Candy Cutlass"].Global.Light
            }
        }
    }
};
local v9 = {
    ["Rush Attack"] = {
        From = "Combat.Rush Attack",
        AnimationTimed = true,
        MaxCombo = 4,
        ComboTick = 1.5,
        Damage = 11.25,
        PresetData = {
            [2] = "RIGHT",
            [3] = "D_LEFT_UP",
            [4] = "RIGHT"
        },
        ["LMB-1"] = TableUtil.Reconcile({
            Speed = 1.5,
            Stun = 0.75,
            Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 20, "Attack" }, { 24, "End" } },
            HitRemotes = v2,
            HitSounds = {
                Hit = {
                    SoundId = 8287429879,
                    Volume = 1.5
                }
            }
        }, BaseStatsModule.Rush_Attack),
        ["LMB-2"] = TableUtil.Reconcile({
            HitSounds = {
                Hit = {
                    SoundId = 8287430345,
                    Volume = 1.5
                }
            }
        }, BaseStatsModule.Rush_Attack),
        ["LMB-3"] = TableUtil.Reconcile({
            HitSounds = {
                Hit = {
                    SoundId = 8287430721,
                    Volume = 1.5
                }
            }
        }, BaseStatsModule.Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            HitSounds = {
                Hit = {
                    SoundId = 8287431303,
                    Volume = 1.5
                }
            }
        }, BaseStatsModule.Rush_Attack_Finisher),
        Callbacks = {
            PreAnim = function(p3, p4) -- Line: 93, Name: PreAnim
                local _ = p3.Player;
                local Character = p3.Character;
                local _ = p3.Stats;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;

                for _, descendant in ipairs(Character.Stand:GetDescendants()) do
                    if descendant:IsA("Trail") then
                        descendant.Enabled = true;
                    end;
                end;
            end,

            PostAnim = function(p5, p6) -- Line: 109, Name: PostAnim
                local _ = p5.Player;
                local Character = p5.Character;
                local _ = p5.Stats;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;

                for _, descendant in ipairs(Character.Stand:GetDescendants()) do
                    if descendant:IsA("Trail") then
                        descendant.Enabled = false;
                    end;
                end;
            end,

            PreHit = function(p7, p8) -- Line: 125, Name: PreHit
                -- upvalues: Knit (copy), u1 (copy)
                local _ = p7.Player;
                local Character = p7.Character;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;
                local Count = p8.MoveState.Count;
                local PresetData = p7.Stats.PresetData;

                if PresetData[Count] then
                    Knit.Remotes.Output:FireAllClients("FX", "Create FX", "Slash FX V3", Character, {
                        Preset = PresetData[Count],
                        Part = u1["Hit Effects"].SlashParticle,
                        ParticleProps = {
                            Color = ColorSequence.new(Color3.new(0, 1, 1)),
                            Size = NumberSequence.new(5)
                        }
                    });
                end;
            end
        }
    }
};
local v10 = {
    Damage = 8.5,
    HitAnimations = "Default",
    Knockback = {
        RelativePart = "Attacker",
        Speed = 2.5,
        Time = 0.15
    },
    Stun = {
        Time = 0.65
    },
    HitRemotes = v2
};
v9["Sword Slashes"] = {
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Active = true,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    PresetData = { "LEFT", "D_LEFT_DOWN", "D_LEFT_UP", "D_LEFT_DOWN" },
    Hit1 = TableUtil.Reconcile({
        Block = {
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 8287429879,
                Volume = 1
            }
        }
    }, v10),
    Hit2 = TableUtil.Reconcile({
        Block = {
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 8287430345,
                Volume = 1
            }
        }
    }, v10),
    Hit3 = TableUtil.Reconcile({
        Block = {
            PerfectBlockable = false
        },
        HitSounds = {
            Hit = {
                SoundId = 8287430721,
                Volume = 1
            }
        }
    }, v10),
    Hit4 = TableUtil.Reconcile({
        Damage = 30,
        Stun = {
            Time = 0.05,
            Priority = Enums.Stun.Medium
        },
        Ragdoll = {
            Time = 0.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 55,
            Time = 0.15
        },
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 8287431303,
                Volume = 1
            }
        }
    }, v10)
};
v9["Naughty List"] = {
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Active = true,
    Properties = {
        Armor = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Attempt = {
        Damage = 10,
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Medium
        },
        HitRemotes = v2
    },
    Impale = {
        Damage = 25,
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Medium
        },
        HitRemotes = v2
    },
    Kick = {
        Damage = 10,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 35,
            Time = 0.15,
            Velocity = Vector3.new(0, 25, 0)
        },
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Medium
        },
        Ragdoll = {
            Time = 1
        },
        HitRemotes = v2
    }
};
v9["Ice Stampede"] = {
    Time = 3,
    Tick = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 2,
        MeterGain = 0
    },
    Active = true,
    Hitbox = {
        Size = Vector3.new(45, 45, 45),
        Debug = false
    },
    Strike = {
        Damage = 30,
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 25,
            Time = 0.15,
            Velocity = Vector3.new(0, 5, 0)
        },
        HitRemotes = v2
    },
    Rain = {
        Damage = 2.6666666666666665,
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.25,
            Priority = Enums.Stun.Medium
        },
        HitRemotes = v2,
        HitSounds = {
            Hit = {
                SoundId = 8304551623,
                Volume = 1
            }
        }
    }
};
v9["Second Degree Burn"] = {
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
    Properties = {
        Armor = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 16),
        Debug = false,
        Offset = CFrame.new(0, 0, -8)
    },
    Stun = {
        Time = 1.75,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "Hot Chocolate Hit", "__Legacy" }
        }, {
            Name = "Output",
            Clients = { "__Data.Target" },
            Arguments = { "FX", "Hot Chocolate Screen", "__Legacy" }
        } },
    HitSounds = {
        Hit = {
            SoundId = 8398000784,
            Volume = 1
        }
    },
    Block = {
        PerfectBlockable = false,
        Unblockable = true
    }
};
v9["Insulin Spike"] = {
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1,
        MeterGain = 0
    },
    Active = true,
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Jab = {
        Damage = 10,
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 1.5,
            Priority = Enums.Stun.Medium
        },
        HitRemotes = v2
    },
    Spikes = {
        Damage = 55,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Medium
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 75,
            Time = 0.3,
            Velocity = Vector3.new(0, 50, 0)
        },
        HitRemotes = v2
    }
};
v9["Christmas Spirit"] = {
    Duration = 30,
    Heal = 50,
    Active = true,
    Meter = {
        RequiredLevel = 2,
        MeterGain = 0
    },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Name = "Christmas Spirit",
        Time = 45,
        Manual = true
    }
};
v9["Sugar Spikes"] = {
    Tick = 3,
    Frequency = 0.2,
    Active = true,
    HitAnimations = "Default",
    Damage = 15,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.5,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "HitEffect V2",
                "__Legacy",
                {
                    AutoSerialize = true,
                    LookAt = "Attacker",
                    Particle = u1["Candy Cutlass"].Global.Light
                }
            }
        },
        {
            Name = "Output",
            Clients = { "__Data.Target" },
            Arguments = { "FX", "Sugar Spikes Screen", "__Legacy" }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 8466469454,
            Volume = 1
        }
    }
};
v9.Block = {
    From = "Combat.Block"
};
v9.Quickstep = {
    From = "Combat.Quickstep"
};
v9.Pose = {
    From = "Combat.Pose"
};
v9.Grab = {
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
            ["Sword Slashes"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Perform four consecutive slashes"
            },
            ["Naughty List"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Impale the target, grabbing them by the neck while stabbing/impaling them in the stomach, followed up with a kick."
            },
            ["Ice Stampede"] = {
                DefaultKeybind = "T",
                LevelRequirement = 75,
                Description = "Plunge your sword into the ground, causing a hailstorm above to appear, hitting everyone within an area around you.",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Second Degree Burn"] = {
                DefaultKeybind = "Y",
                LevelRequirement = 20,
                Description = "Pull out a convenient cup of hot chocolate, throwing all of the drink in front of you, landing this attack will cause the target to become temporarily blinded.",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Insulin Spike"] = {
                DefaultKeybind = "G",
                LevelRequirement = 60,
                Description = "Impale the target, slamming them into a field of peppermint spikes.",
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Christmas Spirit"] = {
                DefaultKeybind = "B",
                LevelRequirement = 85,
                Description = "Eat your weapon/enter an awakened state, causing you to become hyper, increase overall damage and speed for a small period of time.",
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Sugar Spikes"] = {
                DefaultKeybind = "V",
                LevelRequirement = 40,
                Description = "Put some peppermints into your mouth, before spitting them forwards, landing this attack will cause the target to become temporarily blinded.",
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 8339433631,
            ["LMB-2"] = 8339494888,
            ["LMB-3"] = 8339540203,
            ["LMB-4"] = 8347065812,
            ["Sword Slashes"] = 8284745181,
            ["Second Degree Burn"] = 8285521172,
            ["Naughty List Attempt"] = 8287443015,
            ["Naughty List Hit"] = 8287444401,
            ["Naughty List Victim"] = 8287447145,
            ["Naughty List Victim Kick"] = 8294844534,
            ["Ice Stampede"] = 8294686957,
            ["Christmas Spirit"] = 8301744269,
            ["Candy Spit"] = 8444886216,
            ["Insulin Spike Jab"] = 8321963485,
            ["Insulin Spike Hit"] = 8335322126,
            ["Insulin Spike Victim"] = 8335332078,
            ["Insulin Spike Victim Knockback"] = 8335338603,
            PoseTransition = 8420240312,
            PoseIdle = 8420237840
        },
        Movement = {
            Run = 8368299567,
            Walk = 8368306574
        },
        Idle = {
            Idle = 8368309134
        }
    },
    Stats = v9,
    Sounds = {
        ["LMB-1"] = {
            SoundId = 8416221626,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 8416222359,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 8416222752,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 8416223185,
            Volume = 1
        },
        SugarSpikesStart = {
            SoundId = 8466578476,
            Volume = 1
        },
        InsulinSequence = {
            SoundId = 8379462479,
            Volume = 1
        },
        InsulinStartup = {
            SoundId = 8379460925,
            Volume = 1
        },
        SpiritBuff = {
            SoundId = 8379366672,
            Volume = 1
        },
        SpiritWindup = {
            SoundId = 8379365868,
            Volume = 1
        },
        IceGroundSlam = {
            SoundId = 8304491731,
            Volume = 1
        },
        IceWindup = {
            SoundId = 8304492251,
            Volume = 1
        },
        ["Second Degree Burn"] = {
            SoundId = 8397999984,
            Volume = 1
        },
        NLSequence = {
            SoundId = 8296133493,
            Volume = 1
        },
        NLStart = {
            SoundId = 8296131139,
            Volume = 1
        },
        Slashes = {
            SoundId = 8287344959,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 9966321814,
            Volume = 2.5,
            PlaybackSpeed = 0.669
        },
        ["Christmas Spirit"] = {
            SoundId = 9062222166,
            Volume = 1,
            Looped = true
        }
    }
};