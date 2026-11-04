 

 

return {
    Description = "Shows a player\'s ping, the ping hitboxes use, and their jitter.",
    Name = script.Name,
    Aliases = {},
    Group = script.Parent.Name,
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Player to check."
        } }
};