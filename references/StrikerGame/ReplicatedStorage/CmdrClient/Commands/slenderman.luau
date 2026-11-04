 

 

return {
    Description = "he\'s behind you",
    Name = script.Name,
    Aliases = {},
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "targets",
            Description = "who sees him"
        }, {
            Type = "boolean",
            Name = "kill?",
            Description = "kill them after the video",
            Optional = true,
            Default = false
        } }
};