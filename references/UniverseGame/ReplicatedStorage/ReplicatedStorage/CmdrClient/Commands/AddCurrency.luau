  

 

return {
    Name = "addcurrency",
    Description = "Sets your currency",
    Aliases = {},
    Group = { "ScriptDevs", "PublicTesters" },
    Args = { {
            Type = "currency",
            Name = "currency",
            Description = "Currency to modify"
        }, {
            Type = "number",
            Name = "amount",
            Description = "New currency amount"
        } }
};