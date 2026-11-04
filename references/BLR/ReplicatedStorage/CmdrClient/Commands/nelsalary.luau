  

return {
    Name = "nelsalary",
    Description = "Set a player\'s current NEL career yen salary",
    Group = "Admin",
    Aliases = { "nelsalary" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "amount",
            Description = "Yen amount to set"
        } }
};