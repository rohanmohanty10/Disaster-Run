  

 

return {
    Name = "overridequote",
    Description = "Overrides your current quote set with quotes from another ability (skin) and, optionally, groups.",
    Aliases = {},
    Group = { "ScriptDevs", "Admins", "Devs", "Admins", "Mods" },
    Args = { {
            Type = "players",
            Name = "player",
            Description = "The player to modify"
        }, {
            Type = "string",
            Name = "Ability Name",
            Description = "The ability to inherit from",
            Optional = true,
            Default = ""
        }, {
            Type = "string",
            Name = "Skin Name",
            Description = "The ability skin to inherit from",
            Optional = true,
            Default = ""
        }, {
            Type = "string",
            Name = "Quote Group",
            Description = "The group to use",
            Optional = true,
            Default = ""
        } }
};