  

 

return {
    Name = "interrupt",
    Description = "Forces a character interrupt on target players.",
    Aliases = { "int" },
    Group = { "ScriptDevs", "HeadDevs", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players\' characters to interrupt."
        }, {
            Type = "string",
            Name = "interrupt type",
            Description = "The type to use.",
            Optional = true,
            Default = "Stunned"
        } }
};