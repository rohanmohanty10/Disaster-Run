 
 

return {
    Name = "ban",
    Description = "Bans the specified player",
    Aliases = {},
    Args = { {
            Type = "playerId",
            Name = "player name",
            Description = "Name of player to be banned"
        }, {
            Type = "string",
            Name = "reason",
            Description = "Reason why player is being banned"
        }, {
            Type = "number",
            Name = "time",
            Description = "Ban duration, defaults to permanent",
            Optional = true
        } }
};