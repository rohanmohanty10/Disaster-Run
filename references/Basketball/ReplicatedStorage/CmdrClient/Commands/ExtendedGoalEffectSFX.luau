 
 

return {
    Name = "extendedgoaleffectsfx",
    Description = "Gives the specified player extended duration on goal effect sfx",
    Aliases = { "extendedsfx" },
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
        }, {
            Type = "boolean",
            Name = "extra",
            Description = "Defaults to false",
            Optional = true
        } }
};