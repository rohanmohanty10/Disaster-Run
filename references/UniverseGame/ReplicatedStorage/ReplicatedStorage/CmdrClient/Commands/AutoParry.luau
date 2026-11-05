  

 

return {
    Name = "ugoparry",
    Description = "Gain infinite parry window",
    Aliases = { "parry" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player to modify"
        }, {
            Type = "boolean",
            Name = "State",
            Description = "True: Inf False: 1 Parry time",
            Default = true
        }, {
            Type = "boolean",
            Name = "pb all",
            Description = "If true, all moves inflicted onto you will be (perfect) blockable.",
            Default = false
        } }
};