 

 

return {
    Description = "remove a player\'s ranked suspension.",
    Name = script.Name,
    Aliases = { "rsusp", "clearsuspension", "rs" },
    Group = script.Parent.Name,
    Args = { {
            Type = "strings # numbers ; players",
            Name = "players",
            Description = "The players to clear suspension for."
        } }
};