  

 

return {
    Name = "serverban",
    Description = "ban player from this server",
    Aliases = { "sban" },
    Group = { "ScriptDevs", "Admins", "Mods", "Devs", "PSOwner" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "Who to server ban"
        }, {
            Type = "string",
            Name = "reason",
            Description = "reason for server ban",
            Default = "No reason was given at time of kick"
        } }
};