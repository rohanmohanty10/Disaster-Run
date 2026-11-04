  

return {
    Name = "wcresettestreward",
    Description = "DEV ONLY: remove the active U20 Top 1 test rewards and restore its player state",
    Group = "Admin",
    Aliases = { "wctestreset" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The online test player"
        } }
};