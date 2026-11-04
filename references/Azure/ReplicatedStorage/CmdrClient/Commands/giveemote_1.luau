 
 

return {
    Description = "give emote.",
    Name = script.Name,
    Aliases = { "ge" },
    Group = script.Parent.Name,
    Args = { {
            Type = "strings # numbers ; players",
            Name = "players",
            Description = "The players to set."
        }, {
            Type = "emotes",
            Name = "what emote u want to give.",
            Description = "what emote u want to give again lol."
        } }
};