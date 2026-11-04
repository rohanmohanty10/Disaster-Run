 
 

return {
    Name = "getRank",
    Description = "Gets the specified player\'s rank",
    Aliases = {},
    Args = { {
            Type = "playerId",
            Name = "player name",
            Description = "Name of player to lookup"
        }, {
            Type = "rankedGamemode",
            Name = "gamemode",
            Description = "The gamemode to target"
        }, {
            Type = "number",
            Name = "season",
            Description = "Season in number"
        } }
};