  

return {
    Name = "gemskin",
    Description = "Forces the Vietnam gem currency skin on or off for a player this session",
    Group = "Tester",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "boolean",
            Name = "enabled",
            Description = "on or off"
        } }
};