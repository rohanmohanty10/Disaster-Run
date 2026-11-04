  

return {
    Name = "nelskip",
    Description = "Advance a player\'s NEL league career rounds",
    Group = "Admin",
    Aliases = { "nelskip" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "number",
            Name = "rounds",
            Description = "How many rounds to advance (default 1)",
            Default = 1
        } }
};