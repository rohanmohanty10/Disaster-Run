  

 

return {
    Name = "resetstats",
    Description = "Reset stats of a player",
    Aliases = { "reset", "rs" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        } }
};