 
 

return {
    Name = "getMerchantPurchased",
    Description = "Gets the amount purchased of an item from the Black Market",
    Aliases = { "getBlackMarketPurchased", "getPurchasedAmount" },
    Args = { {
            Type = "string",
            Name = "item type",
            Description = "Type that the item is in eg. \"Cosmetics\", \"GoalEffects\", etc."
        }, {
            Type = "string",
            Name = "item name",
            Description = "Name of the item"
        } }
};