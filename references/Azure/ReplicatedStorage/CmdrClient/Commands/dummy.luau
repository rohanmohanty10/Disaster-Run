 

 

return {
    Description = "spawns dummy infront of you",
    Name = script.Name,
    Aliases = { "dum" },
    Group = script.Parent.Name,
    Args = { {
            Type = "string",
            Name = "what team?",
            Description = "this autofills as your own team or A if left empty"
        }, {
            Type = "string",
            Name = "what team placement?",
            Description = "this autofills as LW, options CF|RW|LW|CM|GK"
        }, {
            Type = "boolean",
            Name = "tackles?",
            Description = "bro on offensive"
        }, {
            Type = "stylepublic",
            Name = "what style",
            Description = "le style"
        } }
};