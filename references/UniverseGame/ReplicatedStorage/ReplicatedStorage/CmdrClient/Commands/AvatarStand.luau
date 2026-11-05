  

 

return {
    Name = "avatarstand",
    Description = "temporarily sets stand model to an avatar (must be humanoid stand)",
    Aliases = { "avstand", "charstand" },
    Group = { "ScriptDevs", "HeadDevs", "Admins", "Devs", "PublicTesters", "Mods" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "Id or Name",
            Description = "Id or Name",
            Default = 21141528
        }, {
            Type = "boolean",
            Name = "bones",
            Description = "Keep special/boned accessories of the stand (i.e Fallen\'s Wings)",
            Default = false,
            Optional = true
        }, {
            Type = "boolean",
            Name = "no particles",
            Description = "Removes all particles the stand has",
            Default = false,
            Optional = true
        }, {
            Type = "boolean",
            Name = "outfit id?",
            Description = "use a outfit from a player?",
            Default = false,
            Optional = true
        } }
};