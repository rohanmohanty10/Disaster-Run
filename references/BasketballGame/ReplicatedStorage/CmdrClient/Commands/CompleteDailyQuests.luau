 
 

return {
    Name = "completedailyquests",
    Description = "Completes all of the specified player\'s daily quests so they can be claimed",
    Group = "Admin",
    Aliases = { "cdq" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};