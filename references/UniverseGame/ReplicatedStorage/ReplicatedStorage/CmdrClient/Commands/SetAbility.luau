  

 

return {
    Name = "setability",
    Description = "Sets player to a certain ability id",
    Aliases = { "set" },
    Group = { "ScriptDevs", "PublicTesters", "HeadDevs" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player to modify"
        }, {
            Type = "number",
            Name = "ability",
            Description = "New ability for player"
        } }
};