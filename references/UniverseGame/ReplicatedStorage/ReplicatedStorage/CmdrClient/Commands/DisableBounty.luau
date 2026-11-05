  

 

return {
    Name = "Disable Bounty",
    Description = "disables bounty gain on a player",
    Aliases = { "disablebounty" },
    Group = { "ScriptDevs", "Devs", "Admins", "Mods", "PSOwner", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to disable bounty gain on"
        }, {
            Type = "boolean",
            Name = "disable",
            Description = "disable bounty?",
            Default = true,
            Optional = true
        } }
};