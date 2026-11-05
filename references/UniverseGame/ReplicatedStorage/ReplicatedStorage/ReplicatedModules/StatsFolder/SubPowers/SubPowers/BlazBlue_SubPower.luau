  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local v1 = {
    Moveset = {
        MovesInfo = {
            SerpentsLaceration = {
                DefaultKeybind = "J+",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Serpent\'s Laceration"
                }
            }
        }
    },
    Stats = {},
    Animations = {
        Action4 = {
            ["SerpentsLaceration Attempt"] = 97807020401065,
            ["SerpentsLaceration Player"] = 85274200781039,
            ["SerpentsLaceration Target"] = 98874996277249
        }
    },
    Sounds = {
        SerpentsLaceration = {
            SoundId = 73977073987489,
            Volume = 2
        },
        ["SerpentsLaceration Attempt"] = {
            SoundId = 93629978050811,
            Volume = 2
        }
    }
};
local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            AutoSerialize = true,
            LookAt = "Attacker",
            AbilityName = script.Name
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
            Path = "Particles/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker",
            AbilityName = script.Name
        }
    }
};
v1.Stats.SerpentsLaceration = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 45,
        Manual = true
    },
    Meter = {
        Required = 100,
        RemoveMeter = false,
        IgnoreTraits = true
    },
    Attempt = {
        CheckPVPSafe = true,
        Block = {
            PerfectBlockable = false,
            Unblockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 9),
            Offset = CFrame.new(0, 0, -4.25)
        }
    },
    Success = {
        Damage = 3,
        MinHealth = 1,
        Meter = false,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v2 },
        Stun = {
            Time = 1.15
        },
        Block = {
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Release = {
        Damage = 26,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2.5
        },
        HitRemotes = { v3 },
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 75,
            Time = 0.2,
            Override = true,
            Velocity = Vector3.new(0, 15, 0)
        }
    }
};

return v1;