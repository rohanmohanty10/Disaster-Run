  

 

return {
    Name = "questlinetask",
    Description = "increments a questline task by a certain amount",
    Aliases = {},
    Group = { "ScriptDevs", "PublicTesters" },
    Args = { {
            Type = "string",
            Name = "quest task",
            Description = "the name of the task for example Defeat [Dio]"
        }, {
            Type = "number",
            Name = "increment",
            Description = "the amount to increment by",
            Optional = true
        } }
};