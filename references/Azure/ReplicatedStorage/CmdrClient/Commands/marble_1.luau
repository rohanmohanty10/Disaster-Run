 
 

return {
    Description = "Toggle marble mode: roll around in a glass ball (if anyone listed isn\'t a marble, everyone listed becomes one)",
    Name = script.Name,
    Aliases = {},
    Group = script.Parent.Name,
    Args = { {
            Type = "players",
            Name = "targets",
            Description = "who to marble"
        } }
};