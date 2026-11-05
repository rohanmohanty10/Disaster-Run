  

 

return {
    Name = "debughook",
    Description = "debug a hook",
    Aliases = {},
    Group = { "ScriptDevs" },
    Args = { {
            Type = "string",
            Name = "hook name",
            Description = "Name of hook to debug"
        }, {
            Type = "boolean",
            Name = "debug mode",
            Description = "which state to set debug mode"
        } }
};