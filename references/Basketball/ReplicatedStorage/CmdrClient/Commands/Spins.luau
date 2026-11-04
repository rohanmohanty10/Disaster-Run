 
 

return {
    Name = "spins",
    Description = "Gives the specified player spins of a selected type",
    Aliases = {},
    Args = { {
            Type = "spins",
            Name = "spin type",
            Description = "Type of spin"
        }, {
            Type = "number",
            Name = "amount",
            Description = "Amount of spins to give"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};