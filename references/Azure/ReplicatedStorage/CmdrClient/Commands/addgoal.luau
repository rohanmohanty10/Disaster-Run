 

 

return {
    Description = "give add goal to team",
    Name = script.Name,
    Aliases = { "ag" },
    Group = script.Parent.Name,
    Args = { {
            Type = "string",
            Name = "what team?",
            Description = "A or B"
        }, {
            Type = "number",
            Name = "amount",
            Description = "can be negative of course"
        } }
};