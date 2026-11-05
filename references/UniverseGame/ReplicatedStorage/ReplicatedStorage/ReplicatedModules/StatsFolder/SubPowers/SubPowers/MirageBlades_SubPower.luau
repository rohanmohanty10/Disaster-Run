  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local v1 = { {
        SoundId = 73674926969925,
        Volume = 1
    }, {
        SoundId = 135364455404951,
        Volume = 1
    } };
local v2 = {
    Moveset = {
        MovesInfo = {
            ShootMirageBlade = {
                DefaultKeybind = "MouseButton2",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Mirage Blade"
                }
            },
            BlisteringBlades = {
                DefaultKeybind = "One",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Blistering Blades"
                }
            },
            SpiralBlades = {
                DefaultKeybind = "Two",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Spiral Blades"
                }
            },
            StormBlades = {
                DefaultKeybind = "Three",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Storm Blades"
                }
            },
            HeavyRainBlades = {
                DefaultKeybind = "Four",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Heavy Rain"
                }
            }
        }
    },
    Stats = {},
    Animations = {},
    Sounds = {
        heavyrainblades_sfx = {
            SoundId = 86581782383909
        },
        mirageblade_shoot_sfx = {
            SoundId = 131800169154125
        },
        spiralblades_sfx = {
            SoundId = 108143304426747
        },
        stormblades_sfx = {
            SoundId = 93124971724808
        }
    }
};
v2.Stats.ShootMirageBlade = {
    Damage = 0.25,
    IgnoreProcessing = true,
    HitAnimations = "Default",
    Actionable = {},
    Cooldown = {
        Time = 0.25
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = 50,
        Offset = CFrame.identity
    },
    Meter = {
        MoveMax = 0.5
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitSounds = v1
};
v2.Stats.BlisteringBlades = {
    Damage = 15,
    HitAnimations = "Default",
    Actionable = {},
    Stun = {
        Time = 0.5
    },
    Cooldown = {
        Time = 13,
        Manual = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = 50,
        Offset = CFrame.identity
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    HitSounds = v1
};
v2.Stats.SpiralBlades = {
    Damage = 1,
    HitAnimations = "Default",
    Actionable = {},
    Priority = Enums.Intangible.Ragdoll,
    Cooldown = {
        Time = 22
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Offset = CFrame.identity
    },
    Meter = {
        RequiredAmount = 25
    },
    HitSounds = v1,
    FinalHit = {
        Damage = 10,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Hitbox = {
            HitboxType = "ClientHitbox",
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.identity
        },
        HitSounds = v1
    }
};
v2.Stats.StormBlades = {
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {},
    Stun = {
        Time = 1
    },
    Cooldown = {
        Time = 13,
        Manual = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(50, 50, 50),
        Offset = CFrame.identity
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    HitSounds = v1
};
v2.Stats.HeavyRainBlades = {
    Damage = 5,
    HitAnimations = "Default",
    Actionable = {},
    Priority = Enums.Intangible.Ragdoll,
    Cooldown = {
        Time = 20,
        Manual = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BypassCounter = true
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = 50,
        Offset = CFrame.identity
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    },
    HitSounds = v1
};

return v2;