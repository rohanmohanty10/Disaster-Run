 
 

return {
    Description = "give goal effect.",
    Name = script.Name,
    Aliases = { "goaleffect" },
    Group = script.Parent.Name,
    Args = { {
            Type = "strings # numbers ; players",
            Name = "players",
            Description = "The players to set."
        }, {
            Type = "goaleffects",
            Name = "name of goal effect",
            Description = "what goal effect u want to give again lol."
        } }
};