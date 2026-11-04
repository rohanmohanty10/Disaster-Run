 

 

return {
    Description = "Kills a player or set of players.",
    Name = script.Name,
    Aliases = { "slay" },
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "victims",
            Description = "The players to kill."
        } }
};