  

return {
    Name = "card",
    Description = "give a card to someone",
    Group = "Mod",
    Aliases = { "card" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "card",
            Name = "card",
            Description = "Card Name"
        } }
};