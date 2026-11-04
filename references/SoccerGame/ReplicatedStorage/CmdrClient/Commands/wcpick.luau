  

return {
    Name = "wcpick",
    Description = "Force a Soccer Game Cup team pick",
    Group = "Admin",
    Aliases = { "wcpick" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "string",
            Name = "group",
            Description = "Group letter"
        }, {
            Type = "string",
            Name = "team",
            Description = "Team name"
        } }
};