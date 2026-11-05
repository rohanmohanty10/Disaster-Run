  

 

return {
    Name = "Vanish",
    Description = "hides players on the leaderboard",
    Aliases = { "vanish" },
    Group = { "ScriptDevs", "Devs" },
    Args = { {
            Type = "boolean",
            Name = "state",
            Description = "true or false",
            Default = true,
            Optional = true
        }, {
            Type = "boolean",
            Name = "persistent",
            Description = "whether the effect lasts across servers until toggled again",
            Default = false,
            Optional = true
        }, {
            Type = "boolean",
            Name = "dynamic",
            Description = "whether the effect should handled dynamically (you need first two arguments to be false)",
            Default = false,
            Optional = true
        } }
};