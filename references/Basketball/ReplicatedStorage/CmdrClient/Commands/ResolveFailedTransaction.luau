 
 

return {
    Name = "resolveFailedTransaction",
    Description = "Resolves the specified player\'s failed transaction",
    Aliases = {},
    Args = { {
            Type = "playerId",
            Name = "player name",
            Description = "Name of player to lookup"
        }, {
            Type = "string",
            Name = "transaction id",
            Description = "Id of transaction to resolve"
        } }
};