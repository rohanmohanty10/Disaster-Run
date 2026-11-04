  

return {
    Name = "giveballskin",
    Description = "Gives ball skins",
    Group = "Mod",
    Aliases = { "giveballskin" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "ballSkin",
            Name = "Ball Skin",
            Description = "Ball  Skin Name"
        } }
};