 
 

return {
    Name = "unban",
    Description = "Unbans the specified player",
    Aliases = { "pardon" },
    Args = { {
            Type = "playerId",
            Name = "player name",
            Description = "Name of player to be unbanned"
        }, {
            Type = "string",
            Name = "reason",
            Description = "Reason why player is being unbanned"
        } }
};