  

 

return {
    Name = "spawnadventure",
    Description = "spawns the given adventure if the requirements are met. if no adventure is given, spawns all.",
    Aliases = { "sab" },
    Group = { "ScriptDevs", "PublicTesters" },
    Args = { {
            Type = "string",
            Name = "adventure name",
            Description = "the adventure to spawn",
            Optional = true
        }, {
            Type = "number",
            Name = "zone",
            Description = "the zone to spawn it in",
            Optional = true
        } }
};