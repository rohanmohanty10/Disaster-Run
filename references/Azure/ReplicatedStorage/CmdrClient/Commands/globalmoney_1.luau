 
 

return {
    Description = "set global money other server.",
    Name = script.Name,
    Aliases = { "gb" },
    Group = script.Parent.Name,
    Args = { {
            Type = "number",
            Name = "userid",
            Description = "The players to set."
        }, {
            Type = "number",
            Name = "how much do u want.",
            Description = "how much do u want again lol."
        } }
};