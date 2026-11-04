  

return {
    Name = "removegamepass",
    Description = "Removes a gamepass from a player (this server)",
    Group = "Mod",
    Aliases = { "removegamepass" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "gamepass",
            Name = "gamepass",
            Description = "Exact gamepass name to remove"
        } }
};