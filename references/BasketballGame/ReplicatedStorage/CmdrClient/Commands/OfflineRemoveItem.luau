 
 

return {
    Name = "removeItemOffline",
    Description = "Removes the specified item from the specified player",
    Aliases = { "removeItemOff" },
    Args = { {
            Type = "number",
            Name = "userid",
            Description = "Target player (from userid)"
        }, {
            Type = "itemCategory",
            Name = "item category",
            Description = "Category that the item is in eg. \"Cosmetics\", \"GoalEffects\", etc."
        }, {
            Type = "string",
            Name = "item name",
            Description = "Name of the item you want to remove"
        } }
};