  

return {
    Name = "wctesttopreward",
    Description = "DEV ONLY: simulate the fixed Top 1 U20 weekly resolution and claim path",
    Group = "Admin",
    Aliases = { "wctestreward" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The online test player"
        }, {
            Type = "string",
            Name = "team",
            Description = "Packaged U20 team name (quote Cape Verde)"
        } }
};