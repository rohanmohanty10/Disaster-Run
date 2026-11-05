  

 

return {
    Name = "bypassblock",
    Description = "Makes attacks unblockable, including perfect blocks",
    Aliases = { "bypassblock" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "toggle",
            Description = "Whether to enable it",
            Default = true
        } }
};