  

return {
    Name = "timer",
    Description = "Set the current timer",
    Group = "Admin",
    Aliases = { "timer" },
    Args = { {
            Type = "number",
            Name = "value",
            Description = "new time"
        } }
};