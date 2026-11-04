 
 

return {
    Description = "Toggles target player(s) on the exclusive bypass list while nospecs is active.",
    Name = script.Name,
    Aliases = { "specbypass" },
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "targets",
            Description = "Players to add or remove from the exclusive bypass list."
        } }
};