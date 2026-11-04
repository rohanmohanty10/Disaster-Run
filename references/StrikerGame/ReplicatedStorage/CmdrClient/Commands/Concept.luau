 

 

return {
    Description = "access to concepts",
    Name = script.Name,
    Aliases = { "conc" },
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "targets",
            Description = "The players to conceptualize ez."
        } }
};