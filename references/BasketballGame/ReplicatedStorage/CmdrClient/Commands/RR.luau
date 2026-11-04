 
 

return {
    Name = "rr",
    Description = "Adjusts a user\'s RR",
    Aliases = { "elo" },
    Args = { {
            Type = "number",
            Name = "userid",
            Description = "Target player (from userid)"
        }, {
            Type = "rankedGamemode",
            Name = "gamemode",
            Description = "The gamemode to target"
        }, {
            Type = "integer",
            Name = "adjustment",
            Description = "Amount to adjust by (negatives supported)"
        } }
};