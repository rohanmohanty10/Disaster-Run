  

return {
    Name = "goal",
    Description = "give a goal effect to someone",
    Group = "Mod",
    Aliases = { "goal" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "goal",
            Name = "goal",
            Description = "Goal effect name"
        } }
};