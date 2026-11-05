  

 

return {
    Name = "heal",
    Description = "heal players",
    Aliases = { "heal" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        } }
};