  

 

game:GetService("RunService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.BaseStatsModule);
local _ = ReplicatedStorage["Client Assets"];
local v1 = {};

local function CreateMultiIndicator(p2) -- Line: 17
    local v3 = {};

    for i, v in pairs(p2) do
        if i ~= "Overrides" then
            table.insert(v3, {
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

    if p2.Overrides then
        for _, v in ipairs(v3) do
            for i, v2 in pairs(p2.Overrides) do
                v[i] = v2;
            end;
        end;
    end;

    return v3;
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
    Indicators = CreateMultiIndicator({
        Universal = "Grab"
    }),
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
v1["Mirror Kick"] = {
    Active = true,
    Damage = 45,
    Range = 250,
    IntervalTime = 0.025,
    SidewaysOffset = 13,
    UpOffset = 55,
    SegmentDistance = 10,
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Mirror Kick"
    }),
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 2,
            Overrides = {
                Lifetime = 7,
                Rate = 1
            }
        } },
    Block = {
        Blockable = false,
        PerfectBlockable = true
    },
    Stun = {
        Time = 1.25
    },
    Ragdoll = {
        Time = 1.25
    },
    Knockback = {
        Override = true,
        Speed = 30,
        Time = 0.13
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 40,
        Debug = false
    }
};
v1["Light Rays"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Light Rays"
    }),
    Cooldown = {
        Time = 1,
        Manual = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 75,
        Debug = false
    },
    TargetRays = {
        ExplosionDelay = 30,
        Damage = 8.5,
        AmountRange = Vector2.new(2, 4),
        Priority = Enums.Intangible.Ragdoll,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                Damage = 2,
                Overrides = {
                    Lifetime = 3,
                    Rate = 1
                }
            } },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Stun = {
            Time = 0.5
        },
        Ragdoll = {
            Time = 0.5
        },
        Knockback = {
            Override = true,
            Speed = 20,
            Time = 0.13,
            Velocity = Vector3.new(0, 15, 0)
        },
        Hitbox = {
            Type = "Magnitude",
            Size = 13,
            Debug = false
        }
    },
    LingerRays = {
        Frequency = 3,
        Radius = 40,
        Damage = 2,
        AmountRange = Vector2.new(5, 8),
        Speed = Vector2.new(150, 210),
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                Damage = 2,
                Overrides = {
                    Lifetime = 3,
                    Rate = 1
                }
            } },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Stun = {
            Time = 0.45
        },
        Hitbox = {
            Type = "Magnitude",
            Size = 13,
            Debug = false
        }
    }
};
v1["Light Kick"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Light Kick"
    }),
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 42,
        Time = 0.16,
        Velocity = Vector3.new(0, 24, 0)
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 25,
        Debug = false
    }
};
v1["Light Meteors"] = {
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Light Meteors"
    }),
    Cooldown = {
        Time = 1,
        Manual = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 75,
        Debug = false
    },
    Meteor = {
        ExplosionDelay = 80,
        Damage = 20,
        AmountRange = Vector2.new(1, 2),
        Priority = Enums.Intangible.Ragdoll,
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Burn",
                Damage = 2,
                Overrides = {
                    Lifetime = 3,
                    Rate = 1
                }
            } },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Stun = {
            Time = 0.5
        },
        Ragdoll = {
            Time = 0.5
        },
        Knockback = {
            RelativePart = "Target",
            Override = true,
            Speed = 20,
            Time = 0.13,
            Velocity = Vector3.new(0, 30, 0)
        },
        Hitbox = {
            Type = "Magnitude",
            Size = 20,
            Debug = false
        }
    }
};
v1["Jewels Of Light"] = {
    Active = true,
    Duration = 180,
    Frequency = 3,
    UpDistance = 20,
    Damage = 15,
    Actionable = {
        Active = true
    },
    Indicators = CreateMultiIndicator({
        Universal = "Jewels Of Light"
    }),
    Priority = Enums.Intangible.Ragdoll,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Stun = {
        Time = 1.5
    },
    Ragdoll = {
        Time = 1.25
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 32,
        Time = 0.15,
        Velocity = Vector3.new(0, 30, 0)
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 18,
        Debug = false
    }
};

return {
    Stats = v1,
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Moves = {
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            R = "Mirror Kick",
            T = "Light Rays",
            E = "Light Kick",
            Y = "Light Meteors",
            G = "Jewels Of Light"
        }
    },
    Animations = {
        Action = {
            ["Mirror Kick Charge"] = 15369109992,
            ["Mirror Kick"] = 15369111906,
            ["Light Kick"] = 15373564392,
            ["Jewels Of Light Start"] = 15462211917,
            ["Jewels Of Light"] = 15382846067
        },
        Movement = {
            Walk = 15382698169,
            Run = 15382701827
        },
        Idle = {
            Idle = 15369108738
        }
    },
    Sounds = {}
};