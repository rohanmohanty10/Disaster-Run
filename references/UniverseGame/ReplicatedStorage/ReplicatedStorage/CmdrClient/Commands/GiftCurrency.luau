  

 

return {
    Name = "giftcurrency",
    Description = "gift currency to a player",
    Aliases = { "gift" },
    Group = { "ScriptDevs", "Admins" },
    Args = { {
            Type = "number",
            Name = "player userid",
            Description = "The userid to send gift to"
        }, {
            Type = "currency",
            Name = "currency",
            Description = "Currency to modify"
        }, {
            Type = "number",
            Name = "amount",
            Description = "New currency amount"
        } }
};