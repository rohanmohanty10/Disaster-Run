 
 

return {
    Name = "formless",
    Description = "Puts the specified player in Formless Mode",
    Group = "HeadTester",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        }, {
            Type = "boolean",
            Name = "toggle",
            Description = "Defaults to true",
            Optional = true
        } }
};