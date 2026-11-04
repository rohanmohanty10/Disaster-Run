  

return {
    Name = "skipoverallquests",
    Description = "Completes the target\'s NEL Overall (main) quests and grants rewards",
    Group = "Admin",
    Aliases = { "skipoverallquests", "completeoverallquests", "skipmainquests" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};