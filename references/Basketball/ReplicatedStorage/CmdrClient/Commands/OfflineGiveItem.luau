 
 

return {
    Name = "giveItemOffline",
    Description = "Gives the specified item from the specified player",
    Aliases = { "giveItemOff" },
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