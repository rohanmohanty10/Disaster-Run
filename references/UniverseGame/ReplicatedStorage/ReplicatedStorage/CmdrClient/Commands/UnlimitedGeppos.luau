  

 

return {
    Name = "unlimitedgeppos",
    Description = "unlimited geppos",
    Aliases = { "unlimitedgeppos" },
    Group = { "ScriptDevs", "Admins", "Mods", "HeadDevs", "PublicTesters", "Devs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "value",
            Description = "whether to toggle unlimited geppos",
            Default = true
        } }
};