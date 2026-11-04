 
 

return {
    Name = "cdon",
    Description = "Turns ability cooldowns on for all players or targets",
    Group = "AlwaysLog",
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "players",
            Description = "Target players, defaults to LocalPlayer",
            Optional = true
        } }
};