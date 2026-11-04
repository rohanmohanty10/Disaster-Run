  

return {
    Name = "giveballskinglobal",
    Description = "Gives a player a ball skin (global / cross-server)",
    Group = "Mod",
    Aliases = { "ballskinglobal" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "ballSkin",
            Name = "ballSkin",
            Description = "Ball skin name"
        } }
};