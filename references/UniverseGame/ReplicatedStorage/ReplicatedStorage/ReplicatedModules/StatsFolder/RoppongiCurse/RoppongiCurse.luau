  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local v1 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v2 = {
    SoundId = 15685762921,
    Volume = 1
};
local v3 = {
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
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            L = "Breaker",
            E = "Chain Attack",
            R = "Forceful Slam",
            T = "Powerful Dash"
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v3.Stats.Block = {
    From = "Combat.Block"
};
v3.Stats.Breaker = {
    From = "Combat.Breaker"
};
v3.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Stats.Grab = {
    From = "Combat.Grab"
};
v3.Stats["Chain Attack"] = {
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
    Attack = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        ["First Hit"] = {
            Damage = 12.5,
            HitAnimations = "Default",
            Stun = {
                Time = 0.8
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            Block = {
                PerfectBlockable = false,
                Blockable = true,
                BlockBreak = true
            },
            HitRemotes = { v1 },
            HitSounds = { v2 }
        },
        ["Second Hit"] = {
            Damage = 15,
            HitAnimations = "Default",
            Stun = {
                Time = 1
            },
            Ragdoll = {
                Time = 2
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 50,
                Time = 0.3
            },
            Block = {
                PerfectBlockable = true,
                Blockable = true,
                BlockBreak = true
            },
            HitRemotes = { v1 },
            HitSounds = { v2 }
        }
    }
};
v3.Stats["Forceful Slam"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Attack = {
        Damage = 30,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(25, 25, 25),
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
            Speed = 20,
            Time = 0.3,
            Velocity = Vector3.new(0, 15, 0)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        HitRemotes = { v1 },
        HitSounds = { v2 }
    }
};
v3.Stats["Powerful Dash"] = {
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
    Properties = {
        Armor = true
    },
    Attack = {
        Damage = 45,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15),
            Offset = CFrame.new(0, 0, -5)
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
            Time = 0.3
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = false
        },
        HitRemotes = { v1 },
        HitSounds = { v2 }
    }
};

return v3;