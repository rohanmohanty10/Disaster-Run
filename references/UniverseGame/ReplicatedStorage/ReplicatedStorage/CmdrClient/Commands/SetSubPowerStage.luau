  

 

return {
    Name = "setsubpowerstage",
    Description = "sets stage of subpower",
    Aliases = { "subpowerstage" },
    Group = { "ScriptDevs", "Devs", "HOS", "HeadDevs", "PublicTesters" },
    Args = { {
            Type = "string",
            Name = "SubPower name",
            Description = "the name of the Sub Power to modify"
        }, {
            Type = "number",
            Name = "SubPower Stage",
            Description = "Sub Power Stage"
        } }
};