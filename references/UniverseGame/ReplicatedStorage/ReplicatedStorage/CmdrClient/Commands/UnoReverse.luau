  

 

return {
    Name = "unoreverse",
    Description = "Reverses Damage back onto the Attacker",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "HOS", "Devs", "Admins" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "active",
            Description = "reversal active",
            Optional = true,
            Default = false
        }, {
            Type = "boolean",
            Name = "reverse healing",
            Description = "reverses healing onto attacker as well",
            Optional = true,
            Default = false
        }, {
            Type = "number",
            Name = "timestop",
            Description = "timestop length inflicted onto attacker",
            Optional = true,
            Default = nil
        }, {
            Type = "boolean",
            Name = "statsis effects",
            Description = "inflicts the stasis effect on the timestop",
            Optional = true,
            Default = false
        } }
};