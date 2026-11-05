  

 

return {
    Name = "fakenotify",
    Description = "fakenotify",
    Aliases = { "fakenotify" },
    Group = { "ScriptDevs", "Admins", "Mods", "HeadDevs", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "itemid",
            Description = "the item id"
        }, {
            Type = "boolean",
            Name = "chest animation",
            Description = "chest/trait pulling animation",
            Optional = true,
            Default = false
        } }
};