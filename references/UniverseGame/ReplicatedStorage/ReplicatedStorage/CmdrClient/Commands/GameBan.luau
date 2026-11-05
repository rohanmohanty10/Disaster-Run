  

 

return {
    Name = "gameban",
    Description = "ban a list of user ids from game",
    Aliases = { "gameban" },
    Group = { "ScriptDevs", "Admins" },
    Args = { {
            Type = "string",
            Name = "targets",
            Description = "List of usernames or userids to ban (comma separated)"
        }, {
            Type = "durations",
            Name = "banlength",
            Description = "How long to ban for, pass in a negative value for inf"
        }, {
            Type = "string",
            Name = "reason",
            Description = "reason for ban",
            Default = "No reason was given at time of ban"
        } }
};