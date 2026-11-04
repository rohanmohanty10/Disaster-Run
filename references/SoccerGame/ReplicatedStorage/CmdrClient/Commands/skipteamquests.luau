  

return {
    Name = "skipteamquests",
    Description = "Completes the target\'s current-team NEL Team Quests (captain quests)",
    Group = "Admin",
    Aliases = { "skipteamquests", "completeteamquests" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};