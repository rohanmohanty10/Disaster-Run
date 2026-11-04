 
 

return {
    Description = "toggle freecam for players",
    Name = script.Name,
    Aliases = { "fc" },
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to give freecam, requires a keyboard."
        } }
};