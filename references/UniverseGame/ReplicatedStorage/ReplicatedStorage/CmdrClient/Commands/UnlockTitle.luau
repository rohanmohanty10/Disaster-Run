  

 

return {
    Name = "unlocktitle",
    Description = "adds item to inventory",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Admins", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to grant item to"
        }, {
            Type = "string",
            Name = "itemid",
            Description = "the item id"
        } }
};