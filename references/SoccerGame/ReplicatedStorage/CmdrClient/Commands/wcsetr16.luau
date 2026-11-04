  

return {
    Name = "wcsetr16",
    Description = "Deprecated: configure R16 matchups in BlueLockCupEventData",
    Group = "Admin",
    Aliases = { "wcsetr16" },
    Args = { {
            Type = "number",
            Name = "day",
            Description = "Day index of the R16 day"
        }, {
            Type = "number",
            Name = "match",
            Description = "Match number (1-based)"
        }, {
            Type = "string",
            Name = "teamA",
            Description = "First team name"
        }, {
            Type = "string",
            Name = "teamB",
            Description = "Second team name"
        } }
};