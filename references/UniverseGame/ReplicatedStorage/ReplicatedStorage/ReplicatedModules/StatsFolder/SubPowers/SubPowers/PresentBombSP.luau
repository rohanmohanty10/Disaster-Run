  

 

local v1 = {
    Moveset = {
        MovesInfo = {
            ["Present Bomb"] = {
                DefaultKeybind = "Z+",
                DisplayName = "\"Here\'s something to remember me by!\"",
                Description = "Heheh! Eat this!",
                Unlocked = true
            }
        }
    },
    Stats = {},
    Animations = {
        Action4 = {
            PresentBombPrepare = 108136064353006,
            PresentBombRun = 121655914101402,
            PresentBombCutsceneUser = 116767904021233,
            PresentBombCutsceneTarget = 126768569045307,
            PresentBombCutsceneCamera = 88889884273124
        }
    },
    Sounds = {}
};
v1.Stats["Present Bomb"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.25
    },
    Block = {
        Blockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 150,
        Time = 0.1
    },
    Ragdoll = {
        Time = 3
    },
    Cooldown = {
        Time = 6,
        AfterMove = true
    },
    Detection = {
        Block = {
            Blockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Offset = CFrame.new(0, 0, -4)
        }
    }
};

return v1;