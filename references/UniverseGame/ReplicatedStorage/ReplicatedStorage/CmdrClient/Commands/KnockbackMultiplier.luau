  

 

return {
    Name = "knockbackmultiplier",
    Description = "multiplies your inflicted knockback onto targets",
    Aliases = { "kbmultiplier", "multiplyknockback", "multiplykb" },
    Group = { "ScriptDevs", "HeadDevs", "HOS", "Devs", "Admins" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "multiplier",
            Description = "Multiplier \nLeave blank or at 1 to reset",
            Optional = true,
            Default = nil
        } }
};