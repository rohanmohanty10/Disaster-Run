 
 

return {
    Description = "claim quest",
    Name = script.Name,
    Aliases = { "cq" },
    Group = script.Parent.Name,
    Args = { {
            Type = "quest",
            Name = "quest",
            Description = "quest"
        } }
};