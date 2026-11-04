  

return {
    Name = "wcclearpicks",
    Description = "Clear a player\'s Soccer Game Cup picks",
    Group = "Admin",
    Aliases = { "wcclearpicks" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};