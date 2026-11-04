  

return {
    Name = "addlunarxp",
    Description = "Givel unar xp!!!",
    Group = "Admin",
    Aliases = { "addlunarxp" },
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