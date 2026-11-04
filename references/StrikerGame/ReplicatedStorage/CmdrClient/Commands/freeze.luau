 

 

return {
    Description = "freeze the game",
    Name = script.Name,
    Aliases = { "fz" },
    Group = script.Parent.Name,
    Args = { {
            Type = "number",
            Name = "delay",
            Description = "delay until freeze"
        }, {
            Type = "number",
            Name = "duration",
            Description = "positive to have a specific duration"
        } }
};