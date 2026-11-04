 
 

return {
    Name = "truecopycat",
    Description = "Makes the specified player True Copycat",
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