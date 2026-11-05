  

 

return {
    Name = "check",
    Description = "Checks target player\'s current equipped status",
    Aliases = {},
    Group = { "Public" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to check"
        } }
};