 
 

return {
    Name = "removeZone",
    Description = "Removes specified zone from the specified player, has to be a limited",
    Aliases = {},
    Args = { {
            Type = "zone",
            Name = "Zone",
            Description = "Name of zone"
        }, {
            Type = "player",
            Name = "Player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};