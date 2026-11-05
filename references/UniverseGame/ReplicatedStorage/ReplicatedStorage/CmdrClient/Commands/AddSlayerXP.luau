  

 

return {
    Name = "addslayerxp",
    Description = "increments current slayer xp by a given amount",
    Aliases = { "slayerxp" },
    Group = { "ScriptDevs", "PublicTesters" },
    Args = { {
            Type = "number",
            Name = "increment",
            Description = "the amount to increment by"
        } }
};