  

 

return {
    Name = "ignorecombattag",
    Description = "immunity to being combat tagged",
    Aliases = { "ignorectag", "ignorect", "ctimmune", "combattagimmune", "ctagimmune" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "PublicTesters", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "value",
            Description = "Immunity Status",
            Default = true
        } }
};