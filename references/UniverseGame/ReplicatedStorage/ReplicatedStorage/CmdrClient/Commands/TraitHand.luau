  

 

return {
    Name = "traithand",
    Description = "gives trait hand",
    Aliases = {},
    Group = { "ScriptDevs", "PublicTesters" },
    Args = { {
            Type = "string",
            Name = "rarity",
            Description = "trait hand must be certain rarity"
        }, {
            Type = "boolean",
            Name = "hexed",
            Description = "trait hand must have a hexed trait",
            Optional = true
        }, {
            Type = "player",
            Name = "player",
            Description = "The player to grant trait hand to",
            Optional = true
        } }
};