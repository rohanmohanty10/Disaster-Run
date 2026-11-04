 
 

return {
    Name = "giveAsset",
    Description = "Gives the specified player the specified asset",
    Aliases = { "asset" },
    Args = { {
            Type = "assets",
            Name = "asset name",
            Description = "Name of asset to give"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};