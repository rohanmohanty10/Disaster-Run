 
 

return {
    Name = "all",
    Description = "Gives the specified player every single item",
    Group = "AlwaysLog",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};