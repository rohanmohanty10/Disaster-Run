  

return {
    Name = "rollmode",
    Description = "Switch a player\'s style/flow rolling system (test environments only)",
    Group = "Tester",
    Aliases = { "rollmode" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "string",
            Name = "mode",
            Description = "normal | preroll | auto"
        } }
};