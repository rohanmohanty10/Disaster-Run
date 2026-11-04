  

return {
    Name = "join",
    Description = "Join a player in a different server",
    Group = "Mod",
    Aliases = { "join" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        } }
};