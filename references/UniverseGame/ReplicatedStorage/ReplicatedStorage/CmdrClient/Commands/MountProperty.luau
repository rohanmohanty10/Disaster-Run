  

 

return {
    Name = "mountproperty",
    Description = "Force a mount stat to use a custom value. Applies per character, may need to respawn the mount in order for changes to apply.",
    Aliases = { "mountproperty", "mountprop" },
    Group = { "ScriptDevs", "HeadDevs", "HOS", "Devs", "Admins" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify",
            Optional = false
        }, {
            Type = "mountproperty",
            Name = "mount property",
            Description = "Mount property to modify",
            Optional = false
        }, {
            Type = "number",
            Name = "value",
            Description = "Property value",
            Optional = true,
            Default = nil
        } }
};