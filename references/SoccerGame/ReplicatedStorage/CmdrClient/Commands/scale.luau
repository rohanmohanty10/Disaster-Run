  

return {
    Name = "scale",
    Description = "Scales the targets character",
    Group = "Admin",
    Aliases = { "scale" },
    Args = { {
            Type = "players",
            Name = "targetPlayers",
            Description = "the targt players"
        }, {
            Type = "number",
            Name = "scale",
            Description = "The scale value"
        } }
};