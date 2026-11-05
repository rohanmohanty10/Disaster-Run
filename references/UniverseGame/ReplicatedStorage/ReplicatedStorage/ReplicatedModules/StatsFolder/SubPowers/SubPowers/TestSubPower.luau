  

 

local v1 = {
    Moveset = {
        MovesInfo = {
            ["Plunger Throw"] = {
                DefaultKeybind = "U",
                Unlocked = true
            }
        }
    },
    Stats = {},
    Animations = {},
    Sounds = {}
};
v1.Stats["Plunger Throw"] = {
    Active = true,
    Damage = 1000,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    }
};

return v1;