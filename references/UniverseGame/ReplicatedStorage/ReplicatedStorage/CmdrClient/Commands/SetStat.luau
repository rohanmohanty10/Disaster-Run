  

 

return {
    Name = "setstat",
    Description = "Set stats of a player",
    Aliases = { "stat", "set" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "stat",
            Name = "Stat Type",
            Description = "The stat to set",
            Default = "Health"
        }, {
            Type = "number",
            Name = "stat value",
            Description = "The new value to set stat to",
            Default = 0
        } }
};