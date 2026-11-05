  

 

return {
    Name = "spawndummy",
    Description = "Spawn a dummy",
    Aliases = { "dummy" },
    Group = { "ScriptDevs", "HeadDevs", "Devs", "Admins", "PublicTesters" },
    Args = { {
            Type = "dummytype",
            Name = "Dummy Type",
            Description = "The dummy to spawn",
            Default = "Normal"
        }, {
            Type = "string",
            Name = "Player avatar",
            Description = "The avatar to use from a player. Takes either a UserId or Username.",
            Optional = true,
            Default = ""
        } }
};