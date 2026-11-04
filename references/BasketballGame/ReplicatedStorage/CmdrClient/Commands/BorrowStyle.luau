 
 

return {
    Name = "borrowstyle",
    Description = "Borrows specified style to the specified player",
    Group = "HeadTester",
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