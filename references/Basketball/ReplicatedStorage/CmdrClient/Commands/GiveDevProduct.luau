 
 

return {
    Name = "giveDevProduct",
    Description = "Gives the specified player the specified developer product",
    Aliases = { "giveProduct", "product" },
    Args = { {
            Type = "devProducts",
            Name = "product name",
            Description = "Name of developer product to give"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};