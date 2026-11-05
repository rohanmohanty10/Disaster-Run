  

 

return {
    Name = "removeboundlessmodifier",
    Description = "Removes modifier on boundless tower.",
    Group = { "ScriptDevs" },
    Args = { {
            Type = "string",
            Name = "modifier",
            Description = "The modifier",
            Default = nil,
            Optional = true
        } }
};