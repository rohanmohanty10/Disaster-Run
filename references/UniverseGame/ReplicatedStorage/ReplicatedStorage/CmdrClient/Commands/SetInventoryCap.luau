  

 

return {
    Name = "setinventorycap",
    Description = "set inventory max capacity",
    Aliases = {},
    Group = { "ScriptDevs", "PublicTesters", "Devs", "Admins" },
    Args = { {
            Type = "string",
            Name = "type",
            Description = "ability, skins, items, mounts or killeffects"
        }, {
            Type = "number",
            Name = "cap",
            Description = "new inventory cap"
        } }
};