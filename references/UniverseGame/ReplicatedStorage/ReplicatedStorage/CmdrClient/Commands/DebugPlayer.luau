  

 

return {
    Name = "debugplayer",
    Description = "Applies a debug UI on top of a player\'s head.",
    Aliases = { "dbplr" },
    Group = { "ScriptDevs", "HeadDevs", "Devs", "Admins", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "Players",
            Description = "The player(s) to apply debug to."
        } }
};