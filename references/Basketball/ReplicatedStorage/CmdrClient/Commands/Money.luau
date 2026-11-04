 
 

return {
    Name = "money",
    Description = "Gives the specified player the specified amount of cash",
    Aliases = { "m" },
    Args = { {
            Type = "number",
            Name = "amount",
            Description = "Amount of money to give"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};