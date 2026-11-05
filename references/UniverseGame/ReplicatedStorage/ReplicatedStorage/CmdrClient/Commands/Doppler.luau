  

 

return {
    Name = "Doppler",
    Description = "Messes up sounds",
    Aliases = { "doppler" },
    Group = { "ScriptDevs", "Admins", "Devs" },
    Args = { {
            Type = "number",
            Name = "Doppler Scale",
            Description = "the desired doppler scale",
            Default = 1
        }, {
            Type = "number",
            Name = "Multiplier value",
            Description = "The scalar for the multiplier\nNOTE: Reduction multipliers should have decimal values (ex. 0.5)\nNOTE: Use 1 for value to reset",
            Default = 1,
            Optional = true
        } }
};