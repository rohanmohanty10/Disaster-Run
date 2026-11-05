  

 

return {
    Name = "rollchest",
    Description = "rolls chest of certain rarity",
    Aliases = {},
    Group = { "ScriptDevs", "PublicTesters", "Admins", "Devs" },
    Args = { {
            Type = "string",
            Name = "rarity",
            Description = "what chest rarity to roll"
        }, {
            Type = "number",
            Name = "rolls",
            Description = "roll amount",
            Optional = true
        } }
};