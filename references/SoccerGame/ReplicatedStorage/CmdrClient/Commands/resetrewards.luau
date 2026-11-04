  

return {
    Name = "resetRankedRewards",
    Description = "Resets a player\'s claimed rank rewards for testing",
    Group = "Admin",
    Aliases = { "resetrankedrewards" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};