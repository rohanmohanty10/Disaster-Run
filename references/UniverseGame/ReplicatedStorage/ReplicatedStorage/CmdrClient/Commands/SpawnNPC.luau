  

 

return {
    Name = "spawnnpc",
    Description = "spawn a npc",
    Aliases = { "spawn" },
    Group = { "HOS", "ScriptDevs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player",
            Description = "The player to spawn on"
        }, {
            Type = "string",
            Name = "npc",
            Description = "the npc name"
        }, {
            Type = "number",
            Name = "npc level",
            Description = "give specific level to npc",
            Optional = true
        }, {
            Type = "number",
            Name = "npc skin id",
            Description = "give specific skin id to npc",
            Optional = true
        }, {
            Type = "number",
            Name = "amount",
            Description = "amount to spawn",
            Optional = true
        }, {
            Type = "player",
            Name = "summoner",
            Description = "custom summoner for the npc (defaults to command executor)",
            Optional = true
        } }
};