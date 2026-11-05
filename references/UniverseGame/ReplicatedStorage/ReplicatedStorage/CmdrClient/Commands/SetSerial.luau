  

 

return {
    Name = "setserial",
    Description = "generates a serial for current equipped ability",
    Aliases = {},
    Group = { "ScriptDevs", "PublicTesters" },
    Args = { {
            Type = "number",
            Name = "serial",
            Description = "the serial to set to"
        } }
};