  

 

return {
    Name = "Shield",
    Description = "adds shield to players",
    Aliases = { "shield" },
    Group = { "ScriptDevs", "HeadDevs", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "value",
            Description = "Value of shield to set to"
        } }
};