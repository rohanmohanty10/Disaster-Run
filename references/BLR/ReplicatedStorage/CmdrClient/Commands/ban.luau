  

return {
    Name = "ban",
    Description = "Bans a player (global)",
    Group = "Mod",
    Aliases = { "ban" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "banlength",
            Name = "length",
            Description = "Ban duration"
        }, {
            Type = "string",
            Name = "reason",
            Description = "Detail the ban reason here"
        } }
};