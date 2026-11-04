  

return {
    Name = "crossgive",
    Description = "Gives a player an item (global)",
    Group = "Mod",
    Aliases = { "crossgive" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "itemType",
            Name = "itemType",
            Description = "The item type"
        }, {
            Type = "number",
            Name = "count",
            Description = "The amount"
        } }
};