  

 

return {
    Name = "delayhitbox",
    Aliases = { "delayhitbox", "laghitbox" },
    Description = "Delays the casting of hitboxes." .. (game.GameId == 1900951801 and " This is useful for debugging CLIENT hitboxes." or ""),
    Group = { "ScriptDevs", "HeadDevs", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players\' hitboxes to delay."
        }, {
            Type = "number",
            Name = "delay length",
            Description = "How long the hitbox cast should be delayed for. Set to 0 to disable.",
            Optional = true,
            Default = 0
        } }
};