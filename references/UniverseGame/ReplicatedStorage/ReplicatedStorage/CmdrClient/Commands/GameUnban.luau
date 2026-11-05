  

 

return {
    Name = "gameunban",
    Description = "unban a list of user ids from game",
    Aliases = { "gameunban" },
    Group = { "ScriptDevs", "Admins" },
    Args = { {
            Type = "string",
            Name = "userids or names",
            Description = "List of userids or names to ban"
        }, {
            Type = "string",
            Name = "reason",
            Description = "reason for unban",
            Default = "No reason was given at time of unban"
        } }
};