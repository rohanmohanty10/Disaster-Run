  

 

return {
    Name = "bypassragdoll",
    Description = "Bypasses ragdoll intangibility",
    Aliases = { "bypassragdoll" },
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