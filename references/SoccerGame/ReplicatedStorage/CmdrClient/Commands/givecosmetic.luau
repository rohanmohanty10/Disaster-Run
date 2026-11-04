  

return {
    Name = "givecosmetic",
    Description = "Gives a player a cosmetic",
    Group = "Mod",
    Aliases = { "givecosmetic" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player"
        }, {
            Type = "cosmetic",
            Name = "cosmetic",
            Description = "The cosmetic"
        } }
};