  

 

return {
    Name = "unlockall",
    Description = "unlocks all in selected inventory category",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "PublicTesters" },
    Args = { {
            Type = "string",
            Name = "itemtype",
            Description = "ability, skins, items, mounts, killeffects, emotes",
            Optional = true,
            Default = "ability"
        }, {
            Type = "number",
            Name = "rarity",
            Description = "Minimum rarity",
            Optional = true
        }, {
            Type = "boolean",
            Name = "KeepInventory",
            Description = "Keep current inventory",
            Optional = true,
            Default = true
        }, {
            Type = "boolean",
            Name = "TradeLock",
            Description = "Tradelock items",
            Optional = true,
            Default = true
        } }
};