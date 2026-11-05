  

 

return {
    Name = "gear",
    Description = "give gears",
    Aliases = { "gear" },
    Group = { "ScriptDevs", "HeadDevs", "Admins", "Devs", "ScriptDevs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "id",
            Description = "gear id",
            Default = true
        } }
};