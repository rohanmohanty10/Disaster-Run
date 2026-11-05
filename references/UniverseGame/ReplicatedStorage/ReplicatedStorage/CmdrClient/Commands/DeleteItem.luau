  

 

return {
    Name = "deleteitem",
    Description = "Deletes a specific item from someone.",
    Aliases = { "deleteitem" },
    Group = { "ScriptDevs", "Admins" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "type",
            Description = "ability, skins, items, mounts, killeffects"
        }, {
            Type = "string",
            Name = "itemid",
            Description = "itemid"
        } }
};