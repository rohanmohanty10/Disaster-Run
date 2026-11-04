 

 

return {
    Description = "Caps a player\'s FPS for testing. 0 removes the cap.",
    Name = script.Name,
    Aliases = {},
    Group = script.Parent.Name,
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Player to cap."
        }, {
            Type = "nonNegativeInteger",
            Name = "fps",
            Description = "FPS cap (5-240), 0 to remove."
        } }
};