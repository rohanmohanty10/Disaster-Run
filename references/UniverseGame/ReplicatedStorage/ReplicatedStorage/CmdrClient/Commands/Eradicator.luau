  

 

return {
    Name = "eradicator",
    Description = "doom",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Devs", "Admins", "Mods" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "active",
            Description = "yea",
            Default = true
        } }
};