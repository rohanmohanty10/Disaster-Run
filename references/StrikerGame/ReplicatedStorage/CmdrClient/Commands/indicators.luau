 

 

return {
    Description = "show indicators",
    Name = script.Name,
    Aliases = { "ind" },
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "targets",
            Description = "The players to show indicators in this server."
        } }
};