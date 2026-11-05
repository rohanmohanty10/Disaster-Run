  

 

local v1 = {
    Moveset = {
        MovesInfo = {
            ["Shard 4 Shard"] = {
                DefaultKeybind = "U",
                Unlocked = true
            }
        }
    },
    Stats = {},
    Animations = {},
    Sounds = {}
};
v1.Stats["Shard 4 Shard"] = {
    Active = true,
    UShards = 10000,
    DamageBuff = 0.1,
    Duration = 10,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};

return v1;