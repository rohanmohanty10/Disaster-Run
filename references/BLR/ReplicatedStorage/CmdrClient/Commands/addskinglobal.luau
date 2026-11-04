  

return {
    Name = "addskinglobal",
    Description = "Gives a player a style skin (global / cross-server)",
    Group = "Mod",
    Aliases = { "addskinglobal" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "style",
            Name = "style",
            Description = "Style name"
        }, {
            Type = "skin",
            Name = "skin",
            Description = "Skin name"
        } }
};