  

 

return {
    Name = "damage",
    Description = "damage players",
    Aliases = { "damage" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "damage",
            Description = "damage",
            Default = true
        }, {
            Type = "boolean",
            Name = "system damage",
            Description = "whether damage should be applied through combat system",
            Default = false
        }, {
            Type = "boolean",
            Name = "true damage",
            Description = "whether damage should be true",
            Default = false
        } }
};