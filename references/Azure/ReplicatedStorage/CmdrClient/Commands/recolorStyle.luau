 

 

return {
    Description = "mmm different color",
    Name = script.Name,
    Aliases = { "rs" },
    Group = script.Parent.Name,
    Args = { {
            Type = "color3",
            Name = "color",
            Description = "what to go through..."
        }, {
            Type = "number",
            Name = "alpha",
            Description = "strength of recolor (0-1)"
        } }
};