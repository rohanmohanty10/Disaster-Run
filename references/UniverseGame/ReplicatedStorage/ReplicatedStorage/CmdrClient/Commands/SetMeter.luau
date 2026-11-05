  

 

return {
    Name = "setmeter",
    Description = "Sets player meter to given value",
    Aliases = { "meter" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "value",
            Description = "Value of meter to set to"
        } }
};