  

 

return {
    Name = "additem",
    Description = "adds item to inventory",
    Aliases = { "add" },
    Group = { "ScriptDevs", "HeadDevs", "Admins", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to grant item to"
        }, {
            Type = "string",
            Name = "itemid",
            Description = "the item id"
        }, {
            Type = "boolean",
            Name = "premium",
            Description = "make premium",
            Optional = true
        }, {
            Type = "number",
            Name = "amount",
            Description = "how much to add",
            Optional = true,
            Default = 1
        }, {
            Type = "number",
            Name = "serial",
            Description = "serial to set",
            Optional = true
        }, {
            Type = "number",
            Name = "pattern id",
            Description = "custom hue id 0-72",
            Optional = true
        }, {
            Type = "number",
            Name = "charm id",
            Description = "custom charm id 1-11",
            Optional = true
        }, {
            Type = "boolean",
            Name = "chroma",
            Description = "rgb chroma unusual",
            Optional = true
        }, {
            Type = "boolean",
            Name = "tradelock",
            Default = true,
            Description = "whether item should be tradelocked",
            Optional = true
        } }
};