  

return {
    Name = "gamepass",
    Description = "Gives a player a gamepass (global)",
    Group = "Mod",
    Aliases = { "gamepass" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "gamepass",
            Name = "gamepass",
            Description = "The gamepass"
        } }
};