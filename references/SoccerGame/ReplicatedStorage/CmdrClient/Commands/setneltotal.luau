  

return {
    Name = "setneltotal",
    Description = "Set a player\'s NEL skill Total (0-100; -1 to clear override)",
    Group = "Admin",
    Aliases = { "setneltotal" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "total",
            Description = "Skill Total 0-100 (-1 clears)"
        } }
};