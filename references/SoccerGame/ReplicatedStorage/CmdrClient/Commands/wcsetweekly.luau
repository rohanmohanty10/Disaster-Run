  

return {
    Name = "wcsetweekly",
    Description = "Set a player\'s Soccer Game Cup weekly points",
    Group = "Admin",
    Aliases = { "wcsetweekly" },
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