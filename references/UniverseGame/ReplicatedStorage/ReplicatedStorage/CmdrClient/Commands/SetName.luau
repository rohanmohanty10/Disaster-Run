  

 

return {
    Name = "setname",
    Description = "temporarily sets the name of the player(s)",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "name",
            Description = "name\n Leave blank to reset",
            Optional = true
        }, {
            Type = "boolean",
            Name = "ignore humanoid",
            Description = "doesn\'t apply the name to your character",
            Optional = true
        }, {
            Type = "boolean",
            Name = "modify chat name",
            Description = "add chat name",
            Optional = true
        }, {
            Type = "number",
            Name = "chat color R",
            Description = "chat name custom color R",
            Default = nil,
            Optional = true
        }, {
            Type = "number",
            Name = "chat color G",
            Description = "chat name custom color G",
            Default = nil,
            Optional = true
        }, {
            Type = "number",
            Name = "chat color B",
            Description = "chat name custom color B",
            Default = nil,
            Optional = true
        } }
};