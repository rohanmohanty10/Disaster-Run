  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.Enums);
local v1 = {
    Moveset = {
        MovesInfo = {
            ["Hollow Summon"] = {
                DefaultKeybind = "V",
                Unlocked = true
            }
        }
    },
    Stats = {},
    Animations = {
        Action4 = {
            ["Hollow Summon"] = 72533952347852,
            ["Skull Gun"] = 88878309587645
        }
    },
    Sounds = {}
};
v1.Stats["Hollow Summon"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Projectile = {
        Damage = 1,
        HitAnimations = "Default",
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Stun = {
            Time = 1
        },
        Knockback = {
            Speed = 1,
            Time = 0.1,
            RelativeTowards = "Target"
        },
        HitSounds = {
            Hit = {
                SoundId = 132291204995469,
                Volume = 1
            }
        }
    },
    Explosion = {
        Damage = 5,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.75
        },
        Knockback = {
            Speed = 30,
            Time = 0.35,
            Velocity = Vector3.new(0, 35, 0),
            RelativeTowards = "Target"
        },
        Ragdoll = {
            Time = 1.5
        }
    }
};

return v1;