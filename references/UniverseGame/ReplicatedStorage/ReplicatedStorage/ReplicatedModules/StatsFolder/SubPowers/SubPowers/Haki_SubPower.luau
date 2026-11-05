  

 

local v1 = {
    Moveset = {
        MovesInfo = {
            ["Busoshoku Haki"] = {
                DefaultKeybind = "J",
                Unlocked = true
            },
            ["Haoshoku Haki"] = {
                DefaultKeybind = "H",
                Unlocked = true
            },
            ["Kenbunshoku Haki"] = {
                DefaultKeybind = "B",
                Unlocked = true
            }
        }
    },
    Stats = {},
    Animations = {
        Action4 = {
            ["Busoshoku Haki"] = 18762893702,
            ["Kenbunshoku Haki"] = 18841680241,
            ["Haoshoku Haki"] = 18890192349
        }
    },
    Sounds = {}
};
v1.Stats["Busoshoku Haki"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Cooldown = {
        Time = 120,
        Manual = true
    }
};
v1.Stats["Haoshoku Haki"] = {
    Active = true,
    Time = 2.5,
    Lock = 10,
    Actionable = {
        Active = true
    },
    Meter = {
        IgnoreTraits = true,
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 70,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.identity
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Stun = {
        Time = 2
    },
    Block = {
        Unblockable = true,
        BypassCounter = true,
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    }
};
v1.Stats["Kenbunshoku Haki"] = {
    Active = true,
    Duration = 10,
    MinSpeed = 18,
    MaxSpeed = 32,
    Timescale = 1.05,
    Distance = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 45,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    }
};

return v1;