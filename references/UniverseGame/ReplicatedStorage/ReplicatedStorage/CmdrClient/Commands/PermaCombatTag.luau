  

 

return {
    Name = "permacombattag",
    Description = "sets target(s) in combat",
    Aliases = { "permactag", "permact", "permct", "permcombattag", "permctag" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "PublicTesters", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "value",
            Description = "Status",
            Default = true
        } }
};