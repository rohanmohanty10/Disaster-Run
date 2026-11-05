  

 

return {
    Name = "kill",
    Description = "Kills a player or set of players.",
    Aliases = { "slay" },
    Group = { "ScriptDevs", "Admins", "Mods", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "victims",
            Description = "The players to kill.",
            Optional = true
        } }
};