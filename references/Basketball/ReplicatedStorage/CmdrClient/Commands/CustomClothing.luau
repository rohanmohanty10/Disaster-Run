 
 

return {
    Name = "customclothing",
    Description = "Makes the specified player use their own clothing",
    Aliases = { "clothing" },
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