  

return {
    Name = "wcforceweek",
    Description = "Force Soccer Game Cup weekly reward resolution for a player (optional forced top-percent)",
    Group = "Admin",
    Aliases = { "wcforceweek" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "percentile",
            Description = "Optional forced top-percent (1 = top 1%, grants everything)",
            Optional = true
        } }
};