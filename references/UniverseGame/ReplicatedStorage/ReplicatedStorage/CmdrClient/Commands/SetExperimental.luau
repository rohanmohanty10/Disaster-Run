  

 

return {
    Name = "setexperimental",
    Description = "Activates experimental combat features",
    Aliases = { "experimental" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player to modify"
        }, {
            Type = "boolean",
            Name = "State",
            Description = "Toggles whether experimental features are on",
            Default = true
        } }
};