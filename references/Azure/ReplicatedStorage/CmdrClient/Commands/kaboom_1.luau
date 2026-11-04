 
 

return {
    Description = "KA BOOM 💣💣💥💥💥💥",
    Name = script.Name,
    Aliases = { "nuke", "boom" },
    Group = script.Parent.Name,
    Args = { {
            Type = "player",
            Name = "where on?",
            Description = "what to nuke."
        }, {
            Type = "boolean",
            Name = "music",
            Description = "So you want sonne?",
            Optional = true
        } }
};