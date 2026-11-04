 
 

return {
    Name = "giveClanSeasonsRewards",
    Description = "Attempts to give clean season rewards to the specified player",
    Aliases = { "giveClanRewards", "clanSeasonRewards", "clanRewards" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player"
        } }
};