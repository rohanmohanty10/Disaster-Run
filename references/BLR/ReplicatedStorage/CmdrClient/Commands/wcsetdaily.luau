  

return {
    Name = "wcsetdaily",
    Description = "Set a player\'s Soccer Game Cup daily points",
    Group = "Admin",
    Aliases = { "wcsetdaily" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "amount",
            Description = "Points amount"
        } }
};