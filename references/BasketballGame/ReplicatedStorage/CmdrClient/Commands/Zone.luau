 
 

return {
    Name = "zone",
    Description = "Gives specified zone to the specified player",
    Aliases = {},
    Args = { {
            Type = "zone",
            Name = "zone",
            Description = "Name of zone"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        }, {
            Type = "number",
            Name = "Slot",
            Description = "Slot number (1 - 3), defaults to currently equipped slot",
            Optional = true
        } }
};