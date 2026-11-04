 
 

return {
    Name = "infinitedribbles",
    Description = "Gives the specified player infinite dribbles",
    Aliases = { "infdribbles" },
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