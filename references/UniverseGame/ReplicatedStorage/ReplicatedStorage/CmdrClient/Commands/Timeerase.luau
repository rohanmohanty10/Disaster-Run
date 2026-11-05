  

 

return {
    Name = "timeerase",
    Description = "Force a timeerase",
    Aliases = {},
    Group = { "ScriptDevs", "Admins", "Devs" },
    Args = { {
            Type = "number",
            Name = "length",
            Description = "how long to timeerase"
        }, {
            Type = "number",
            Name = "delay",
            Description = "delay before timeerasing",
            Optional = true
        } }
};