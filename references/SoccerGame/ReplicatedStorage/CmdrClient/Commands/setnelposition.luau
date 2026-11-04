  

return {
    Name = "setnelposition",
    Description = "Set a player\'s NEL derived position label",
    Group = "Admin",
    Aliases = { "setnelposition" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "string",
            Name = "position",
            Description = "Striker | Midfielder | Defender"
        } }
};