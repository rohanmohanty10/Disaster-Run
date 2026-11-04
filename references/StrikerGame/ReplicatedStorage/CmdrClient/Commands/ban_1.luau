 
 

return {
    Description = "ban die. lol.wwwwwwwwww",
    Name = script.Name,
    Aliases = { "ban" },
    Group = script.Parent.Name,
    Args = { {
            Type = "number",
            Name = "user id",
            Description = "give userid to ban someone."
        }, {
            Type = "string",
            Name = "reason.",
            Description = "reason."
        }, {
            Type = "string",
            Name = "ExcludeAltAccounts.",
            Description = "true / false."
        } }
};