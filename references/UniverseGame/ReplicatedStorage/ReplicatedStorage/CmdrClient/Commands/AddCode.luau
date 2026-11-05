  

 

return {
    Name = "addcode",
    Description = "Creates a code for redemption",
    Aliases = {},
    Group = { "ScriptDevs", 195353328, 156538383 },
    Args = { {
            Type = "string",
            Name = "code",
            Description = "name of the code"
        }, {
            Type = "string",
            Name = "itemid",
            Description = "the itemid it should reward"
        }, {
            Type = "boolean",
            Name = "requirements",
            Description = "whether code should require ranked matches",
            Default = true
        }, {
            Type = "duration",
            Name = "expiration",
            Description = "How long code should last for",
            Optional = true
        } }
};