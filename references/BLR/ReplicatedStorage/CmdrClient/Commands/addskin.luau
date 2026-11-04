  

return {
    Name = "addskin",
    Description = "Gives ability skin to player",
    Group = "Tester",
    Aliases = { "addskin" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "style",
            Name = "style",
            Description = "Style name"
        }, {
            Type = "skin",
            Name = "skin",
            Description = "Skin name"
        } }
};