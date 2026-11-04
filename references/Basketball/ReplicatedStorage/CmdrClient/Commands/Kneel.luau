 
 

return {
    Name = "kneel",
    Description = "Makes a player or set of players start kneeling.",
    Group = "DefaultAdmin",
    Aliases = { "bow" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to make start kneeling."
        }, {
            Type = "number",
            Name = "number",
            Description = "How many seconds they will be kneeling for (1-4 seconds)."
        } }
};