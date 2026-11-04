 

 

return {
    Description = "Take full control of a player. Control yourself again to exit.",
    Name = script.Name,
    Aliases = { "mc", "mindcontrol" },
    Group = script.Parent.Name,
    Args = { {
            Type = "player",
            Name = "target",
            Description = "who to control"
        } }
};