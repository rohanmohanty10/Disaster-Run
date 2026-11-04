 
 

return {
    Name = "customclothingweek",
    Description = "Makes the specified player use their own clothing for a week",
    Aliases = { "clothingweek" },
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