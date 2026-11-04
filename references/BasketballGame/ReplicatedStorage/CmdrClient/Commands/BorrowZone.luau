 
 

return {
    Name = "borrowzone",
    Description = "Borrows specified zone to the specified player",
    Group = "HeadTester",
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
        } }
};