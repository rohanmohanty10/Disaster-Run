 
 

return {
    Name = "giveGamepass",
    Description = "Gives the specified player the specified gamepass",
    Aliases = { "gamepass" },
    Args = { {
            Type = "gamepasses",
            Name = "gamepass name",
            Description = "Name of gamepass to give"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};