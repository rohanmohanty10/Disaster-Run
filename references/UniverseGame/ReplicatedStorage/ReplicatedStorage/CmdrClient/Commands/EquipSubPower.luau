  

 

return {
    Name = "equipsubpower",
    Description = "equips or unequips a sub power",
    Aliases = { "subpower" },
    Group = { "ScriptDevs", "Devs", "HOS", "HeadDevs", "PublicTesters" },
    Args = { {
            Type = "string",
            Name = "SubPower name",
            Description = "the name of the Sub Power to equip/unequip"
        }, {
            Type = "boolean",
            Name = "Toggle",
            Description = "the name of the Sub Power to equip/unequip",
            Optional = true,
            Default = true
        } }
};