  

return {
    Name = "executeevent",
    Description = "Execute an event GLOBALLY",
    Group = "Admin",
    Aliases = {},
    Args = { {
            Type = "event",
            Name = "event",
            Description = "The event"
        } }
};