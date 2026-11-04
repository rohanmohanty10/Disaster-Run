 
 

return {
    Description = "give commentator.",
    Name = script.Name,
    Aliases = { "gcommentator" },
    Group = script.Parent.Name,
    Args = { {
            Type = "strings # numbers ; players",
            Name = "players",
            Description = "The players to set."
        }, {
            Type = "commentators",
            Name = "name of commentator",
            Description = "what commentator u want to give again lol."
        } }
};