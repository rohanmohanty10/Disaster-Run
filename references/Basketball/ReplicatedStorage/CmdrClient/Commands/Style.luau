 
 

return {
    Name = "style",
    Description = "Gives specified style to the specified player",
    Aliases = {},
    Args = { {
            Type = "style",
            Name = "Style",
            Description = "Name of style"
        }, {
            Type = "player",
            Name = "Player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        }, {
            Type = "number",
            Name = "Slot",
            Description = "Slot number (1 - 3), defaults to currently equipped slot",
            Optional = true
        } }
};