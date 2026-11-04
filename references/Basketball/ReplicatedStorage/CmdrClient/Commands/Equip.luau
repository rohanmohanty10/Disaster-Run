 
 

return {
    Name = "equip",
    Description = "Equips a customizable item from a player\'s inventory in a given category",
    Aliases = { "eq" },
    Args = { {
            Type = "itemCategory",
            Name = "item category",
            Description = "Category that the item is in eg. \"Cosmetics\", \"GoalEffects\", etc."
        }, {
            Type = "string",
            Name = "item name",
            Description = "Name of the item you want to give"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};