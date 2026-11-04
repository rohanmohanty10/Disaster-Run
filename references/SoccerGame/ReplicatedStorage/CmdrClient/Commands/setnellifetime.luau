  

return {
    Name = "setnellifetime",
    Description = "Set a player\'s lifetime NEL yen on a team",
    Group = "Admin",
    Aliases = { "setnellifetime" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "string",
            Name = "team",
            Description = "Team name"
        }, {
            Type = "number",
            Name = "amount",
            Description = "Lifetime yen"
        } }
};