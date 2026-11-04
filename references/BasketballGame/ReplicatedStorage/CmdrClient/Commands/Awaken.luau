 
 

return {
    Name = "awaken",
    Description = "Gives awakening to the specified player",
    Group = "HeadTester",
    Aliases = { "awk" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        }, {
            Type = "boolean",
            Name = "skipCutscene",
            Description = "Defaults to true",
            Optional = true
        } }
};