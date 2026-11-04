 
 

return {
    Name = "fastflagscheck",
    Description = "Checks if a player or set of players are on fast-flags.",
    Group = "Tester",
    Aliases = { "fastflags", "flags", "ffs", "water" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to check."
        }, {
            Type = "boolean",
            Name = "punish",
            Description = "Defaults to true",
            Optional = true
        } }
};