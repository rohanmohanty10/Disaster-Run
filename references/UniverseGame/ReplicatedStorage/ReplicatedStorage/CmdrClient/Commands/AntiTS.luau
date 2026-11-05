  

 

return {
    Name = "AntiTS",
    Description = "gain timestop resistance",
    Aliases = { "antits", "nots", "nts" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to modify"
        }, {
            Type = "boolean",
            Name = "state",
            Description = "true or false",
            Default = true,
            Optional = true
        } }
};