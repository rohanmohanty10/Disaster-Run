  

 

return {
    Name = "CombatTag",
    Description = "combat tags",
    Aliases = { "combattag" },
    Group = { "ScriptDevs", "HeadDevs", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "value",
            Description = "time to set to"
        } }
};