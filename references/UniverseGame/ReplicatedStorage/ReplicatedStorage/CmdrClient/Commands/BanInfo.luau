  

 

return {
    Name = "baninfo",
    Description = "Check if a user is banned and view ban details",
    Aliases = { "checkban", "isbanned" },
    Group = { "ScriptDevs", "Admins", "Mods" },
    Args = { {
            Type = "string",
            Name = "Target",
            Description = "Username or UserID to check ban status"
        } }
};