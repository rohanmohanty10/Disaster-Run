  

 

return {
    Name = "unlocksubpower",
    Description = "unlocks a sub power",
    Aliases = {},
    Group = { "ScriptDevs", "Devs", "HOS", "HeadDevs", "PublicTesters", "Admins" },
    Args = { {
            Type = "string",
            Name = "SubPower name",
            Description = "the name of the Sub Power to unlock"
        } }
};