  

return {
    Name = "addxp",
    Description = "Gives player xp",
    Group = "Admin",
    Aliases = { "addxp" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "amount",
            Description = "amount"
        } }
};