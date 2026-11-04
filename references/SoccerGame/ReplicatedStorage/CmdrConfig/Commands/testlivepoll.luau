  

return {
    Name = "testlivepoll",
    Description = "Starts a 15 second test poll with two options on this server only (dev place)",
    Group = "Tester",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "question",
            Description = "The poll question (wrap it in quotes)"
        }, {
            Type = "string",
            Name = "option1",
            Description = "First option"
        }, {
            Type = "string",
            Name = "option2",
            Description = "Second option"
        } }
};