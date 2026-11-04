  

return {
    Name = "cardglobal",
    Description = "Gives a player a card (global / cross-server)",
    Group = "Mod",
    Aliases = { "cardglobal" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "card",
            Name = "card",
            Description = "Card name"
        } }
};