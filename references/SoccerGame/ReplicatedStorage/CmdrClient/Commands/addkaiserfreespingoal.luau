  

return {
    Name = "addkaiserfreespingoal",
    Description = "Gives kaiser free spin goal!",
    Group = "Admin",
    Aliases = { "addkaiserfreespingoal" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "amount",
            Description = "amount"
        } }
};