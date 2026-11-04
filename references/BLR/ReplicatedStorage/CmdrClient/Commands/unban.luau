  

return {
    Name = "unban",
    Description = "Unbans a player (global)",
    Group = "Mod",
    Aliases = { "unban" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        } }
};