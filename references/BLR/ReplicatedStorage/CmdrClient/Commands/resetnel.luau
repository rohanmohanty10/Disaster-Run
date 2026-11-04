  

return {
    Name = "resetnel",
    Description = "Reset a player\'s entire NEL state (team, lifetime, quests, streaks)",
    Group = "Admin",
    Aliases = { "resetnel" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};