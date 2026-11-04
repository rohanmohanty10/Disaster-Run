  

return {
    Name = "removeitemglobal",
    Description = "Removes a customization item from a player (global / cross-server)",
    Group = "Mod",
    Aliases = { "removeitemglobal" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "string",
            Name = "item",
            Description = "Exact item name to remove"
        } }
};