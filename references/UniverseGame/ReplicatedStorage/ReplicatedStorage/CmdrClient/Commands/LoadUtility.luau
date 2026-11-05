  

 

return {
    Name = "loadutility",
    Description = "Run a developer utility.",
    Aliases = { "loadutility", " loadutil", "utility", "util" },
    Group = { "ScriptDevs" },
    Args = { {
            Type = "string",
            Name = "Utility",
            Description = "The developer utility to load (i.e. Dex)"
        } }
};