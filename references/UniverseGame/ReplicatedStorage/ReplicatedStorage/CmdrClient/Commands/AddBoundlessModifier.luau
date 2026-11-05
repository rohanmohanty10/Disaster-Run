  

 

return {
    Name = "addboundlessmodifier",
    Description = "Activates modifier on boundless tower.",
    Group = { "ScriptDevs" },
    Args = { {
            Type = "string",
            Name = "modifier",
            Description = "The modifier",
            Default = nil,
            Optional = true
        } }
};