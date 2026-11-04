  

return {
    Name = "removeitem",
    Description = "Removes a customization item from a player (this server)",
    Group = "Mod",
    Aliases = { "removeitem" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "string",
            Name = "item",
            Description = "Exact item name to remove"
        } }
};