 
 

return {
    Name = "giveItem",
    Description = "Gives the specified player the specified item if they don\'t have it",
    Aliases = { "item", "gi" },
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