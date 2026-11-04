  

return {
    Name = "cosmetic",
    Description = "Gives a player a cosmetic (global)",
    Group = "Mod",
    Aliases = { "cosmetic" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "cosmetic",
            Name = "cosmetic",
            Description = "The cosmetic"
        } }
};