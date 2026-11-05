  

 

return {
    Name = "addtrait",
    Description = "adds trait to current player ability",
    Aliases = {},
    Group = { "ScriptDevs", "HOS", "PublicTesters", "GuestTesters", "Admins" },
    Args = { {
            Type = "trait",
            Name = "trait",
            Description = "the desired trait",
            Optional = false
        }, {
            Type = "boolean",
            Name = "Hexed",
            Description = "whether the trait is hexed or not",
            Default = false,
            Optional = true
        }, {
            Type = "integer",
            Name = "Attack",
            Description = "override the attack stat bonus",
            Optional = true
        }, {
            Type = "integer",
            Name = "Defense",
            Description = "override the defense stat bonus",
            Optional = true
        }, {
            Type = "integer",
            Name = "Health",
            Description = "override the health stat bonus",
            Optional = true
        }, {
            Type = "integer",
            Name = "Special",
            Description = "override the special stat bonus",
            Optional = true
        } }
};