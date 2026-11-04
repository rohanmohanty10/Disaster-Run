  

return {
    Name = "emote",
    Description = "give a emote to someone",
    Group = "Mod",
    Aliases = { "emote" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "emote",
            Name = "emote",
            Description = "emote name"
        } }
};