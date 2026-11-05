  

 

return {
    Name = "giftitem",
    Description = "gift item to a player",
    Aliases = { "gift" },
    Group = { "ScriptDevs", "Admins" },
    Args = { {
            Type = "number",
            Name = "player userid",
            Description = "The userid to send gift to"
        }, {
            Type = "strings",
            Name = "itemids",
            Description = "the item ids"
        } }
};