  

 

return {
    Name = "addpscode",
    Description = "Creates a code for private servers",
    Aliases = {},
    Group = { "ScriptDevs", "Admins", "HeadDevs", 100747086 },
    Args = { {
            Type = "string",
            Name = "code",
            Description = "name of the code"
        }, {
            Type = "duration",
            Name = "expiration",
            Description = "How long code should last for"
        }, {
            Type = "players",
            Name = "players",
            Description = "which players to teleport to code currently in server",
            Optional = true
        } }
};