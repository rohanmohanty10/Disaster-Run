  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local v1 = {
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
            E = "Cursed Energy Blast",
            R = "Full Power Cursed Energy Blast",
            T = "Behind You",
            L = "Breaker"
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
            Visible = true
        } },
    MaxCombo = 2,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 24, 25, "Attack" }, { 45, "End" } },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 15554638913,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 24, 25, "Attack" }, { 45, "End" } },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 15554638913
            }
        }
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
v1.Stats.Breaker = {
    From = "Combat.Breaker"
};
v1.Stats["Cursed Energy Blast"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
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
    Properties = {
        Armor = true
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 1
    },
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 30,
        Time = 0.3,
        Velocity = Vector3.new(0, 15, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 15653594788,
            Volume = 1.5
        }
    },
    Explosion = {
        Damage = 30,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3,
            Velocity = Vector3.new(0, 15, 0)
        }
    }
};
v1.Stats["Full Power Cursed Energy Blast"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Attack = {
        Damage = 27.5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(50, 50, 50),
            Offset = CFrame.new(0, 0, 0)
        },
        Stun = {
            Time = 1
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3,
            Velocity = Vector3.new(0, 15, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitRemotes = {},
        HitSounds = {}
    }
};
v1.Stats["Behind You"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 30
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false
        }
    },
    Attack = {
        Damage = 35,
        HitAnimations = "Default",
        Stun = {
            Time = 0.75
        },
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 30,
            Time = 0.3
        },
        Block = {
            PerfectBlockable = true,
            Blockable = true,
            BlockBreak = false
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
        HitSounds = {
            Hit = {
                SoundId = 15653595293,
                Volume = 1.5
            }
        }
    }
};

return v1;