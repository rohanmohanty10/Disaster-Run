 
 

return {
    Name = "playertime",
    Description = "Returns the amount of time the target player has been in the game.",
    Group = "LeadTester",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};