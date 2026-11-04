 
 

return {
    Description = "enable dub for this life",
    Name = script.Name,
    Aliases = { "dub" },
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "targets",
            Description = "The players to dub ez."
        } }
};