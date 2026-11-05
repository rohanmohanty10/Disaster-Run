  

 

return {
    Name = "resetdailyquest",
    Description = "Reset Daily Quest Cooldown",
    Aliases = { "resetdaily" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player to modify"
        } }
};