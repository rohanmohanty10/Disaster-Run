  

 

return {
    Name = "announce",
    Description = "announce",
    Aliases = { "announce" },
    Group = { "ScriptDevs", "HOS", "Devs", "Admins" },
    Args = { {
            Type = "number",
            Name = "Time",
            Description = "The amount of time the announcement lasts."
        }, {
            Type = "boolean",
            Name = "global",
            Description = "If the announcement is global."
        }, {
            Type = "string",
            Name = "Message",
            Description = "The message."
        } }
};