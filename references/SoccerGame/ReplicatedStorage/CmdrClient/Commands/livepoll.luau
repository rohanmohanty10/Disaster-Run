  

return {
    Name = "livepoll",
    Description = "Starts a 15 second live poll with two options on every server",
    Group = "Admin",
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