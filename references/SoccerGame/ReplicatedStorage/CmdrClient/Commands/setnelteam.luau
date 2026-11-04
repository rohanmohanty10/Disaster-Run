  

return {
    Name = "setnelteam",
    Description = "Set a player\'s NEL current team (academy bypass)",
    Group = "Admin",
    Aliases = { "setnelteam" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "string",
            Name = "team",
            Description = "Team name, or \"\" to clear"
        } }
};