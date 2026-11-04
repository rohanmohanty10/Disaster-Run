 
 

return {
    Name = "kill",
    Description = "Kills a player or set of players.",
    Group = "AlwaysLog",
    Aliases = { "slay" },
    Args = { {
            Type = "players",
            Name = "victims",
            Description = "The players to kill."
        } }
};