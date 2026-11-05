  

 

return {
    Name = "listtradelogs",
    Description = "view trade log id",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Admins" },
    Args = { {
            Type = "string",
            Name = "user id or name",
            Description = "The UserId or name to view trade logs of."
        } }
};