  

 

return {
    Name = "setsouls",
    Description = "set reaper soul count",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Devs", "Admins", "Mods", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify Reaper / Shinigami souls"
        }, {
            Type = "number",
            Name = "soul count",
            Description = "How many souls to set the user"
        } }
};