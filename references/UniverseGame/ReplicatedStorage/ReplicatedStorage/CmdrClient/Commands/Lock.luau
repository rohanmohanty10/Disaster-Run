  

 

return {
    Name = "lockserver",
    Description = "lockserver",
    Aliases = { "lockserver" },
    Group = { "ScriptDevs", "Admins", "HeadDevs", "Devs", "PSOwner" },
    Args = { {
            Type = "string",
            Name = "message",
            Description = "kick message",
            Default = false
        } }
};