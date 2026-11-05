  

 

return {
    Name = "setascension",
    Description = "sets ascension rank of current ability",
    Aliases = {},
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs", "PublicTesters", "GuestTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to ascend"
        }, {
            Type = "number",
            Name = "rank",
            Description = "new ascension rank"
        } }
};