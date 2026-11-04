  

return {
    Name = "wcaddcoins",
    Description = "Give a player World Coins for the Soccer Game Cup Final",
    Group = "Admin",
    Aliases = { "wcaddcoins" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "amount",
            Description = "World Coins to add (negative to remove)"
        } }
};