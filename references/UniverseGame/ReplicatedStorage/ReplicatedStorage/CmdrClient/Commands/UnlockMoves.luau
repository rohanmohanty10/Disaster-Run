  

 

return {
    Name = "unlockmoves",
    Description = "unlockmoves",
    Aliases = { "unlockmoves" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "Status",
            Description = "Unlock Status",
            Default = true
        } }
};