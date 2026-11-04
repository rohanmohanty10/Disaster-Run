 
 

return {
    Name = "giveUser",
    Description = "Gives the player whatever even if they\'re in another server or offline (USUALLY TAKES A FEW MINUTES)",
    Aliases = {},
    Args = { {
            Type = "integer",
            Name = "playerId",
            Description = "player\'s user id"
        }, {
            Type = "toGive",
            Name = "type",
            Description = ""
        }, {
            Type = "number",
            Name = "value",
            Description = "how much to give them"
        } }
};