  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local v1 = {
    Moveset = {
        MovesInfo = {
            SubstitutionJutsu = {
                DefaultKeybind = "J",
                Unlocked = true,
                IndicatorInfo = {
                    DisplayName = "Substitution Jutsu"
                }
            }
        }
    },
    Stats = {},
    Animations = {
        Action4 = {}
    },
    Sounds = {}
};
v1.Stats.SubstitutionJutsu = {
    Active = true,
    Damage = 20,
    Actionable = {
        Active = true,
        Stunned = false,
        Ragdolled = false
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Stun = {
        Time = 0.8,
        Priority = Enums.Stun.Heavy
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.identity
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true,
        Unblockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 48,
        Time = 0.3
    }
};

return v1;