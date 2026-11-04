 
 

return {
    Name = "scale",
    Description = "Scales a player or set of players.",
    Group = "LeadTester",
    Aliases = { "size" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to scale."
        }, {
            Type = "number",
            Name = "size",
            Description = "The size to scale to."
        } }
};