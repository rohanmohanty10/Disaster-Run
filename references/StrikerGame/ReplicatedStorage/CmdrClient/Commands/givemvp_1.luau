 
 

return {
    Description = "give mvp.",
    Name = script.Name,
    Aliases = { "gm" },
    Group = script.Parent.Name,
    Args = { {
            Type = "strings # numbers ; players",
            Name = "players",
            Description = "The players to set."
        }, {
            Type = "mvps",
            Name = "what mvp u want to give.",
            Description = "what mvp u want to give again lol."
        } }
};