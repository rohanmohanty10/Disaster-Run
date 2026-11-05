  

 

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
            Path = "Particles/Hit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v2 = {
    SoundId = 15685763082,
    Volume = 1
};
local v3 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Moves = {
            F = "Block",
            C = "Quickstep",
            E = "Slash",
            R = "Double Slash",
            L = "Breaker"
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
v3.Stats.Breaker = {
    From = "Combat.Breaker"
};
v3.Stats.Slash = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Attack = {
        Damage = 30,
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
            Time = 0.3,
            Velocity = Vector3.new(0, 15, 0)
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
v3.Stats["Double Slash"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Attack = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15),
            Offset = CFrame.new(0, 0, -5)
        },
        ["First Slash"] = {
            Damage = 12.5,
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
                BlockBreak = false
            },
            HitRemotes = { v1 },
            HitSounds = { v2 }
        },
        ["Second Slash"] = {
            Damage = 15.5,
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
                PerfectBlockable = true,
                Blockable = true,
                BlockBreak = true
            },
            HitRemotes = { v1 },
            HitSounds = { v2 }
        }
    }
};

return v3;