  

return {
    Name = "nelstat",
    Description = "Give a player NEL career stat counts (auto-adds matching yen)",
    Group = "Admin",
    Aliases = { "nelstat" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "string",
            Name = "stat",
            Description = "Goals | Assists | Saves | Steals"
        }, {
            Type = "number",
            Name = "count",
            Description = "How many to add"
        } }
};