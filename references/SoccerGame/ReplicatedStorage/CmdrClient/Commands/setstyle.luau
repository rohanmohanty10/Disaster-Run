  

return {
    Name = "setstyle",
    Description = "Sets a players style in the given slot",
    Group = "Tester",
    Aliases = { "style" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
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