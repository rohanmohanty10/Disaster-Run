  

 

return {
    Name = "viewinventory",
    Description = "view inventory from user id",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Admins" },
    Args = { {
            Type = "string",
            Name = "user id or name",
            Description = "the user id or name"
        } }
};