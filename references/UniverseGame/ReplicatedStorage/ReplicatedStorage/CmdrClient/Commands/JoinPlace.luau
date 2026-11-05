  

 

return {
    Name = "JoinPlace",
    Description = "Joins a specified UG sub-place",
    Aliases = { "Join", "join" },
    Group = { "ScriptDevs", "Admins", "Mods", "HeadDevs", "Devs" },
    Args = { {
            Type = "players",
            Name = "Players",
            Description = "The players to teleport",
            Optional = false
        }, {
            Type = "place",
            Name = "Place",
            Description = "The place to join",
            Default = "Main Game",
            Optional = false
        }, {
            Type = "string",
            Name = "Instance ID",
            Description = "The Job/Instance ID of a specific server to join",
            Optional = true
        } }
};