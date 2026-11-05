  

 

return {
    Name = "removetitle",
    Description = "removes title from yourself or other players",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "the selected player"
        }, {
            Type = "string",
            Name = "itemid",
            Description = "the title to look for"
        } }
};