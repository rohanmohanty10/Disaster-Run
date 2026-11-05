  

 

return {
    Name = "addpremium",
    Description = "Adds a premium to shop",
    Aliases = {},
    Group = { "ScriptDevs" },
    Args = { {
            Type = "string",
            Name = "itemid",
            Description = "itemid to add"
        }, {
            Type = "number",
            Name = "price",
            Description = "price in upoints"
        }, {
            Type = "duration",
            Name = "expiration",
            Description = "when it expires"
        } }
};