 
 

return {
    Name = "givecandycorn",
    Group = "Admin",
    Description = "Adds candy corn directly to a player\'s balance",
    Args = { {
            Type = "integer",
            Name = "amount",
            Description = "Positive amount of candy corn to give"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to yourself",
            Optional = true
        } }
};