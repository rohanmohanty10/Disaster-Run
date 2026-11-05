  

 

return {
    Name = "sethealth",
    Description = "set the health of players",
    Aliases = { "sethealth" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "health",
            Description = "health",
            Default = 500
        }, {
            Type = "boolean",
            Name = "change maxhealth",
            Description = "changes Maximum Health as well",
            Default = false
        } }
};