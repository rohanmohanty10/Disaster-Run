 
 

return {
    Name = "getBestRank",
    Description = "Gets the specified player\'s best rank",
    Aliases = {},
    Args = { {
            Type = "playerId",
            Name = "player name",
            Description = "Name of player to lookup"
        }, {
            Type = "number",
            Name = "season",
            Description = "Season in number"
        } }
};