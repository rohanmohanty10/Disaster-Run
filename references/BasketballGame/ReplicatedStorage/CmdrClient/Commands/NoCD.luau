 
 

return {
    Name = "nocd",
    Description = "Turns ability cooldowns off for all players or targets",
    Group = "AlwaysLog",
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "players",
            Description = "Target players, defaults to LocalPlayer",
            Optional = true
        } }
};