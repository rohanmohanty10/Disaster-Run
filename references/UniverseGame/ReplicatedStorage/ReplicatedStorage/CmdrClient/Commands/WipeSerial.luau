  

 

return {
    Name = "wipeserial",
    Description = "Resets serial for an item",
    Aliases = {},
    Group = { "ScriptDevs" },
    Args = { {
            Type = "string",
            Name = "itemid",
            Description = "the itemid to reset serial"
        } }
};