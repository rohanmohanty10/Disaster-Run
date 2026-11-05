  

 

return {
    Name = "teleport",
    Description = "Teleports a player or set of players to one target.",
    Aliases = { "tp" },
    Group = { "ScriptDevs", "Admins", "Mods", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "from",
            Description = "The players to teleport"
        }, {
            Type = "player",
            Name = "to",
            Description = "The player to teleport to"
        }, {
            Type = "number",
            Name = "offset",
            Description = "The offset from the \'from\' player",
            Optional = true,
            Default = 0
        } }
};