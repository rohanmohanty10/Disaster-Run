  

return {
    Name = "wcreset",
    Description = "Reset a player\'s Soccer Game Cup data",
    Group = "Admin",
    Aliases = { "wcreset" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};