  

 

return {
    Name = "wipeinventory",
    Description = "wipes inventory",
    Aliases = { "wipeinv" },
    Group = { "ScriptDevs", "Admins", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "type",
            Description = "ability, skins, items, mounts, killeffects or emotes"
        } }
};