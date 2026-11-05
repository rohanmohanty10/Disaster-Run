  

 

return {
    Name = "Multiplier",
    Description = "Set a stat multiplier",
    Aliases = { "multiplier", "mult" },
    Group = { "ScriptDevs", "Admins", "Devs", "PublicTesters" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "multiplier",
            Name = "Multiplier Type",
            Description = "The multiplier to apply",
            Default = "WalkSpeedMultiplier"
        }, {
            Type = "number",
            Name = "Multiplier value",
            Description = "The scalar for the multiplier\nNOTE: Reduction multipliers should have decimal values (ex. 0.5)\nNOTE: Use 1 for value to reset",
            Default = 1,
            Optional = true
        } }
};