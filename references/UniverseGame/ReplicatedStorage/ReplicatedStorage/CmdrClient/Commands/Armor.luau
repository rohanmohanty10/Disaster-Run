  

 

return {
    Name = "Armor",
    Description = "gain hyperarmor",
    Aliases = { "armor" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "state",
            Description = "true or false",
            Default = true,
            Optional = true
        } }
};