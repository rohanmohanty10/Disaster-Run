 
 

return {
    Description = "BE STRONGER. BE SMARTER. BE BETTER.",
    Name = script.Name,
    Aliases = { "yummers" },
    Group = script.Parent.Name,
    Args = { {
            Type = "player",
            Name = "target",
            Description = "who homelander"
        }, {
            Type = "boolean",
            Name = "morph",
            Description = "does he become homelander fr?",
            Optional = true
        } }
};