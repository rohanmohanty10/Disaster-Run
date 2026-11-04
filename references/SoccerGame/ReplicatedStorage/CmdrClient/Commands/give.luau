  

return {
    Name = "give",
    Description = "Gives a player an item (global)",
    Group = "Mod",
    Aliases = { "give" },
    Args = { {
            Type = "player",
            Name = "player name",
            Description = "The player"
        }, {
            Type = "itemType",
            Name = "itemType",
            Description = "The item type"
        }, {
            Type = "number",
            Name = "amount",
            Description = "The amount"
        } }
};