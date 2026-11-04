  

return {
    Name = "wcsetmatchscore",
    Description = "Set absolute test scores for both teams in a current World Cup knockout match",
    Group = "Admin",
    Aliases = { "wcsetmatchscore" },
    Args = { {
            Type = "number",
            Name = "match",
            Description = "Current day\'s match number"
        }, {
            Type = "number",
            Name = "teamAScore",
            Description = "Absolute score for the first listed team"
        }, {
            Type = "number",
            Name = "teamBScore",
            Description = "Absolute score for the second listed team"
        } }
};