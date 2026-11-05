  

 

return {
    Name = "accel",
    Description = "gain time acceleration",
    Aliases = { "accel" },
    Group = { "ScriptDevs", "Admins", "Mods", "Devs" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The player to modify"
        }, {
            Type = "number",
            Name = "state",
            Description = "0 - 5",
            Default = "0"
        } }
};