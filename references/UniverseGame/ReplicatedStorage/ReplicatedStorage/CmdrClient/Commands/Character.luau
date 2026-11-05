  

 

return {
    Name = "character",
    Description = "temporarily sets the player(s) avatar to the given id\n To clear just leave input blank",
    Aliases = { "char" },
    Group = { "ScriptDevs", "HeadDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "Id or Name",
            Description = "Id or Name Leave blank to reset",
            Optional = true
        }, {
            Type = "boolean",
            Name = "save",
            Description = "save usage across respawn",
            Default = false,
            Optional = true
        }, {
            Type = "boolean",
            Name = "change chat name",
            Description = "change chat name to display name (if given)\n Locked to HighRanks Only",
            Default = false,
            Optional = true
        }, {
            Type = "boolean",
            Name = "outfit id",
            Description = "use a outfit from a player?",
            Default = false,
            Optional = true
        } }
};