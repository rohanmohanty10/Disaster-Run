  

 

return {
    Name = "setgamemodestat",
    Description = "Sets your gamemode stat.",
    Group = { "ScriptDevs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to grant item to"
        }, {
            Type = "string",
            Name = "gamemode",
            Description = "the gamemode"
        }, {
            Type = "string",
            Name = "stat",
            Description = "the stat to change"
        }, {
            Type = "number",
            Name = "value",
            Description = "the value to change"
        } }
};