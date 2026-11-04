 

 

return {
    Description = "set saves.",
    Name = script.Name,
    Aliases = { "ss" },
    Group = script.Parent.Name,
    Args = { {
            Type = "strings # numbers ; players",
            Name = "players",
            Description = "The players to set."
        }, {
            Type = "number",
            Name = "how much do u want.",
            Description = "how much do u want again lol."
        } }
};