  

 

return {
    Name = "conquerorshaki",
    Description = "release a wave of haki",
    Aliases = {},
    Group = { "ScriptDevs", "Admins", "Devs" },
    Args = { {
            Type = "number",
            Name = "length",
            Description = "how long the base conquerors haki stun should be",
            Optional = true
        }, {
            Type = "number",
            Name = "time-multiplier",
            Description = "how long the final stun time should be multiplied by (0, 5]",
            Optional = true
        }, {
            Type = "number",
            Name = "delay",
            Description = "delay before conquerors haki",
            Optional = true
        } }
};