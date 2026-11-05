  

 

return {
    Name = "urf",
    Description = "gain urf mechanics",
    Aliases = { "urf" },
    Group = { "ScriptDevs", "Admins", "Mods", "HeadDevs", "PublicTesters", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "value",
            Description = "whether to toggle URF",
            Default = true
        }, {
            Type = "boolean",
            Name = "true urf",
            Description = "whether to toggle true URF",
            Default = false
        }, {
            Type = "boolean",
            Name = "true true urf",
            Description = "whether to toggle true true URF",
            Default = false
        } }
};