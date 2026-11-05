  

 

return {
    Name = "ToggleTag",
    Description = "Hides or shows your chat tag",
    Aliases = { "tag" },
    Group = { "ScriptDevs", "Admins", "Mods", "HeadDevs", "PublicTesters", "Testers", "Devs", "Public" },
    Args = { {
            Type = "boolean",
            Name = "State",
            Description = "Whether to show or hide the tag",
            Default = false
        } }
};