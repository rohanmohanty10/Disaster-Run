  

 

return {
    Name = "forcejoin",
    Description = "forcejoin",
    Aliases = { "forcejoin" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "UserId or Name",
            Description = "The player\'s userid or Name"
        }, {
            Type = "server",
            Name = "Server Type",
            Description = "The desired server type"
        } }
};