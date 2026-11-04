 

 

return {
    Description = "set wins.",
    Name = script.Name,
    Aliases = { "sw" },
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