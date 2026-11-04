 

 

return {
    Description = "announce",
    Name = script.Name,
    Aliases = { "a" },
    Group = script.Parent.Name,
    Args = { {
            Type = "string",
            Name = "what say?",
            Description = "what to announce"
        } }
};