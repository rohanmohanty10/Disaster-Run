  

 

return {
    Name = "kick",
    Description = "Kicks a player or set of players.",
    Aliases = { "boot" },
    Group = { "ScriptDevs", "Admins", "Mods", "Devs", "PSOwner" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to kick."
        } }
};