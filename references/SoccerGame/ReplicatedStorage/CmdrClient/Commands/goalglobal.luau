  

return {
    Name = "goalglobal",
    Description = "Gives a player a goal effect (global / cross-server)",
    Group = "Mod",
    Aliases = { "goalglobal" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "goal",
            Name = "goal",
            Description = "Goal effect name"
        } }
};