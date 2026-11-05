  

 

return {
    Name = "forceparty",
    Description = "Force create a party and add specified players",
    Aliases = { "forceparty" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs" },
    Args = { {
            Type = "players",
            Name = "Players",
            Description = "Players to add to the party"
        } }
};