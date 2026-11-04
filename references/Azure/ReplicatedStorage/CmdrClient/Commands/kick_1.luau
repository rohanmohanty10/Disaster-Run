 
 

return {
    Description = "Kicks a player or set of players.",
    Name = script.Name,
    Aliases = { "boot" },
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to kick."
        } }
};