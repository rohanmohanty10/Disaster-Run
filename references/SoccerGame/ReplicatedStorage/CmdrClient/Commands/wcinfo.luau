  

return {
    Name = "wcinfo",
    Description = "Print Soccer Game Cup state for a player",
    Group = "Admin",
    Aliases = { "wcinfo" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};