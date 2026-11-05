  

 

return {
    Name = "addlimited",
    Description = "Adds a limited to shop",
    Aliases = {},
    Group = { "ScriptDevs", 195353328, 156538383 },
    Args = { {
            Type = "string",
            Name = "itemid",
            Description = "itemid to add"
        }, {
            Type = "number",
            Name = "price",
            Description = "price per stock"
        }, {
            Type = "number",
            Name = "amount",
            Description = "how much stock to add"
        }, {
            Type = "boolean",
            Name = "inf stock",
            Description = "make stock unlimited",
            Optional = true
        } }
};