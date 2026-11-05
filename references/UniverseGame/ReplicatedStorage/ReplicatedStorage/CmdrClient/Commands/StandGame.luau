  

 

return {
    Name = "standgame",
    Description = "Teleports a list of players to stand game",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Devs", "Admins", "Mods", "PSOwner" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to teleport to stand game"
        } }
};