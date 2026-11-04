  

return {
    Name = "resetoverallquests",
    Description = "Reset a player\'s NEL overall quests so they can be earned again",
    Group = "Admin",
    Aliases = { "resetoverallquests" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};