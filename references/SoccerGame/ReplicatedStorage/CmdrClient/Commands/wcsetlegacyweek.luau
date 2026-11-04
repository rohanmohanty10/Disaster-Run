  

return {
    Name = "wcsetlegacyweek",
    Description = "DEV only: insert an absolute player score into the completed legacy World Cup week",
    Group = "Admin",
    Aliases = { "wcsetlegacyweek" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The online tester"
        }, {
            Type = "number",
            Name = "score",
            Description = "Absolute legacy weekly score"
        } }
};