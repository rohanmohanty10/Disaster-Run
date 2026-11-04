  

return {
    Name = "givemvpcutscene",
    Description = "Gives a player an MVP cutscene",
    Group = "Mod",
    Aliases = { "givemvpcutscene", "givemvp" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player"
        }, {
            Type = "mvpCutscene",
            Name = "mvpCutscene",
            Description = "The MVP cutscene"
        } }
};