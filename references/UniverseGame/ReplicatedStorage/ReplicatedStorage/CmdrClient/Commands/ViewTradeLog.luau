  

 

return {
    Name = "viewtradelog",
    Description = "view trade log id",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Admins" },
    Args = { {
            Type = "string",
            Name = "trade id",
            Description = "the trade id"
        } }
};