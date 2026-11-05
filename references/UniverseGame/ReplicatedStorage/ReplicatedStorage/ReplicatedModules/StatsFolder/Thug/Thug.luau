  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local v1 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            },
            StandOff = {
                Visible = true
            },
            StandOn = {
                Visible = false
            }
        },
        Moves = {
            MouseButton1 = "Rush Attack",
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            L = "Breaker",
            E = "Shoulder Rush",
            R = "Winding Hook",
            T = "Glock",
            Y = "Spinning Throw",
            G = "Whaling Slam",
            H = "Home Run",
            V = "Counter",
            B = "Backstab"
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v1.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Knuckle Sandwich",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = { { 0, "Start" }, { 24, 28, "Attack" }, { 31, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15619855456,
                Volume = 1.5
            }
        },
        HitRemotes = { v1.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 26, 29, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15619855533,
                Volume = 1.5
            }
        }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 22, 24, "Attack" }, { 30, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15619855248,
                Volume = 1.5
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 26, 39, "Attack" }, { 40, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15619855137,
                Volume = 1.5
            }
        },
        HitRemotes = { v1.Resources.HeavyHit }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Breaker = {
    From = "Combat.Breaker"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Stats.Grab = {
    From = "Combat.Grab"
};
v1.Stats["Shoulder Rush"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Attack = {
        Damage = 30,
        HitAnimations = "Default",
        Stun = {
            Time = 0.8
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v1.Resources.LightHit }
    }
};
v1.Stats["Winding Hook"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Attack = {
        Damage = 35,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = {
            Hit = {
                SoundId = 15619855920,
                Volume = 1
            }
        },
        HitRemotes = { v1.Resources.HeavyHit }
    }
};
v1.Stats.Glock = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Attack = {
        Damage = 12.5,
        HitAnimations = "Default",
        Stun = {
            Time = 0.35
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        HitRemotes = { v1.Resources.LightHit }
    }
};
v1.Stats["Spinning Throw"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Startup = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    Release = {
        Damage = 25,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 56,
            Velocity = Vector3.new(0, 16, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        HitRemotes = { v1.Resources.HeavyHit }
    }
};
v1.Stats["Whaling Slam"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    Slam = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    BodySlam = {
        Damage = 25,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        HitRemotes = { v1.Resources.HeavyHit }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        }
    }
};
v1.Stats["Home Run"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Attack = {
        Damage = 65,
        HitAnimations = "Default",
        Stun = {
            Time = 0.25
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.HeavyHit }
    },
    HomeRun = {
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 56,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        }
    }
};
v1.Stats.Counter = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Attack = {
        Damage = 35,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        HitRemotes = { v1.Resources.HeavyHit }
    }
};
v1.Stats.Counter = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Attack = {
        Damage = 35,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        HitRemotes = { v1.Resources.HeavyHit }
    }
};
v1.Stats.Backstab = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Attack = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 0.65
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit }
    }
};

return v1;