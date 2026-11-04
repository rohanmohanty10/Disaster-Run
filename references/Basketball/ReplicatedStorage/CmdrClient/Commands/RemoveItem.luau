 
 

return {
    Name = "removeItem",
    Description = "Removes the specified item from the specified player",
    Aliases = { "remove" },
    Args = { {
            Type = "itemCategory",
            Name = "item category",
            Description = "Category that the item is in eg. \"Cosmetics\", \"GoalEffects\", etc."
        }, {
            Type = "string",
            Name = "item name",
            Description = "Name of the item you want to remove"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};