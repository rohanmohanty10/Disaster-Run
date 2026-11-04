  

return {
    Name = "wcaddpoints",
    Description = "Add Soccer Game Cup points through the full pipeline",
    Group = "Admin",
    Aliases = { "wcaddpoints" },
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