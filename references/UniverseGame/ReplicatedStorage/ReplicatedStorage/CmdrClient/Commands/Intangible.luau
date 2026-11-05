  

 

return {
    Name = "Intangible",
    Description = "Gain intangibility",
    Aliases = { "intangible" },
    Group = { "ScriptDevs", "Admins", "Devs" },
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