 
 

return {
    Name = "notify",
    Description = "Local Announcement Command",
    Group = "HeadTester",
    Aliases = {},
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The players to notify."
        }, {
            Type = "string",
            Name = "message",
            Description = "announcement"
        } }
};