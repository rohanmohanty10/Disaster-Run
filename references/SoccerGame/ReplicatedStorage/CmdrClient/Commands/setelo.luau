  

return {
    Name = "setelo",
    Description = "Sets a player\'s ranked Elo and HighestElo for testing",
    Group = "Admin",
    Aliases = { "setelo" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "elo",
            Description = "The Elo value to set"
        }, {
            Type = "string",
            Name = "mode",
            Description = "Ranked mode (5v5 or 2v2)",
            Optional = true,
            Default = "5v5"
        } }
};