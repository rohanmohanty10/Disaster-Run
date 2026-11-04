 
 

return {
    Description = "kill people",
    Name = script.Name,
    Aliases = { "leaderremove" },
    Group = script.Parent.Name,
    Args = { {
            Type = "strings # numbers ; players",
            Name = "player",
            Description = "The player to KILL."
        }, {
            Type = "string",
            Name = "leaderboard type.",
            Description = "assists|goals|saves2|wins"
        } }
};