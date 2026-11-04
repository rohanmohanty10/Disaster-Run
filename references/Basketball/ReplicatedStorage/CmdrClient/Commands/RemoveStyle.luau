 
 

return {
    Name = "removeStyle",
    Description = "Removes specified style from the specified player, has to be a limited",
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
        } }
};