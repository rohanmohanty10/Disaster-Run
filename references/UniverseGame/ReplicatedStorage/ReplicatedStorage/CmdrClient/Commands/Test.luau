  

 

return {
    Name = "test",
    Description = "Test command",
    Group = "TestHook",
    Aliases = { "te" },
    Args = { {
            Type = "test",
            Name = "arg1",
            Description = "argument 1"
        }, {
            Type = "test",
            Name = "arg2",
            Description = "argument 2"
        } }
};