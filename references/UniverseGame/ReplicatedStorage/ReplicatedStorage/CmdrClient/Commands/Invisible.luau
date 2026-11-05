  

 

return {
    Name = "invisible",
    Description = "toggles player invisibility",
    Aliases = { "invis" },
    Group = { "ScriptDevs", "Admins", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "invisible?",
            Description = "visibility status",
            Optional = true,
            Default = true
        } }
};