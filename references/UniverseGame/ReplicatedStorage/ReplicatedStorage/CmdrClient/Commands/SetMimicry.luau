  

 

return {
    Name = "setmimicry",
    Description = "set mimicry ability",
    Aliases = { "mimicry" },
    Group = { "ScriptDevs", "HeadDevs", "Devs", "Admins", "Mods", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify mimicry"
        }, {
            Type = "string",
            Name = "ability name",
            Description = "ability name"
        } }
};