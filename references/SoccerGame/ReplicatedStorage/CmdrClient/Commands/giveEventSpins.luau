  

return {
    Name = "giveEventSpins",
    Description = "Give hallow spin",
    Group = "Mod",
    Aliases = { "giveEventSpins" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "amount",
            Description = "amount"
        } }
};