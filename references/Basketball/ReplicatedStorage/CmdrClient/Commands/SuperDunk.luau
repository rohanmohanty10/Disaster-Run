 
 

return {
    Name = "superdunk",
    Description = "Activates Super Dunk on the specified player",
    Aliases = { "dunkmode" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        }, {
            Type = "boolean",
            Name = "toggle",
            Description = "Defaults to true",
            Optional = true
        } }
};