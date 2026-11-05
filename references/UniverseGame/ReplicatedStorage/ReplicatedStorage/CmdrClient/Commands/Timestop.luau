  

 

return {
    Name = "timestop",
    Description = "Force a timestop",
    Aliases = {},
    Group = { "ScriptDevs", "Admins", "Devs" },
    Args = { {
            Type = "number",
            Name = "length",
            Description = "how long to timestop"
        }, {
            Type = "number",
            Name = "delay",
            Description = "delay before timestopping",
            Optional = true
        }, {
            Type = "boolean",
            Name = "ignore",
            Description = "timestop stops you also",
            Optional = true
        } }
};