 
 

return {
    Description = "Remove player(s) access to PS+ exclusive styles.",
    Name = script.Name,
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "peoples",
            Description = "The People."
        }, {
            Type = "psstyles",
            Name = "Options",
            Description = "The current catalog, more to come"
        } }
};