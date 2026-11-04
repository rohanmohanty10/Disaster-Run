 
 

return {
    Name = "kick",
    Description = "Kicks a player or set of players.",
    Group = "AlwaysLog",
    Aliases = { "boot" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to kick."
        } }
};