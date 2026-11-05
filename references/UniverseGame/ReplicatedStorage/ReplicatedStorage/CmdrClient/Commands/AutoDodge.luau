  

 

return {
    Name = "ugododge",
    Description = "Automatically dodge incoming attacks",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "HOS", "Devs", "Admins" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "dodge chance",
            Description = "chance of dodging attack in % (0-100) \nLeave blank to remove dodging",
            Optional = true,
            Default = nil
        }, {
            Type = "boolean",
            Name = "true bypass",
            Description = "True Damage bypasses dodging?",
            Optional = true,
            Default = false
        } }
};