  

return {
    Name = "emoteglobal",
    Description = "Gives a player an emote (global / cross-server)",
    Group = "Mod",
    Aliases = { "emoteglobal" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "emote",
            Name = "emote",
            Description = "Emote name"
        } }
};