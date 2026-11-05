  

 

return {
    Name = "ignorestun",
    Description = "ignore stun",
    Aliases = { "stunignore" },
    Group = { "ScriptDevs", "Admins", "Mods", "HeadDevs", "PublicTesters", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "state",
            Description = "true or false",
            Default = true,
            Optional = true
        } }
};