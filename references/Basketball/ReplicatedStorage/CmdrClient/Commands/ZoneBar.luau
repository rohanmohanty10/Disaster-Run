 
 

return {
    Name = "zonebar",
    Description = "Sets the specified player\'s zone bar to a specified value",
    Group = "HeadTester",
    Aliases = { "zb" },
    Args = { {
            Type = "number",
            Name = "amount",
            Description = "Value to set the zone bar to"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};