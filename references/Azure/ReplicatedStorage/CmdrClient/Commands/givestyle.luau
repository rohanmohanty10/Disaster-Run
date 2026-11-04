 

 

return {
    Description = "give style lalala.",
    Name = script.Name,
    Aliases = { "gm" },
    Group = script.Parent.Name,
    Args = { {
            Type = "strings # numbers ; players",
            Name = "players",
            Description = "The players to set."
        }, {
            Type = "styles",
            Name = "style",
            Description = "what style u want to give again lol."
        } }
};