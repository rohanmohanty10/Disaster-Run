  

return {
    Name = "setflow",
    Description = "Sets a players flow in the given slot",
    Group = "Tester",
    Aliases = { "setflow" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
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