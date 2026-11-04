 
 

return {
    Name = "trueemperor",
    Description = "Makes the specified player True Emperor",
    Group = "LeadTester",
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
        }, {
            Type = "boolean",
            Name = "no color",
            Description = "Defaults to false",
            Optional = true
        } }
};