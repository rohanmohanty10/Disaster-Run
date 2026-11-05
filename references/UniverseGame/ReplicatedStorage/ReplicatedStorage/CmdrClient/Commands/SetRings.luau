  

 

return {
    Name = "setrings",
    Description = "set rings amount, this will not work outside the respective abilities",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Devs", "Admins", "Mods", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify Reaper / Shinigami souls"
        }, {
            Type = "number",
            Name = "rings",
            Description = "How many Rings to set the user"
        } }
};