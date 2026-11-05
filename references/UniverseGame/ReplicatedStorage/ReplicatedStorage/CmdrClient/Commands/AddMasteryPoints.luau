  

 

return {
    Name = "addmasterypoints",
    Description = "Adds mastery points to current ability",
    Aliases = {},
    Group = { "ScriptDevs", "Devs", "PublicTesters", "HOS", "GuestTesters", "Admins" },
    Args = { {
            Type = "players",
            Name = "player",
            Description = "Players to give mastery points"
        }, {
            Type = "number",
            Name = "points",
            Description = "amount of points to give"
        } }
};