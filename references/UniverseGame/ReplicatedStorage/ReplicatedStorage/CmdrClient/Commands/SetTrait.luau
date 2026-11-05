  

 

return {
    Name = "settrait",
    Description = "temporarily sets trait of current player ability",
    Aliases = {},
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to set trait"
        }, {
            Type = "trait",
            Name = "trait",
            Description = "the trait to set",
            Optional = false
        }, {
            Type = "boolean",
            Name = "hexed",
            Description = "whether this trait is hexed",
            Optional = true
        } }
};