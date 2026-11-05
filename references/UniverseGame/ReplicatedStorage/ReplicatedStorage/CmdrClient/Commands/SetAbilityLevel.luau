  

 

return {
    Name = "setlevel",
    Description = "sets level of current ability",
    Aliases = {},
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs", "PublicTesters", "GuestTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to set level"
        }, {
            Type = "number",
            Name = "level",
            Description = "new ability level"
        }, {
            Type = "boolean",
            Name = "traithands active",
            Description = "as if you normally leveled up",
            Optional = true,
            Default = false
        } }
};