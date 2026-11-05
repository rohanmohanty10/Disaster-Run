  

 

return {
    Name = "bypassall",
    Description = "forcibly confirms the attack state from your attacks to true, bypassing pretty much everything",
    Aliases = { "forceconfirmattack" },
    Group = { "ScriptDevs", "HeadDevs", "HOS", "Devs", "Admins" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "boolean",
            Name = "active",
            Description = "bypass active",
            Optional = true,
            Default = true
        }, {
            Type = "boolean",
            Name = "intangability bypass",
            Description = "as it says",
            Optional = true,
            Default = false
        } }
};