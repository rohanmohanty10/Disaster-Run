 
 

return {
    Description = "ENDS GAME",
    Name = script.Name,
    Aliases = { "end" },
    Group = script.Parent.Name,
    Args = { {
            Type = "number",
            Name = "delay",
            Description = "delay... like striker game?"
        } }
};