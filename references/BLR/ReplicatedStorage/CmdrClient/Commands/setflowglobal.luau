  

return {
    Name = "setflowglobal",
    Description = "Sets a player\'s flow in a slot (global / cross-server)",
    Group = "Mod",
    Aliases = { "flowglobal" },
    Args = { {
            Type = "string",
            Name = "full_player_name",
            Description = "The player\'s full name"
        }, {
            Type = "flowSlotId",
            Name = "slotId",
            Description = "Slot number"
        }, {
            Type = "flow",
            Name = "flow",
            Description = "Flow name"
        } }
};