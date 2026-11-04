 
 

return {
    Name = "supermalevolentvision",
    Description = "Activates Super MalevolentVision on the specified player",
    Aliases = { "malevolentvisionmode" },
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