  

return {
    Name = "skipallnelquests",
    Description = "Marks every NEL quest as completed for the target player.",
    Group = "Mod",
    Aliases = { "skipallnelquests", "skipnelall", "completeallnelquests" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The target player"
        } }
};