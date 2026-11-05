  

 

return {
    Name = "sendmessage",
    Description = "send a message as someone else",
    Aliases = {},
    Group = { "ScriptDevs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "message",
            Description = "the message the player should send"
        }, {
            Type = "boolean",
            Name = "rank",
            Description = "whether or not it should include their group rank"
        } }
};