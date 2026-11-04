  

return {
    Name = "setstyleglobal",
    Description = "Sets a player\'s style in a slot (global / cross-server)",
    Group = "Mod",
    Aliases = { "styleglobal" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "styleSlotId",
            Name = "slotId",
            Description = "Slot number"
        }, {
            Type = "style",
            Name = "style",
            Description = "Style name"
        } }
};