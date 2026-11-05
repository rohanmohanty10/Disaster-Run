  

 

return {
    Name = "restoreprofile",
    Description = "Restores profile given a time",
    Aliases = {},
    Group = { "ScriptDevs", 195353328, 156538383 },
    Args = { {
            Type = "number",
            Name = "userid",
            Description = "UserId to restore"
        }, {
            Type = "duration",
            Name = "timelength",
            Description = "How far back from current time"
        } }
};